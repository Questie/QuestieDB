import re
import json
import sys
import time
import threading
import queue
import concurrent.futures
from dotenv import load_dotenv
from ids import getAllIdsWowhead
from quest import getQuestSections
from sitemap import get_all_ids

# Constants
# Thread-safe queue for subtitles
fetch_queue = queue.Queue()


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
  tries = {}
  while not fetch_queue.empty():
    idType, id = fetch_queue.get()
    try:
      if len(fetch_queue.queue) % 100 == 0:
        print(f"{len(fetch_queue.queue)} items left in queue")

      # Get data
      start_time = time.time()
      data = getData(idType, id, version, "all")
      fetch_time = time.time() - start_time
      start_time = time.time()

      # If data is None, continue to the next item in the queue
      if data is None:
        print(f"Data is None for {idType} {id}")
        continue

      # Common processing for all idTypes
      idData[idType][id] = {}
      if idType == "faction":
        for locale, data in data.items():
          if type(data) == bytes:
            rawData = data.decode("utf-8")
          else:
            rawData = data
          # Get g_faction
          g_faction = faction_g_faction_regex.search(rawData).group(1)
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
      else:
        for locale, localeData in data.items():
          data = json.loads(localeData)
          idData[idType][id][locale] = data
      print(f"{str(idType).capitalize()} {id} took processing: {(time.time() - start_time):.2f}s, fetch: {fetch_time:.2f}s, total: {fetch_time + (time.time() - start_time):.2f}s")

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
      fetch_queue.task_done()

allowed_expansions = ["Classic", "TBC", "Wotlk", "Cata", "MoP"]
if __name__ == "__main__":
  # Classic, TBC, Wotlk, Cata, MoP
  if len(sys.argv) > 1:
    version = sys.argv[1]
  if version not in allowed_expansions:
    print(f"Version {version} is not allowed. Allowed versions are: {', '.join(allowed_expansions)}")
    sys.exit(1)

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


  # Save all ids
  with open(f"{version.lower()}_all_ids.json", "w", encoding="utf-8") as f:
    json.dump(all_ids, f, indent=2, ensure_ascii=False)

  for idType, ids in all_ids.items():
    # if idType != "quest":
    print(f"{idType}: {len(ids)}")
    for id in ids:
      fetch_queue.put((idType, id))
  # else:
  # print(f"{str(idType).capitalize()} is skipped for now, requires special handling")

  idData = {}
  for idType, ids in all_ids.items():
    idData[idType] = {}

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

  # This function is used to write a dictionary to a file
  # But also not print the trailing comma
  # json.dump works but the map value is too nested and makes the file unreadable
  def write_dict(d, f, indent=0):
    f.write("{")
    items = list(d.items())
    for i, (k, v) in enumerate(items):
      f.write(f"\n{' ' * (indent + 2)}\"{k}\": ")
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
  filename = f"{version.lower()}_locales.json"
  print(f"Saving {filename}...")

  with open(filename, "w", encoding="utf-8") as f:
    write_dict(idData, f)

  print("Done")
