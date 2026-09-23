"""Drive real tool cleanup with fixture-only blocking I/O; no network or database writes."""
import io
import json
import os
from pathlib import Path
import sys
import time

TOOLS = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOLS))
phase, directory = sys.argv[1:]
root = Path(directory)
ready = root / "ready.json"

if phase == "validation":
    import convert
    convert.ROOT = root
    convert.INPUTS = ()
    convert.find_lua = lambda *_: sys.executable
    convert.ensure_database = lambda *_args, **_kwargs: {"origin": "fixture", "path": "fixture"}
    convert.geometry = lambda *_: ({}, {})
    convert.require_matching_helper = lambda *_: {"details": "fixture helper matched"}
    convert.prepare = lambda *_: ({}, {"files": {}})
    os.environ["DBC_CANCEL_READY"] = str(ready)
    sys.argv = ["convert.py", "--from-build", "1.15.9.69722", "--to-build", "1.60.1.69893", "--dry-run"]
    raise SystemExit(convert.main())

if phase == "download":
    import download
    import maps
    metadata = [
        {"tag_name": "fixture", "assets": [
            {"name": "manifest.json", "browser_download_url": "https://fixture/manifest"},
            {"name": "dbc-source.db.xz", "browser_download_url": "https://fixture/database"}]},
        {"tag": "fixture", "artifacts": {"source": {"filename": "dbc-source.db.xz", "sha256": "0" * 64}}},
    ]
    download.should_use_gh = lambda: False
    download.read_json = lambda _url: metadata.pop(0)

    class BlockingDownload(io.BytesIO):
        def read(self, _size=-1):
            ready.write_text(json.dumps({"pid": os.getpid()}))
            while True:
                time.sleep(0.1)

    download.open_url = lambda _url: BlockingDownload()
    sys.argv = ["maps.py", "--from-build", "1.15.9.69722", "--to-build", "1.60.1.69893",
                "--database", str(root / "cache/dbc-source.db")]
    raise SystemExit(maps.main())

raise ValueError("Unknown fixture phase")
