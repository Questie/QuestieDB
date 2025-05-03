#!/usr/bin/env python3
"""
mysql_to_sqlite_converter.py

A simple script to convert a MySQL dump file into SQLite-compatible SQL.

Usage:
    python mysql_to_sqlite_converter.py input.sql [output.sql]

If output file is omitted, results are printed to stdout.
"""

import re


def convert(sql: str) -> str:
  # Remove MySQL versioned comments
  sql = re.sub(r"/\*![0-9]* .*?\*/;", "", sql, flags=re.DOTALL)

  # Remove backticks
  sql = sql.replace("`", "")

  # Remove ENGINE, DEFAULT CHARSET, ROW_FORMAT, COLLATE
  sql = re.sub(r"ENGINE=\w+", "", sql, flags=re.IGNORECASE)
  sql = re.sub(r"DEFAULT CHARSET=[^;\s]+", "", sql, flags=re.IGNORECASE)
  sql = re.sub(r"ROW_FORMAT=[^;\s]+", "", sql, flags=re.IGNORECASE)
  sql = re.sub(r"COLLATE\s+\w+", "", sql, flags=re.IGNORECASE)

  # Remove COMMENT '...'
  sql = re.sub(r"COMMENT[\s+|=]'[^']*'", "", sql, flags=re.IGNORECASE)

  # Convert common MySQL data types to SQLite equivalents
  type_mappings = {
    r"mediumint\(\d+\)\s+unsigned": "INTEGER",
    r"int\(\d+\)\s+unsigned": "INTEGER",
    r"smallint\(\d+\)\s+unsigned": "INTEGER",
    r"tinyint\(\d+\)\s+unsigned": "INTEGER",
    r"int\(\d+\)": "INTEGER",
    r"smallint\(\d+\)": "INTEGER",
    r"tinyint\(\d+\)": "INTEGER",
    r"longtext": "TEXT",
    r"mediumtext": "TEXT",
    r"tinytext": "TEXT",
    r"varchar\(\d+\)": "TEXT",
  }
  for pattern, repl in type_mappings.items():
    # sql = re.sub(r"\b" + pattern + r"\b", repl, sql, flags=re.IGNORECASE)
    sql = re.sub(pattern, repl, sql, flags=re.IGNORECASE)

  # Collapse multiple spaces
  sql = re.sub(r"[ \t]+", " ", sql)

  return sql


def convert_alter(sql: str) -> str:
  # Match the ALTER TABLE statement and capture the table name
  # print(sql)
  match = re.findall(
    r"ALTER TABLE (\w+)(.*?;)",
    sql.strip().replace("\n", "").replace("\r", ""),
    re.MULTILINE | re.DOTALL | re.IGNORECASE,
  )

  if not match:
    return sql  # Return original if not a matching ALTER TABLE statement

  output = []
  for m in match:
    table_name = m[0]

    # Add create of not exists statement for the table, empty
    output.append(f"CREATE TABLE IF NOT EXISTS {table_name} (id INTEGER PRIMARY KEY);")

    # Find all ADD COLUMN clauses
    # Regex captures the 'ADD COLUMN ...' part until the next comma or semicolon
    add_column_clauses = re.findall(r"ADD COLUMN\s+.*?(?=,\s*ADD COLUMN|\s*;)", m[1], re.IGNORECASE | re.DOTALL)

    if not add_column_clauses:
      return sql  # Return original if no ADD COLUMN clauses found

    # Construct new ALTER TABLE statements
    new_statements = []
    for clause in add_column_clauses:
      # Remove leading/trailing whitespace and potential trailing comma
      clause = clause.strip().rstrip(",")
      combined = f"ALTER TABLE {table_name} {clause};"
      # Remove any "AFTER <column_name>"
      combined = re.sub(r"AFTER\s+\w+", "", combined, flags=re.IGNORECASE)
      new_statements.append(combined)
      #
    # Append the new statements to the output
    output.extend(new_statements)

  return "\n".join(output)


