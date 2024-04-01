# A script that reads classic_locales.json and generates a table of locale
# information for use in the localization system.
import json
from dataclasses import dataclass
import os
import sys
import re
from helpers import get_data_dir_path


# Order Item, Npc, Object, Quest
# "enUS": "", # English (US) # Yes EN is empty
# "ptBR": "pt", # Portuguese (Brazil)
# "ruRU": "ru", # Russian (Russia)
# "deDE": "de", # German (Germany)
# "koKR": "ko", # Korean (Korea)
# "esES": "es", # Spanish (Spain)
# "frFR": "fr", # French (France)
# "zhCN": "cn",
# The very special character https://www.compart.com/en/unicode/U+2016
# Double Dagger
# "‡"

if __name__ == "__main__":
  # if len(sys.argv) != 2:
  #   print("Usage: python generate_l10n_table.py <path to classic_locales.json>")
  #   sys.exit(1)

  fileoutput = get_data_dir_path("l10n", "era") + "/l10nData.lua-table"

  # ! The order of these are very important and has to match the order in the
  # ! reading l10n code (Database\l10n\l10n.lua: indexToLocale)
  supportedLocales = ["enUS", "ptBR", "ruRU", "deDE", "koKR", "esES", "frFR", "zhCN"]
  # ! Same is true for the order of these
  supportedDataTypes = ["item", "npc", "object", "quest"]

  with open("./classic_locales.json", "r", encoding="utf-8") as f:
    locales = json.load(f)
  print(len(locales))

  LocaleData = {}
  for datatype, data in locales.items():
    if datatype not in supportedDataTypes:
      continue
    for typeId, typeData in data.items():
      if int(typeId) not in LocaleData:
        LocaleData[int(typeId)] = {}
      if datatype not in LocaleData[int(typeId)]:
        # LocaleData[int(typeId)][datatype] = {}
        LocaleData[int(typeId)][datatype] = []
      for locale in supportedLocales:
        # LocaleData[int(typeId)][datatype][locale] = typeData[locale]["name"]
        if datatype == "item" or datatype == "object":
          LocaleData[int(typeId)][datatype].append(typeData[locale]["name"])
        if datatype == "npc":
          subname = ""
          # regex: <\/b><\/td><\/tr>\\n<tr><td>(.*?)<\/td><\/tr><tr>
          # Extract the subname from the tooltip
          if "tooltip" in typeData[locale]:
            tooltip = typeData[locale]["tooltip"]
            match = re.search(r"<\/b><\/td><\/tr>\\n<tr><td>(.*?)<\/td><\/tr><tr>", tooltip)
            if match:
              subname = match.group(1)

          LocaleData[int(typeId)][datatype].append((typeData[locale]["name"], subname))
        if datatype == "quest":
          Description = ""
          if "Description" in typeData[locale]:
            Description = typeData[locale]["Description"]
          Text = ""
          if "Text" in typeData[locale]:
            Text = typeData[locale]["Text"]
          LocaleData[int(typeId)][datatype].append((typeData[locale]["Title"], Description, Text))

    print(f"const {datatype}")

  print("Deleting empty entries")
  # Delete all empty entries
  for dataid in list(LocaleData.keys()):
    if len(LocaleData[dataid]) == 0:
      del LocaleData[dataid]

  print("Escaping ' in strings")
  # Escape ' in strings
  for dataid in LocaleData.keys():
    for datatype in LocaleData[dataid].keys():
      if datatype == "item" or datatype == "object":
        for i in range(len(LocaleData[dataid][datatype])):
          LocaleData[dataid][datatype][i] = LocaleData[dataid][datatype][i].replace("'", "\\'")
      if datatype == "npc":
        for i in range(len(LocaleData[dataid][datatype])):
          LocaleData[dataid][datatype][i] = (LocaleData[dataid][datatype][i][0].replace("'", "\\'"), LocaleData[dataid][datatype][i][1].replace("'", "\\'"))
      if datatype == "quest":
        for i in range(len(LocaleData[dataid][datatype])):
          LocaleData[dataid][datatype][i] = (
            LocaleData[dataid][datatype][i][0].replace("'", "\\'"),
            LocaleData[dataid][datatype][i][1].replace("'", "\\'"),
            LocaleData[dataid][datatype][i][2].replace("'", "\\'"),
          )

  # print(LocaleData)
  print("Writing to file", fileoutput)
  with open(fileoutput, "w", encoding="utf-8") as f:
    indentation = "  "
    f.write("{\n")
    for dataid in sorted(LocaleData.keys()):
      data = LocaleData[dataid]

      #! Item
      f.write(f"[{dataid}] = " + "{\n")  # {json.dumps(data, ensure_ascii=False)}\n")
      if "item" in data:
        f.write(indentation + "-- Item\n")
        f.write(indentation + "'" + "‡".join(data["item"]) + "',\n")
      elif "npc" in data or "object" in data or "quest" in data:
        f.write("nil,\n")

      #! NPC
      # { "name", "subname" }
      if "npc" in data:
        AllNames = []
        AllSubnames = []
        for npc in data["npc"]:
          AllNames.append(npc[0])
          AllSubnames.append(npc[1])
        f.write(indentation + "{ -- Npc\n")
        f.write((indentation * 2) + "'" + "‡".join(AllNames) + "',\n")
        if "‡".join(AllSubnames) == "‡‡‡‡‡‡‡":
          f.write((indentation * 2) + "nil,\n")
        else:
          f.write("    '" + "‡".join(AllSubnames) + "',\n")
        f.write(indentation + "},\n")
      elif "object" in data or "quest" in data:
        f.write("nil,\n")

      #! Object
      if "object" in data:
        f.write(indentation + "-- Object\n")
        f.write(indentation + "'" + "‡".join(data["object"]) + "',\n")
      elif "quest" in data:
        f.write("nil,\n")

      #! Quest
      # { "Title", {"Description"}, {"Text"} }
      if "quest" in data:
        AllTitles = []
        AllDescriptions = []
        AllTexts = []
        for quest in data["quest"]:
          AllTitles.append(quest[0])
          AllDescriptions.append(quest[1])
          AllTexts.append(quest[2])
        f.write(indentation + "{ -- Quest\n")

        # ? Title
        f.write((indentation * 2) + "'" + "‡".join(AllTitles) + "',\n")

        # ? Progress/Description
        if "‡".join(AllDescriptions) == "‡‡‡‡‡‡‡":
          f.write((indentation * 2) + "nil,\n")
        else:
          f.write((indentation * 2) + "'" + "‡".join(AllDescriptions) + "',\n")

        # ? Quest Text
        if "‡".join(AllTexts) == "‡‡‡‡‡‡‡":
          f.write((indentation * 2) + "nil,\n")
        else:
          f.write((indentation * 2) + "'" + "‡".join(AllTexts) + "',\n")
        f.write(indentation + "},\n")
      # We don't need to write nil if it's the last entry

      f.write("},\n")

    f.write("}\n")
