import os
import concurrent.futures
import math
import requests
from slpp import slpp as lua
from luaparser import ast
from luaparser import astnodes
import json
from helpers import find_addon_name, read_expansion_data, get_project_dir_path, get_data_dir_path

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
def convertData(luadata, totalEndLength, luaReplaceIndex, luaCombineIndex):
  data = lua.decode(luadata)
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




# These are all the same for all expansions
replaceLookup = {
 "Item": {
    "totalEndLength": 10, #The length after combining the data
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
    "totalEndLength": 7, #The length after combining the data
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
    "totalEndLength": 6, #The length after combining the data
    "luaReplaceIndex": None,
    "luaCombineIndex": None,
  },
  "Quest": {
    "totalEndLength": 30, #The length after combining the data
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
def dumpData(expansion):
  print("Dumping data for expansion: "+expansion)
  for entityTypeName in dataLookup[expansion]:
    print(entityTypeName)
    entityMeta = dataLookup[expansion][entityTypeName]
    path = os.path.join(get_data_dir_path(entityTypeName, expansion))
    filename = f"{path}\{entityTypeName.capitalize()}Data.lua-table"
    print("  Downloading data: "+entityMeta["url"])
    req = requests.get(entityMeta["url"])
    newData = convertData(getData(req.text, entityMeta["dataVarName"]),
      replaceLookup[entityTypeName]["totalEndLength"],
      replaceLookup[entityTypeName]["luaReplaceIndex"],
      replaceLookup[entityTypeName]["luaCombineIndex"])
    if newData != None:
      print("  Dumping data:")
      print("   ", filename)
      with open(filename, "w", encoding="utf-8", newline="\n") as f:
        f.write(newData)


def dumpAllData():
  for expansion in dataLookup:
    dumpData(expansion)

if __name__ == "__main__":
  # dumpAllData()
  dumpData("Era")