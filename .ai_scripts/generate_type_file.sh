#!/bin/bash

# ? ####################################################################
# ? These are just Logons scripts to help him with some AI context shit.
# ? ####################################################################

# Goto the script directory
script_dir=$(dirname "$0")
cd "$script_dir"

# Go up one directory
cd ..

# Define the output file
output_file=".ai_lua/Instructions/QuestieDB_Lua_Types.instructions.md"

# Multiline echo to outputfile
cat << EOF > "$output_file"
---
applyTo: '**/*.lua'
---
# QuestieDB Lua Types

EOF

# Find all files .*\.t\.lua, excluding the .shit directory
find . -name '.shit' -type d -prune -o -name '*.t.lua' -print | while read -r file; do
  printf "\n-- filepath: %s\n" "$file"
  printf "\`\`\`lua\n"
  cat "$file"
  printf "\n\`\`\`\n"
done >> "$output_file"

echo "Combined types generated in $output_file"