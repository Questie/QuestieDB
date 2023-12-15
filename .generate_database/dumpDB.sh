#!/bin/bash

cd QuestieDB

# Make _data folders
mkdir -p ./.generate_database/_data/Era
mkdir -p ./.generate_database/_data/Tbc
mkdir -p ./.generate_database/_data/Wotlk

# Each expansion has its own dump process for each type
lua ./.generate_database/createStatic.lua

echo "Done dumping corrections - createStatic.lua"

# Change to the generate_database directory
cd .generate_database

echo "Dumping database files"

# Generate the full database files with corrections
python3 ./convert_questie_database.py Era &
python3 ./convert_questie_database.py Tbc &
python3 ./convert_questie_database.py Wotlk &

wait

echo "Done dumping HTML files"

# Generate the HTML files
python3 ./dump.py Era &
python3 ./dump.py Tbc &
python3 ./dump.py Wotlk &

wait

echo "Done"
