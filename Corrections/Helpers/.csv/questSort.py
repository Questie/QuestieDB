import csv
import re

# Get current script directory
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
print(current_dir)


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


data = load_csv("QuestSort.5.5.0.60700.csv")

lua_table_parts = ["---@enum QuestSortKeys @ These are the values for the 'zoneOrSort' field", "QuestCorrection.sortKeys = {"]
sort_keys_data = []  # Store key-value pairs for sorting

# Skip header row
for row in data[1:]:
  if not row:  # Skip empty rows
    continue
  try:
    id_val = int(row[0])
    sort_name = row[1]

    # Format the key (e.g., "Hallow's End" -> HALLOWS_END)
    key_name = format_key(sort_name)

    sort_keys_data.append({"key": key_name, "value": -abs(id_val)})

  except ValueError:
    print(f"Skipping row due to invalid ID: {row}")
  except IndexError:
    print(f"Skipping row due to missing columns: {row}")

# Sort the data by value (ID)
sort_keys_data.sort(key=lambda x: x["value"], reverse=True)

for item in sort_keys_data:
  lua_table_parts.append(f"  {item['key']} = {item['value']},")


lua_table_parts.append("}")
generated_lua_table_string = "\n".join(lua_table_parts)
print(generated_lua_table_string)

# --- New code to load, replace, and save QuestSort.lua ---
quest_profession_file_path = os.path.join(current_dir, "..", "QuestSort.lua")

try:
  with open(quest_profession_file_path, "r", encoding="utf-8") as file:
    lua_content = file.read()

  # Regex to find the QuestCorrection.sortKeys table
  # This regex looks for the start of the table definition and its closing '}'
  # It handles cases where the table might be empty or span multiple lines.
  # (?s) allows . to match newlines.
  # It captures the part before the table, the table itself, and the part after.
  pattern = re.compile(r"(QuestCorrection\.sortKeys\s*=\s*\{)(?:[^{}]*\{[^{}]*\})*?[^{}]*(\})", re.DOTALL | re.MULTILINE)

  # Find the start and end of the old table
  match = re.search(r"---@enum QuestSortKeys.*?QuestCorrection\.sortKeys\s*=\s*\{", lua_content, re.DOTALL | re.MULTILINE)
  if match:
    start_index = match.start()
    # Find the matching closing brace for this table
    # Initialize brace_level to 1 to account for the opening brace already matched by the regex
    brace_level = 1
    end_index = -1
    # Loop starts from the character *after* the initial opening brace
    for i in range(match.end(), len(lua_content)):
      if lua_content[i] == "{":
        brace_level += 1
      elif lua_content[i] == "}":
        brace_level -= 1
        if brace_level == 0:  # Found the closing brace of our table
          end_index = i + 1
          break

    if end_index != -1:
      # Reconstruct the content with the new table
      # The generated_lua_table_string already includes the header and QuestCorrection.sortKeys = {
      # So we just need to place it correctly.
      # The first line of generated_lua_table_string is the enum comment.
      # The second line is QuestCorrection.sortKeys = {
      # The rest are the entries, and the last line is }

      # We want to replace from "---@enum QuestSortKeys" up to the closing } of the old table

      # Find the start of the "---@enum QuestSortKeys" line for replacement
      enum_comment_start = lua_content.rfind("---@enum QuestSortKeys", 0, start_index)
      if enum_comment_start == -1:  # Fallback if comment not found before, use table start
        enum_comment_start = start_index

      new_lua_content = lua_content[:enum_comment_start] + generated_lua_table_string + lua_content[end_index:]

      with open(quest_profession_file_path, "w", encoding="utf-8") as file:
        file.write(new_lua_content)
      print(f"\nSuccessfully updated {quest_profession_file_path}")
    else:
      print(f"\nError: Could not find the closing brace for QuestCorrection.sortKeys in {quest_profession_file_path}")
  else:
    print(f"\nError: Could not find 'QuestCorrection.sortKeys = {{' in {quest_profession_file_path}")

except FileNotFoundError:
  print(f"\nError: {quest_profession_file_path} not found.")
except Exception as e:
  print(f"\nAn error occurred: {e}")
