"""Generate and execute the addon helper against the selected DBC geometry."""
from __future__ import annotations

import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
HELPER = Path("src/support/eraToForever.lua")
TOOLS = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools/cli"))
from questiedb import find_lua, start_process, stop_process

COEFFICIENTS = ("scale_x", "offset_x", "scale_y", "offset_y")


def supported_rows(report: dict) -> list[dict]:
    """Use only direct, unambiguous AreaID/UiMapID pairs, as the offline converter does."""
    rows = [row for row in report["transforms"] if row["area_transform_supported"]]
    if not rows:
        raise ValueError("No supported zone transforms; refusing to certify or generate a runtime helper")
    return sorted(rows, key=lambda row: row["ui_map_id"])


def render_helper(report: dict) -> bytes:
    """Emit a deterministic small addon module; Python's float spelling round-trips to Lua doubles."""
    for key, pattern in (("source_build", r"1\.15\.\d+\.\d+"), ("target_build", r"1\.60\.\d+\.\d+")):
        if not re.fullmatch(pattern, report[key]):
            raise ValueError("Runtime helper requires an explicit " + key)
    transforms, maps = [], []
    for row in supported_rows(report):
        if not row["changed"]:
            continue
        values = ", ".join(repr(row["coefficients"][key]) for key in COEFFICIENTS)
        name = " ".join(row["target_name"].splitlines())
        transforms.append(f'  [{row["area_id"]}] = {{ {values} }}, -- {name}')
        maps.append(f'  [{row["ui_map_id"]}] = {row["area_id"]}, -- {name}')
    text = (TOOLS / "runtime-helper.template.lua").read_text(encoding="utf-8")
    replacements = {"SOURCE_BUILD": report["source_build"], "TARGET_BUILD": report["target_build"],
                    "TRANSFORMS": "\n".join(transforms), "UI_MAPS": "\n".join(maps)}
    # Substitute once so a map name cannot inject a second template expansion.
    return re.sub(r"@(SOURCE_BUILD|TARGET_BUILD|TRANSFORMS|UI_MAPS)@",
                  lambda match: replacements[match[1]], text).encode("utf-8")


def check_helper(report: dict, helper: Path, lua: str) -> dict:
    """Check actual public Lua behavior, including passthrough and obsolete map entries."""
    rows = supported_rows(report)
    with tempfile.TemporaryDirectory(prefix="questiedb-helper-check-") as temporary:
        plan = Path(temporary) / "plan.lua"
        literals = []
        for row in rows:
            values = [row["area_id"], row["ui_map_id"], *(row["coefficients"][key] for key in COEFFICIENTS)]
            literals.append("{" + ",".join(repr(value) for value in values) + "}")
        plan.write_text("return {" + ",".join(literals) + "}\n", encoding="utf-8")
        process = start_process([lua, str(TOOLS / "check-runtime-helper.lua"), str(helper.resolve()), str(plan)],
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        try:
            stdout, stderr = process.communicate(timeout=10)
        except subprocess.TimeoutExpired:
            stop_process(process)
            raise ValueError("Runtime helper validation timed out") from None
        except BaseException:
            stop_process(process)
            raise
    return {"status": "matched" if process.returncode == 0 else "stale",
            "checked_maps": len(rows), "details": (stdout + stderr).strip()}


def require_matching_helper(report: dict, helper: Path, lua: str) -> dict:
    """Block entity conversion when the independently shipped runtime projection is stale."""
    result = check_helper(report, helper, lua)
    if result["status"] != "matched":
        raise ValueError("Runtime helper is stale:\n" + result["details"] +
                         "\nRun dbc-coordinates with the same builds and --write-runtime-helper, then review the diff. "
                         "Updating the helper does not migrate existing Forever data.")
    return result


def write_helper(report: dict, root: Path, lua: str) -> dict:
    """Validate before explicitly replacing the generated helper, never entity data or TOCs."""
    destination = root / HELPER
    for path in (destination, destination.parent, destination.parent.parent):
        if path.is_symlink():
            raise ValueError("Refusing symlinked runtime helper destination: " + str(path))
    before = destination.read_bytes() if destination.exists() else None
    candidate = render_helper(report)
    # Stage beside the destination so publication is one atomic replacement on the same filesystem.
    with tempfile.NamedTemporaryFile(prefix=".eraToForever-", suffix=".lua", dir=destination.parent,
                                     delete=False) as staged:
        temporary = Path(staged.name)
    try:
        temporary.write_bytes(candidate)
        result = require_matching_helper(report, temporary, lua)
        current = destination.read_bytes() if destination.exists() else None
        if current != before or destination.is_symlink():
            raise ValueError("Runtime helper changed during generation; no output installed")
        if current != candidate:
            temporary.chmod(destination.stat().st_mode & 0o777 if destination.exists() else 0o644)
            os.replace(temporary, destination)
        return {**result, "written": current != candidate}
    finally:
        temporary.unlink(missing_ok=True)
