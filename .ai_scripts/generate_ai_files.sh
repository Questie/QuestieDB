#!/bin/bash

# ? ####################################################################
# ? These are just Logons scripts to help him with some AI context shit.
# ? ####################################################################

# Goto the script directory
script_dir=$(dirname "$0")
cd "$script_dir"

source setEnv.sh

# Go up one directory
cd ..

# cloc . --json --exclude-dir=node_modules,.git,.shit,Questie-data,_data --exclude-ext=html,log,md,toml,ai,gitignore,gitattributes,editorconfig,lua-table --not-match-d=.database_generator/mangos_translation/translations --by-file > "$script_dir/cloc.output"
  # --exclude-ext=html,log,md,toml,ai,gitignore,gitattributes,editorconfig,lua-table,txt,sh \
  # --exclude-ext=html,log,md,toml,ai,gitignore,gitattributes,editorconfig,lua-table,txt,sh,xml \

# All code
# cloc . --json \
#   --exclude-dir=node_modules,.git,.shit,Questie-data,_data,.github \
#   --exclude-ext=html,log,md,toml,ai,gitignore,gitattributes,editorconfig,lua-table,txt,sh,xml,py,json,yml,db \
#   --fullpath \
#   --not-match-d=.database_generator/mangos_translation/translations \
#   --not-match-d=cli/builtins \
#   --not-match-d=cli/libs \
#   --not-match-f='Corrections\/.*\/.*Fixes\.lua' \
#   --not-match-f='Corrections\/.*\/base\/.*Items|NPCs|Quests|Objects\.lua' \
#   --not-match-f='cli\/dump.lua' \
#   --not-match-f='.*\.test|t\.lua' \
#   --not-match-f='Dockerfile' \
#   --not-match-f='Helpers\/_s.lua' \
#   --by-file | jq 'keys_unsorted[] | select(. != "header" and . != "SUM")'

# Only Addon code (No Generators)
# cloc . --json \
#   --exclude-dir=node_modules,.git,.shit,Questie-data,_data,.github \
#   --exclude-ext=html,log,md,toml,ai,gitignore,gitattributes,editorconfig,lua-table,txt,sh,xml,py,json,yml,db \
#   --fullpath \
#   --not-match-d=.database_generator \
#   --not-match-d=cli \
#   --not-match-f='Corrections\/.*\/.*Fixes\.lua' \
#   --not-match-f='Corrections\/.*\/base\/.*Items|NPCs|Quests|Objects\.lua' \
#   --not-match-f='cli\/dump.lua' \
#   --not-match-f='.*\.test|t\.lua' \
#   --not-match-f='Dockerfile' \
#   --not-match-f='Helpers\/_s.lua' \
#   --not-match-f='Translations\/TranslationsLookup.lua' \
#   --by-file | jq 'keys_unsorted[] | select(. != "header" and . != "SUM")'


DAT=$(find . \
    -name "node_modules" -type d -prune -o \
    -name ".git" -type d -prune -o \
    -name ".shit" -type d -prune -o \
    -name "Questie-data" -type d -prune -o \
    -name "_data" -type d -prune -o \
    -name ".github" -type d -prune -o \
    -name ".database_generator" -type d -prune -o \
    -name ".tests" -type d -prune -o \
    -name ".vscode" -type d -prune -o \
    -name ".ai_lua" -type d -prune -o \
    -name ".ai_py" -type d -prune -o \
    -name ".ai_scripts" -type d -prune -o \
    -name ".wowhead" -type d -prune -o \
    -name "__pycache__" -type d -prune -o \
    -name "cli" -type d -prune -o \
    \( \
        -type f \
        -not -name "*.html" \
        -not -name "*.log" \
        -not -name "*.md" \
        -not -name "*.toml" \
        -not -name "*.ai" \
        -not -name "*.gitignore" \
        -not -name "*.gitattributes" \
        -not -name "*.editorconfig" \
        -not -name "*.lua-table" \
        -not -name "*.txt" \
        -not -name "*.sh" \
        -not -name "*.xml" \
        -not -name "*.py" \
        -not -name "*.json" \
        -not -name ".DS_Store" \
        -not -name "LICENSE" \
        -not -name "*.toc" \
        -not -name "*.lua.backup" \
        -not -name "*.yml" \
        -not -name "*.db" \
        -not -name "*.test.lua" \
        -not -name "*.data" \
        -not -name "*.t.lua" \
        -not -path "./Corrections/*/*Fixes.lua" \
        -not -path "./Corrections/*/base/*Items.lua" \
        -not -path "./Corrections/*/base/*NPCs.lua" \
        -not -path "./Corrections/*/base/*Quests.lua" \
        -not -path "./Corrections/*/base/*Objects.lua" \
        -not -path "./Corrections/Era/*.lua" \
        -not -path "./Corrections/Sod/*.lua" \
        -not -path "./Corrections/Tbc/*.lua" \
        -not -path "./Corrections/Wotlk/*.lua" \
        -not -path "./Corrections/Cata/*.lua" \
        -not -path "./Corrections/MoP/*.lua" \
        -not -path "./cli/dump.lua" \
        -not -name "Dockerfile" \
        -not -path "./Helpers/_s.lua" \
        -not -path "./Translations/TranslationsLookup.lua" \
    \) -print)

