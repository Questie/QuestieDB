#!/bin/bash

cd QuestieDB

# Create directories if they don't exist
mkdir -p ./.generate_database/_data/Era
mkdir -p ./.generate_database/_data/Tbc
mkdir -p ./.generate_database/_data/Wotlk

# Download files for Era
wget -nv -O ./.generate_database/_data/Era/classicItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicItemDB.lua &
wget -nv -O ./.generate_database/_data/Era/classicNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicNpcDB.lua &
wget -nv -O ./.generate_database/_data/Era/classicObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicObjectDB.lua &
wget -nv -O ./.generate_database/_data/Era/classicQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicQuestDB.lua &

# Download files for Tbc
wget -nv -O ./.generate_database/_data/Tbc/tbcItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcItemDB.lua &
wget -nv -O ./.generate_database/_data/Tbc/tbcNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcNpcDB.lua &
wget -nv -O ./.generate_database/_data/Tbc/tbcObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcObjectDB.lua &
wget -nv -O ./.generate_database/_data/Tbc/tbcQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcQuestDB.lua &

# Download files for Wotlk
wget -nv -O ./.generate_database/_data/Wotlk/wotlkItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkItemDB.lua &
wget -nv -O ./.generate_database/_data/Wotlk/wotlkNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkNpcDB.lua &
wget -nv -O ./.generate_database/_data/Wotlk/wotlkObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkObjectDB.lua &
wget -nv -O ./.generate_database/_data/Wotlk/wotlkQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkQuestDB.lua &

wait

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
