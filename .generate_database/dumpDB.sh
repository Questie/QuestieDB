#!/bin/bash

cd QuestieDB

# Create directories if they don't exist
mkdir -p ./.generate_database/_data/Era
mkdir -p ./.generate_database/_data/Tbc
mkdir -p ./.generate_database/_data/Wotlk

# Download files for Era
# We rename these to era for consistency and automation simplicity
wget -nv -O ./.generate_database/_data/Era/eraItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicItemDB.lua &
wget -nv -O ./.generate_database/_data/Era/eraNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicNpcDB.lua &
wget -nv -O ./.generate_database/_data/Era/eraObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicObjectDB.lua &
wget -nv -O ./.generate_database/_data/Era/eraQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicQuestDB.lua &

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

echo "Dumping all databases - createStatic.lua"

# Each expansion has its own dump process for each type
for name in Era Tbc Wotlk
do
  echo "$name"
  lua ./.generate_database/createStatic.lua $name > ./.generate_database/_data/$name/$name-output.log &
done

wait

echo "Log output saved to ./.generate_database/_data/<Version>/<Version>-output.log"

# Change to the generate_database directory
cd .generate_database

echo "Dumping all databases - dump.py"

# Generate the HTML files
# python3 ./dump.py Era &
# python3 ./dump.py Tbc &
# python3 ./dump.py Wotlk &

wait

echo "Done dumping HTML files"


echo "dumpDB.sh Finished."
