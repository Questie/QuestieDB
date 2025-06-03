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
        -not -name "*.test" \
        -not -name "*t.lua" \
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
# -exec sh -c '
#     ai_file="$1"
#     lua_file="${ai_file%.ai}.lua"
#     #echo "-- filepath: ${ai_file}"
#     ' sh {} \;)

# Generate Function
generate_ai_content() {
    local input_file="$1"
    local output_file="$2"

    GEMINI_API_KEY="$GEMINI_API_KEY"
    # MODEL_ID="gemini-2.5-pro-preview-05-06"
    MODEL_ID="gemini-2.5-flash-preview-05-20"
    GENERATE_CONTENT_API="streamGenerateContent"

    # Read the content of the input file
    local input_content
    input_content=$(cat "$input_file")
    # Prepare the request JSON
    # Prepare the request JSON using jq to safely embed input_content
    local request_json
    request_json=$(jq -n \
                  --arg content "$input_content" \
                  '{
                    "system_instruction": {
                      "parts": [
                        {
                            "text": "Explain what this files does, and what it is used for. If it is a Questie file, explain what Questie is."
                        }
                      ]
                    },
                    "contents": [
                      {
                        "role": "user",
                        "parts": [
                          {
                            "text": "This is some context"
                          }
                        ]
                      },
                      {
                        "role": "user",
                        "parts": [
                          {
                            "text": $content
                          }
                        ]
                      }
                    ],
                    "generationConfig": {
                      "thinkingConfig": {
                        "thinkingBudget": 0,
                      },
                      "responseMimeType": "text/plain"
                    }
                  }')

    output_data=$(curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    "https://generativelanguage.googleapis.com/v1beta/models/${MODEL_ID}:${GENERATE_CONTENT_API}?key=${GEMINI_API_KEY}" \
    -d "$request_json")

    # Extract and concatenate all text parts from the streaming response
    extracted_text=$(echo "$output_data" | jq -r 'map(.candidates[0].content.parts[0].text) | join("")')

    # Write the extracted text to the output file
    echo "$extracted_text" > "$output_file"
}

mkdir -p .vscode/AI_Context

# Loop over DAT and generate AI files
for file in $DAT; do
    # Check if the file is a Lua file
    if [[ "$file" == *.lua ]]; then
        # Extract the base name without extension
        base_name=$(basename "$file" .lua)
        # Create the AI file name
        ai_file=".vscode/AI_Context/${base_name}.ai"

        # Generate AI content (this is a placeholder, replace with actual AI generation logic)
        echo "Generating AI content for $file..."

        # Here you would call your AI generation script or API to generate the content
        # For example, using a hypothetical command:
        # generate_ai_content "$file" > "$ai_file"
        generate_ai_content "$file" "$ai_file"

        # For demonstration, we will just create an empty AI file
        # touch "$ai_file"
        exit 0
    fi
done

echo "AI files generated in .vscode/AI_Context"