"""Expose actual argv and exit-code forwarding through the public launchers."""
import json
import os
import sys

print(json.dumps(sys.argv[1:]))
sys.exit(int(os.environ.get("QUESTIEDB_TEST_EXIT", "0")))
