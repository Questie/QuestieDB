# check_version.py
# This script is used in the CI workflow to ensure that any new release on the main branch
# has a version number that is strictly higher than the latest published GitHub release.
# It fetches the latest release tag from GitHub, parses the version, and compares it to the
# version reported by the TOC file. If the new version is not higher, the workflow fails.

import sys
import requests
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__)))
from version_utils import get_versions_from_toc, validate_same_version

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


def parse_version(version):
  """
  Parse a version string (e.g., '1.2.3' or 'v1.2.3-abcdef') into a tuple of integers (1, 2, 3).
  Strips leading 'v' and any suffix after a dash.
  Returns None if parsing fails.
  """
  print("Parse String:", version)
  try:
    version = version.lstrip("v").split("-")[0]
    version = version.strip('"')  # Remove any surrounding quotes
    return tuple(int(x) for x in version.split("."))
  except ValueError:
    return None


latest_tag = "0.0.0"
latest_version_tuple = (0, 0, 0)
found_valid_version = False

# 1. Try /releases/latest
print("Fetching latest release from /releases/latest...")
resp = requests.get(
  f"https://api.github.com/repos/{REPO}/releases/latest",
  headers=headers,
  timeout=10,
)

if resp.ok:
  data = resp.json()
  tag = data.get("tag_name", "")
  parsed = parse_version(tag)
  if parsed:
    latest_tag = tag
    latest_version_tuple = parsed
    found_valid_version = True
    print(f"Found latest release via /latest: {latest_tag}")

# 2. Fallback to /releases if needed
if not found_valid_version:
  print("Falling back to iterating /releases...")
  resp = requests.get(
    f"https://api.github.com/repos/{REPO}/releases",
    headers=headers,
    timeout=10,
  )

  if resp.status_code == 404:
    # No releases yet – treat as version 0.0.0
    pass
  elif resp.ok:
    releases = resp.json()
    if isinstance(releases, list):
      for release in releases:
        tag = release.get("tag_name", "")
        parsed = parse_version(tag)
        if parsed:
          latest_tag = tag
          latest_version_tuple = parsed
          found_valid_version = True
          break
  else:
    print(f"GitHub API error ({resp.status_code}): {resp.text}")
    sys.exit(1)


# Use the new functions to get and check all TOC versions
try:
  versions = get_versions_from_toc(os.path.join(os.path.dirname(__file__), ".."))
  if not validate_same_version(versions):
    print(f"Version mismatch in TOC files: {versions}")
    sys.exit(1)
  current_version = versions["vanilla"]
except Exception as exc:
  print(f"Failed to get version from TOC files: {exc}")
  sys.exit(1)

# Parse the current version
try:
  print("Latest version:", latest_version_tuple)
  current_version_tuple = parse_version(current_version)
  if current_version_tuple is None:
    raise ValueError(f"Current version '{current_version}' is invalid")
  print("Current version:", current_version_tuple)
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
