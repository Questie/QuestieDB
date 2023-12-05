import re
import json
import sys
import srt
import os
import time
import requests

listview_re = re.compile(r"new Listview\((.*)\);")
var_listview_re = re.compile(r"var listviewitems = \[(.*)\];")
var_listview_re = re.compile(r"var (?:listviewitems|listviewspells) = (\[.*\]);\n") # Used by Item and Spells
data_quest_re = re.compile(r"data:\s*(\[.*\])}\);") # Used by Quests
data_re = re.compile(r"\"data\":\s*(\[.*\]),") # Used by NPC and Objects
def extractData(response_text):
  # Initialize listview_data
  listview_data = []
  listview = listview_re.search(response_text)
  if listview:
    text = listview.group(1)
    # Find NPC and Objects
    data = data_re.search(text)
    if not data:
      # Find Items
      var_listview = var_listview_re.search(response_text)
      if var_listview:
        data = var_listview.group(1)
        # Some of the data is not valid json, so we need to fix it
        # Items + Spells
        data = data.replace("firstseenpatch", '\"firstseenpatch\"')
        data = data.replace("popularity", '\"popularity\"')
        data = data.replace("contentPhase", '\"contentPhase\"')
        # Spells
        data = data.replace("quality", '\"quality\"')
        # Due to some weirdness, we need to remove double citations
        data = data.replace("\"\"quality\"\"", '\"quality\"')
    else:
      data = data.group(1)

    # Find Quests
    if not data:
      data = data_quest_re.search(response_text)
      if data:
        data = data.group(1)

    # Convert to json
    if data:
      listview_data = json.loads(data)
      if "data" in listview_data:
        listview_data = listview_data["data"]
  return listview_data

# All are >= 1 and < 1000
# Items https://www.wowhead.com/classic/items?filter=151:151;2:4;1:1000 1-1000
# Objects https://www.wowhead.com/classic/objects?filter=15:15;2:5;1:1000 1-1000
# Quests https://www.wowhead.com/classic/quests?filter=30:30;2:5;1:1000 1-1000
# Npcs https://www.wowhead.com/classic/npcs?filter=37:37;2:5;1:1000 1-1000
urlLookups = {
  "npc": "https://www.wowhead.com/{version}/npcs?filter=37:37;2:5;{min_id}:{max_id}",
  "item": "https://www.wowhead.com/{version}/items?filter=151:151;2:4;{min_id}:{max_id}",
  "quest": "https://www.wowhead.com/{version}/quests?filter=30:30;1:4;{min_id}:{max_id}",
  "object": "https://www.wowhead.com/{version}/objects?filter=15:15;2:5;{min_id}:{max_id}",
  "spell": "https://www.wowhead.com/{version}/spells?filter=14:14;2:5;{min_id}:{max_id}",
  "faction": "https://www.wowhead.com/{version}/factions"
}

def getAllIdsWowhead(version, idType):
  #? Object and Spell produces a lot of 0 results but simplicity is more important than speed

  version = version.lower()
  ids = {
    idType: []
  }

  if idType != "faction":
    max_id_allowed = 1000000
    biggest_found_id = 0
    fails = 0
    for min_id in range(1, max_id_allowed, 1000):
      max_id = min_id + 999
      # response = requests.get(f"https://www.wowhead.com/classic/quests/min-level:{min_level}/max-level:{max_level}")
      url = urlLookups[idType].format(version=version, min_id=min_id, max_id=max_id)
      start_time = time.time()
      response = requests.get(url)
      listview_data = extractData(response.text)

      # If we get 0 results, try again with a super high max_id
      if len(listview_data) == 0 and max_id > biggest_found_id:
        print(f"{min_id} - {max_id}, found 0 {idType}s")
        print(f"Trying again with {max_id} - {max_id_allowed}")
        url = urlLookups[idType].format(version=version, min_id=max_id, max_id=max_id_allowed)
        response = requests.get(url)
        listview_data = extractData(response.text)
        # If we get less than 1000 results, we have all the results
        # If we get 1000 results, we need to continue
        # If we get 0 results, we have all the results
        if len(listview_data) < 1000:
          for row in listview_data:
            if row["id"] not in ids[idType]:
              ids[idType].append(row["id"])
          print(f"{max_id} - {max_id_allowed}, found {len(listview_data)} {idType}s")
          print(f"All {idType}s found")
          break
        elif len(listview_data) == 0:
          print(f"All {idType}s found")
          break
        else:
          for row in listview_data:
            if biggest_found_id < row["id"]:
              biggest_found_id = row["id"]
          print(f"{max_id} - {max_id_allowed}, found {len(listview_data)} {idType}s, continuing (1000 is max), biggest found ID is {biggest_found_id}")
      else:
        for row in listview_data:
          if row["id"] not in ids[idType]:
            ids[idType].append(row["id"])
        print(f"{min_id} - {max_id}, found {len(listview_data)} {idType}s, took {(time.time() - start_time):.2f} seconds")

      if len(listview_data) == 0:
        fails += 1
        if fails > 5:
          biggest_found_id = 0
          fails = 0
      else:
        fails = 0
  elif idType == "faction":
    url = urlLookups[idType].format(version=version)
    response = requests.get(url)
    listview_data = extractData(response.text)
    for row in listview_data:
      if row["id"] not in ids[idType]:
        ids[idType].append(row["id"])


  # Sort
  for key in ids:
    ids[key].sort()

  return ids[idType]
