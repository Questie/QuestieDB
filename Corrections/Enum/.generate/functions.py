import csv
import re
import os
import requests

# Get current script directory
curr_dir = os.path.dirname(os.path.abspath(__file__))
print(curr_dir)


def current_dir():
  return curr_dir


def download_csv(url, filename):
  response = requests.get(url)
  if response.status_code == 200:
    with open(filename, "wb") as file:
      file.write(response.content)
    print(f"Downloaded {filename}")
  else:
    print(f"Failed to download {filename}: {response.status_code}")


# Load the CSV file
def load_csv(file_path):
  with open(file_path, mode="r", encoding="utf-8") as file:
    reader = csv.reader(file)
    data = [row for row in reader]
  return data


def format_key(name):
  # Remove apostrophes and other special characters, replace spaces with underscores
  name = re.sub(r"[^\w\s-]", "", name)
  name = re.sub(r"[\s-]+", "_", name)
  return name.upper()


# --- Reusable Lua block update function ---
def update_lua_block(lua_file_path, new_block_content, block_start_regex_pattern):
  """
  Replaces a block of Lua code in a file, identified by a regex pattern
  matching its start (e.g., enum comment + table assignment up to '{'),
  with new content.
  """
  try:
    with open(lua_file_path, "r", encoding="utf-8") as file:
      lua_content = file.read()

    match = re.search(block_start_regex_pattern, lua_content, re.DOTALL | re.MULTILINE)

    if not match:
      print(f"\nError: Could not find the Lua block to replace using pattern: {block_start_regex_pattern} in {lua_file_path}")
      return False

    replacement_start_index = match.start()
    search_for_closing_brace_from_index = match.end()

    brace_level = 1
    old_block_end_index = -1

    for i in range(search_for_closing_brace_from_index, len(lua_content)):
      if lua_content[i] == "{":
        brace_level += 1
      elif lua_content[i] == "}":
        brace_level -= 1
        if brace_level == 0:
          old_block_end_index = i + 1
          break

    if old_block_end_index != -1:
      new_lua_content = lua_content[:replacement_start_index] + new_block_content + lua_content[old_block_end_index:]

      with open(lua_file_path, "w", encoding="utf-8") as file:
        file.write(new_lua_content)
      print(f"\nSuccessfully updated {lua_file_path}")
      return True
    else:
      print(f"\nError: Could not find the matching closing brace for the table in {lua_file_path} after pattern match.")
      return False

  except FileNotFoundError:
    print(f"\nError: {lua_file_path} not found.")
    return False
  except Exception as e:
    print(f"\nAn error occurred during Lua file update: {e}")
    return False
