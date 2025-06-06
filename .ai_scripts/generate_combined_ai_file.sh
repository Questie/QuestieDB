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
output_file="$script_dir/combined_QuestieDB_AI.ai"

echo "---" > "$output_file" # Clear the output file before writing
echo "# AI Context Entries" >> "$output_file"
echo "" >> "$output_file"

# Step-by-step explanation:
# 1. This script searches for all .ai files in the project, except the output file itself.
# 2. For each .ai file found:
#    a. It extracts the base filename.
#    b. The script replaces any '#' characters in the filename with '/' to reconstruct the original directory structure.
#       - This is necessary because when .ai files are generated, directory separators '/' are replaced with '#' to make valid filenames (since '/' is not allowed in filenames).
#       - Replacing '#' with '/' allows the script to map the .ai file back to its corresponding .lua source file.
#    c. It tries to find the corresponding .lua file in the same directory or elsewhere in the project.
#    d. If the .ai file is not empty, it appends its content (and optionally the Lua source) to the combined output file in a Markdown format.
# 3. After processing all .ai files, it replaces escaped code block markers with proper Markdown code fences for formatting.
find . -name "*.ai" ! -samefile "$output_file" ! -name "combined_QuestieDB_AI_n_Code.ai" -exec sh -c '
    ai_file="$1"
    ai_filename=$(basename "$ai_file")
    # echo "AI Filename: $ai_filename"



    # Replace # with / in the file path to make it a valid path
    ai_filename="${ai_filename//\#//}"
    # echo "$ai_filename"

    clean_ai_file="${ai_filename#./}"
    base_name_no_ext="${ai_filename%.ai}"
    ai_filename_no_ext="${base_name_no_ext##*/}"
    # echo "AI Filename No Ext: $ai_filename_no_ext"
    ai_file_dir=$(dirname "$ai_filename")
    # echo "AI File Directory: $ai_file_dir"
    lua_file=$(find "$ai_file_dir" -maxdepth 1 -name "${ai_filename_no_ext}.lua" -print -quit)
    if [ -z "$lua_file" ]; then
        lua_file=$(find . -name "${ai_filename_no_ext}.lua" | head -n 1)
    fi
    clean_lua_file=""
    if [ -n "$lua_file" ]; then
        clean_lua_file="${lua_file#./}"
    fi

    # Only process if the .ai file is not empty (ignoring whitespace)
    if grep -qve "^[[:space:]]*$" "$ai_file"; then
        echo "---"
        echo ""
        echo "## AI Context for $clean_lua_file"
        echo ""

        echo "### AI Explanation"
        echo ""

        # echo "**File:** $clean_ai_file\n\n"
        # echo "\\\`\\\`\\\`text\n"
        cat "${ai_file}"
        # echo "\n\\\`\\\`\\\`\n"
        echo ""

        # if [ -n "$lua_file" ] && [ -f "$lua_file" ]; then
        #   echo "### Lua Source Code\n"
        #   printf "**File:** %s\n\n" "$clean_lua_file"
        #   echo "\\\`\\\`\\\`lua\n"
        #   cat "${lua_file}"
        #   echo "\n\\\`\\\`\\\`\n"
        # fi
        # echo "\n"
    fi
' sh {} \; >> "$output_file"

# Sed replace all instances of \\\`\\\`\\\` with ``` for proper Markdown formatting
sed -i 's/\\`\\`\\`/```/g' "$output_file"

echo "Combined types and source generated in $output_file"



# ! old stuff

# Find all files ending in .ai, excluding the output file itself.
# For each .ai file found:
# 1. Print its path as a comment header and then its content.
# 2. Construct the path to the corresponding .lua file.
# 3. If the .lua file exists, print its path as a comment header and then its content.
# Redirect the combined output to the output file.
# find . -name "*.ai" ! -path "./$output_file" -exec sh -c '
#     ai_file="$1"
#     base_name="${ai_file%.ai}"
#     lua_file=$(find . -name "${base_name##*/}.lua" | head -n 1)

#     echo ""
#     echo "-- filepath: ${ai_file}"
#     cat "${ai_file}"
#     if [ -n "$lua_file" ]; then
#       echo ""
#       echo "-- filepath: ${lua_file}"
#       cat "${lua_file}"
#     fi
# ' sh {} \; > "$output_file"
# find . -name "*.ai" ! -samefile "$output_file" -exec sh -c '
#     ai_file="$1"
#     # Get a cleaner base name, removing "./" prefix if present
#     clean_ai_file="${ai_file#./}"
#     base_name_no_ext="${ai_file%.ai}"
#     # Extract just the filename without path for Lua search
#     ai_filename_no_ext="${base_name_no_ext##*/}"
#     # Search for the Lua file in the same directory as the .ai file or subdirectories
#     # This find is more robust if Lua files are not always in the root.
#     # It starts searching from the directory of the .ai file.
#     ai_file_dir=$(dirname "$ai_file")
#     lua_file=$(find "$ai_file_dir" -maxdepth 1 -name "${ai_filename_no_ext}.lua" -print -quit)
#     # Fallback: if not found in same dir, search more broadly (original behavior)
#     if [ -z "$lua_file" ]; then
#         lua_file=$(find . -name "${ai_filename_no_ext}.lua" | head -n 1)
#     fi
#     clean_lua_file=""
#     if [ -n "$lua_file" ]; then
#         clean_lua_file="${lua_file#./}"
#     fi

#     echo "---\n"
#     echo "# AI Context Entry\n"

#     echo "## AI Explanation\n"
#     echo "**File:** $clean_ai_file\n\n"
#     echo "\\\`\\\`\\\`text\n"
#     cat "${ai_file}"
#     echo "\n\\\`\\\`\\\`\n" # Ensure a newline before closing fence if file lacks one

#     if [ -n "$lua_file" ] && [ -f "$lua_file" ]; then
#       echo "## Lua Source Code\n"
#       printf "**File:** %s\n\n" "$clean_lua_file"
#       echo "\\\`\\\`\\\`lua\n"
#       cat "${lua_file}"
#       echo "\n\\\`\\\`\\\`\n" # Ensure a newline before closing fence
#     else
#       echo "## Lua Source Code\n"
#       echo "**File:** (No corresponding .lua file found for %s)\n\n" "$ai_filename_no_ext.lua"
#     fi
#     echo "\n" # Extra newline between entries
# ' sh {} \; >> "$output_file"