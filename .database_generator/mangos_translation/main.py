import os
import shutil
import sqlite3
import threading

import zipfile

from convertSQL import convert_file, convert_locale_file
from download import download_loadDB, download_alterDB, download_locales
from export import export_item, export_gameobject, export_creature, export_quest, generate_xml_import
from lightshope import download_lightshope, extract_lightshope_locales, convert_lightshope_sqlite_inserts_only, convert_lightshope_sqlite_updates_only
from lightshope_merge import merge_lightshope


def create_connection(db_file):
  """create a database connection to a SQLite database"""
  conn = None
  try:
    conn = sqlite3.connect(db_file)
    print(f"Connection to {db_file} successful")
  except sqlite3.Error as e:
    print(f"The error '{e}' occurred")
  return conn


def execute_query(conn, query):
  """Execute a single query"""
  try:
    cursor = conn.cursor()
    cursor.execute(query)
    conn.commit()
    print("Query executed successfully")
  except sqlite3.Error as e:
    print(f"The error '{e}' occurred")


def execute_read_query(conn, query):
  """Execute a read query and return the results"""
  cursor = conn.cursor()
  result = None
  try:
    cursor.execute(query)
    result = cursor.fetchall()
    return result
  except sqlite3.Error as e:
    print(f"The error '{e}' occurred")


def column_exists(connection, table_name, column_name):
  cursor = connection.cursor()
  cursor.execute(f"PRAGMA table_info({table_name})")
  columns = [row[1] for row in cursor.fetchall()]  # row[1] is the column name
  return column_name in columns


def import_sql_file(conn, file_path):
  """Import SQL file into the database"""
  with open(file_path, "r", encoding="utf-8", newline="\n") as file:
    sql_script = file.read()
  try:
    cursor = conn.cursor()
    cursor.executescript(sql_script)
    conn.commit()
    print(f"SQL script executed successfully {file_path}")
  except sqlite3.Error as e:
    print(f"Error occurred while executing {file_path}: {e}")
    exit(1)


def process(locales, version, datasources={"emit": "inserts", "lightshope": False}):
  """Process the locales and version"""
  db_file = f"{version}.db"
  os.remove(db_file) if os.path.exists(db_file) else None
  connection = create_connection(db_file)

  if connection:
    # Set PRAGMA to increase write speed
    cursor = connection.cursor()
    cursor.execute("PRAGMA synchronous = OFF")
    cursor.execute("PRAGMA journal_mode = MEMORY")
    cursor.execute("PRAGMA temp_store = MEMORY")
    cursor.execute("PRAGMA cache_size = 1000000")
    cursor.execute("PRAGMA locking_mode = EXCLUSIVE")
    cursor.execute("PRAGMA foreign_keys = ON")
    # cursor.execute("PRAGMA auto_vacuum = FULL")
    # cursor.execute("PRAGMA page_size = 4096")
    connection.commit()

    # Check if the locales directory exists
    os.makedirs("locales", exist_ok=True)
    # Check if the version directory exists
    if os.path.exists(f"locales/{version}"):
      shutil.rmtree(f"locales/{version}", ignore_errors=True)
    os.makedirs(f"locales/{version}", exist_ok=True)

    loaddb_file = f"locales/{version}/mangos{version}LoadDB.sql"
    with open(loaddb_file, "w", encoding="utf-8", newline="\n") as file:
      create = download_loadDB(version)
      file.write(create)
    convert_file(loaddb_file, loaddb_file)
    import_sql_file(connection, loaddb_file)

    alterdb_file = f"locales/{version}/mangos{version}AlterDB.sql"
    with open(alterdb_file, "w", encoding="utf-8", newline="\n") as file:
      alter = download_alterDB(version)
      file.write(alter)
    convert_file(alterdb_file, alterdb_file)

    # Manual fix, add ALTER TABLE locales_quest ADD COLUMN CompletedText_loc9 TEXT ;
    # This is a workaround for the fact that the ALTER TABLE statement does not support adding multiple columns in one statement
    # Append the ALTER TABLE statement to the file
    if not column_exists(connection, "locales_quest", "CompletedText_loc9"):
      with open(alterdb_file, "a", encoding="utf-8", newline="\n") as file:
        file.write("ALTER TABLE locales_quest ADD COLUMN CompletedText_loc9 TEXT ;\n")

    import_sql_file(connection, alterdb_file)

    # Download locales
    download_locales(locales, version, f"locales/{version}")
    # Convert and import locales
    # Recursively get all files in the locales directory
    for locale in locales:
      locale_dir = os.path.join(f"locales/{version}", locale)
      if not os.path.exists(locale_dir):
        continue
      for root, dirs, files in os.walk(locale_dir):
        for file in files:
          if not file.endswith(".sql"):
            continue
          path = os.path.join(root, file)
          convert_locale_file(path, path)
          import_sql_file(connection, path)
    connection.commit()

    if version == "zero" and datasources["lightshope"]:
      print("Processing Lightshope database...")
      download_lightshope()
      zip_path = os.path.join("locales", "world_full_14_june_2021.zip")
      if os.path.exists(zip_path):
        try:
          with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall("locales")
          print("Unpacked Lightshope database into locales/")
          extracted = extract_lightshope_locales(os.path.join("locales", "world_full_14_june_2021"))
          if extracted:
            # Convert to SQLite and import
            # converted = convert_lightshope_sqlite(extracted)
            # if datasources["emit"] == "updates":
            #   converted = convert_lightshope_sqlite_updates_only(extracted)
            # else:
            converted = convert_lightshope_sqlite_inserts_only(extracted)
            print(len(converted), "Lightshope locale SQL dumps converted.")
            merge_lightshope(
              os.path.join("locales", "world_full_14_june_2021", "lightshope_locales"),
              db_file,
              insert=(datasources["emit"] == "inserts"),
              updates=(datasources["emit"] == "updates"),
              target_conn=connection,
            )

            # for path in converted:
            #   import_sql_file(connection, path)
          else:
            print("No Lightshope SQL dump found for extraction.")
        except (zipfile.BadZipFile, OSError) as exc:
          print(f"Failed to unpack Lightshope zip: {exc}")

    # Export all entityType locales
    for locale in locales:
      export_item(connection, locale, version)
      export_gameobject(connection, locale, version)
      export_creature(connection, locale, version)
      export_quest(connection, locale, version)

    # Generate import xml file
    # <Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ https://raw.githubusercontent.com/Gethe/wow-ui-source/live/Interface/AddOns/Blizzard_SharedXML/UI.xsd">
    #   <Script file="deDE/item_era_deDE.lua"/>
    #   ...
    # </Ui>
    generate_xml_import(version)

    connection.close()

    print(f"Finished processing version {version}")


if __name__ == "__main__":
  locales = [
    "Chinese",
    "French",
    "German",
    "Italian",
    "Korean",
    "Russian",
    "Spanish",
    "Spanish_South_American",
    "Taiwanese",
  ]
  versions = [
    "zero",
    # "one",
    # "two",
    # "three",
  ]  # four is mop but does not have locales
  threads = []
  for version in versions:
    # Process the locales and version
    thread = threading.Thread(
      target=process,
      args=(
        locales,
        version,
        {
          "emit": "inserts",
          "lightshope": True,
        },
      ),
      daemon=True,
    )
    threads.append(thread)
    thread.start()

  # Wait for all threads to finish
  for thread in threads:
    thread.join()

  print("Removing locales directory...")
  # Remove the locales directory
  # shutil.rmtree("locales", ignore_errors=True)

  print("All threads have finished processing.")
