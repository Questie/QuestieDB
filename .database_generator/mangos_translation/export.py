import sqlite3
import os

localeToDBIndex = {
  # Title_loc1 	text 	YES 		NULL 	  	Korean localization of Title in the "quest_template" table.
  # Title_loc2 	text 	YES 		NULL 	  	French localization of Title in the "quest_template" table.
  # Title_loc3 	text 	YES 		NULL 	  	German localization of Title in the "quest_template" table.
  # Title_loc4 	text 	YES 		NULL 	  	Chinese localization of Title in the "quest_template" table.
  # Title_loc5 	text 	YES 		NULL 	  	Taiwanese localization of Title in the "quest_template" table.
  # Title_loc6 	text 	YES 		NULL 	  	Spanish Spain localization of Title in the "quest_template" table.
  # Title_loc7 	text 	YES 		NULL 	  	Spanish Latin America localization of Title.
  # Title_loc8 	text 	YES 		NULL 	  	Russian localization of Title in the "quest_template" table.
  # Title_loc9 	text 	YES 		NULL 	  	Italian localization of Title in the "quest_template" table.
  # "ptBR": -,  # Portuguese (Brazil)
  "ruRU": 8,  # Russian (Russia)
  "deDE": 3,  # German (Germany)
  "koKR": 1,  # Korean (Korea)
  "esES": 6,  # Spanish (Spain)
  "frFR": 2,  # French (France)
  "esMX": 7,  # Spanish (Mexico)
  "zhTW": 5,  # Traditional Chinese (Taiwan)
  "zhCN": 4,  # Simplified Chinese (China)
  "itIT": 9,  # Italian (Italy)
}

fullLocaleToShort = {
  "Chinese": "zhCN",
  "French": "frFR",
  "German": "deDE",
  "Italian": "itIT",
  "Korean": "koKR",
  "Russian": "ruRU",
  "Spanish": "esES",
  "Spanish_South_American": "esMX",
  "Taiwanese": "zhTW",
}

mangosToVersion = {
  "zero": "era",
  "one": "tbc",
  "two": "wotlk",
  "three": "cata",
  # "four": "four",  # mop
}


def not_null_text(text: str) -> bool:
  """
  Check if the text is not null or empty.
  """
  return text is not None and text != "" and text != "None"


def export_item(conn: sqlite3.Connection, fullLocale: str, version: str) -> None:
  # Table locales_item
  # entry
  # name_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("output"):
    os.makedirs("output")
  # Check if version directory exists
  if not os.path.exists(f"output/{questieDBVersion}"):
    os.makedirs(f"output/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"output/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"output/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_item for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, name_loc{localeToDBIndex[shortLocale]} FROM locales_item")
  rows = cursor.fetchall()
  # Output data in lua table format
  with open(f"output/{questieDBVersion}/{shortLocale}/item_{questieDBVersion}_{shortLocale}.lua", "w", encoding="utf-8") as file:
    file.write("locales_item = locales_item or {}\n")
    file.write(f"locales_item['{shortLocale}'] = {{\n")
    for row in rows:
      entry = row[0]
      name = row[1]
      if name != "":
        name = str(name).replace("'", "\\'")
        file.write(f"  [{entry}] = '{name}',\n")
    file.write("}\n")


def export_gameobject(conn: sqlite3.Connection, fullLocale: str, version: str) -> None:
  # Table locales_object
  # entry
  # name_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("output"):
    os.makedirs("output")
  # Check if version directory exists
  if not os.path.exists(f"output/{questieDBVersion}"):
    os.makedirs(f"output/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"output/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"output/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_gameobject for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, name_loc{localeToDBIndex[shortLocale]} FROM locales_gameobject")
  rows = cursor.fetchall()
  # Output data in lua table format
  with open(f"output/{questieDBVersion}/{shortLocale}/object_{questieDBVersion}_{shortLocale}.lua", "w", encoding="utf-8") as file:
    file.write("locales_object = locales_object or {}\n")
    file.write(f"locales_object['{shortLocale}'] = {{\n")
    for row in rows:
      entry = row[0]
      name = row[1]
      if name != "":
        name = str(name).replace("'", "\\'")
        file.write(f"  [{entry}] = '{name}',\n")
    file.write("}\n")


# Npc
def export_creature(conn: sqlite3.Connection, fullLocale: str, version: str) -> None:
  # Table locales_creature
  # entry
  # name_loc<locale_id>, subname_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("output"):
    os.makedirs("output")
  # Check if version directory exists
  if not os.path.exists(f"output/{questieDBVersion}"):
    os.makedirs(f"output/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"output/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"output/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_creature for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, name_loc{localeToDBIndex[shortLocale]}, subname_loc{localeToDBIndex[shortLocale]} FROM locales_creature")
  rows = cursor.fetchall()
  # Output data in lua table format
  with open(f"output/{questieDBVersion}/{shortLocale}/npc_{questieDBVersion}_{shortLocale}.lua", "w", encoding="utf-8") as file:
    file.write("locales_npc = locales_npc or {}\n")
    file.write(f"locales_npc['{shortLocale}'] = {{\n")
    for row in rows:
      entry = row[0]
      name = row[1]
      subname = row[2]
      if not not_null_text(name) and not not_null_text(subname):
        continue

      file.write(f"  [{entry}] = {{\n")
      name = str(name).replace("'", "\\'")
      subname = str(subname).replace("'", "\\'")
      if not_null_text(name):
        file.write(f"    '{name}',\n")
      else:
        file.write("    nil,\n")
      if not_null_text(subname):
        file.write(f"    '{subname}',\n")
      else:
        file.write("    nil,\n")
      file.write("  },\n")
    file.write("}\n")


# Quest
# Title_loc<locale_id>, { Details_loc<locale_id> }, { Objectives_loc<locale_id> }
def export_quest(conn: sqlite3.Connection, fullLocale: str, version: str) -> None:
  # Table locales_quest
  # entry
  # name_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("output"):
    os.makedirs("output")
  # Check if version directory exists
  if not os.path.exists(f"output/{questieDBVersion}"):
    os.makedirs(f"output/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"output/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"output/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_quest for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, Title_loc{localeToDBIndex[shortLocale]}, Details_loc{localeToDBIndex[shortLocale]}, Objectives_loc{localeToDBIndex[shortLocale]} FROM locales_quest")
  rows = cursor.fetchall()
  # Output data in lua table format
  with open(f"output/{questieDBVersion}/{shortLocale}/quest_{questieDBVersion}_{shortLocale}.lua", "w", encoding="utf-8") as file:
    file.write("locales_quest = locales_quest or {}\n")
    file.write(f"locales_quest['{shortLocale}'] = {{\n")
    for row in rows:
      entry = row[0]
      title = row[1]
      details = row[2]
      objectives = row[3]
      if not not_null_text(title) and not not_null_text(details) and not not_null_text(objectives):
        continue

      title = str(title).replace("'", "\\'")
      details = str(details).replace("'", "\\'")
      objectives = str(objectives).replace("'", "\\'")
      file.write(f"  [{entry}] = {{\n")
      if not_null_text(title):
        file.write(f"    '{title}',\n")
      else:
        file.write("    nil,\n")
      if not_null_text(details):
        file.write(f"    {{'{details}', }},\n")
      else:
        file.write("    nil,\n")
      if not_null_text(objectives):
        file.write(f"    {{'{objectives}', }},\n")
      else:
        file.write("    nil,\n")
      file.write("  },\n")
    file.write("}\n")
