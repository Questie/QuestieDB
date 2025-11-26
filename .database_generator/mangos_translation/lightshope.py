import os
import re
import sqlite3
from typing import Optional, List

import requests
from convertSQL import convert_file


def download_lightshope() -> None:
  """Download the LightsHope database ZIP file into the temporary locales directory."""
  url = "https://github.com/Questie/QuestieDB/releases/download/LightsHope-db/world_full_14_june_2021.zip"
  output_dir = "locales"
  os.makedirs(output_dir, exist_ok=True)
  output_file = os.path.join(output_dir, "world_full_14_june_2021.zip")

  try:
    print(f"Downloading from {url} to {output_file} ...")
    response = requests.get(url, stream=True)
    response.raise_for_status()

    with open(output_file, "wb") as file:
      for chunk in response.iter_content(chunk_size=8192):
        if chunk:
          file.write(chunk)

    print(f"Successfully downloaded to {os.path.abspath(output_file)}")
  except requests.RequestException as e:
    print(f"Error downloading file: {e}")
    exit(1)


def _find_first_sql_file(directory: str) -> Optional[str]:
  """Return the first .sql file found under the given directory (shallow or nested)."""
  try:
    for root, _dirs, files in os.walk(directory):
      for name in files:
        if name.lower().endswith(".sql"):
          return os.path.join(root, name)
  except FileNotFoundError:
    return None
  return None


def _section_table_name(line: str) -> Optional[str]:
  """Extract the table name from comment headers like '-- Dumping data for table ...'."""
  match = re.search(r"table\s+`?([A-Za-z0-9_.]+)`?", line, re.IGNORECASE)
  return match.group(1) if match else None


def extract_locales_tables(dump_path: str, output_dir: str) -> List[str]:
  """
  Stream-extract all mangos.locales_* sections from a large SQL dump into separate files.

  We avoid loading the full dump into memory; lines are copied while the current section
  header contains "mangos.locales_".
  """
  if not os.path.exists(dump_path):
    raise FileNotFoundError(f"Dump file not found: {dump_path}")
  os.makedirs(output_dir, exist_ok=True)

  written_counts: dict[str, int] = {}
  current_table: Optional[str] = None
  current_file = None
  current_path: Optional[str] = None

  def _close_current():
    nonlocal current_file, current_table, current_path
    if current_file:
      current_file.close()
    current_file = None
    current_table = None
    current_path = None

  def _open_for_table(table_name: str):
    nonlocal current_file, current_table, current_path
    table_base = table_name.split(".")[-1]
    safe_name = re.sub(r"[^A-Za-z0-9_.-]+", "_", table_base)
    current_path = os.path.join(output_dir, f"locale_{safe_name}.sql")
    current_file = open(current_path, "w", encoding="utf-8", errors="replace", newline="\n")
    written_counts[current_path] = 0
    current_table = table_name

  try:
    with open(dump_path, "r", encoding="utf-8", errors="replace") as src:
      for line in src:
        table_name = _section_table_name(line) if line.startswith("--") else None
        if table_name:
          if not table_name.startswith("mangos.locales_"):
            _close_current()
            continue
          if table_name != current_table:
            _close_current()
            _open_for_table(table_name)

        if current_file:
          current_file.write(line)
          written_counts[current_path] += 1
  finally:
    _close_current()

  for path, count in written_counts.items():
    print(f"Extracted {count} lines to {os.path.abspath(path)}")
  return list(written_counts.keys())


def extract_lightshope_locales(base_dir: str = "locales", output_dirname: str = "lightshope_locales") -> Optional[List[str]]:
  """
  Convenience wrapper to locate the Lightshope SQL dump in the locales directory
  and extract all mangos.locales_* tables into standalone SQL files.
  """
  dump_path = _find_first_sql_file(base_dir)
  if not dump_path:
    print(f"No SQL dump found in {base_dir}; skipping Lightshope locales extraction.")
    return None

  output_dir = os.path.join(base_dir, output_dirname)
  return extract_locales_tables(dump_path, output_dir)


def convert_lightshope_sqlite_updates_only(file_paths: List[str]) -> List[str]:
  """
  Same as convert_lightshope_sqlite but only emits UPDATE statements (no insert).
  Useful when rows already exist and only content should be filled.
  """

  def _fmt(val) -> str:
    if val is None:
      return "NULL"
    if isinstance(val, str):
      return "'" + val.replace("'", "''") + "'"
    return str(val)

  converted: List[str] = []
  for path in file_paths:
    print(f"[Lightshope] Converting (updates-only) {path}")
    convert_file(path, path)
    with open(path, "r", encoding="utf-8", errors="replace") as infile:
      content = infile.read()
    content = content.replace("\\'", "''")
    content = re.sub(r"\)\s*COLLATE\s*=\s*[\w_]+\s*;", ");", content, flags=re.IGNORECASE)
    content = content.replace("DROP TABLE IF EXISTS", "-- DROP TABLE IF EXISTS")

    conn = sqlite3.connect(":memory:")
    try:
      conn.executescript(content)
    except sqlite3.Error as exc:
      print(f"[Lightshope] Failed to import {path} into temp DB: {exc}")
      conn.close()
      continue

    cursor = conn.cursor()
    cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table' AND name LIKE 'locales_%'")
    tables = cursor.fetchall()
    output_lines: List[str] = []

    for table, create_sql in tables:
      if create_sql:
        normalized_create = re.sub(
          r"^\s*CREATE\s+TABLE\s+(?!IF\s+NOT\s+EXISTS)",
          "CREATE TABLE IF NOT EXISTS ",
          create_sql,
          flags=re.IGNORECASE,
        )
        output_lines.append(normalized_create + ";")

      cursor.execute(f"PRAGMA table_info({table})")
      columns_info = cursor.fetchall()
      if not columns_info:
        continue
      columns = [c[1] for c in columns_info]
      key_column = columns[0]

      cursor.execute(f"SELECT * FROM {table}")
      rows = cursor.fetchall()
      if not rows:
        continue

      for row in rows:
        sets = []
        key_val = _fmt(row[0])
        for col, val in zip(columns[1:], row[1:]):
          if val is None:
            continue
          if isinstance(val, str) and val == "":
            continue
          sets.append(f"{col}={_fmt(val)}")
        if sets:
          output_lines.append(f"UPDATE {table} SET {','.join(sets)} WHERE {key_column}={key_val};")

    conn.close()

    out_path = path.replace(".sql", "_updates_only.sql")
    with open(out_path, "w", encoding="utf-8", errors="replace", newline="\n") as outfile:
      outfile.write("\n".join(output_lines))
    converted.append(out_path)

  return converted


