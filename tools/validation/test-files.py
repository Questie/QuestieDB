"""Small filesystem adapter for Lua's offline tests; no platform shell utilities needed."""
import argparse
from pathlib import Path
import shutil
import tempfile


def main():
    """Print an acknowledgement only after the requested operation succeeds."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("operation", choices=("list", "temp", "remove"))
    parser.add_argument("path", nargs="?")
    parser.add_argument("--recursive", action="store_true")
    parser.add_argument("--suffix", action="append", default=[])
    args = parser.parse_args()
    result = []
    if args.operation == "temp":
        result = [Path(tempfile.mkdtemp(prefix="questiedb-test-")).as_posix()]
    else:
        if args.path is None:
            parser.error("path is required")
        path = Path(args.path)
        if args.operation == "remove":
            if path.is_symlink() or path.is_file():
                path.unlink()
            elif path.exists():
                shutil.rmtree(path)
        else:
            paths = path.rglob("*") if args.recursive else path.iterdir()
            result = sorted(p.as_posix() for p in paths if p.is_file() and
                            (not args.suffix or any(p.name.endswith(suffix) for suffix in args.suffix)))
    print("OK")
    for value in result:
        print(value)


if __name__ == "__main__":
    main()
