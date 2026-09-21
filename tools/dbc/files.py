"""Install a complete conversion without overwriting hand-edited Forever sources."""
from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile

MANIFEST = "data/Forever/conversion.json"
TOOL = "QuestieDB convert-forever"


def digest(data: bytes) -> str:
    """Hash exact file bytes, including comments and line endings."""
    return hashlib.sha256(data).hexdigest()


def destination(root: Path, relative: str) -> Path:
    """Reject output traversal, symlinks and non-file destinations before writes."""
    suffix = Path(relative)
    if suffix.is_absolute() or ".." in suffix.parts:
        raise ValueError("Output must remain inside QuestieDB: " + relative)
    path = root / suffix
    for component in (path, *path.parents):
        if component.is_symlink():
            raise ValueError("Refusing symlinked conversion output: " + str(component))
        if component == root:
            break
        if component != path and component.exists() and not component.is_dir():
            raise ValueError("Output parent is not a directory: " + str(component))
    if path.exists() and not path.is_file():
        raise ValueError("Output is not a regular file: " + str(path))
    return path


def install_outputs(root: Path, outputs: dict[str, bytes], *,
                    manifest_name: str = MANIFEST, tool: str = TOOL) -> list[str]:
    """Replace only unchanged prior generated files, rolling back installation errors.

    The caller supplies a separate manifest and tool identity for support candidates.
    The manifest is installed last. A failed rollback retains the transaction
    directory with backups and reports its path rather than deleting recovery data.
    """
    root = root.absolute()
    paths = {name: destination(root, name) for name in outputs}
    manifest_path = destination(root, manifest_name)
    previous = {}
    if manifest_path.exists():
        previous = json.loads(manifest_path.read_bytes())
        if previous.get("tool") != tool or previous.get("format") != 1:
            raise ValueError("Unrecognized conversion manifest; refusing to overwrite it")
    changed = []
    originals = {}
    for name, payload in outputs.items():
        path = paths[name]
        old = path.read_bytes() if path.exists() else None
        if old == payload:
            continue
        if old is not None and name != manifest_name:
            known_hash = previous.get("files", {}).get(name, {}).get("output_sha256")
            if digest(old) != known_hash:
                raise ValueError("Refusing to overwrite hand-edited or unowned output: " + name
                                 + ". Preserve/move it before regenerating.")
        changed.append(name)
        originals[name] = old
    if not changed:
        return []

    transaction = Path(tempfile.mkdtemp(prefix=".forever-conversion-", dir=str(root)))
    pending = []
    retain_backups = False
    try:
        # Stage all bytes before replacing any destination; backups never leave this run.
        for index, name in enumerate(changed):
            (transaction / (str(index) + ".new")).write_bytes(outputs[name])
            if originals[name] is not None:
                (transaction / (str(index) + ".old")).write_bytes(originals[name])
        (transaction / "recovery.json").write_text(json.dumps({
            str(index): {"destination": name, "previously_existed": originals[name] is not None}
            for index, name in enumerate(changed)
        }, indent=2) + "\n", encoding="utf-8")
        order = [name for name in changed if name != manifest_name] + ([manifest_name] if manifest_name in changed else [])
        indices = {name: index for index, name in enumerate(changed)}
        for name in order:
            path = destination(root, name)
            current = path.read_bytes() if path.exists() else None
            if current != originals[name]:
                raise ValueError("Output changed during conversion: " + name)
            path.parent.mkdir(parents=True, exist_ok=True)
            # Register intent first: cancellation can arrive after the rename succeeds
            # but before Python executes another instruction. Rollback inspects bytes.
            pending.append(name)
            os.replace(str(transaction / (str(indices[name]) + ".new")), str(path))
    except BaseException:
        # A second interrupt during rollback must leave recovery files, not clean them up.
        retain_backups = True
        rollback_complete = True
        for name in reversed(pending):
            try:
                # Do not erase an edit made after this transaction published a file.
                # Preserve both that edit and our backups for explicit recovery.
                path = destination(root, name)
                current = path.read_bytes() if path.exists() else None
                if current == originals[name]:
                    continue  # Replacement did not happen, or was already restored.
                if current != outputs[name]:
                    rollback_complete = False
                    continue
                if originals[name] is None:
                    path.unlink()
                else:
                    os.replace(str(transaction / (str(indices[name]) + ".old")), str(path))
            except (OSError, ValueError):
                rollback_complete = False
        retain_backups = not rollback_complete
        if retain_backups:
            raise RuntimeError("Rollback incomplete; preserve recovery files in " + str(transaction))
        raise
    finally:
        if retain_backups:
            print("Conversion recovery files retained at " + str(transaction), file=sys.stderr)
        else:
            shutil.rmtree(str(transaction))
    return changed
