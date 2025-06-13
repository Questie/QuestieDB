# check_version.py
# This script is used in the CI workflow to ensure that any new release on the main branch
# has a version number that is strictly higher than the latest published GitHub release.
# It fetches the latest release tag from GitHub, parses the version, and compares it to the
# version reported by build.py. If the new version is not higher, the workflow fails.

import subprocess
import sys
import requests
import os

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

# Get the current version from build.py (which reads from the TOC file)
try:
  current_version = subprocess.check_output(
    [sys.executable, "build.py", "version"],
    stderr=subprocess.STDOUT,
    text=True,
  ).strip()
except subprocess.CalledProcessError as exc:
  print(f"`build.py version` failed:\n{exc.output}")
  sys.exit(exc.returncode)


def parse_version(version):
  """
  Parse a version string (e.g., '1.2.3' or 'v1.2.3-abcdef') into a tuple of integers (1, 2, 3).
  Strips leading 'v' and any suffix after a dash.
  """
  version = version.lstrip("v").split("-")[0]
  version = version.strip('"')  # Remove any surrounding quotes
  return tuple(int(x) for x in version.split("."))


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
