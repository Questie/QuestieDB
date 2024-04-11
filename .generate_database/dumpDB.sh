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

# Create directories if they don't exist
for type in Item Npc Object Quest
do
  for name in Era Tbc Wotlk
  do
    mkdir -p ./.generate_database/_data/output/$type/$name
  done
done


# Download files for Era
# We rename these to era for consistency and automation simplicity
wget -nv -O ./.generate_database/_data/eraItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicItemDB.lua &
wget -nv -O ./.generate_database/_data/eraNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicNpcDB.lua &
wget -nv -O ./.generate_database/_data/eraObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicObjectDB.lua &
wget -nv -O ./.generate_database/_data/eraQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicQuestDB.lua &

# Download files for Tbc
wget -nv -O ./.generate_database/_data/tbcItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcItemDB.lua &
wget -nv -O ./.generate_database/_data/tbcNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcNpcDB.lua &
wget -nv -O ./.generate_database/_data/tbcObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcObjectDB.lua &
wget -nv -O ./.generate_database/_data/tbcQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcQuestDB.lua &

# Download files for Wotlk
wget -nv -O ./.generate_database/_data/wotlkItemDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkItemDB.lua &
wget -nv -O ./.generate_database/_data/wotlkNpcDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkNpcDB.lua &
wget -nv -O ./.generate_database/_data/wotlkObjectDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkObjectDB.lua &
wget -nv -O ./.generate_database/_data/wotlkQuestDB.lua https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkQuestDB.lua &

wait

echo "Dumping all databases - createStatic.lua"

# Each expansion has its own dump process for each type
for name in Era Tbc Wotlk
do
  echo "Dumping $name"
  echo "Log output saved to ./.generate_database/_data/$name-output.log"
  $LUA ./.generate_database/createStatic.lua $name > ./.generate_database/_data/$name-output.log &
done

wait

echo "Done dumping databases"

# Copy the output to the Database directory
echo "Copying output to ./Database"
cp -r ./.generate_database/_data/output/* ./Database


# Change to the generate_database directory
cd .generate_database

echo "Dumping all databases - dump.py"

# Generate the HTML files
for name in Era Tbc Wotlk
do
  python3 ./dump.py False $name &
done

wait

echo "Done dumping HTML files"


echo "dumpDB.sh Finished."
