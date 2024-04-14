# Copy the strutcture of the project to the build directory
# Only include files in root folders that does not start with a dot
# Only include *.lua, *.html, *.toc and *.xml files

import os
import shutil
import sys


base_build_dir = "./.build"


def copy_files(src, dest):
  files_to_copy = {}
  files_copied = 0
  for root, dirs, files in os.walk("."):
    if root.startswith(".\\."):
      continue
    if "cli" in root:
      continue
    if ".wowhead" in root:
      continue
    if ".translator" in root:
      continue
    if ".git" in root:
      continue
    if ".vscode" in root:
      continue
    if ".generate_database" in root:
      continue
    if ".tests" in root:
      continue
    # Python venv
    if "venv" in root:
      continue
    # Github actions
    if ".lua" in root:
      continue
    if ".luarocks" in root:
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


def get_version_from_toc():
  classic_version = None
  tbc_version = None
  wotlk_version = None
  with open("QuestieDB-Classic.toc", "r") as f:
    for line in f:
      if "## Version:" in line:
        classic_version = line.split(":")[1].strip()
  with open("QuestieDB-BCC.toc", "r") as f:
    for line in f:
      if "## Version:" in line:
        tbc_version = line.split(":")[1].strip()
  with open("QuestieDB-WOTLKC.toc", "r") as f:
    for line in f:
      if "## Version:" in line:
        wotlk_version = line.split(":")[1].strip()
  if classic_version == tbc_version == wotlk_version:
    return classic_version
  else:
    raise Exception("Version mismatch")


def main():
  # Arg1 Build Directory Name
  # Directory Name from args
  if len(sys.argv) > 1:
    build_output = sys.argv[1]
  else:
    build_output = "QuestieDB." + get_version_from_toc()

  if not os.path.exists(base_build_dir):
    os.mkdir(base_build_dir)

  build_dir = f"{base_build_dir}/{build_output}"
  if not os.path.exists(build_dir):
    os.mkdir(build_dir)
  print(f"Copying files to build directory '{build_dir}'...")
  copy_files(".", build_dir)
  # If we are in github actions we output the toc version
  if os.environ["GITHUB_ACTIONS"] == "true":
    print("::set-output name=toc_version::" + get_version_from_toc())

  if os.environ["GITHUB_SHA"]:
    short_commit_hash = os.environ["GITHUB_SHA"][:7]
    for toc_file in [f"{build_dir}/QuestieDB-Classic.toc", f"{build_dir}/QuestieDB-BCC.toc", f"{build_dir}/QuestieDB-WOTLKC.toc"]:
      print(f"Adding sha {short_commit_hash} commit hash to toc file")
      with open(toc_file, "r") as f:
        full_file = f.readlines()
      with open(toc_file, "w") as f:
        for line in full_file:
          if "## Version:" in line:
            version = line.split(":")[1].strip()
            f.write(f"## Version: {version}+{short_commit_hash}\n")
          else:
            f.write(line)

  print("Done")


if __name__ == "__main__":
  main()
