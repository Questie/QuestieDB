#!/bin/sh
# Python owns command parsing and orchestration on every platform.
set -eu
for python in python3 python; do
    if command -v "$python" >/dev/null 2>&1 &&
        "$python" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)' 2>/dev/null; then
        exec "$python" "$(dirname "$0")/tools/cli/questiedb.py" "$@"
    fi
done
echo 'QuestieDB requires Python 3.8+ (python3 or python) for this command.' >&2
echo 'To generate without Python, run ./generate.sh Vanilla from the checkout (see README.md, Working on corrections).' >&2
exit 2
