"""
version_utils.py
Shared version extraction and validation logic for QuestieDB build and CI scripts.
"""
import os
import sys

toc_files = {
    "classic": "QuestieDB-Classic.toc",
    "tbc": "QuestieDB-BCC.toc",
    "wotlk": "QuestieDB-WOTLKC.toc",
    "cata": "QuestieDB-Cata.toc",
}

def get_versions_from_toc(path=".."):
    """
    Reads all TOC files and returns a dict of {key: version} for each expansion.
    """
    versions = {}
    for key, filename in toc_files.items():
        toc_path = os.path.join(path, filename)
        version = None
        try:
            with open(toc_path, "r") as f:
                for line in f:
                    if line.startswith("## Version:"):
                        version = line.split(":", 1)[1].strip()
                        break
        except FileNotFoundError:
            print(f"TOC file not found at {toc_path}")
            sys.exit(1)
        except Exception as e:
            print(f"Error reading {toc_path}: {e}")
            sys.exit(1)
        versions[key] = version
    return versions

def validate_same_version(versions):
    """Checks if all version values in the dictionary are the same."""
    version_values = [v for v in versions.values() if v is not None]
    if len(version_values) <= 1:
        return True
    first_version = version_values[0]
    return all(v == first_version for v in version_values)
