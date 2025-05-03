import re
import json
import sys
import time
import threading
import queue
import datetime
import os
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
# -------------------------

# --- Control Flag ---
stop_event = threading.Event()
# --------------------


# --- Progress Monitoring Function ---
def monitor_progress(total_items_to_process, start_time_global_ts, already_processed=0):
  global items_processed  # Access global counter
  while not stop_event.is_set():
    with items_processed_lock:
      current_processed = items_processed - already_processed  # Adjust for already processed items

    if current_processed >= total_items_to_process and stop_event.is_set():
      print("\nProcessing complete!")
      break  # Exit monitor loop

    elapsed_time = time.time() - start_time_global_ts
    if elapsed_time > 0 and current_processed > 0:
      items_per_second = current_processed / elapsed_time
      remaining_items = total_items_to_process - current_processed
      estimated_time_remaining = remaining_items / items_per_second if items_per_second > 0 else 0

      # Format ETA
      eta_str = str(datetime.timedelta(seconds=int(estimated_time_remaining)))

      # Print progress update
      print(
        f"\rProgress: {current_processed}/{total_items_to_process} ({items_per_second:.2f} items/sec) | Elapsed: {str(datetime.timedelta(seconds=int(elapsed_time)))} | ETA: {eta_str}   ", end="\n"
      )
    elif current_processed == 0 and elapsed_time > 0:
      print(f"\rProgress: 0/{total_items_to_process} | Elapsed: {str(datetime.timedelta(seconds=int(elapsed_time)))} | Calculating rate...", end="\n")
    else:
      # Initial state or edge case
      print(f"\rStarting processing... {total_items_to_process} items queued.", end="\n")

    time.sleep(2)  # Update frequency (in seconds)

  # --- Final message ---
  if stop_event.is_set():
    print("\nProcessing stopped by request.")
  else:
    print("\nProcessing complete!")
  # -------------------


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


def fetch_worker(version, idData):
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
      data = getDataSqlite(idType, id, version, "all")

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


def scrape(version, db_path="./"):
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
  already_processed = cursor.fetchone()[0]
  print(f"Already processed {already_processed} items for version {version}")
  cache.close()

  all_ids = {}
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
  # all_ids["npc"].append(3354)

  # Save all ids
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
  start_http_server(stop_event)
  time.sleep(2)  # Give the server a moment to start
  # -------------------------------------

  # --- Start Monitor Thread ---
  start_time_global = time.time()
  monitor_thread = threading.Thread(target=monitor_progress, args=(total_items, start_time_global, already_processed), daemon=True)
  monitor_thread.start()
  # ----------------------------

  # Start translation workers
  num_threads = 10  # You can adjust this based on your actual RPM and CPU cores
  threads = []
  for _ in range(num_threads):
    thread = threading.Thread(target=fetch_worker, args=(version, idData))
    thread.start()
    threads.append(thread)
    # Stagger the start of the threads
    time.sleep(0.3)

  # Wait for all threads to finish
  for thread in threads:
    thread.join()

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
    yaml.dump(idData, open(yaml_filename, "w", encoding="utf-8"), allow_unicode=True, sort_keys=False, width=float("inf"))
  except ImportError:
    print("PyYAML not installed, skipping YAML output.")

  print("Done")


allowed_expansions = ["Classic", "TBC", "Wotlk", "Cata", "MoP-Classic"]
if __name__ == "__main__":
  version = ""
  db_path = "./"
  # Classic, TBC, Wotlk, Cata, MoP
  if len(sys.argv) > 1:
    version = sys.argv[1]
  if version not in allowed_expansions and version != "all":
    print(f"Version {version} is not allowed. Allowed versions are: {', '.join(allowed_expansions)}")
    sys.exit(1)

  if version == "all":
    for version in allowed_expansions:
      scrape(version, db_path)
      stop_event.clear()  # Reset the stop event for the next version
  else:
    scrape(version, db_path)
