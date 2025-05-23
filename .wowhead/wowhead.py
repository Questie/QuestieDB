import os
from proxy import RateLimitedProxyManager
import sqlite3
import threading
import requests
import time

rate_proxy_manager = RateLimitedProxyManager(db_path="proxy_usage.db", rate_limit_seconds=1)

# Dictionary mapping locales to their corresponding numeric codes
localeLookup = {
  "enUS": 0,  # English (US)
  "ptBR": 8,  # Portuguese (Brazil)
  "ruRU": 7,  # Russian (Russia)
  "deDE": 3,  # German (Germany)
  "koKR": 1,  # Korean (Korea)
  "esES": 6,  # Spanish (Spain)
  "frFR": 2,  # French (France)
  "esMX": 11,  # Spanish (Mexico)
  "zhTW": 10,  # Traditional Chinese (Taiwan)
  "zhCN": 4,  # Simplified Chinese (China)
  "itIT": 9,  # Italian (Italy)
}
# Add Flipped localeLookup
reverselocaleLookup = {}
for key, value in localeLookup.items():
  reverselocaleLookup[value] = key

# Dictionary mapping locales to their corresponding URL locales (zhCN is the only one that differs...)
localeToURLLocale = {
  "enUS": "",  # English (US) # Yes EN is empty
  "ptBR": "pt",  # Portuguese (Brazil)
  "ruRU": "ru",  # Russian (Russia)
  "deDE": "de",  # German (Germany)
  "koKR": "ko",  # Korean (Korea)
  "esES": "es",  # Spanish (Spain)
  "frFR": "fr",  # French (France)
  "esMX": "mx",  # Spanish (Mexico)
  "zhTW": "tw",  # Traditional Chinese (Taiwan)
  "zhCN": "cn",
  "itIT": "it",  # Italian (Italy)
}

# Dictionary mapping game versions to their corresponding numeric codes
dataEnvLookup = {
  "classic": 4,  # Classic version of the game
  "tbc": 5,  # The Burning Crusade version
  "wotlk": 8,  # Wrath of the Lich King version
  "cata": 11,  # Cataclysm version
  "mop-classic": 15,  # Mists of Pandaria version
}
# Add Flipped dataEnvLookup
reversedataEnvLookup = {}
for key, value in dataEnvLookup.items():
  reversedataEnvLookup[value] = key

# List of allowed types for game entities
allowedTypes = [
  "item",  # Game item
  "npc",  # Non-player character
  "quest",  # Quest
  "object",  # In-game object
  "spell",  # Spell
  "faction",  # Faction
]


# Function to construct the URL for fetching data based on various parameters
def getUrl(idType, id, dataEnv, locale):
  if idType not in allowedTypes:
    raise Exception(f"Invalid idType: {idType}")

  if idType == "faction" or idType == "quest":
    # Swap from numeric code to string
    if type(locale) is int:
      locale = reverselocaleLookup[locale]
    # Swap from numeric code to string
    if type(dataEnv) is int:
      dataEnv = reversedataEnvLookup[dataEnv]
    urlLocale = localeToURLLocale[locale]

    # Constructs the URL using the provided parameters
    if urlLocale == "" or urlLocale == "en":
      return f"https://www.wowhead.com/{dataEnv}/{idType}={id}"
    else:
      return f"https://www.wowhead.com/{dataEnv}/{urlLocale}/{idType}={id}"
  else:
    # Constructs the URL using the provided parameters
    return f"https://nether.wowhead.com/tooltip/{idType}/{id}?dataEnv={dataEnv}&locale={locale}"


def cacheResponse(response, idType, id, version, locale):
  try:
    if not os.path.exists(f".cache/{version.lower()}/{idType}"):
      os.mkdir(f".cache/{version.lower()}/{idType}")
    with open(f".cache/{version.lower()}/{idType}/{id}_{locale}.json", "w", encoding="utf-8") as f:
      f.write(response.text)
  except Exception as e:
    print(f"Failed to write .cache Exception: {e}")


# Function to fetch data for a given game entity
def getData(idType, id, version, locale="enUS", useCache=True):
  data = {}

  if not os.path.exists(".cache"):
    os.mkdir(".cache")
  if not os.path.exists(f".cache/{version.lower()}"):
    os.mkdir(f".cache/{version.lower()}")
  if locale == "all":
    # If the locale is "all", fetch data for all locales
    for locale in localeLookup:
      if id == 400080:
        print(f"Fetching {idType} {id} for {locale}")
      if useCache:
        try:
          with open(f".cache/{version.lower()}/{idType}/{id}_{locale}.json", "r", encoding="utf-8") as f:
            data[locale] = f.read()
          continue
        except Exception as e:
          print(f"Cache is missing {idType} {id} for {locale}.")
          # continue

      # Get proxy port (RateLimited)
      next_proxy = None
      while next_proxy is None:  # Loop until a proxy is available
        next_proxy = rate_proxy_manager.get_next_proxy()
        if next_proxy is None:
          # print(f"Worker {worker_id}, Request {i + 1}: No proxy available, waiting...")
          time.sleep(0.1)  # Wait before retrying

      # Set up the proxy for the session
      proxies = {
        "http": next_proxy,
        "https": next_proxy,
      }

      # with rate_limiter:  # Applies rate limiting to the requests
      # Fetches the data from the constructed URL
      response = requests.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]), proxies=proxies, timeout=10)
      # If the entity is found, add the response content to the data dictionary
      if "Entity not found" not in response.text:
        data[locale] = response.content
        cacheResponse(response, idType, id, version, locale)
      # If the entity is not found for the primary locale "enUS", return None
      elif "Entity not found" in response.text and locale == "enUS":
        print(f"Entity not found: {id}")
        return None
  elif locale in localeLookup:
    if useCache:
      try:
        with open(f".cache/{version.lower()}/{idType}/{id}_{locale}.json", "r", encoding="utf-8") as f:
          data[locale] = f.read()
          return data
      except Exception as e:
        print(f"Failed to read .cache Exception: {e}")

    # Get proxy port (RateLimited)
    next_proxy = None
    while next_proxy is None:  # Loop until a proxy is available
      next_proxy = rate_proxy_manager.get_next_proxy()
      if next_proxy is None:
        # print(f"Worker {worker_id}, Request {i + 1}: No proxy available, waiting...")
        time.sleep(0.1)  # Wait before retrying

    # Set up the proxy for the session
    proxies = {
      "http": next_proxy,
      "https": next_proxy,
    }
    # If a specific locale is requested, fetch data for that locale
    # with rate_limiter:  # Applies rate limiting to the requests
    # Fetches the data from the constructed URL
    response = requests.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]), proxies=proxies, timeout=10)
    # If the entity is found, add the response content to the data dictionary
    if "Entity not found" not in response.text:
      data[locale] = response.content
      cacheResponse(response, idType, id, version, locale)
  # If no data was found for any locale, return None
  if len(data) == 0:
    return None
  return data


