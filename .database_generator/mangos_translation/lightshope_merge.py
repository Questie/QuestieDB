import argparse
import os
import re
import sqlite3
import shutil
import tempfile
from typing import List, Tuple, Optional

from convertSQL import convert_file


def _clean_sql_content(raw: str) -> str:
  """Normalize SQL before feeding into SQLite."""
  cleaned = raw.replace("\\'", "''")
  cleaned = re.sub(r"\)\s*COLLATE\s*=\s*[\w_]+\s*;", ");", cleaned, flags=re.IGNORECASE)
  cleaned = cleaned.replace("DROP TABLE IF EXISTS", "-- DROP TABLE IF EXISTS")
  return cleaned


def _load_lightshope_table(sql_path: str) -> Tuple[str, str, List[str], List[Tuple]]:
  """
  Convert a single Lightshope SQL file to SQLite, load into memory, and return table data.
  Returns (table_name, create_sql, columns, rows).
  """
  with open(sql_path, "r", encoding="utf-8", errors="replace") as infile:
    original = infile.read()

  # Work on a temp copy so we don't mutate the source file
  with tempfile.NamedTemporaryFile(delete=False, suffix=".sql") as tmp:
    tmp.write(original.encode("utf-8"))
    temp_path = tmp.name

  try:
    convert_file(temp_path, temp_path)
    with open(temp_path, "r", encoding="utf-8", errors="replace") as infile:
      converted = _clean_sql_content(infile.read())
  finally:
    try:
      os.remove(temp_path)
    except OSError:
      pass

  mem_conn = sqlite3.connect(":memory:")
  mem_conn.executescript(converted)

  cur = mem_conn.cursor()
  cur.execute("SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'locales_%'")
  tables = cur.fetchall()
  if not tables:
    raise RuntimeError(f"No locales tables found in {sql_path}")

  table_name = tables[0][0]
  cur.execute("SELECT sql FROM sqlite_master WHERE type='table' AND name=?", (table_name,))
  create_sql_row = cur.fetchone()
  create_sql = create_sql_row[0] if create_sql_row else None

  cur.execute(f"PRAGMA table_info({table_name})")
  columns = [row[1] for row in cur.fetchall()]
  cur.execute(f"SELECT * FROM {table_name}")
  rows = cur.fetchall()
  mem_conn.close()
  return table_name, create_sql, columns, rows


def _import_sql_file_into_db(target_conn: sqlite3.Connection, sql_path: str):
  """Convert and import a Lightshope SQL file directly into the target DB."""
  with open(sql_path, "r", encoding="utf-8", errors="replace") as infile:
    original = infile.read()

  with tempfile.NamedTemporaryFile(delete=False, suffix=".sql") as tmp:
    tmp.write(original.encode("utf-8"))
    temp_path = tmp.name

  try:
    convert_file(temp_path, temp_path)
    with open(temp_path, "r", encoding="utf-8", errors="replace") as infile:
      converted = _clean_sql_content(infile.read())
  finally:
    try:
      os.remove(temp_path)
    except OSError:
      pass

  target_conn.executescript(converted)


def _ensure_row_exists(conn: sqlite3.Connection, table: str, key_col: str, key_val):
  conn.execute(f"INSERT OR IGNORE INTO {table} ({key_col}) VALUES (?)", (key_val,))


