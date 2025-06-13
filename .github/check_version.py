# check_version.py
# This script is used in the CI workflow to ensure that any new release on the main branch
# has a version number that is strictly higher than the latest published GitHub release.
# It fetches the latest release tag from GitHub, parses the version, and compares it to the
# version reported by the TOC file. If the new version is not higher, the workflow fails.

import sys
import requests
import os

toc_files = {
  "classic": "QuestieDB-Classic.toc",
  "tbc": "QuestieDB-BCC.toc",
  "wotlk": "QuestieDB-WOTLKC.toc",
  "cata": "QuestieDB-Cata.toc",
}

# Get repository and token from environment variables set by GitHub Actions
REPO = os.environ.get("GITHUB_REPOSITORY")
GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")

if not REPO:
  print("GITHUB_REPOSITORY not set")
  sys.exit(1)

# Prepare headers for GitHub API authentication if token is available
headers = {}
if GITHUB_TOKEN:
  headers["Authorization"] = f"token {GITHUB_TOKEN}"

# Fetch the latest (non-prerelease) release from GitHub using the REST API
resp = requests.get(
  f"https://api.github.com/repos/{REPO}/releases/latest",
  headers=headers,
  timeout=10,
)
if resp.status_code == 404:
  # No releases yet – treat as version 0.0.0
  latest_tag = "0.0.0"
elif resp.ok:
  latest_tag = resp.json().get("tag_name", "0.0.0")
else:
  print(f"GitHub API error ({resp.status_code}): {resp.text}")
  sys.exit(1)


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


def parse_version(version):
  """
  Parse a version string (e.g., '1.2.3' or 'v1.2.3-abcdef') into a tuple of integers (1, 2, 3).
  Strips leading 'v' and any suffix after a dash.
  """
  version = version.lstrip("v").split("-")[0]
  version = version.strip('"')  # Remove any surrounding quotes
  print(version)
  return tuple(int(x) for x in version.split("."))


# Use the new functions to get and check all TOC versions
try:
  versions = get_versions_from_toc(os.path.join(os.path.dirname(__file__), ".."))
  if not validate_same_version(versions):
    print(f"Version mismatch in TOC files: {versions}")
    sys.exit(1)
  current_version = versions["classic"]
except Exception as exc:
  print(f"Failed to get version from TOC files: {exc}")
  sys.exit(1)

# Parse both the latest release version and the current version
try:
  latest_version_tuple = parse_version(latest_tag)
  current_version_tuple = parse_version(current_version)
except Exception as e:
  print(f"Error parsing versions: {e}")
  sys.exit(1)

# Compare versions: fail if the new version is not strictly higher
if current_version_tuple <= latest_version_tuple:
  print(f"Version not higher: {current_version} (latest release: {latest_tag})")
  sys.exit(1)
else:
  print(f"Version is higher: {current_version} (latest release: {latest_tag})")
  sys.exit(0)
