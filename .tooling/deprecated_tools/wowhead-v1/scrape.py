import re
import json
import sys
import time
import threading
import queue
import datetime
import os
import argparse
from typing import NamedTuple
from wowhead import getData, getDataSqlite
from http_controller import start_http_server
from quest import getQuestSections
from sitemap import get_all_ids
import sqlite3

# Constants
# Thread-safe queue for subtitles
fetch_queue = queue.Queue()

output_dir = ".output"
if not os.path.exists(output_dir):
  os.mkdir(output_dir)

# --- Progress Tracking ---
items_processed = 0
items_processed_lock = threading.Lock()
total_items = 0
start_time_global = 0
already_processed = 0
# -------------------------

# --- Control Flag ---
stop_event = threading.Event()
# --------------------


# --- Progress Data Structure ---
class ProgressData(NamedTuple):
  total_processed_now: int
  total_items_to_process: int
  current_session_processed: int
  items_remaining_to_process: int
  elapsed_time: float
  items_per_second: float
  estimated_time_remaining: float
  eta_str: str
  is_complete: bool
  has_started: bool


def calculate_progress_data() -> ProgressData:
  """Calculate current progress data that can be used by both monitor and HTTP functions."""
  global items_processed, total_items, start_time_global, already_processed

  # Calculate items remaining to process in this session
  items_remaining_to_process = total_items - already_processed

  with items_processed_lock:
    total_processed_now = items_processed  # Total items processed so far
    current_session_processed = total_processed_now - already_processed  # Items processed in current session

  # Check if current session is complete OR we've processed everything
  is_complete = current_session_processed >= items_remaining_to_process or total_processed_now >= total_items

  elapsed_time = time.time() - start_time_global if start_time_global > 0 else 0

  # Ensure current session processed is not negative
  current_session_processed = max(0, current_session_processed)

  # Calculate rate and ETA
  items_per_second = 0.0
  estimated_time_remaining = 0.0
  eta_str = "0:00:00"

  if elapsed_time > 0 and current_session_processed > 0:
    # Calculate rate based only on current session processing
    items_per_second = current_session_processed / elapsed_time
    remaining_items_in_session = items_remaining_to_process - current_session_processed
    estimated_time_remaining = remaining_items_in_session / items_per_second if items_per_second > 0 else 0
    # Format ETA
    eta_str = str(datetime.timedelta(seconds=int(estimated_time_remaining)))

  has_started = elapsed_time > 0

  return ProgressData(
    total_processed_now=total_processed_now,
    total_items_to_process=total_items,
    current_session_processed=current_session_processed,
    items_remaining_to_process=items_remaining_to_process,
    elapsed_time=elapsed_time,
    items_per_second=items_per_second,
    estimated_time_remaining=estimated_time_remaining,
    eta_str=eta_str,
    is_complete=is_complete,
    has_started=has_started,
  )


def format_progress_string(progress_data: ProgressData) -> str:
  """Format progress data into a human-readable string."""
  if progress_data.is_complete:
    return f"Processing complete! {progress_data.total_processed_now}/{progress_data.total_items_to_process} ids processed"

  if progress_data.has_started and progress_data.current_session_processed > 0:
    # Return progress update showing both total and session progress
    return f"Progress: {progress_data.total_processed_now}/{progress_data.total_items_to_process} | Session: {progress_data.current_session_processed}/{progress_data.items_remaining_to_process} ({progress_data.items_per_second:.2f} ids/sec) | Elapsed: {str(datetime.timedelta(seconds=int(progress_data.elapsed_time)))} | ETA: {progress_data.eta_str}"
  elif progress_data.current_session_processed == 0 and progress_data.has_started:
    return f"Progress: {progress_data.total_processed_now}/{progress_data.total_items_to_process} | Session: 0/{progress_data.items_remaining_to_process} | Elapsed: {str(datetime.timedelta(seconds=int(progress_data.elapsed_time)))} | Calculating rate..."
  else:
    # Initial state or edge case
    return f"Starting processing... {progress_data.items_remaining_to_process} ids queued for this session."


# ----------------------------


