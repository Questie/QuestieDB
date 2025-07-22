"""
This module centralizes all logic for parsing and generating Wowhead URLs.

It provides a single source of truth for converting between raw URL strings and
the structured, type-safe `WowheadEntity` object. This approach avoids
ad-hoc string manipulation and ensures consistency across the application.
"""

import re
from urllib.parse import urlparse
from sitemap_types import Locale, VersionSlug, WowheadEntity, EntityId, EntityType, EntityDataType

# === MAPPINGS ===

# Reverse lookups for string to enum conversion
STRING_TO_LOCALE = {locale.value: locale for locale in Locale}
STRING_TO_VERSION = {version.value: version for version in VersionSlug}

# URL segment mappings for locales
LOCALE_TO_URL_SEGMENT = {
  Locale.enUS: "",  # English (US) # Yes EN is empty
  Locale.ptBR: "pt",  # Portuguese (Brazil)
  Locale.ruRU: "ru",  # Russian (Russia)
  Locale.deDE: "de",  # German (Germany)
  Locale.koKR: "ko",  # Korean (Korea)
  Locale.esES: "es",  # Spanish (Spain)
  Locale.frFR: "fr",  # French (France)
  Locale.esMX: "mx",  # Spanish (Mexico)
  Locale.zhTW: "tw",  # Traditional Chinese (Taiwan)
  Locale.zhCN: "cn",  # Simplified Chinese (China)
  Locale.itIT: "it",  # Italian (Italy)
}
URL_SEGMENT_TO_LOCALE = {v: k for k, v in LOCALE_TO_URL_SEGMENT.items()}

# Numeric codes used in tooltip URLs
LOCALE_TO_NUMERIC_LOCALE = {
  Locale.enUS: 0,  # English (US)
  Locale.ptBR: 8,  # Portuguese (Brazil)
  Locale.ruRU: 7,  # Russian (Russia)
  Locale.deDE: 3,  # German (Germany)
  Locale.koKR: 1,  # Korean (Korea)
  Locale.esES: 6,  # Spanish (Spain)
  Locale.frFR: 2,  # French (France)
  Locale.esMX: 11,  # Spanish (Mexico)
  Locale.zhTW: 10,  # Traditional Chinese (Taiwan)
  Locale.zhCN: 4,  # Simplified Chinese (China)
  Locale.itIT: 9,  # Italian (Italy)
}

# This is the dataEnv numbers
VERSION_TO_NUMERIC_VERSION = {
  VersionSlug.RETAIL: 1,  # Retail version of the game
  VersionSlug.CLASSIC: 4,  # Classic version of the game
  VersionSlug.TBC: 5,  # The Burning Crusade version
  VersionSlug.WOTLK: 8,  # Wrath of the Lich King version
  VersionSlug.CATA: 11,  # Cataclysm version
  VersionSlug.MOP_CLASSIC: 15,  # Mists of Pandaria version
}

ENTITY_DATA_TYPE: dict[str, EntityDataType] = {
  "quest": "full",
  "item": "tooltip",
  "npc": "tooltip",
  "object": "tooltip",
}

# === CORE CONVERSION LOGIC ===


def parse_url(url: str, lastmod: str | None = None) -> WowheadEntity:
  """
  Parses a Wowhead URL into a structured WowheadEntity.
  Automatically detects the entity type from the URL.

  Args:
      url: The full Wowhead URL to parse.

  Returns:
      WowheadEntity: A structured entity containing entity type, ID, version, locale, and optional name slug.
  """
  parsed = urlparse(url)
  path_parts = [part for part in parsed.path.split("/") if part]

  # Automatically detect entity type and ID
  # entity_pattern = r"(quest|item|npc|zone|spell|achievement)=(\d+)"
  entity_pattern = r"(\w+)=(\d+)"
  match = re.search(entity_pattern, parsed.path)
  if not match:
    raise ValueError(f"Could not extract entity type and ID from URL: {url}")

  entity_type: EntityType = match.group(1)  # type: ignore
  entity_id = EntityId(int(match.group(2)))

  # Rest of the logic remains the same...
  version = VersionSlug.RETAIL
  locale = Locale.enUS
  name_slug = None

  if path_parts:
    if path_parts[0] in STRING_TO_VERSION:
      version = STRING_TO_VERSION[path_parts.pop(0)]
    if path_parts and path_parts[0] in URL_SEGMENT_TO_LOCALE:
      locale = URL_SEGMENT_TO_LOCALE[path_parts.pop(0)]

  # Find name slug after entity definition
  id_part = f"{entity_type}={entity_id}"
  if id_part in path_parts:
    id_index = path_parts.index(id_part)
    if id_index + 1 < len(path_parts):
      name_slug = path_parts[id_index + 1]

  return WowheadEntity(
    entity_id=entity_id,
    entity_type=entity_type,
    version=version,
    locale=locale,
    name_slug=name_slug,
    lastmod=lastmod,
    data_fetch_type=ENTITY_DATA_TYPE.get(entity_type, "full"),
  )


# === DEMO ===


def _demo() -> None:
  """Demonstrates the parsing and generation functions."""
  urls_to_test = [
    "https://www.wowhead.com/classic/de/quest=123/the-test-quest",
    "https://www.wowhead.com/tbc/quest=456",
    "https://www.wowhead.com/quest=789/a-retail-quest",
    "https://www.wowhead.com/wotlk/fr/item=9001/le-super-item",
    "https://www.wowhead.com/item=9002",
  ]

  for url in urls_to_test:
    print(f"--- Testing URL: {url} ---")
    try:
      entity = parse_url(url)
      print(f"  Parsed Entity: {entity}")
      print(f"  Generated URL:     {entity.generate_url()}")
      print(f"  Tooltip URL:       {entity.generate_tooltip_url()}\n")
    except ValueError as e:
      print(f"  Error parsing: {e}\n")


if __name__ == "__main__":
  _demo()
