#!/bin/bash

# Get current directory
# This script is used to generate the translations for Questie
script_dir=$(dirname "$0")
echo "Script directory: $script_dir"

cd $script_dir
FULL_PATH="$(pwd)"

# First argument points to lua executable set "lua" if not set
if [ -z "$1" ]; then
  LUA=lua
else
  LUA=$1
fi

echo "Current directory: $FULL_PATH"
echo "$LUA is the lua executable"

git_sparse_clone_addon_translations() {
  local force_fetch=${1:-false}

  # Check if directory exists and skip if not forcing
  if [ -d "Questie-data" ] && [ "$force_fetch" != "true" ]; then
    echo "# Questie-data directory already exists, skipping fetch (use force=true to override)"
    return 0
  fi

  # Delete repo if it exists (either forcing or doesn't exist)
  if [ -d "Questie-data" ]; then
    echo "# Force fetch enabled: Removing existing Questie-data $(pwd)/Questie-data"
    rm -rf Questie-data
  else
    echo "# Questie-data directory not found, fetching fresh copy"
  fi
  git config --global --add safe.directory /QuestieDB/.database_generator/Questie-data

  # Shallow, partial clone with no tags to minimize download size
  git clone --filter=blob:none --sparse --no-checkout --no-tags --depth=1 --single-branch -b master https://github.com/Questie/Questie.git Questie-data

  # # Cd into the git directory
  cd Questie-data || exit 1

  # # Sparse checkout only the Localization directory
  echo "# Setting sparse checkout for Localization, Database/Classic, Database/TBC, Database/Wotlk, Database/Cata Database/MoP"
  git sparse-checkout set --no-cone Localization Database/Classic Database/TBC Database/Wotlk Database/Cata Database/MoP

  # # Pull the sparse checkout
  echo "# Pulling the sparse checkout"
  git checkout

  # Remove the .git directory
  rm -rf .git

  echo "# Done sparse checkout"
}

# Needed for the docker container but not action but it doesn't hurt the run if it fails
cd /QuestieDB

LAST_PATH="$(pwd)"

# Goto the QuestieDB/.database_generator directory
cd "$FULL_PATH"

# Make sure the Questie-data directory is there
git_sparse_clone_addon_translations $2

echo "$(pwd)"

cd "$LAST_PATH"

echo "$(pwd)"

# Goto the QuestieDB directory
cd "$FULL_PATH/.."

$LUA "$FULL_PATH/main.lua"

cd "$LAST_PATH"
