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


def generate_xml_import(version: str):
  """
  Generate the XML import file for the given locale and version.
  """
  # Generate import xml file
  # <Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ https://raw.githubusercontent.com/Gethe/wow-ui-source/live/Interface/AddOns/Blizzard_SharedXML/UI.xsd">
  #   <Script file="deDE/item_era_deDE.lua"/>
  #   ...
  # </Ui>

  questieDBVersion = mangosToVersion[version]
  output_dir = f"translations/{questieDBVersion}"

  # Check if output directory exists
  if not os.path.exists(output_dir):
    print(f"Output directory {output_dir} does not exist. Skipping XML generation.")
    return

  output_filename = f"locales_{questieDBVersion}.xml"
  xml_filepath = os.path.join(output_dir, output_filename)

  print(f"Generating XML import file: {xml_filepath}")

  # Generate import xml file
  with open(xml_filepath, "w", encoding="utf-8") as file:
    file.write(
      '<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ https://raw.githubusercontent.com/Gethe/wow-ui-source/live/Interface/AddOns/Blizzard_SharedXML/UI.xsd">\n'
    )

    # Iterate through locale subdirectories
    try:
      locale_dirs = [d for d in os.listdir(output_dir) if os.path.isdir(os.path.join(output_dir, d))]
    except FileNotFoundError:
      print(f"Error: Directory not found {output_dir}")
      locale_dirs = []

    for shortLocale in locale_dirs:
      locale_path = os.path.join(output_dir, shortLocale)
      try:
        lua_files = [f for f in os.listdir(locale_path) if f.endswith(".lua")]
      except FileNotFoundError:
        print(f"Error: Directory not found {locale_path}")
        lua_files = []

      for lua_filename in lua_files:
        # Use forward slashes for WoW paths
        relative_path = f"{shortLocale}/{lua_filename}"
        file.write(f'  <Script file="{relative_path}"/>\n')

    file.write("</Ui>\n")
  print(f"Finished generating XML import file: {xml_filepath}")


def export_item(conn: sqlite3.Connection, fullLocale: str, version: str):
  # Table locales_item
  # entry
  # name_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("translations"):
    os.makedirs("translations")
  # Check if version directory exists
  if not os.path.exists(f"translations/{questieDBVersion}"):
    os.makedirs(f"translations/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"translations/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"translations/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_item for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, name_loc{localeToDBIndex[shortLocale]} FROM locales_item")
  rows = cursor.fetchall()

  output_path = f"translations/{questieDBVersion}/{shortLocale}"
  output_filename = f"item_{questieDBVersion}_{shortLocale}.lua"

  # Output data in lua table format
  with open(os.path.join(output_path, output_filename), "w", encoding="utf-8") as file:
    file.write("locales_item = locales_item or {}\n")
    file.write(f"locales_item['{shortLocale}'] = {{\n")
    for row in rows:
      entry = row[0]
      name = row[1]
      if name != "":
        name = str(name).replace("'", "\\'")
        file.write(f"  [{entry}] = '{name}',\n")
    file.write("}\n")


def export_gameobject(conn: sqlite3.Connection, fullLocale: str, version: str):
  # Table locales_object
  # entry
  # name_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("translations"):
    os.makedirs("translations")
  # Check if version directory exists
  if not os.path.exists(f"translations/{questieDBVersion}"):
    os.makedirs(f"translations/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"translations/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"translations/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_gameobject for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, name_loc{localeToDBIndex[shortLocale]} FROM locales_gameobject")
  rows = cursor.fetchall()

  output_path = f"translations/{questieDBVersion}/{shortLocale}"
  output_filename = f"object_{questieDBVersion}_{shortLocale}.lua"

  # Output data in lua table format
  with open(os.path.join(output_path, output_filename), "w", encoding="utf-8") as file:
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
def export_creature(conn: sqlite3.Connection, fullLocale: str, version: str):
  # Table locales_creature
  # entry
  # name_loc<locale_id>, subname_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("translations"):
    os.makedirs("translations")
  # Check if version directory exists
  if not os.path.exists(f"translations/{questieDBVersion}"):
    os.makedirs(f"translations/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"translations/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"translations/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_creature for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, name_loc{localeToDBIndex[shortLocale]}, subname_loc{localeToDBIndex[shortLocale]} FROM locales_creature")
  rows = cursor.fetchall()

  output_path = f"translations/{questieDBVersion}/{shortLocale}"
  output_filename = f"npc_{questieDBVersion}_{shortLocale}.lua"

  # Output data in lua table format
  with open(os.path.join(output_path, output_filename), "w", encoding="utf-8") as file:
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
def export_quest(conn: sqlite3.Connection, fullLocale: str, version: str):
  # Table locales_quest
  # entry
  # name_loc<locale_id>

  shortLocale = fullLocaleToShort[fullLocale]
  questieDBVersion = mangosToVersion[version]

  # Check if output directory exists
  if not os.path.exists("translations"):
    os.makedirs("translations")
  # Check if version directory exists
  if not os.path.exists(f"translations/{questieDBVersion}"):
    os.makedirs(f"translations/{questieDBVersion}")
  # Check if locale directory exists
  if not os.path.exists(f"translations/{questieDBVersion}/{shortLocale}"):
    os.makedirs(f"translations/{questieDBVersion}/{shortLocale}")

  print(f"Exporting locales_quest for {fullLocale}")
  cursor = conn.cursor()
  cursor.execute(f"SELECT entry, Title_loc{localeToDBIndex[shortLocale]}, Details_loc{localeToDBIndex[shortLocale]}, Objectives_loc{localeToDBIndex[shortLocale]} FROM locales_quest")
  rows = cursor.fetchall()

  output_path = f"translations/{questieDBVersion}/{shortLocale}"
  output_filename = f"quest_{questieDBVersion}_{shortLocale}.lua"

  # Output data in lua table format
  with open(os.path.join(output_path, output_filename), "w", encoding="utf-8") as file:
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
