# helpers.py
import os
from pathlib import Path
import logging

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def get_project_dir_path():
  return os.path.dirname(os.path.realpath(__file__ + "/.."))  # Go up one level


def get_data_dir_path(entity_type: str, expansion: str):
  path = os.path.join(get_project_dir_path(), "Database", entity_type, expansion)
  # Does path not exist, l10n has this issue...
  if not os.path.exists(path):
    print(f"Path {path} does not exist, trying lowercase")
    path = os.path.join(get_project_dir_path(), "Database", entity_type.lower(), expansion)

  return path


# This is used to find the Addons folder, which is used to find the project directory.
# Used when generating out the relative paths for the HTML files, allows them to be
# embedded in an addon.
def find_addon_name():
  current_dir = Path.cwd()
  previous_dir = None
  addon_dir = None
  max_level = 20
  level = 0
  while level < max_level:
    if current_dir.name.lower() == "addons" and current_dir.parent.name.lower() == "interface":
      addon_dir = previous_dir
      break
    else:
      previous_dir = current_dir.name
      current_dir = current_dir.parent
      level += 1

  if addon_dir is None:
    logger.warning("Could not find the Addons folder, defaulting to 'QuestieDB'.")
    return "QuestieDB"
  else:
    logger.info("Found Addons folder: {}".format(addon_dir))

  return addon_dir


def read_expansion_data(expansion: str, entity_type: str):
  """
  Reads data for a given expansion and data type from a Lua file.

  :param expansion: The expansion name (e.g., "Era", "Tbc", "Wotlk")
  :param entity_type: The type of data (e.g., "Quest", "Item")
  :param entity_folder: The folder where the data files are located
  :return: A string containing the file's contents
  """
  path = os.path.join(get_data_dir_path(entity_type, expansion))
  logger.info(f"Reading {expansion} lua {entity_type.lower()} data from {path}")
  try:
    file_path = os.path.join(path, f"{entity_type.capitalize()}Data.lua-table")
    # Check if it exists, otherwise use lower l10n
    if not os.path.exists(file_path):
      file_path = os.path.join(path, f"{entity_type.lower()}Data.lua-table")

    with open(file_path, "r", encoding="utf-8") as file:
      data = file.read()
    # Perform any necessary replacements on the data string
    data = data.replace("&", "and").replace("<", "|").replace(">", "|")
    return data
  except FileNotFoundError:
    logger.error(f"File not found: {path}")
    return None
