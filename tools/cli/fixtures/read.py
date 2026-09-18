"""Record a Python gate starting in the disposable command-flow fixture."""
from pathlib import Path
import sys

with Path("events.log").open("a") as log:
    log.write("read:" + sys.argv[0] + "\n")
