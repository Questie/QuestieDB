The easiest way to run this is by just having docker
installed and running the following command:

```
docker-compose up
or
docker compose up (if you have the latest version of docker)
```
## createStatic.py
This script creates the correction files by loading the addon and applying all corrections
It then dumps it into `.generate_database\_data\Era\ItemOverride.lua-table`

## convert_questie_database.py
This script downloads the different DBs from github if they are missing from
`.generate_database\_data\Era\ItemQuestieData.lua-table`
It then tries to apply the corrections from the createStatic script

## dump.py
This script actually reads the data from
`Database/Item/Era/ItemData.lua-table`
Then dumps the data into HTML files