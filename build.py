# Copy the strutcture of the project to the build directory
# Only include files in root folders that does not start with a dot
# Only include *.lua, *.html, *.toc and *.xml files

import os
import shutil
import sys
import json


base_build_dir = "./.build"

toc_files = {
  "classic": "QuestieDB-Classic.toc",
  "tbc": "QuestieDB-BCC.toc",
  "wotlk": "QuestieDB-WOTLKC.toc",
  "cata": "QuestieDB-Cata.toc",
}

disallowed_folders = [
  "cli",
  ".wowhead",
  ".translator",
  ".git",
  ".vscode",
  ".generate_database",
  ".database_generator",
  ".tests",
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


def get_versions_from_toc(path="."):
  versions = {}
  for key, filename in toc_files.items():
    version = None
    filepath = os.path.join(path, filename)
    try:
      with open(filepath, "r") as f:
        for line in f:
          if line.startswith("## Version:"):
            version = line.split(":", 1)[1].strip()
            break  # Found the version, no need to read further
    except FileNotFoundError:
      print(f"Warning: TOC file not found at {filepath}")
      # Keep version as None
    except Exception as e:
      print(f"Warning: Error reading {filepath}: {e}")
      # Keep version as None
    versions[key] = version
  return versions


def validate_same_version(versions):
  """Checks if all version values in the dictionary are the same."""
  if not versions:
    return True  # Or False, depending on desired behavior for empty input

  # Get all version values, filtering out None in case a file is missing or lacks the version line
  version_values = [v for v in versions.values() if v is not None]

  # If there are no valid versions or only one, they are considered the same
  if len(version_values) <= 1:
    return True

  # Check if all valid version values are identical by comparing them to the first one
  first_version = version_values[0]
  return all(v == first_version for v in version_values)


def get_versionstring_from_toc():
  versions = get_versions_from_toc()
  if validate_same_version(versions):
    return versions["classic"]
  else:
    raise Exception("Version mismatch")


def export_version_github_actions(versions):
  if "GITHUB_ACTIONS" in os.environ and os.environ["GITHUB_ACTIONS"] == "true":
    print("::set-output name=toc_version::" + get_versionstring_from_toc())
    versions = get_versions_from_toc()
    split_version = versions["classic"].split(".")
    print("::set-output name=major_toc_version::" + split_version[0])
    print("::set-output name=minor_toc_version::" + split_version[1])
    print("::set-output name=patch_toc_version::" + split_version[2])


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
    versions = get_versions_from_toc()
    export_version_github_actions(versions)

    if "GITHUB_SHA" in os.environ and os.environ["GITHUB_SHA"] and len(os.environ["GITHUB_SHA"]) >= 7:
      short_commit_hash = os.environ["GITHUB_SHA"][:7]
      toc_files_path = []
      for _, filename in toc_files.items():
        toc_files_path.append(os.path.join(build_dir, filename))
      # Check if toc files exist
      for toc_file in toc_files_path:
        print(f"Adding sha {short_commit_hash} commit hash to toc file: {toc_file}")
        with open(toc_file, "r") as f:
          full_file = f.readlines()
        with open(toc_file, "w") as f:
          for line in full_file:
            if "## Version:" in line:
              version = line.split(":")[1].strip()
              f.write(f"## Version: {version}-{short_commit_hash}\n")
            else:
              f.write(line)

    print("Done")
  elif command == "version":
    # If we are in github actions we output the toc version
    versions = get_versions_from_toc()
    export_version_github_actions(versions)

    print(json.dumps(get_versionstring_from_toc(), ensure_ascii=False))
    return get_versionstring_from_toc()
  else:
    raise Exception(f"Unknown command: {command}")


if __name__ == "__main__":
  main()
