#!/bin/bash

LAST_PATH="$(pwd)"

# cd to current script directory
cd "$(dirname "$0")"

python ./generate_l10n_table.py

echo "$(pwd)"

cd $LAST_PATH

