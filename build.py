# Copy the strutcture of the project to the build directory
# Only include files in root folders that does not start with a dot
# Only include *.lua, *.html, *.toc and *.xml files

import os
import shutil
import sys
import json

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".github"))
from version_utils import get_versions_from_toc, validate_same_version, toc_files  # type: ignore


base_build_dir = "./.build"

disallowed_folders = [
  ".ai_lua",
  ".ai_py",
  ".ai_scripts",
  "cli",
  ".wowhead",
  ".translator",
  ".git",
  ".vscode",
  ".generate_database",
  ".database_generator",
  ".generate",  # General generate folders
  ".tests",
  ".shit",
  # Python venv
  "venv",
  # Github actions
  ".lua",
  ".luarocks",
  # Perfy performance thing
  "Perfy",
  # Stuff
  "WoW-API",
]

disallowed_files_exact = [
  "_dotenv.lua",
]

remove_lines_from_toc = [
  "_dotenv.lua",  # Remove dotenv file from toc
  "# Load Environment",
]


def copy_files(src, dest):
  files_to_copy = {}
  files_copied = 0
  for root, dirs, files in os.walk(src):
    if root.startswith(".\\."):
      continue
    # Check if the folder is disallowed
    cont = False
    for folder in disallowed_folders:
      if folder in root:
        cont = True
        break
    # Continue if the folder is disallowed
    if cont:
      continue

    for file in files:
      if file in disallowed_files_exact:  # Skip disallowed files
        continue
      if file.endswith(".lua") or file.endswith(".html") or file.endswith(".toc") or file.endswith(".xml") or file.endswith("LICENSE") or file.endswith("README.md"):
        # print(file)
        filepath = os.path.join(root, file).replace("\\", "/")
        # Replace first dot character with .build
        destpath = filepath.replace(".", dest, 1)

        # Create directories if they do not exist
        os.makedirs(os.path.dirname(destpath), exist_ok=True)

        files_to_copy[destpath] = filepath
        files_copied += 1
  print(f"{len(files_to_copy)} files to copy")
  copied = 0
  for destpath, filepath in files_to_copy.items():
    shutil.copy(filepath, destpath)
    copied += 1
    if copied % 100 == 0:
      print(f"Copied {copied}/{len(files_to_copy)} files")
  print(f"Copied {files_copied} files")
  return files_copied


def export_version_github_actions(versions):
  if "GITHUB_ACTIONS" in os.environ and os.environ["GITHUB_ACTIONS"] == "true":
    print("::set-output name=toc_version::" + get_versionstring_from_toc())
    versions = get_versions_from_toc(".")
    split_version = versions["vanilla"].split(".")
    print("::set-output name=major_toc_version::" + split_version[0])
    print("::set-output name=minor_toc_version::" + split_version[1])
    print("::set-output name=patch_toc_version::" + split_version[2])


def get_versionstring_from_toc():
  versions = get_versions_from_toc(".")
  if validate_same_version(versions):
    return versions["vanilla"]
  else:
    raise Exception("Version mismatch")


def main():
  # Arg 1 Command
  if len(sys.argv) > 1:
    command = sys.argv[1]
  else:
    command = "build"

  if command == "build":
    # Arg1 Build Directory Name
    # Directory Name from args
    if len(sys.argv) > 2:
      build_output = sys.argv[2]
    else:
      build_output = "QuestieDB." + get_versionstring_from_toc()

    if not os.path.exists(base_build_dir):
      os.mkdir(base_build_dir)

    build_dir = f"{base_build_dir}/{build_output}"
    if not os.path.exists(build_dir):
      os.mkdir(build_dir)
    else:
      # Delete the directory if it exists
      print(f"Build directory '{build_dir}' already exists. Deleting...")
      shutil.rmtree(build_dir)
      os.mkdir(build_dir)
    print(f"Build directory '{build_dir}' created")
    print(f"Copying files to build directory '{build_dir}'...")
    copy_files(".", build_dir)
    # If we are in github actions we output the toc version
    versions = get_versions_from_toc(".")
    export_version_github_actions(versions)

    # Always build toc_files_path and short_commit_hash
    toc_files_path = [os.path.join(build_dir, filename) for _, filename in toc_files.items()]
    short_commit_hash = ""
    if "GITHUB_SHA" in os.environ and os.environ["GITHUB_SHA"] and len(os.environ["GITHUB_SHA"]) >= 7:
      short_commit_hash = f"-{os.environ['GITHUB_SHA'][:7]}"

    # If short_commit_hash is not empty, we will update the toc files with the current commit hash
    if short_commit_hash == "":
      # Use git to get the current commit hash
      try:
        import subprocess

        short_commit_hash_raw = subprocess.check_output(["git", "rev-parse", "--short", "HEAD"]).strip().decode("utf-8")
        short_commit_hash = f"-{short_commit_hash_raw}"
        print("Updating toc files with commit hash:", short_commit_hash)
      except Exception as e:
        print(f"Error getting git commit hash: {e}")
        short_commit_hash = ""

    for toc_file in toc_files_path:
      if not os.path.exists(toc_file):
        print(f"Warning: TOC file {toc_file} not found in build directory. Skipping.")
        continue
      print(f"Processing toc file{' with sha' if short_commit_hash else ' (no commit hash)'}: {toc_file}")
      with open(toc_file, "r") as f:
        full_file = f.readlines()
      with open(toc_file, "w") as f:
        for line in full_file:
          # Remove lines from toc, for example `_dotenv.lua`
          if line.strip() in remove_lines_from_toc:
            print(f"  Removing line: {line.strip()}")
            continue
          if "## Version:" in line:
            version = line.split(":")[1].strip()
            if short_commit_hash:
              print(f"  Updating version with sha: {version}{short_commit_hash}")
              f.write(f"## Version: {version}{short_commit_hash}\n")
            else:
              f.write(line)
          else:
            f.write(line)
    print("Done")
  elif command == "version":
    # If we are in github actions we output the toc version
    versions = get_versions_from_toc(".")
    export_version_github_actions(versions)

    print(json.dumps(get_versionstring_from_toc(), ensure_ascii=False))
    return get_versionstring_from_toc()
  else:
    raise Exception(f"Unknown command: {command}")


if __name__ == "__main__":
  main()