def convert_lightshope_sqlite_inserts_only(file_paths: List[str]) -> List[str]:
  """
  Convert extracted MySQL locale tables to SQLite syntax and emit only INSERT OR IGNORE statements.
  Useful when you want to seed rows without touching existing data.
  """

  def _fmt(val) -> str:
    if val is None:
      return "NULL"
    if isinstance(val, str):
      return "'" + val.replace("'", "''") + "'"
    return str(val)

  converted: List[str] = []
  for path in file_paths:
    print(f"[Lightshope] Converting (inserts-only) {path}")
    convert_file(path, path)
    with open(path, "r", encoding="utf-8", errors="replace") as infile:
      content = infile.read()
    content = content.replace("\\'", "''")
    content = content.replace("\\''", "'''")
    content = re.sub(r"\)\s*COLLATE\s*=\s*[\w_]+\s*;", ");", content, flags=re.IGNORECASE)
    content = content.replace("DROP TABLE IF EXISTS", "-- DROP TABLE IF EXISTS")

    content = content.replace("INSERT INTO", "INSERT OR IGNORE INTO")

    with open(path, "w", encoding="utf-8", errors="replace", newline="\n") as outfile:
      outfile.write(content)
    converted.append(path)

  return converted


# Original function:

# def convert_lightshope_sqlite(file_paths: List[str]) -> List[str]:
#   """
#   Convert extracted MySQL locale tables to SQLite syntax and emit merge-friendly SQL:
#     - Create a temporary SQLite DB and import the table
#     - Emit INSERT OR IGNORE for all primary key entries
#     - Emit UPDATEs setting non-null, non-empty columns per row
#     - Write to <original>_converted.sql (does not import)
#   """

#   def _fmt(val) -> str:
#     if val is None:
#       return "NULL"
#     if isinstance(val, str):
#       return "'" + val.replace("'", "''") + "'"
#     return str(val)

#   converted: List[str] = []
#   for path in file_paths:
#     print(f"[Lightshope] Converting {path}")
#     convert_file(path, path)
#     with open(path, "r", encoding="utf-8", errors="replace") as infile:
#       content = infile.read()
#     content = content.replace("\\'", "''")
#     content = content.replace("\\''", "'''")
#     # Drop unsupported table-level COLLATE clauses that can follow CREATE TABLE (...).
#     content = re.sub(r"\)\s*COLLATE\s*=\s*[\w_]+\s*;", ");", content, flags=re.IGNORECASE)
#     content = content.replace("DROP TABLE IF EXISTS", "-- DROP TABLE IF EXISTS")

#     # Write content to disk
#     with open(path, "w", encoding="utf-8", errors="replace", newline="\n") as outfile:
#       outfile.write(content)

#     conn = sqlite3.connect(":memory:")
#     try:
#       conn.executescript(content)
#     except sqlite3.Error as exc:
#       print(f"[Lightshope] Failed to import {path} into temp DB: {exc}")
#       conn.close()
#       continue

#     cursor = conn.cursor()
#     cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table' AND name LIKE 'locales_%'")
#     tables = cursor.fetchall()
#     output_lines: List[str] = []

#     for table, create_sql in tables:
#       if create_sql:
#         normalized_create = re.sub(
#           r"^\s*CREATE\s+TABLE\s+(?!IF\s+NOT\s+EXISTS)",
#           "CREATE TABLE IF NOT EXISTS ",
#           create_sql,
#           flags=re.IGNORECASE,
#         )
#         output_lines.append(normalized_create + ";")

#       cursor.execute(f"PRAGMA table_info({table})")
#       columns_info = cursor.fetchall()
#       if not columns_info:
#         continue
#       columns = [c[1] for c in columns_info]
#       key_column = columns[0]

#       cursor.execute(f"SELECT * FROM {table}")
#       rows = cursor.fetchall()
#       if not rows:
#         continue

#       entries = ",".join(f"({_fmt(row[0])})" for row in rows)
#       output_lines.append(f"INSERT OR IGNORE INTO {table} ({key_column}) VALUES {entries};")

#       for row in rows:
#         sets = []
#         key_val = _fmt(row[0])
#         for col, val in zip(columns[1:], row[1:]):
#           if val is None:
#             continue
#           if isinstance(val, str) and val == "":
#             continue
#           sets.append(f"{col}={_fmt(val)}")
#         if sets:
#           output_lines.append(f"UPDATE OR IGNORE {table} SET {','.join(sets)} WHERE {key_column}={key_val};")

#     conn.close()

#     # out_path = path.replace(".sql", "_converted.sql")
#     with open(path, "w", encoding="utf-8", errors="replace", newline="\n") as outfile:
#       outfile.write("\n".join(output_lines))
#     converted.append(path)

#   return converted
