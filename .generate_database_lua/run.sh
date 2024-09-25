#!/bin/bash

echo "Current directory: $(pwd)"
echo "$(which $1) is the lua executable"

# First argument points to lua executable set "lua" if not set
if [ -z "$1" ]; then
  LUA=lua
else
  LUA=$1
fi

# Needed for the docker container but not action but it doesn't hurt the run if it fails
cd /QuestieDB



$LUA ./.generate_database_lua/main.lua
# $LUA ./.generate_database_lua/generate_translation_trie.lua