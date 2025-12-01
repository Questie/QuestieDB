#!/bin/bash
# This file is used by docker or local to run all tests
# output is saved to file and error will show in the CLI

# Calculate path relative to this script: tests -> lua -> .tooling -> project root
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR/../../.."

mkdir -p ./.tooling/lua/tests/_data

# Each expansion has its own dump process for each type
for name in Era Sod Tbc Wotlk Cata Mop
do
  echo "Running test for $name"
  echo "Log output saved to ./.tooling/lua/tests/_data/$name-output.log"
  lua ./.tooling/lua/tests/runTests.lua $name > ./.tooling/lua/tests/_data/$name-output.log &
done

wait