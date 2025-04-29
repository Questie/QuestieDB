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
output_file=".vscode/combined_QuestieDB_AI.ai"

# Find all files ending in .ai, excluding the output file itself.
# For each .ai file found:
# 1. Print its path as a comment header and then its content.
# 2. Construct the path to the corresponding .lua file.
# 3. If the .lua file exists, print its path as a comment header and then its content.
# Redirect the combined output to the output file.
find . -name "*.ai" ! -path "./$output_file" -exec sh -c '
    ai_file="$1"
    lua_file="${ai_file%.ai}.lua"
    echo ""
    echo "-- filepath: ${ai_file}"
    cat "${ai_file}"
    if [ -f "${lua_file}" ]; then
        echo ""
        echo "-- filepath: ${lua_file}"
        cat "${lua_file}"
    fi
' sh {} \; > "$output_file"

echo "Combined types and source generated in $output_file"