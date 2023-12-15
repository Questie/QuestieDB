import os
import concurrent.futures
import math
import sys
import requests
from slpp import slpp as lua
from luaparser import ast
from luaparser import astnodes
import json
from helpers import find_addon_name, read_expansion_data, get_project_dir_path, get_data_dir_path


expansions = ["Era", "Tbc", "Wotlk"]

# Get the string data from the AST tree
def getData(fileData, varName):
  tree = ast.parse(fileData)
  for node in ast.walk(tree):
      if isinstance(node, astnodes.Assign):
          data = node.to_json()
          containsData = False
          for node2 in ast.walk(node):
            if isinstance(node2, astnodes.Name):
              data2 = node2.to_json()
              if "Name" in data2 and "id" in data2["Name"]:
                if data2["Name"]["id"] == varName:
                  containsData = True
                  break
          if containsData:
            for node2 in ast.walk(data["Assign"]["values"]):
              if isinstance(node2, astnodes.String):
                data2 = node2.to_json()
                # print(data2["String"]["s"])
                stringdata = data2["String"]["s"]
                # Remove the "return " from the start of the string
                stringdata = stringdata[6:].strip()
                return stringdata
  raise Exception("Failed to find data")

# Generate a lookup table for the types of the data
def indexToType(data):
  typeFromIndex = {}
  for dataId in data:
    for index, value in enumerate(data[dataId]):
      if index not in typeFromIndex and value != None:
        typeFromIndex[index] = type(value)
  return typeFromIndex

# Used to combine data from multiple indexes into one and returns a string of the data
def convertData(data, totalEndLength, luaReplaceIndex, luaCombineIndex):
  typeFromIndex = indexToType(data)

  if type(luaReplaceIndex) == int and luaReplaceIndex >= 0 and type(luaCombineIndex) == list and len(luaCombineIndex) > 0:
    pythonReplaceIndex = luaReplaceIndex-1
    pythonCombineIndex = [ luaIndex-1 for luaIndex in luaCombineIndex ]

    for dataId in data:
      # print(data[dataId])
      combinedString = ""
      for dataIndex in sorted(pythonCombineIndex):
        if dataIndex <= len(data[dataId]):
          # Combine the data, if it is None we have to add an empty string
          if data[dataId][dataIndex] != None:
            combinedString += str(data[dataId][dataIndex])+";"
          elif dataIndex in typeFromIndex:
            if typeFromIndex[dataIndex] == str:
              combinedString += ";"
            elif typeFromIndex[dataIndex] == int or typeFromIndex[dataIndex] == float:
              combinedString += "0;"
          else:
            # print(f"Unknown type: {dataIndex} : {type(data[dataId][dataIndex])}")
            combinedString += "0;"
        else:
          combinedString += "0;"
      # Remove last semicolon
      combinedString = combinedString[:-1]

      # Create the new data object
      newData = []
      for index, value in enumerate(data[dataId]):
        if index == pythonReplaceIndex:
          newData.append(combinedString)
          continue
        if index in pythonCombineIndex:
          continue
        newData.append(value)
      # Check if the new data is the correct length
      if len(newData) <= totalEndLength:
        # Add empty strings to the end of the data
        for i in range(totalEndLength-len(newData)-1):
          newData.append(None)

      data[dataId] = newData
      # exit(0)

  lua.newline = ""
  lua.tab = ""
  allData = ""

  # loop the list by sorted Id
  for dataId in sorted(data.keys()):
    # This looks a bit stupid on the end because we want trailing commas
    allData += f"  [{dataId}] = {lua.encode(data[dataId])[:-1]},}},\n"
  # This is to replace " with ' for strings
  # The lib always uses " but we can't change it so we have to replace it
  allData = allData.replace('\\"', '||||||||||')
  allData = allData.replace("'", "__________")
  allData = allData.replace('"', "'")
  allData = allData.replace('||||||||||', '"')
  allData = allData.replace("__________", "\\'")
  return f"{{\n{allData}}}"

def getHighestIndex(data):
  if type(data) == dict:
    biggest_index = 0
    for key in data.keys():
      if key > biggest_index:
        biggest_index = key
    return biggest_index
  else:
    return len(data)

def applyCorrections(entity_data, entity_corrections):
  # Load the entity_data for all expansions
  for entityId in entity_corrections:
    if entityId not in entity_data:
      # Create a new entry if it does not exist
      entity_data[entityId] = []
    entity = entity_data[entityId]
    corrections = entity_corrections[entityId]

    # Get biggest index from entity and corrections
    biggest_correction_index = getHighestIndex(corrections)
    biggest_entity_index = getHighestIndex(entity)
    # print(f"Biggest index for {entity_type} {entityId}: {biggest_correction_index} {biggest_entity_index}")
    for i in range(biggest_entity_index):
      # Create a new entry if it does not exist
      if i >= len(entity):
        entity.append(corrections[i])
      elif i in corrections:
        entity[i] = corrections[i]
  return entity_data


