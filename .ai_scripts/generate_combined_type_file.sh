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
output_file=".ai_lua/combined_QuestieDB_LuaLS_Alias.lua"

echo "---@diagnostic disable: duplicate-doc-alias, duplicate-doc-field" > "$output_file"

# Find all files .*\.t\.lua
# For each file, print its path as a comment header, then print its content.
# Redirect the combined output to the output file.
find . -name "*.t.lua" -exec sh -c 'echo ""; echo "-- filepath: {}"; cat "{}"' \; >> "$output_file"

echo "Combined types generated in $output_file"