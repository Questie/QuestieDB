#!/bin/bash

# Change directory to script's directory
cd "$(dirname "$0")"
cd ..

echo "Dumping all tables..."

python Database/Item/dumpItems.py &
python Database/Npc/dumpNpcs.py &
python Database/Object/dumpObjects.py &
python Database/Quest/dumpQuests.py &

wait

echo "Done!"
