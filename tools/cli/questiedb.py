#!/usr/bin/env python3
"""Portable contributor commands; Lua owns generation and database validation.

Usage: questiedb.sh <task> [task ...] [flavor ...] [options]
       questiedb.ps1 <task> [task ...] [flavor ...] [options]

Tasks:
  generate       Generate Baked TOCs
  check          Verify, equivalence, reconstruct, validators, compiler differential
  all            Generate, check, golden snapshots, and unit tests (not packaging)
  package        Package existing TOCs: package [all|Vanilla TBC Wrath Cata Mists]
  bootstrap      Download an install: bootstrap <AddOns-path> [tag] [--repo=OWNER/REPO]
  verify equivalence reconstruct validators differential golden test determinism freeze

Flavors: Vanilla TBC Wrath Cata Mists; omitted means all applicable flavors.
Freeze supports Vanilla and Mists only.

Options:
  --flavors=Vanilla,Mists  Select flavors instead of positional names
  --budget-mb=4000        Scheduling budget, 1 to 2147483647 MB
  --questie=PATH          Legacy migration checkout, default ../Questie
  --lua=COMMAND          Lua 5.1-compatible executable (also accepts LUA)
  --sequential           Run one job at a time
  -h, --help             Show this help
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
import os
from pathlib import Path
import re
import shutil
import signal
import subprocess
import sys
import time
from typing import Any, BinaryIO, Optional

ROOT = Path(__file__).resolve().parents[2]
FLAVORS = ("Vanilla", "TBC", "Wrath", "Cata", "Mists")
CHECKS = ("verify", "equivalence", "reconstruct", "validators", "differential")
GATES = ("generate", *CHECKS, "golden", "test", "determinism", "freeze")
WEIGHTS = dict(zip(FLAVORS, (450, 700, 1000, 1400, 1750)))
MAX_BUDGET_MB = 2147483647


@dataclass
class Options:
    tasks: list[str]
    flavors: list[str]
    budget: Optional[int] = None
    lua: Optional[str] = None
    questie: str = "../Questie"
    sequential: bool = False


def parse_args(args: list[str]) -> Options:
    """Validate the complete selection before probing executables or touching outputs."""
    tasks, positional = [], []
    explicit = None
    options = Options(tasks, [], lua=os.environ.get("LUA") or None,
                      questie=os.environ.get("QUESTIE_PATH") or "../Questie")
    for arg in args:
        if arg.startswith("--flavors="):
            if explicit is not None:
                raise ValueError("--flavors may be provided only once")
            explicit = arg.split("=", 1)[1].split(",")
            if any(not flavor for flavor in explicit):
                raise ValueError("--flavors requires a comma-separated list without empty values")
            if any(flavor not in FLAVORS for flavor in explicit):
                raise ValueError("unknown flavor in --flavors: " + ", ".join(explicit))
        elif arg.startswith("--budget-mb="):
            if options.budget is not None:
                raise ValueError("--budget-mb may be provided only once")
            value = arg.split("=", 1)[1]
            if not re.fullmatch(r"[0-9]+", value) or not value.strip("0"):
                raise ValueError("--budget-mb requires a positive decimal integer")
            value = value.lstrip("0")
            if len(value) > 10 or int(value) > MAX_BUDGET_MB:
                raise ValueError("--budget-mb must not exceed %d MB" % MAX_BUDGET_MB)
            options.budget = int(value)
        elif arg.startswith("--lua="):
            options.lua = arg.split("=", 1)[1]
        elif arg.startswith("--questie="):
            options.questie = arg.split("=", 1)[1]
        elif arg == "--sequential":
            options.sequential = True
        elif arg in FLAVORS:
            positional.append(arg)
        elif arg == "check":
            tasks.extend(CHECKS)
        elif arg in (*GATES, "all"):
            tasks.append(arg)
        else:
            raise ValueError("unknown task, flavor, or option: " + arg)
    tasks = list(dict.fromkeys(tasks))
    if not tasks:
        raise ValueError("no task selected")
    if "all" in tasks:
        if len(tasks) != 1:
            raise ValueError("all cannot be combined with other tasks")
        tasks = ["generate", *CHECKS, "golden", "test"]
    if explicit is not None and positional:
        raise ValueError("positional flavors cannot be combined with --flavors")
    selected = explicit if explicit is not None else positional
    if "freeze" in tasks and any(flavor not in ("Vanilla", "Mists") for flavor in selected):
        raise ValueError("freeze supports only Vanilla and Mists")
    options.tasks = tasks
    options.flavors = list(dict.fromkeys(selected or FLAVORS))
    return options


def find_lua(explicit: Optional[str], root: Path) -> str:
    """Resolve an executable once; children use an absolute path, including paths with spaces."""
    candidates = [explicit] if explicit is not None else ["lua5.1", "lua"]
    found = []
    for candidate in candidates:
        if not candidate:
            continue
        local = root / candidate
        executable = str(local.resolve()) if local.is_file() else shutil.which(candidate)
        if executable:
            process = start_process([executable, "-e", "io.write(_VERSION)"], cwd=root,
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            try:
                output, _ = process.communicate()
            except BaseException:
                stop_process(process)
                raise
            if process.returncode == 0 and output == "Lua 5.1":
                return str(Path(executable).resolve())
            found.append("%s: %s" % (candidate, output.strip() or "unusable"))
    detail = "; found " + ", ".join(found) if found else ""
    raise ValueError("Lua 5.1 is required%s. Set LUA or --lua=/path/to/lua5.1." % detail)


def default_budget() -> int:
    """Use Linux available memory when present, otherwise a conservative 4 GiB estimate."""
    available = 4096
    try:
        for line in Path("/proc/meminfo").read_text().splitlines():
            if line.startswith("MemAvailable:"):
                available = int(line.split()[1]) // 1024
                break
    except (OSError, ValueError):
        pass
    return max(2000, available * 70 // 100)


def start_process(command: list[str], **kwargs: Any) -> subprocess.Popen:
    """Own a job's process group so cancellation can stop its nested Lua tools too."""
    if os.name == "nt":
        return subprocess.Popen(command, creationflags=subprocess.CREATE_NEW_PROCESS_GROUP, **kwargs)
    return subprocess.Popen(command, start_new_session=True, **kwargs)


