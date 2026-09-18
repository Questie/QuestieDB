"""A parent waiting for a descendant that ignores graceful termination.

The descendant announces readiness, then waits for the test's release file. If cancellation
misses it, it writes to the inherited stdout pipe. No fixed sleep races the cancellation.
"""
from pathlib import Path
import signal
import subprocess
import sys
import time


def main() -> None:
    """Both levels keep stdout open until they exit, so the test can await complete cleanup."""
    ready, release = map(Path, sys.argv[1:3])
    if sys.argv[3:] == ["child"]:
        signal.signal(signal.SIGTERM, signal.SIG_IGN)
        ready.touch()
        while not release.exists():
            time.sleep(0.01)
        print("escaped", flush=True)
    else:
        command = [sys.executable, __file__, str(ready), str(release), "child"]
        with subprocess.Popen(command) as child:
            child.wait()


if __name__ == "__main__":
    main()
