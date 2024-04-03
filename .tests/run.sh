#!/bin/bash

cd /QuestieDB

# Each expansion has its own dump process for each type
for name in Era Tbc Wotlk
do
  echo "Running test for $name"
  echo "Log output saved to ./.tests/_data/$name-output.log"
  lua ./.tests/runTests.lua $name > ./.tests/_data/$name-output.log &
done