def stop_process(process: subprocess.Popen) -> None:
    """Stop our job tree, then reap the leader; never kill unrelated processes by name."""
    if os.name == "nt":
        # taskkill is part of Windows, not an added toolchain dependency. Run it before
        # killing the leader so Windows can discover that process's descendants.
        if process.poll() is None:
            taskkill = Path(os.environ.get("SystemRoot", r"C:\Windows")) / "System32/taskkill.exe"
            try:
                subprocess.run([str(taskkill), "/PID", str(process.pid), "/T", "/F"],
                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, check=True, timeout=10)
            except (OSError, subprocess.TimeoutExpired, subprocess.CalledProcessError) as error:
                detail = error.output if isinstance(error, subprocess.CalledProcessError) else str(error)
                print("questiedb: process-tree cleanup failed; descendants may remain: %s" % detail, file=sys.stderr)
                process.kill()
    else:
        try:
            os.killpg(process.pid, signal.SIGTERM)
        except ProcessLookupError:
            pass
    try:
        process.wait(timeout=5)
    except subprocess.TimeoutExpired:
        process.kill()
        process.wait()
    finally:
        if os.name != "nt":
            # The leader may exit before a descendant that ignores SIGTERM.
            try:
                os.killpg(process.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass


def run_command(command: list[str], root: Optional[Path] = None,
                env: Optional[dict[str, str]] = None) -> int:
    """Wait for one foreground tool and reap it if the caller is interrupted."""
    process = start_process(command, cwd=root, env=env)
    try:
        return process.wait()
    except BaseException:
        stop_process(process)
        raise


def file_hash(path: Path) -> str:
    """Stream a TOC checksum rather than retaining large metadata files in memory."""
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


@dataclass
class Job:
    label: str
    command: list[str]
    weight: int
    priority: int = 0
    artifact: Optional[Path] = None


@dataclass
class Running:
    job: Job
    process: subprocess.Popen
    log: BinaryIO
    started: float
    before: Optional[str]


def run_jobs(jobs: list[Job], phase: str, root: Path, env: dict[str, str],
             budget: int, sequential: bool) -> bool:
    """Run one barrier phase; admission is memory-budgeted, failures block the next phase."""
    if not jobs:
        return True
    pending = sorted(jobs, key=lambda job: (-job.priority, -job.weight))
    running: list[Running] = []
    results = {}
    logdir = root / ".out/checks"
    started = time.monotonic()
    print("==> %s: %d jobs, budget %d MB%s" %
          (phase, len(jobs), budget, ", sequential" if sequential else ""), flush=True)
    try:
        while pending or running:
            used = sum(active.job.weight for active in running)
            while pending and not (sequential and running):
                # An oversized job runs alone; otherwise smaller jobs may fill unused budget.
                index = next((index for index, job in enumerate(pending)
                              if not running or used + job.weight <= budget), None)
                if index is None:
                    break
                job = pending.pop(index)
                before = file_hash(root / job.artifact) if job.artifact else None
                log = (logdir / (job.label.replace(":", "_") + ".log")).open("wb")
                print("  start %-22s (%4d MB, %d in flight)" %
                      (job.label, job.weight, len(running) + 1), flush=True)
                try:
                    process = start_process(job.command, cwd=root, env=env,
                                            stdout=log, stderr=subprocess.STDOUT)
                except BaseException:
                    log.close()
                    raise
                running.append(Running(job, process, log, time.monotonic(), before))
                used += job.weight
            finished = [active for active in running if active.process.poll() is not None]
            if not finished:
                time.sleep(0.02)
                continue
            for active in finished:
                code = active.process.wait()
                if code == 0 and active.job.artifact:
                    try:
                        if file_hash(root / active.job.artifact) != active.before:
                            raise ValueError("regenerated TOC checksum differs")
                        active.log.write(b"Determinism: identical bytes\n")
                    except (OSError, ValueError) as error:
                        active.log.write(("Determinism: %s\n" % error).encode("utf-8"))
                        code = 1
                active.log.close()
                running.remove(active)
                results[active.job.label] = (code, time.monotonic() - active.started)
                print("    %-4s %-22s %7.1fs" %
                      ("ok" if code == 0 else "FAIL", active.job.label, results[active.job.label][1]), flush=True)
    finally:
        # Cancellation or a launch failure must not leave our direct children writing outputs.
        for active in running:
            try:
                stop_process(active.process)
            finally:
                active.log.close()
    print("\n==> %s results (%.1fs)" % (phase, time.monotonic() - started))
    failed = 0
    for job in jobs:
        code, duration = results[job.label]
        failed += code != 0
        summary = ""
        with (logdir / (job.label.replace(":", "_") + ".log")).open(encoding="utf-8", errors="replace") as log:
            for line in log:
                if re.search(r"^\[(PASS|FAIL)\]|^[0-9]+ checks|^OK(?: |$)|^FAILED|no regressions|divergences:", line):
                    summary = line.rstrip()
        print("  %-4s %-22s %7.1fs  %s" % ("PASS" if code == 0 else "FAIL", job.label, duration, summary))
    if failed:
        print("%d of %d failed in %s. Logs in .out/checks/" % (failed, len(jobs), phase))
    else:
        print("all %d %s jobs passed" % (len(jobs), phase))
    return failed == 0


def execute(options: Options, root: Path) -> int:
    """Resolve prerequisites, then execute Generation, Determinism, and checks in order."""
    lua = find_lua(options.lua, root)
    env = dict(os.environ, LUA=lua, QUESTIE_PATH=options.questie, QUESTIEDB_PYTHON=sys.executable)
    env["SOURCE_DATE_EPOCH"] = env.get("SOURCE_DATE_EPOCH") or "1700000000"
    if "differential" in options.tasks:
        pin = run_command([lua, "-e", "dofile('generator/lib.lua').assertQuestiePin(os.getenv('QUESTIE_PATH'))"],
                          root, env)
        if pin:
            return 1
    logdir = root / ".out/checks"
    logdir.mkdir(parents=True, exist_ok=True)
    for path in logdir.glob("*.log"):
        path.unlink()
    budget = options.budget or default_budget()
    started = time.monotonic()

    if "generate" in options.tasks:
        print("==> generating base TOC", flush=True)
        base_started = time.monotonic()
        base = run_command([lua, "generate.lua", "toc", "--quiet"], root, env)
        print("    %-4s generate:toc %7.1fs" % ("ok" if base == 0 else "FAIL",
                                               time.monotonic() - base_started))
        if base:
            return 1
        jobs = [Job("generate:" + flavor, [lua, "generate.lua", flavor, "--no-base-toc", "--quiet"],
                    WEIGHTS[flavor]) for flavor in options.flavors]
        if not run_jobs(jobs, "Generation", root, env, budget, options.sequential):
            return 1

    if "determinism" in options.tasks:
        jobs = [Job("determinism:" + flavor, [lua, "generate.lua", flavor, "--no-base-toc", "--quiet"],
                    WEIGHTS[flavor], artifact=Path("QuestieDB_%s.toc" % flavor)) for flavor in options.flavors]
        if not run_jobs(jobs, "determinism", root, env, budget, options.sequential):
            return 1

    jobs = []
    for gate in options.tasks:
        if gate in ("generate", "determinism"):
            continue
        if gate == "test":
            # The Lua database suite and Python orchestration suite are independent jobs.
            jobs.append(Job("test", [lua, "test.lua"], 650, priority=100))
            jobs.append(Job("test:cli", [sys.executable, "tools/cli/questiedb.test.py"], 100))
            continue
        for flavor in options.flavors:
            weight = WEIGHTS[flavor]
            label = gate + ":" + flavor
            if gate == "freeze":
                if flavor not in ("Vanilla", "Mists"):
                    continue
                command = [lua, "verify.lua", flavor, "--freeze"]
                label = "verify-freeze:" + flavor
            elif gate == "validators":
                command = [lua, "validators/run.lua", flavor]
                weight = weight * 25 // 100
            elif gate == "differential":
                command = [sys.executable, "tools/differential/compiler_diff.py", flavor,
                           "--questie=" + options.questie, "--lua=" + lua, "--self-check"]
                weight = weight * 75 // 100
            elif gate == "golden":
                command = [sys.executable, "tools/differential/golden.py", "check", flavor,
                           "--lua=" + lua, "--self-check"]
                weight = weight * 50 // 100
            else:
                command = [lua, gate + ".lua", flavor]
            jobs.append(Job(label, command, weight))
    if not run_jobs(jobs, "checks", root, env, budget, options.sequential):
        return 1
    print("\nall stages passed in %.1fs" % (time.monotonic() - started))
    return 0


def main(argv: Optional[list[str]] = None) -> int:
    """Dispatch standalone packaging/install commands without requiring an unrelated toolchain."""
    args = list(sys.argv[1:] if argv is None else argv)
    if args and args[0] in ("package", "bootstrap"):
        task = args.pop(0)
        try:
            return run_command([sys.executable, str(ROOT / "tools/distribution" / (task + ".py")), *args])
        except KeyboardInterrupt:
            return 130
        except OSError as error:
            print("questiedb: %s" % error, file=sys.stderr)
            return 1
    if not args or "--help" in args or "-h" in args:
        print(__doc__)
        return 0
    try:
        options = parse_args(args)
    except ValueError as error:
        print("questiedb: %s" % error, file=sys.stderr)
        return 2
    try:
        return execute(options, ROOT)
    except KeyboardInterrupt:
        print("\nquestiedb: cancelled", file=sys.stderr)
        return 130
    except (OSError, ValueError) as error:
        print("questiedb: %s" % error, file=sys.stderr)
        return 1


def interrupt(_signal: int, _frame: object) -> None:
    """Let ordinary cancellation cleanup run when a parent terminates the runner."""
    raise KeyboardInterrupt


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, interrupt)
    sys.exit(main())
