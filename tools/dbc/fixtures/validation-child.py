"""Stand in for a slow validator and exercise escalation past ignored SIGTERM."""
import json
import os
from pathlib import Path
import signal
import sys
import time

signal.signal(signal.SIGTERM, signal.SIG_IGN)
Path(os.environ["DBC_CANCEL_READY"]).write_text(json.dumps({
    "pid": os.getpid(), "temporary": str(Path(sys.argv[1]).parent),
}))
while True:
    time.sleep(0.1)
