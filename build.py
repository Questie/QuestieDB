# Copy the strutcture of the project to the build directory
# Only include files in root folders that does not start with a dot
# Only include *.lua, *.html, *.toc and *.xml files

import os
import shutil


def copy_files(src, dest):
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
    for file in files:
      if file.endswith(".lua") or file.endswith(".html") or file.endswith(".toc") or file.endswith(".xml") or file.endswith("LICENSE") or file.endswith("README.md"):
        # print(file)
        filepath = os.path.join(root, file).replace("\\", "/")
        # Replace first dot character with .build
        destpath = filepath.replace(".", dest, 1)

        # Create directories if they do not exist
        os.makedirs(os.path.dirname(destpath), exist_ok=True)

        shutil.copy(filepath, destpath)
        files_copied += 1
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


def main():
  build_dir = "./.build/QuestieDB." + get_version_from_toc()
  if not os.path.exists(build_dir):
    os.mkdir(build_dir)
  print("Copying files to build directory...")
  copy_files(".", build_dir)
  print("Done")


if __name__ == "__main__":
  main()
