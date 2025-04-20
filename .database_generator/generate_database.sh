#!/bin/bash

# Get current directory
# This script is used to generate the translations for Questie
script_dir=$(dirname "$0")
echo "Script directory: $script_dir"

# First argument points to lua executable set "lua" if not set
if [ -z "$1" ]; then
  LUA=lua
else
  LUA=$1
fi

echo "Current directory: $(pwd)"
echo "$LUA is the lua executable"

git_sparse_clone_translations() {
  # Delete repo if it exists
  if [ -d "Questie-translations" ]; then
    echo "Removing already existing Questie-translations $(pwd)/Questie-translations"
    rm -rf Questie-translations
  fi

  # Cloning an empty repo
  git clone -n --depth=1 --filter=tree:0 https://github.com/Questie/Questie.git Questie-translations

  # # Cd into the git directory
  cd Questie-translations

  # # Sparse checkout only the Localization/Translations
  git sparse-checkout set --no-cone Localization/Translations

  # # Pull the sparse checkout
  git checkout
}

# Needed for the docker container but not action but it doesn't hurt the run if it fails
cd /QuestieDB

LAST_PATH="$(pwd)"

# cd to current script directory
cd "$(dirname "$0")"

git_sparse_clone_translations

echo "$(pwd)"

cd $LAST_PATH

echo "$(pwd)"

$LUA $script_dir/main.lua
