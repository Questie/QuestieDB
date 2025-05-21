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
  # Delete repo if it exists
  if [ -d "Questie-data" ]; then
    echo "Removing already existing Questie-data $(pwd)/Questie-data"
    rm -rf Questie-data
  fi

  # Cloning an empty repo
  git clone -n --depth=1 --filter=tree:0 https://github.com/Questie/Questie.git Questie-data

  # # Cd into the git directory
  cd Questie-data

  # # Sparse checkout only the Localization directory
  echo "# Setting sparse checkout for Localization, Database/Classic, Database/TBC, Database/Wotlk, Database/Cata"
  git sparse-checkout set --no-cone Localization Database/Classic Database/TBC Database/Wotlk Database/Cata

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
cd $FULL_PATH

# Make sure the Questie-data directory is there
git_sparse_clone_addon_translations

echo "$(pwd)"

cd $LAST_PATH

echo "$(pwd)"

# Goto the QuestieDB directory
cd $FULL_PATH/..

$LUA $FULL_PATH/main.lua

cd $LAST_PATH
