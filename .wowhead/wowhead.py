import requests
import time
import os
from ratelimiter import RateLimiter

#Requests per second
# RPS = 100
RPS = 100


# def limited(until):
#     duration = int(round(until - time.time()))
#     print('Rate limited, sleeping for {:d} seconds'.format(duration))

rate_limiter = RateLimiter(max_calls=RPS, period=1)#, callback=limited)

# Dictionary mapping locales to their corresponding numeric codes
localeLookup = {
  "enUS": 0, # English (US)
  "ptBR": 8, # Portuguese (Brazil)
  "ruRU": 7, # Russian (Russia)
  "deDE": 3, # German (Germany)
  "koKR": 1, # Korean (Korea)
  "esES": 6, # Spanish (Spain)
  "frFR": 2, # French (France)
  # "esMX": 6?, # Spanish (Mexico) - commented out, not supported
  # "zhTW": 4?, # Traditional Chinese (Taiwan) - commented out, not supported
  "zhCN": 4, # Simplified Chinese (China)
  # "itIT": 9, # Italian (Italy) - commented out, not supported
}
# Add Flipped localeLookup
reverselocaleLookup = {}
for key, value in localeLookup.items():
  reverselocaleLookup[value] = key

# Dictionary mapping locales to their corresponding URL locales (zhCN is the only one that differs...)
localeToURLLocale = {
  "enUS": "", # English (US) # Yes EN is empty
  "ptBR": "pt", # Portuguese (Brazil)
  "ruRU": "ru", # Russian (Russia)
  "deDE": "de", # German (Germany)
  "koKR": "ko", # Korean (Korea)
  "esES": "es", # Spanish (Spain)
  "frFR": "fr", # French (France)
  # "esMX": "es", # Spanish (Mexico) - commented out, not supported
  # "zhTW": "zh", # Traditional Chinese (Taiwan) - commented out, not supported
  "zhCN": "cn",
  # "itIT": "it", # Italian (Italy) - commented out, not supported
}

# Dictionary mapping game versions to their corresponding numeric codes
dataEnvLookup = {
  "classic": 4, # Classic version of the game
  "tbc": 5,     # The Burning Crusade version
  "wotlk": 8,   # Wrath of the Lich King version
}
# Add Flipped dataEnvLookup
reversedataEnvLookup = {}
for key, value in dataEnvLookup.items():
  reversedataEnvLookup[value] = key

# List of allowed types for game entities
allowedTypes = [
  "item",   # Game item
  "npc",    # Non-player character
  "quest",  # Quest
  "object", # In-game object
  "spell",  # Spell
  "faction" # Faction
]

# Function to construct the URL for fetching data based on various parameters
def getUrl(idType, id, dataEnv, locale):
  if idType not in allowedTypes:
    raise Exception(f"Invalid idType: {idType}")

  if idType == "faction" or idType == "quest":
    # Swap from numeric code to string
    if type(locale) == int:
      locale = reverselocaleLookup[locale]
    # Swap from numeric code to string
    if type(dataEnv) == int:
      dataEnv = reversedataEnvLookup[dataEnv]
    urlLocale = localeToURLLocale[locale]
    # Constructs the URL using the provided parameters
    return f"https://www.wowhead.com/{dataEnv}/{urlLocale}/{idType}={id}"
  else:
    # Constructs the URL using the provided parameters
    return f"https://nether.wowhead.com/tooltip/{idType}/{id}?dataEnv={dataEnv}&locale={locale}"

def cacheResponse(response, idType, id, version, locale):
  try:
    if not os.path.exists(f".cache/{version}/{idType}"):
      os.mkdir(f".cache/{version.lower()}/{idType}")
    with open(f".cache/{version.lower()}/{idType}/{id}_{locale}.json", "w", encoding="utf-8") as f:
      f.write(response.text)
  except Exception as e:
    print(f"Failed to write .cache Exception: {e}")

# Function to fetch data for a given game entity
def getData(idType, id, version, locale="enUS", useCache=True):
  data = {}
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
      with rate_limiter:  # Applies rate limiting to the requests
        # Fetches the data from the constructed URL
        response = requests.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]))
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

    # If a specific locale is requested, fetch data for that locale
    with rate_limiter:  # Applies rate limiting to the requests
      # Fetches the data from the constructed URL
      response = requests.get(getUrl(idType, id, dataEnvLookup[version.lower()], localeLookup[locale]))
      # If the entity is found, add the response content to the data dictionary
      if "Entity not found" not in response.text:
        data[locale] = response.content
        cacheResponse(response, idType, id, version, locale)
  # If no data was found for any locale, return None
  if len(data) == 0:
    return None
  return data
