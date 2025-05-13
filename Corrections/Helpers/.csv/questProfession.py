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


data = load_csv("SkillLine.5.5.0.60700.csv")

lua_table_parts = ["---@enum ProfessionEnum", "QuestCorrection.professionKeys = {"]
professions = []

# Skip header row
# CSV columns: DisplayName_lang (0), AlternateVerb_lang (1), Description_lang (2), ..., ID (5), CategoryID (6)
for row in data[1:]:
  if not row or len(row) < 7:  # Skip empty rows or rows with insufficient columns
    continue
  try:
    category_id = row[6]
    description = row[2]
    display_name = row[0]
    id_val = int(row[5])

    if (category_id == "11" or category_id == "9") and description.strip() != "":
      key_name = format_key(display_name)
      if key_name:  # Ensure key_name is not empty after formatting
        professions.append((id_val, key_name))

  except ValueError:
    print(f"Skipping row due to invalid ID: {row}")
  except IndexError:
    print(f"Skipping row due to missing columns: {row}")

# Sort professions by ID
professions.sort(key=lambda x: x[0])

for id_val, key_name in professions:
  lua_table_parts.append(f"  {key_name} = {id_val},")

lua_table_parts.append("}")
generated_lua_table_string = "\n".join(lua_table_parts)
print(generated_lua_table_string)

# --- New code to load, replace, and save QuestProfession.lua ---
# Assuming QuestProfession.lua is in the parent directory of the current script's directory
quest_meta_file_path = os.path.join(current_dir, "..", "QuestProfession.lua")

try:
  with open(quest_meta_file_path, "r", encoding="utf-8") as file:
    lua_content = file.read()

  # Regex to find the QuestMeta.professionKeys table
  # It looks for "---@enum ProfessionEnum" followed by "QuestMeta.professionKeys = {"
  # and captures everything until the matching closing brace.
  match = re.search(r"---@enum ProfessionEnum.*?QuestCorrection\.professionKeys\s*=\s*\{", lua_content, re.DOTALL | re.MULTILINE)
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
      # The generated_lua_table_string already includes the "---@enum ProfessionEnum"
      # and "QuestMeta.professionKeys = {" parts.

      # Find the start of the "---@enum ProfessionEnum" line for replacement
      enum_comment_start = lua_content.rfind("---@enum ProfessionEnum", 0, start_index)
      if enum_comment_start == -1:  # Fallback if comment not found before, use table start
        enum_comment_start = start_index

      new_lua_content = lua_content[:enum_comment_start] + generated_lua_table_string + lua_content[end_index:]

      with open(quest_meta_file_path, "w", encoding="utf-8") as file:
        file.write(new_lua_content)
      print(f"\nSuccessfully updated {quest_meta_file_path}")
    else:
      print(f"\nError: Could not find the closing brace for QuestMeta.professionKeys in {quest_meta_file_path}")
  else:
    print(f"\nError: Could not find '---@enum ProfessionEnum' and 'QuestMeta.professionKeys = {{' in {quest_meta_file_path}")

except FileNotFoundError:
  print(f"\nError: {quest_meta_file_path} not found.")
except Exception as e:
  print(f"\nAn error occurred: {e}")