def _merge_file_into_db(target_conn: sqlite3.Connection, sql_path: str, do_insert: bool, do_update: bool):
  table, create_sql, columns, rows = _load_lightshope_table(sql_path)

  cur = target_conn.cursor()
  cur.execute("SELECT name FROM sqlite_master WHERE type='table' AND name=?", (table,))
  if not cur.fetchone():
    print(f"[Lightshope-merge] Missing table {table}, importing full file {sql_path}")
    _import_sql_file_into_db(target_conn, sql_path)
    return

  key_col = columns[0]
  for row in rows:
    key_val = row[0]
    cur.execute(f"SELECT 1 FROM {table} WHERE {key_col}=?", (key_val,))
    exists = cur.fetchone() is not None
    if not exists and do_insert:
      _ensure_row_exists(target_conn, table, key_col, key_val)
      print(f"[Lightshope-merge] Inserted {table} id={key_val}")
    if exists or (do_insert and not exists):
      if do_update:
        updates = []
        params = []
        for col, val in zip(columns[1:], row[1:]):
          if val is None:
            continue
          if isinstance(val, str) and val == "":
            continue
          updates.append(f"{col}=?")
          params.append(val)
        if updates:
          params.append(key_val)
          sql = f"UPDATE {table} SET {', '.join(updates)} WHERE {key_col}=?"
          print(f"[Lightshope-merge] Updating {table} id={key_val}: {', '.join(updates)}")
          target_conn.execute(sql, params)


def merge_lightshope(lightshope_dir: str, target_db: str, insert: bool = True, updates: bool = False, target_conn: Optional[sqlite3.Connection] = None):
  own_conn = target_conn is None
  conn = target_conn or sqlite3.connect(target_db, timeout=30)
  conn.execute("PRAGMA busy_timeout=5000")
  if own_conn:
    conn.execute("PRAGMA journal_mode = DELETE")
    conn.execute("PRAGMA synchronous = NORMAL")

  sql_files = [os.path.join(lightshope_dir, f) for f in os.listdir(lightshope_dir) if f.endswith(".sql")]
  sql_files.sort()

  for sql_path in sql_files:
    print(f"[Lightshope-merge] Merging {sql_path}")
    try:
      _merge_file_into_db(conn, sql_path, insert, updates)
    except Exception as exc:
      print(f"[Lightshope-merge] Failed to merge {sql_path}: {exc}")

  conn.commit()
  if own_conn:
    conn.execute("PRAGMA wal_checkpoint(TRUNCATE)")
    conn.execute("PRAGMA journal_mode = DELETE")
    conn.close()


def import_fixed_sql(lightshope_dir: str, target_db: str):
  target_conn = sqlite3.connect(target_db, timeout=30)
  target_conn.execute("PRAGMA busy_timeout=5000")
  target_conn.execute("PRAGMA journal_mode = DELETE")
  target_conn.execute("PRAGMA synchronous = NORMAL")

  sql_files = [os.path.join(lightshope_dir, f) for f in os.listdir(lightshope_dir) if f.endswith(".sql")]
  sql_files.sort()

  for sql_path in sql_files:
    print(f"[Lightshope-merge] Importing fixed SQL {sql_path}")
    try:
      _import_sql_file_into_db(target_conn, sql_path)
    except Exception as exc:
      print(f"[Lightshope-merge] Failed to import {sql_path}: {exc}")

  target_conn.commit()
  target_conn.execute("PRAGMA wal_checkpoint(TRUNCATE)")
  target_conn.execute("PRAGMA journal_mode = DELETE")
  target_conn.close()


def main():
  parser = argparse.ArgumentParser(description="Merge Lightshope locale data into an existing SQLite DB.")
  parser.add_argument("--lightshope-dir", default="locales/world_full_14_june_2021/lightshope_locales", help="Directory containing Lightshope locale .sql files")
  parser.add_argument("--db", default="zero.db", help="Target SQLite DB to merge into (e.g., zero.db)")
  parser.add_argument("--no-copy", action="store_true", help="Do not copy the DB; merge directly into --db")
  args = parser.parse_args()

  target_db = args.db
  if not args.no_copy:
    base, ext = os.path.splitext(args.db)
    copy_path = f"{base}-testdb{ext}"
    for suffix in ("", "-wal", "-shm"):
      try:
        os.remove(copy_path + suffix)
      except OSError:
        pass
    try:
      shutil.copyfile(args.db, copy_path)
      print(f"[Lightshope-merge] Copied {args.db} -> {copy_path} for testing")
      target_db = copy_path
    except OSError as exc:
      print(f"[Lightshope-merge] Failed to copy DB: {exc}")

  merge_lightshope(args.lightshope_dir, target_db)


if __name__ == "__main__":
  main()