# --- Progress Monitoring Function ---
def monitor_progress() -> None:
  """Monitor progress and print updates to console."""

  while not stop_event.is_set():
    progress_data = calculate_progress_data()

    # Check if processing is complete
    if progress_data.is_complete:
      print(f"\n{format_progress_string(progress_data)}")
      break  # Exit monitor loop

    # Print appropriate progress message based on current state
    progress_string = format_progress_string(progress_data)
    if progress_data.has_started and progress_data.current_session_processed > 0:
      print(f"\r{progress_string}", end="\n")
    elif progress_data.current_session_processed == 0 and progress_data.has_started:
      print(f"\r{progress_string}", end="\n")
    else:
      # Initial state or edge case
      print(progress_string, end="\r")

    time.sleep(2)  # Update frequency (in seconds)

  # --- Final message ---
  # Clear the progress line and show final status
  print("\nMonitoring stopped.")
  # -------------------


# --- Progress Information Function for HTTP Server ---
def get_progress_info() -> str:
  """Return current progress information as a formatted string."""
  progress_data = calculate_progress_data()
  return format_progress_string(progress_data)


# -------------------------------------------------------


faction_description_regex = re.compile(r"\"(.*)\",\n\s*\"article-all\"")
faction_backup_description_regex = re.compile(r"<meta name=\"description\" content=\"(.*?)\">")
faction_g_faction_regex = re.compile(r"g_factions\[\d*\], (.*)\);")
# ? This all works, but only English has any information...
# ADD AFTER THIS LINE ->
# description = None
# try:
#   # Get description
#   description = faction_description_regex.search(rawData).group(1)
#   # Replace all HTML tags
#   description = re.sub(r"\[.*?\]", "", description)
#   # Replace \\r\\n with \n
#   description = description.replace("\\r\\n", "\n")
#   # Replace many \n with just one
#   description = re.sub(r"\n+", "\n", description)
#   # Remove trailing newline
#   description = description.strip()
#   # Add description to g_faction
#   g_faction["description"] = description
# except Exception as e1:
#   try:
#     description = faction_backup_description_regex.search(rawData).group(1)
#     # Add description to g_faction
#     g_faction["description"] = description
#   except Exception as e2:
#     print(f"Failed to get description for {idType} {id} Exception: {e1} and {e2}")


def fetch_worker(version, idData, output_only=False):
  global items_processed  # Declare intent to modify global variable
  tries = {}
  while not fetch_queue.empty():
    # --- Check for stop signal ---
    if stop_event.is_set():
      print(f"Worker thread {threading.current_thread().name} stopping.")
      break
    # ---------------------------

    idType, id = fetch_queue.get()
    processed_successfully = False  # Flag to track if item was processed
    try:
      if len(fetch_queue.queue) % 100 == 0:
        print(f"{len(fetch_queue.queue)} items left in queue")

      # Get data
      # data = getData(idType, id, version, "all")
      data = getDataSqlite(idType, id, version, "all", output_only=output_only)

      # If data is None, continue to the next item in the queue
      if data is None:
        print(f"Data is None for {idType} {id}")
        continue

      # Common processing for all idTypes
      idData[idType][id] = {}
      if idType == "faction":
        for locale, data in data.items():
          if type(data) is bytes:
            rawData = data.decode("utf-8")
          else:
            rawData = data
          # Get g_faction
          g_faction = faction_g_faction_regex.search(rawData)
          if g_faction:
            g_faction = g_faction.group(1)
            # Load g_faction as JSON
            g_faction = json.loads(g_faction)

            idData[idType][id][locale] = g_faction

      elif idType == "quest":
        usData = getQuestSections("enUS", data["enUS"], id)
        if len(usData) == 0:
          print(f"Section count is 0 for {idType} {id}")
          continue
        else:
          idData[idType][id]["enUS"] = usData
        for locale, localeData in data.items():
          if locale != "enUS":
            localeData = getQuestSections(locale, localeData, id)
            if len(localeData) == 0:
              print(f"Section count is 0 for {idType} {id} {locale}")
              continue
            elif len(localeData) != len(usData):
              print(f"Section count mismatch for {idType} {id} {locale}")
            idData[idType][id][locale] = localeData
      elif idType == "npc":
        for locale, localeData in data.items():
          data = json.loads(localeData)
          dataObject = {}
          # Get the name and subname
          dataObject["name"] = data["name"]
          # Extract the subname from the tooltip
          if "tooltip" in data:
            tooltip = data["tooltip"]
            # match = re.search(r"<\/b><\/td><\/tr>\n<tr><td>(.*?)<\/td><\/tr><tr>", tooltip)
            match = re.search(r"<\/b><\/td><\/tr>\n<tr><td>(.*?)<\/td><\/tr><tr><td>.*?<\/td></tr>(?!<\/table>)", tooltip)
            if match:
              subname = match.group(1)
              dataObject["subname"] = subname
          # Add to the dictionary
          idData[idType][id][locale] = dataObject
      elif idType == "object" or idType == "item":
        for locale, localeData in data.items():
          data = json.loads(localeData)
          idData[idType][id][locale] = data["name"]
      else:
        for locale, localeData in data.items():
          data = json.loads(localeData)
          idData[idType][id][locale] = data

      # If we reach here, processing was successful for this ID
      processed_successfully = True
      # print(f"{str(idType).capitalize()} {id} took processing: {(time.time() - start_time):.2f}s, fetch: {fetch_time:.2f}s, total: {fetch_time + (time.time() - start_time):.2f}s")

    except Exception as e:
      if "404 Client Error: Not Found" in str(e):
        print(f"404 Error for {idType} {id}, skipping...")
        with open("404-ids.txt", "a", encoding="utf-8") as f:
          f.write(f"{idType} {id}\n")
        # Increment processed items count
        with items_processed_lock:
          items_processed += 1
        continue
      print(f"Exception: {e} for {idType} {id}, requeueing...")
      if idType not in tries:
        tries[idType] = {}
      if id not in tries[idType]:
        tries[idType][id] = 1
      else:
        tries[idType][id] += 1
      if tries[idType][id] < 10:
        fetch_queue.put((idType, id))
    finally:
      if processed_successfully:
        with items_processed_lock:
          items_processed += 1
      fetch_queue.task_done()


