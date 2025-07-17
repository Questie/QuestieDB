"""
This module centralizes all logic for parsing and generating Wowhead URLs.

It provides a single source of truth for converting between raw URL strings and
the structured, type-safe `WowheadEntity` object. This approach avoids
ad-hoc string manipulation and ensures consistency across the application.
"""

import re
from urllib.parse import urlparse
from sitemap_types import Locale, VersionSlug, WowheadEntity, EntityId, EntityType

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
LOCALE_TO_NUMERIC = {
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

VERSION_TO_NUMERIC = {
  VersionSlug.RETAIL: 1,  # Retail version of the game
  VersionSlug.CLASSIC: 4,  # Classic version of the game
  VersionSlug.TBC: 5,  # The Burning Crusade version
  VersionSlug.WOTLK: 8,  # Wrath of the Lich King version
  VersionSlug.CATA: 11,  # Cataclysm version
  VersionSlug.MOP_CLASSIC: 15,  # Mists of Pandaria version
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
  )


# def generate_url(entity: WowheadEntity) -> str:
#   """Generates a standard, versioned Wowhead URL from an entity."""
#   base = "https://www.wowhead.com"
#   path_parts = []

#   if entity.version != VersionSlug.RETAIL:
#     path_parts.append(entity.version.value)

#   locale_segment = LOCALE_TO_URL_SEGMENT.get(entity.locale)
#   if locale_segment:
#     path_parts.append(locale_segment)

#   path_parts.append(f"{entity.entity_type}={entity.entity_id}")

#   if entity.name_slug:
#     path_parts.append(entity.name_slug)

#   return f"{base}/{'/'.join(path_parts)}"


# def generate_tooltip_url(entity: WowheadEntity) -> str:
#   """Generates a Wowhead tooltip URL (nether.wowhead.com)."""
#   data_env = VERSION_TO_NUMERIC.get(entity.version, 4)  # Default to Classic
#   locale_code = LOCALE_TO_NUMERIC.get(entity.locale, 0)  # Default to enUS

#   return f"https://nether.wowhead.com/tooltip/{entity.entity_type}/{entity.entity_id}?dataEnv={data_env}&locale={locale_code}"


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
