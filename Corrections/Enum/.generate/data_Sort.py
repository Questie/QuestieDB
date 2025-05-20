import os
from functions import load_csv, format_key, update_lua_block, current_dir, download_csv

# Download the CSV files
download_csv("https://wago.tools/db2/QuestSort/csv?build=5.5.0.60700", "QuestSort.5.5.0.60700.csv")
data = load_csv("QuestSort.5.5.0.60700.csv")

lua_table_parts = [
  "---@class EnumSortKeys:OverrideEnumSortKeys",
  "Enum.sortKeys = {",
  "  -- This table is auto-generated from the CSV file",
  "  -- Do not edit this table directly",
  "  -- Instead, edit the override table above",
  "",
]
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

lua_table_parts += [
  "",
  "  -- This table is auto-generated from the CSV file",
  "  -- Do not edit this table directly",
  "  -- Instead, edit the override table above",
]

lua_table_parts.append("}")
generated_lua_table_string = "\n".join(lua_table_parts)
print(generated_lua_table_string)

# --- New code to load, replace, and save QuestSort.lua ---
quest_sortkey_file_path = os.path.join(current_dir(), "..", "Sort.lua")

# This regex matches the "---@class EnumSortKeys:OverrideEnumSortKeys" comment, any characters in between (non-greedy),
# and "Enum.sortKeys = {"
sort_keys_block_start_regex = r"---@class EnumSortKeys:OverrideEnumSortKeys.*?Enum\.sortKeys\s*=\s*\{"

update_lua_block(quest_sortkey_file_path, generated_lua_table_string, sort_keys_block_start_regex)