def scrape(version, db_path="./", ids_file=None, output_only=False):
  # * Yeah i know , globals are bad but whatever...
  global items_processed  # Access global counter
  global total_items  # Access global total items
  global start_time_global  # Access global start time
  global stop_event  # Access global stop event

  db_file = os.path.join(db_path, f".cache-{version.lower()}.db")

  print(f"Making sure that {db_file} exists...")
  cache = sqlite3.connect(db_file)
  # Create the database table if it exists
  cache.execute("""
  CREATE TABLE IF NOT EXISTS wowhead_cache (
    idType TEXT,
    id INTEGER,
    version TEXT,
    locale TEXT,
    data TEXT,
    PRIMARY KEY (idType, id, version, locale)
  )""")
  cache.commit()

  # Get already processed ids count for version
  cursor = cache.cursor()
  cursor.execute("SELECT COUNT(DISTINCT id) FROM wowhead_cache WHERE version = ?", (version,))
  global already_processed
  already_processed = cursor.fetchone()[0]
  print(f"Already processed {already_processed} items for version {version}")
  cache.close()

  entity_types = [
    "npc",
    "item",
    "quest",
    "object",
    # "spell",
    # "faction",
  ]

  all_ids = {}
  if ids_file:
    print(f"Loading IDs from {ids_file}...")
    with open(ids_file, "r", encoding="utf-8") as f:
      all_ids = json.load(f)

    # Validate that the entity types are valid
    for json_entity_type in all_ids.keys():
      if json_entity_type not in entity_types:
        print(f"Invalid entity type {json_entity_type} found in {ids_file}")
        sys.exit(1)

  else:
    print("Fetching all IDs from sitemap...")
    # all_ids["npc"] = getAllIdsWowhead(version, "npc")
    # all_ids["item"] = getAllIdsWowhead(version, "item")
    # all_ids["quest"] = getAllIdsWowhead(version, "quest")
    # all_ids["object"] = getAllIdsWowhead(version, "object")
    # all_ids["spell"] = getAllIdsWowhead(version, "spell")
    # all_ids["faction"] = getAllIdsWowhead(version, "faction")

    all_ids["npc"] = get_all_ids(version.lower(), "npc")
    all_ids["item"] = get_all_ids(version.lower(), "item")
    all_ids["quest"] = get_all_ids(version.lower(), "quest")
    all_ids["object"] = get_all_ids(version.lower(), "object")
    # all_ids["spell"] = get_all_ids(version.lower(), "spell")
    # all_ids["faction"] = get_all_ids(version.lower(), "faction")

    # Only save the first N ids for each type
    # all_ids["npc"] = all_ids["npc"][:3]
    # all_ids["item"] = all_ids["item"][:3]
    # all_ids["quest"] = all_ids["quest"][:3]
    # all_ids["object"] = all_ids["object"][:3]

    # Save all ids fetched from wowhead
    with open(f"{output_dir}/{version.lower()}_all_ids.json", "w", encoding="utf-8") as f:
      json.dump(all_ids, f, indent=2, ensure_ascii=False)

  # --- Populate Queue and Get Total Count ---
  items_processed = 0
  total_items = 0
  idData = {}
  for idType, ids in all_ids.items():
    idData[idType] = {}
    print(f"Queueing {len(ids)} {idType} IDs...")
    for id in ids:
      fetch_queue.put((idType, id))
    total_items += len(ids)
  print(f"Total items queued: {total_items}")
  # ------------------------------------------

  # --- Start the HTTP control server ---
  start_http_server(stop_event, get_progress_info)
  time.sleep(2)  # Give the server a moment to start
  # -------------------------------------

  # --- Start Monitor Thread ---
  start_time_global = time.time()
  monitor_thread = threading.Thread(target=monitor_progress, daemon=True)
  monitor_thread.start()
  # ----------------------------

  print("Starting to process the ids...")
  if not output_only:
    # Start translation workers
    num_threads = 16  # You can adjust this based on your actual RPM and CPU cores
    threads = []
    for _ in range(num_threads):
      thread = threading.Thread(target=fetch_worker, args=(version, idData, output_only))
      thread.start()
      threads.append(thread)
      # Stagger the start of the threads
      time.sleep(0.3)

    # Wait for all threads to finish
    for thread in threads:
      thread.join()
  else:
    print("Output only mode, skipping fetching data.")
    fetch_worker(version, idData, output_only)

  # Stop the monitor thread
  stop_event.set()

  # This function is used to write a dictionary to a file
  # But also not print the trailing comma
  # json.dump works but the map value is too nested and makes the file unreadable
  def write_dict(d, f, indent=0):
    f.write("{")
    items = list(d.items())
    for i, (k, v) in enumerate(items):
      f.write(f'\n{" " * (indent + 2)}"{k}": ')
      if isinstance(v, dict):
        write_dict(v, f, indent=indent + 2)
      else:
        f.write(json.dumps(v, ensure_ascii=False))
      # Write a comma if this isn't the last item
      if i < len(items) - 1:
        f.write(",")
    # If the dictionary is empty, don't print a newline
    if len(items) == 0:
      f.write("}")
    else:
      f.write(f"\n{' ' * indent}}}")

  # Why i don't just use json.dump() is because the map is too nested and creates a huge file
  filename = f"{output_dir}/{version.lower()}_locales.json"
  print(f"Saving {filename}...")

  with open(filename, "w", encoding="utf-8") as f:
    write_dict(idData, f)

  # Save as YAML as well (optional)
  try:
    import yaml

    yaml_filename = f"{output_dir}/{version.lower()}_locales.yaml"
    print(f"Saving {yaml_filename}...")
    # Use a large width to prevent unwanted line wrapping in YAML
    # yaml.dump(idData, open(yaml_filename, "w", encoding="utf-8"), allow_unicode=True, sort_keys=False, width=float("inf"))
  except ImportError:
    print("PyYAML not installed, skipping YAML output.")

  print("Done")


allowed_expansions = ["Classic", "TBC", "Wotlk", "Cata", "MoP-Classic"]
if __name__ == "__main__":
  parser = argparse.ArgumentParser(description="Scrape data from Wowhead.")
  parser.add_argument("version", help=f"The version to scrape. Allowed values: {', '.join(allowed_expansions)}, all")
  parser.add_argument("--ids-file", help="Path to a JSON file containing IDs to fetch.")
  parser.add_argument("--db-path", default="./", help="Path to the database directory.")
  parser.add_argument("--output-only", action="store_true", help="Only output the data without scraping.")
  args = parser.parse_args()

  version = args.version
  db_path = args.db_path
  ids_file = args.ids_file
  output_only = args.output_only

  if version not in allowed_expansions and version != "all":
    print(f"Version {version} is not allowed. Allowed versions are: {', '.join(allowed_expansions)}")
    sys.exit(1)

  if version == "all":
    for version in allowed_expansions:
      scrape(version, db_path, ids_file, output_only)
      stop_event.clear()  # Reset the stop event for the next version
  else:
    scrape(version, db_path, ids_file, output_only)