def convert_locale(sql: str) -> str:
  # UPDATE locales_creature SET subname_loc3='GM Visuell' WHERE entry=1;
  # Each line is an update like this i want to add a INSERT OR IGNORE to create the entry
  # and then the update
  # INSERT OR IGNORE INTO locales_creature (entry, subname_loc3) VALUES (1, 'GM Visuell');
  # Match the UPDATE statement and capture the table name
  match = re.findall(r"UPDATE (\w+)\s+SET\s+(.*)\s+WHERE\s+(.*?);", sql)
  if not match:
    # Remove all SET NAMES '<charset>' statements
    sql = re.sub(r"SET NAMES\s'+.*?';", "", sql, flags=re.IGNORECASE)
    return sql

  output = []
  idOrEntry = {}
  for m in match:
    table_name = m[0]
    set_clause = m[1]
    where_clause = m[2]

    # Extract the values from the SET clause
    set_values = re.findall(r"(\w+)=('.+?',*)", set_clause)
    if not set_values:
      print(f"Error: No set values found in {set_clause}")
      return sql
    # Add the entry to set_values to keep the id/entry
    entryMatch = re.search(r"(\w+)=(\d+)", where_clause)
    if entryMatch:
      # print(entryMatch.group(1), entryMatch.group(2))
      if table_name not in idOrEntry:
        idOrEntry[table_name] = []
      idOrEntry[table_name].append((entryMatch.group(1), entryMatch.group(2)))

    # Construct the INSERT OR IGNORE statement ( This would be better but it bugs out... )
    # insert_values = ", ".join([f"{v.strip(',')}" for k, v in set_values])
    # insert_columns = ", ".join([f"{k}" for k, v in set_values])
    # insert_values.strip(",")
    # insert_statement = f"INSERT OR IGNORE INTO {table_name} ({insert_columns}) VALUES ({insert_values});"

    # Construct the UPDATE statement
    set_clause = set_clause.replace("\\'", "''")
    update_statement = f"UPDATE {table_name} SET {set_clause} WHERE {where_clause};"
    # Append the new statements to the output
    # output.append(insert_statement)
    output.append(update_statement)
  # Add the INSERT OR IGNORE statement for the entries
  for table_name, entries in idOrEntry.items():
    # Multiple entries per insert
    insert_values = ", ".join([f"({v.strip(',')})" for k, v in entries])
    insert_column = entries[0][0]
    insert_values = insert_values.replace("\\'", "''")
    insert_statement = f"INSERT OR IGNORE INTO {table_name} ({insert_column}) VALUES {insert_values};"
    # Insert at the start of the output
    output.insert(0, insert_statement)

  return "\n".join(output)


def convert_file(input_path: str, output_path: str) -> None:
  """
  Read SQL from input_path, convert it (including ALTER TABLE splitting),
  and write the result to output_path.
  """
  with open(input_path, "r", encoding="utf-8") as infile:
    data = infile.read()
  # Apply general conversions first
  converted_general = convert(data)
  # Then apply ALTER TABLE splitting to the result
  converted_final = convert_alter(converted_general)
  with open(output_path, "w", encoding="utf-8") as outfile:
    outfile.write(converted_final)


def convert_locale_file(input_path: str, output_path: str) -> None:
  """
  Read SQL from input_path, convert it (including ALTER TABLE splitting),
  and write the result to output_path.
  """
  with open(input_path, "r", encoding="utf-8") as infile:
    data = infile.read()
  # Apply general conversions first
  converted_general = convert(data)
  # Then apply ALTER TABLE splitting to the result
  converted_final = convert_locale(converted_general)
  with open(output_path, "w", encoding="utf-8") as outfile:
    outfile.write(converted_final)


def convert_locale_string(input_path: str) -> str:
  """
  Read SQL from input_path, convert it (including ALTER TABLE splitting),
  and write the result to output_path.
  """
  with open(input_path, "r", encoding="utf-8") as infile:
    data = infile.read()
  # Apply general conversions first
  converted_general = convert(data)
  # Then apply ALTER TABLE splitting to the result
  converted_final = convert_locale(converted_general)
  return converted_final


# One insert per update
# def convert_locale(sql: str) -> str:
#     # UPDATE locales_creature SET subname_loc3='GM Visuell' WHERE entry=1;
#     # Each line is an update like this i want to add a INSERT OR IGNORE to create the entry
#     # and then the update
#     # INSERT OR IGNORE INTO locales_creature (entry, subname_loc3) VALUES (1, 'GM Visuell');
#     # Match the UPDATE statement and capture the table name
#     match = re.findall(r"UPDATE (\w+)\s+SET\s+(.*?)\s+WHERE\s+(.*?);", sql)
#     if not match:
#         # Remove all SET NAMES '<charset>' statements
#         sql = re.sub(r"SET NAMES\s'+.*?';", "", sql, flags=re.IGNORECASE)
#         return sql

#     output = []
#     for m in match:
#         table_name = m[0]
#         set_clause = m[1]
#         where_clause = m[2]

#         # Extract the values from the SET clause
#         set_values = re.findall(r"(\w+)=('.+?',*)", set_clause)
#         if not set_values:
#             return sql
#         # Add the entry to set_values to keep the id/entry
#         entryMatch = re.search(r"(\w+)=(\d+)", where_clause)
#         if entryMatch:
#             # print(entryMatch.group(1), entryMatch.group(2))
#             set_values.append((entryMatch.group(1), entryMatch.group(2)))
#             insert_statement = f"INSERT OR IGNORE INTO {table_name} ({entryMatch.group(1)}) VALUES ({entryMatch.group(2)});"
#             output.append(insert_statement)

#         # Construct the INSERT OR IGNORE statement ( This would be better but it bugs out... )
#         # insert_values = ", ".join([f"{v.strip(',')}" for k, v in set_values])
#         # insert_columns = ", ".join([f"{k}" for k, v in set_values])
#         # insert_values.strip(",")
#         # insert_statement = f"INSERT OR IGNORE INTO {table_name} ({insert_columns}) VALUES ({insert_values});"

#         # Construct the UPDATE statement
#         set_clause = set_clause.replace("\\'", "''")
#         update_statement = f"UPDATE {table_name} SET {set_clause} WHERE {where_clause};"
#         # Append the new statements to the output
#         # output.append(insert_statement)
#         output.append(update_statement)
#     return "\n".join(output)
