import os
from functions import load_csv, format_key, update_lua_block, current_dir

data = load_csv("SkillLine.5.5.0.60700.csv")

lua_table_parts = [
  "---@class QuestProfessionKeys:OverrideQuestProfessionKeys",
  "QuestCorrection.professionKeys = {",
  "  -- This table is auto-generated from the CSV file",
  "  -- Do not edit this table directly",
  "  -- Instead, edit the override table above",
  "",
]
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

lua_table_parts += [
  "",
  "  -- This table is auto-generated from the CSV file",
  "  -- Do not edit this table directly",
  "  -- Instead, edit the override table above",
]

lua_table_parts.append("}")
generated_lua_table_string = "\n".join(lua_table_parts)
print(generated_lua_table_string)

# --- Use the helper function to update QuestProfession.lua ---
quest_profession_lua_file_path = os.path.join(current_dir(), "..", "QuestProfession.lua")

# This regex matches the "---@class QuestProfessionKeys:OverrideQuestProfessionKeys" comment, any characters in between (non-greedy),
# and "QuestCorrection.professionKeys = {"
profession_keys_block_start_regex = r"---@class QuestProfessionKeys:OverrideQuestProfessionKeys.*?QuestCorrection\.professionKeys\s*=\s*\{"

update_lua_block(quest_profession_lua_file_path, generated_lua_table_string, profession_keys_block_start_regex)