# echo "Found Lua files:"
# echo "$DAT"
# exit
# -exec sh -c '
#     ai_file="$1"
#     lua_file="${ai_file%.ai}.lua"
#     #echo "-- filepath: ${ai_file}"
#     ' sh {} \;)

# Generate Function
generate_ai_content() {
    local input_file="$1"
    local output_file="$2"
    local basefilename=$(basename "$input_file" ".lua")
    # Temporary file for JSON payload
    local tmp_json_file="$script_dir/$basefilename-payload.jq-temp"

    GEMINI_API_KEY="$GEMINI_API_KEY"
    # MODEL_ID="gemini-2.5-pro-preview-05-06"
    # MODEL_ID="gemini-2.5-flash-preview-05-20"
    MODEL_ID="gemini-2.0-flash"
    GENERATE_CONTENT_API="streamGenerateContent"

    # Read the content of the input file
    local input_content
    input_content=$(cat "$input_file")

    # Prepare the request JSON using jq to safely embed input_content
    jq -n \
    --arg content "$input_content" \
    --arg filename "$input_file" \
    --rawfile all_context_data "$script_dir/combined_QuestieDB_AI.ai" \
    -f "$script_dir/jq-template.jq" > "$tmp_json_file"

    output_data=$(curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    "https://generativelanguage.googleapis.com/v1beta/models/${MODEL_ID}:${GENERATE_CONTENT_API}?key=${GEMINI_API_KEY}" \
    --data @"$tmp_json_file")

    # Clean up the temporary JSON file
    rm -f "$tmp_json_file"

    echo "Output Data: $input_file \n $output_data" >> "$script_dir/streaming_output.log"
    echo "" >> "$script_dir/streaming_output.log"
    echo "" >> "$script_dir/streaming_output.log"
    echo "" >> "$script_dir/streaming_output.log"

    # Extract and concatenate all text parts from the streaming response
    extracted_text=$(echo "$output_data" | jq -r 'map(.candidates[0].content.parts[0].text) | join("")')

    # Write the extracted text to the output file
    echo "$extracted_text" > "$output_file"
}

mkdir -p .ai_lua/AI_Context

> "$script_dir/streaming_output.log" # Clear the log file before writing

# Read and combine all .ai files into a variable from .ai_lua/AI_Context
bash $script_dir/generate_combined_ai_file.sh

# Remove any existing .ai files in the AI_Context directory
rm -f .ai_lua/AI_Context/*.ai

total_count_dat=$(echo "$DAT" | wc -l)
echo "Total Lua files to process: $total_count_dat"

processed_count=1
RPM=2000
RPM=$RPM-100 # Reduce RPM just to be safe, as the API might have rate limits
SLEEP_COUNT=$((RPM / 60)) # Calculate sleep time based on RPM


# Step-by-step explanation:
# 1. The script collects all relevant Lua source files into the DAT variable, excluding unwanted files and directories.
# 2. It loops over each file in DAT:
#    a. Checks if the file has a .lua extension.
#    b. Removes any leading './' from the file path for consistency.
#    c. Extracts the base filename (without extension) and its directory path.
#    d. Replaces all '/' in the directory path with '#' to create a valid filename (since '/' is not allowed in filenames).
#    e. Constructs the output .ai filename using the transformed path and base name, placing it in .ai_lua/AI_Context/.
#    f. Calls the generate_ai_content function to generate AI content for the Lua file and writes it to the corresponding .ai file.
#    g. Runs up to 3 jobs in parallel, then waits to avoid overloading the system or API.
# 3. After all files are processed, the script waits for any remaining background jobs to finish.
# 4. Finally, it combines all generated .ai files into a single combined_QuestieDB_AI.ai file.
for file in $DAT; do
    echo "Processing file $processed_count of $total_count_dat: $file"
    # Check if the file is a Lua file
    if [[ "$file" == *.lua ]]; then
        # Remove the leading './' if present
        file=$(echo "$file" | sed 's|^\./||')
        # Extract the base name without extension
        base_name=$(basename "$file" ".lua")
        # echo "Base name: $base_name"
        # Get the path without file name
        dir_path=$(dirname "$file")
        # echo "Directory path: $dir_path"

        # Replace / with # in the path to create a valid file name
        name=$(echo "$dir_path" | sed 's/\//#/g')#"$base_name"
        # echo "AI file name: $name"

        # Create the AI file name
        ai_file=".ai_lua/AI_Context/${name}.ai"

        # Generate AI content (this is a placeholder, replace with actual AI generation logic)
        echo "Generating AI content for $file..."

        # Here you would call your AI generation script or API to generate the content
        # For example, using a hypothetical command:
        # generate_ai_content "$file" > "$ai_file"
        generate_ai_content "$file" "$ai_file" &
        # wait
        # exit
    fi
    processed_count=$((processed_count + 1))
    # Sleep for a short duration to avoid overwhelming the API
    sleep 0.1
    # Limit the number of parallel jobs to avoid overwhelming the system
    if (( processed_count % $SLEEP_COUNT == 0 )); then
        wait # Wait for all background jobs to finish before continuing
        sleep 3
        # if (( processed_count % 3 == 0 )); then
        # Use this for flash 2.5
        # Sleep for a short duration to avoid overwhelming the API
        # sleep 5
    fi
done

wait
echo ""
echo "AI files generated in .ai_lua/AI_Context"

echo ""
echo "Combining all AI files into combined_QuestieDB_AI.ai"
bash $script_dir/generate_combined_ai_file.sh
