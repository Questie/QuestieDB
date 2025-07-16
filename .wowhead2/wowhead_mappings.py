"""
Simple bridge between sitemap types and existing wowhead.py data.
Converts between sitemap enums and the string/numeric formats used in wowhead.py.
"""

import re
from urllib.parse import urlparse
from sitemap_types import Locale, VersionSlug

# Reverse lookups for string to enum conversion
STRING_TO_LOCALE = {locale.value: locale for locale in Locale}
STRING_TO_VERSION = {version.value: version for version in VersionSlug}

# URL segment mappings (from existing wowhead.py data)
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

URL_SEGMENT_TO_LOCALE = {v: k for k, v in LOCALE_TO_URL_SEGMENT.items() if v}
URL_SEGMENT_TO_LOCALE[""] = Locale.enUS  # Handle empty string for English

# Numeric codes from existing wowhead.py
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


# Helper functions for easy conversion between enums and strings
def locale_to_string(locale: Locale) -> str:
  """Convert a Locale enum to its string value."""
  return locale.value


def string_to_locale(locale_string: str) -> Locale:
  """Convert a string to a Locale enum, with fallback to enUS."""
  return STRING_TO_LOCALE.get(locale_string, Locale.enUS)


def version_to_string(version: VersionSlug) -> str:
  """Convert a VersionSlug enum to its string value."""
  return version.value


def string_to_version(version_string: str) -> VersionSlug:
  """Convert a string to a VersionSlug enum, with fallback to CLASSIC."""
  return STRING_TO_VERSION.get(version_string, VersionSlug.CLASSIC)


def extract_version_and_locale_from_url(url: str) -> tuple[str, str]:
  """
  Extract version and locale from a Wowhead URL.

  Args:
    url: Wowhead URL like "https://www.wowhead.com/classic/de/quest=1/title"

  Returns:
    Tuple of (version_string, locale_string) like ("classic", "deDE")
  """
  parsed = urlparse(url)
  path_parts = [part for part in parsed.path.split("/") if part]

  if not path_parts:
    return VersionSlug.CLASSIC.value, Locale.enUS.value  # Default fallback

  version_string = path_parts[0] if path_parts[0] in STRING_TO_VERSION else VersionSlug.CLASSIC.value

  # Check if second part is a locale segment
  if len(path_parts) > 1 and path_parts[1] in URL_SEGMENT_TO_LOCALE:
    locale_enum = URL_SEGMENT_TO_LOCALE[path_parts[1]]
    locale_string = locale_enum.value
  else:
    locale_string = Locale.enUS.value  # Default to English

  return version_string, locale_string


def generate_tooltip_url(content_type: str, content_id: int, version_string: str, locale_string: str) -> str:
  """
  Generate a tooltip URL from extracted data.

  Args:
    content_type: Type like "quest", "item", "npc"
    content_id: Numeric ID
    version_string: Version like "classic", "tbc"
    locale_string: Locale like "deDE", "enUS"

  Returns:
    Tooltip URL like "https://nether.wowhead.com/tooltip/quest/1?dataEnv=4&locale=3"
  """
  # Convert strings to enums, then look up numeric values
  version_enum = STRING_TO_VERSION.get(version_string, VersionSlug.CLASSIC)
  locale_enum = STRING_TO_LOCALE.get(locale_string, Locale.enUS)

  data_env = VERSION_TO_NUMERIC.get(version_enum, 4)  # Default to classic
  locale_code = LOCALE_TO_NUMERIC.get(locale_enum, 0)  # Default to English

  return f"https://nether.wowhead.com/tooltip/{content_type}/{content_id}?dataEnv={data_env}&locale={locale_code}"


def convert_sitemap_url_to_tooltip_url(url: str, content_type: str) -> str:
  """
  Convert a sitemap URL directly to a tooltip URL.

  Args:
    url: Sitemap URL like "https://www.wowhead.com/classic/de/quest=1/title"
    content_type: Content type like "quest", "item", "npc"

  Returns:
    Tooltip URL like "https://nether.wowhead.com/tooltip/quest/1?dataEnv=4&locale=3"
  """
  # Extract content ID from URL
  match = re.search(rf"{content_type}=(\d+)", url)
  if not match:
    raise ValueError(f"Could not extract {content_type} ID from URL: {url}")

  content_id = int(match.group(1))
  version_string, locale_string = extract_version_and_locale_from_url(url)

  return generate_tooltip_url(content_type, content_id, version_string, locale_string)


def _demo() -> None:
  """Demo the mapping functions."""
  test_url = "https://www.wowhead.com/classic/de/quest=1/the-chow-quest-123-aa"

  print(f"Input URL: {test_url}")

  version_string, locale_string = extract_version_and_locale_from_url(test_url)
  print(f"Extracted: version='{version_string}', locale='{locale_string}'")

  tooltip_url = convert_sitemap_url_to_tooltip_url(test_url, "quest")
  print(f"Tooltip URL: {tooltip_url}")

  print(STRING_TO_LOCALE)
  print(STRING_TO_VERSION)
  print(LOCALE_TO_URL_SEGMENT)
  print(URL_SEGMENT_TO_LOCALE)
  print(LOCALE_TO_NUMERIC)
  print(VERSION_TO_NUMERIC)


if __name__ == "__main__":
  _demo()