# These are all the same for all expansions
replaceLookup = {
 "Item": {
    # Example Item has 16 fields
    # ['name'] = 1,             -- string
    # ['npcDrops'] = 2,         -- table or nil, NPC IDs
    # ['objectDrops'] = 3,      -- table or nil, object IDs
    # ['itemDrops'] = 4,        -- table or nil, item IDs
    # ['startQuest'] = 5,       -- int or nil, ID of the quest started by this item
    # ['questRewards'] = 6,     -- table or nil, quest IDs
    # ['flags'] = 7,            -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
    # ['foodType'] = 8,         -- int or nil, see https://github.com/cmangos/issues/wiki/Item_template#foodtype
    # ['itemLevel'] = 9,        -- int, the level of this item
    # ['requiredLevel'] = 10,   -- int, the level required to equip/use this item
    # ['ammoType'] = 11,        -- int,
    # ['class'] = 12,           -- int,
    # ['subClass'] = 13,        -- int,
    # ['vendors'] = 14,         -- table or nil, NPC IDs
    # ['relatedQuests'] = 15,   -- table or nil, IDs of quests that are related to this item
    # ['teachesSpell'] = 16,    -- int, spellID taught by this item upon use
    #
    # We combine 7 fields into 1
    # So 16 - 7 + 1 = 10
    # 16 total, 7 combined into 1 = 10
    "totalEndLength": 10, #The length of the array after combining the data
    "luaReplaceIndex": 7,
    "luaCombineIndex": [
      7,  #flags
      8,  #foodType
      9,  #itemLevel
      10, #requiredLevel
      11, #ammoType
      12, #class
      13, #subClass
    ],
  },
  "Npc": {
    "totalEndLength": 7, #The length of the array after combining the data
    "luaReplaceIndex": 2,
    "luaCombineIndex": [
      2, # minLevelHealth
      3, # maxLevelHealth
      4, # minLevel
      5, # maxLevel
      6, # rank
      9, # zoneID
      12,# factionID
      13,# friendlyToFaction
      15,# npcFlags
    ],
  },
  "Object": {
    "totalEndLength": 6, #The length of the array after combining the data
    "luaReplaceIndex": None,
    "luaCombineIndex": None,
  },
  "Quest": {
    "totalEndLength": 30, #The length of the array after combining the data
    "luaReplaceIndex": None,
    "luaCombineIndex": None,
  },
}


dataLookup = {
  "Era": {
    "Item": {
      "dataVarName": "itemData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicItemDB.lua",
    },
    "Npc": {
      "dataVarName": "npcData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicNpcDB.lua",
    },
    "Object": {
      "dataVarName": "objectData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicObjectDB.lua",
    },
    "Quest": {
      "dataVarName": "questData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicQuestDB.lua",
    },
  },
  "Tbc": {
    "Item": {
      "dataVarName": "itemData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcItemDB.lua",
    },
    "Npc": {
      "dataVarName": "npcData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcNpcDB.lua",
    },
    "Object": {
      "dataVarName": "objectData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcObjectDB.lua",
    },
    "Quest": {
      "dataVarName": "questData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/TBC/tbcQuestDB.lua",
    },
  },
  "Wotlk": {
    "Item": {
      "dataVarName": "itemData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkItemDB.lua",
    },
    "Npc": {
      "dataVarName": "npcData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkNpcDB.lua",
    },
    "Object": {
      "dataVarName": "objectData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkObjectDB.lua",
    },
    "Quest": {
      "dataVarName": "questData",
      "url": "https://raw.githubusercontent.com/Questie/Questie/master/Database/Wotlk/wotlkQuestDB.lua",
    },
  },
}

# Dumps the data for a given expansion into it's Database folder
# e.g. Database\Item\Era\ItemData.lua-table
def dumpData(expansion, download=False):
  datadir = f"{get_project_dir_path()}/.generate_database/_data/{expansion}"
  os.makedirs(datadir, exist_ok=True)
  print("----------------------------------------")
  print("Dumping data for expansion: "+expansion)
  for entityTypeName in dataLookup[expansion]:
    print(entityTypeName)
    entityMeta = dataLookup[expansion][entityTypeName]
    rawDataPath = f"{datadir}/{entityTypeName}QuestieData.lua-table"

    # Download the data if it does not exist
    rawData = ""
    if download or not os.path.exists(rawDataPath):
      print("  Downloading data: "+entityMeta["url"])
      req = requests.get(entityMeta["url"])
      rawData = req.text
      with open(rawDataPath, "w", encoding="utf-8", newline="\n") as f:
        f.write(rawData)
    else:
      with open(rawDataPath, "r", encoding="utf-8") as f:
        rawData = f.read()
    # Decode the data
    data = lua.decode(getData(rawData, entityMeta["dataVarName"]))

    # Apply corrections
    print(get_project_dir_path())
    correctionsPath = os.path.join(get_project_dir_path(), ".generate_database", "_data", expansion, f"{entityTypeName}Override.lua-table")
    print(correctionsPath)
    if os.path.exists(correctionsPath):
      with open(correctionsPath, 'r', encoding="utf-8") as lua_corrections_file:
        print("  Applying corrections:")
        print("   ", correctionsPath)
        lua_corrections = lua_corrections_file.read()
        corrections_data = lua.decode(lua_corrections)
        applyCorrections(data, corrections_data)
    else:
      print("!!!!  No corrections found !!!! Please run createStatic.lua to generate corrections")
    exit

    # Fix the data for the new format
    newData = convertData(data,
      replaceLookup[entityTypeName]["totalEndLength"],
      replaceLookup[entityTypeName]["luaReplaceIndex"],
      replaceLookup[entityTypeName]["luaCombineIndex"])
    if newData != None:
      path = os.path.join(get_data_dir_path(entityTypeName, expansion))
      filename = os.path.join(path, f"{entityTypeName.capitalize()}Data.lua-table")
      print("  Dumping data:")
      print("   ", filename)
      with open(filename, "w", encoding="utf-8", newline="\n") as f:
        f.write(newData)
  print("----------------------------------------")

def dumpAllData():
  for expansion in dataLookup:
    dumpData(expansion)

if __name__ == "__main__":
  # Get arguments
  if len(sys.argv) < 2:
    print("Usage: dump.py <expansion> <expansion> ...")
    exit()

  for expansion in sys.argv[1:]:
    if expansion not in expansions:
      print(f"Invalid expansion: {expansion}")
      exit()
  expansions = sys.argv[1:]
  for expansion in expansions:
    dumpData(expansion)