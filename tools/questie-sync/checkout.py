#!/usr/bin/env python3
"""Fetch the reviewed legacy Questie snapshot for schema materialization.

The working directory is the QuestieDB checkout. Explicit user checkouts never reach
this helper; generator/questie.lua validates those without modifying them.
"""
from __future__ import annotations

import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile

REMOTE = "https://github.com/Questie/Questie.git"


def assert_pin(path: Path, commit: str) -> None:
    """Do not reset or repair an existing cache entry that is not the reviewed commit."""
    result = subprocess.run(["git", "-C", str(path), "rev-parse", "HEAD"],
                            capture_output=True, text=True, check=True)
    if result.stdout.strip() != commit:
        raise ValueError("Questie checkout %s does not match pin %s" % (path, commit))


def resolve(root: Path, remote: str = REMOTE) -> Path:
    """Reuse a per-pin cache, publishing only a complete shallow, tag-free checkout."""
    commit = (root / "QUESTIE_COMMIT").read_text().strip()
    if not re.fullmatch(r"[0-9a-f]{40}", commit):
        raise ValueError("QUESTIE_COMMIT must contain one lowercase 40-character Git SHA")
    cache = root / ".cache/questie"
    target = cache / commit
    if os.path.lexists(target):
        assert_pin(target, commit)
        return target
    cache.mkdir(parents=True, exist_ok=True)
    print("Fetching pinned Questie %s into %s" % (commit, target), file=sys.stderr)
    with tempfile.TemporaryDirectory(prefix=".fetch-", dir=cache) as temporary:
        staging = Path(temporary)
        commands = [
            ["git", "init", "--quiet", str(staging)],
            ["git", "-C", str(staging), "remote", "add", "origin", remote],
            ["git", "-C", str(staging), "fetch", "--quiet", "--depth=1", "--no-tags", "origin", commit],
            ["git", "-C", str(staging), "-c", "advice.detachedHead=false", "checkout", "--quiet", "--detach", commit],
        ]
        for command in commands:
            subprocess.run(command, check=True)
        assert_pin(staging, commit)
        try:
            staging.rename(target)
        except OSError:
            # Another invocation can finish the same pin first. Never replace its directory.
            if not (target / ".git").is_dir():
                raise
            assert_pin(target, commit)
    return target


def main() -> int:
    """Print only the resolved relative path; progress and failures belong on stderr."""
    try:
        root = Path.cwd()
        print(resolve(root).relative_to(root).as_posix())
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print("Questie input checkout failed: %s\nCheck Git/network access or pass --questie=<pinned-checkout>." % error,
              file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