sqlite_processed_lock = threading.Lock()


def getDataSqlite(idType, id, version, locale="enUS", useCache=True) -> dict[str, str] | None:
  data = {}

  # Open the SQLite database connection
  cache = sqlite3.connect(f".cache-{version.lower()}.db")

  print(f"Fetching {idType} {id} for {locale}")

  if locale == "all":
    # If the locale is "all", fetch data for all locales
    for locale in localeLookup:
      if useCache:
        # Check if the data is already in the SQLite database
        with sqlite_processed_lock:
          cursor = cache.cursor()
          cursor.execute("SELECT data FROM wowhead_cache WHERE idType=? AND id=? AND version=? AND locale=?", (idType, id, version, locale))
          row = cursor.fetchone()
          if row:
            data[locale] = row[0]
            continue
          else:
            print(f"Cache is missing {idType} {id} for {locale}.")

      # Get proxy port (RateLimited)
      next_proxy = None
      while next_proxy is None:  # Loop until a proxy is available
        next_proxy = rate_proxy_manager.get_next_proxy()
        if next_proxy is None:
          # print(f"Worker {worker_id}, Request {i + 1}: No proxy available, waiting...")
          time.sleep(0.1)  # Wait before retrying

      # Set up the proxy for the session
      proxies = {
        "http": next_proxy,
        "https": next_proxy,
      }

      # Fetches the data from the constructed URL
      # response = session.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]), proxies=proxies, timeout=10)
      response = requests.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]), proxies=proxies, timeout=10)
      response.raise_for_status()  # Raise an error for bad responses
      # If the entity is found, add the response content to the data dictionary
      if "Entity not found" not in response.text:
        data[locale] = response.content
        # Insert the data into the SQLite database
        with sqlite_processed_lock:
          # print(f"Writing {idType} {id} for {locale}")
          cursor = cache.cursor()
          cursor.execute("INSERT OR REPLACE INTO wowhead_cache (idType, id, version, locale, data) VALUES (?, ?, ?, ?, ?)", (idType, id, version, locale, response.text))
          cache.commit()
      # If the entity is not found for the primary locale "enUS", return None
      elif "Entity not found" in response.text and locale == "enUS":
        print(f"Entity not found: {id}")
        return None
  elif locale in localeLookup:
    if useCache:
      # Check if the data is already in the SQLite database
      with sqlite_processed_lock:
        cursor = cache.cursor()
        cursor.execute("SELECT data FROM wowhead_cache WHERE idType=? AND id=? AND version=? AND locale=?", (idType, id, version, locale))
        row = cursor.fetchone()
        if row:
          data[locale] = row[0]
          return data
        else:
          print(f"Cache is missing {idType} {id} for {locale}.")

    # Get proxy port (RateLimited)
    next_proxy = None
    while next_proxy is None:  # Loop until a proxy is available
      next_proxy = rate_proxy_manager.get_next_proxy()
      if next_proxy is None:
        # print(f"Worker {worker_id}, Request {i + 1}: No proxy available, waiting...")
        time.sleep(0.5)  # Wait before retrying

    # Set up the proxy for the session
    proxies = {
      "http": next_proxy,
      "https": next_proxy,
    }

    # If a specific locale is requested, fetch data for that locale
    # Fetches the data from the constructed URL
    # response = session.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]), proxies=proxies, timeout=10)
    response = requests.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]), proxies=proxies, timeout=10)
    response.raise_for_status()  # Raise an error for bad responses
    # If the entity is found, add the response content to the data dictionary
    if "Entity not found" not in response.text:
      data[locale] = response.content
      # Insert the data into the SQLite database
      with sqlite_processed_lock:
        # print(f"Writing {idType} {id} for {locale}")
        cursor = cache.cursor()
        cursor.execute("INSERT OR REPLACE INTO wowhead_cache (idType, id, version, locale, data) VALUES (?, ?, ?, ?, ?)", (idType, id, version, locale, response.text))
        cache.commit()
  cache.close()
  # If no data was found for any locale, return None
  if len(data) == 0:
    return None
  return data
