"""
Type definitions for the functional sitemap processing module.

This module contains all type definitions following modern Python typing practices.
Separating types into their own module improves maintainability and reusability.
"""

from enum import Enum
from typing import NewType, Literal, Protocol
from dataclasses import dataclass


# === ENUMS ===


class VersionSlug(Enum):
  """Enum for WoW expansion version slugs with chronological ordering."""

  RETAIL = ""  # [0]
  CLASSIC = "classic"  # [1]
  TBC = "tbc"  # [2]
  WOTLK = "wotlk"  # [3]
  CATA = "cata"  # [4]
  MOP_CLASSIC = "mop-classic"  # [5]

  @property
  def order_index(self) -> int:
    """Get the chronological order index for this version."""
    return list(VersionSlug).index(self)

  def __lt__(self, other: "VersionSlug") -> bool:
    """Enable sorting by chronological order."""
    return self.order_index < other.order_index


class Locale(Enum):
  """Enum for supported Wowhead language locales."""

  enUS = "enUS"  # English
  deDE = "deDE"  # German
  esES = "esES"  # Spanish (Spain)
  esMX = "esMX"  # Spanish (Mexico)
  frFR = "frFR"  # French
  itIT = "itIT"  # Italian
  ptBR = "ptBR"  # Portuguese (Brazil)
  ruRU = "ruRU"  # Russian
  koKR = "koKR"  # Korean
  zhCN = "zhCN"  # Chinese (Simplified)
  zhTW = "zhTW"  # Chinese (Traditional)


# === STRONG TYPE ALIASES ===

EntityType = Literal["quest", "item", "npc", "object", "zone", "spell", "achievement"]
"""Literal type for supported Wowhead entity types."""

EntityDataType = Literal["tooltip", "full"]
"""If the entity should fetch tooltip data or full HTML data."""

EntityId = NewType("EntityId", int)
"""Strong type for Wowhead entity IDs extracted from URLs."""


# === IMMUTABLE DATA STRUCTURES ===


@dataclass(frozen=True, order=True)
class WowheadEntity:
  """A type-safe, structured representation of a Wowhead entity's identity."""

  entity_id: EntityId
  entity_type: EntityType
  version: VersionSlug
  locale: Locale
  # The human-readable slug, e.g., "the-lich-king"
  name_slug: str | None = None

  # Metadata
  lastmod: str | None = None

  # Datatype for fetching
  data_fetch_type: EntityDataType = "full"

  def generate_url(self) -> str:
    """
    Generate the full Wowhead URL for this entity.

    Returns:
      The complete URL string for the entity.
    """
    base_url = "https://www.wowhead.com/"

    locale_segment = LOCALE_TO_URL_SEGMENT.get(self.locale)
    if locale_segment is None:
      raise ValueError(f"Unsupported locale: {self.locale}")

    version_segment = self.version.value + "/" if self.version != VersionSlug.RETAIL else ""

    # enUS is "" empty, otherwise they are 2 characters, so check for len(locale_segment) > 0
    locale_separator = "/" if len(locale_segment) > 0 else ""

    return f"{base_url}{version_segment}{locale_segment}{locale_separator}{self.entity_type}={self.entity_id}/{self.name_slug or ''}".rstrip("/")

  def generate_tooltip_url(self) -> str:
    """
    Generate the tooltip URL for this entity.

    Returns:
      The complete tooltip URL string for the entity.
    """
    # Example URL:     f"https://nether.wowhead.com/tooltip/{idType}/{id}?dataEnv={dataEnv}&locale={locale}
    # Default to Classic
    data_env = VERSION_TO_NUMERIC.get(self.version, VERSION_TO_NUMERIC[VersionSlug.CLASSIC])
    # Default to enUS
    locale_code = LOCALE_TO_NUMERIC.get(self.locale, LOCALE_TO_NUMERIC[Locale.enUS])
    return f"https://nether.wowhead.com/tooltip/{self.entity_type}/{self.entity_id}?dataEnv={data_env}&locale={locale_code}"


@dataclass(frozen=True)
class SitemapEntry:
  """
  Represents a single sitemap entry with immutable fields.

  All fields are frozen to ensure immutability and thread safety.
  The entity_id is automatically extracted from the URL.
  """

  loc: str
  priority: float
  lastmod: str
  entity_id: EntityId

  def __post_init__(self) -> None:
    """Extract entity ID from URL during initialization."""
    try:
      entity_id = EntityId(int(self.loc.split("=")[1].split("/")[0]))
      object.__setattr__(self, "entity_id", entity_id)
    except (IndexError, ValueError) as error:
      raise ValueError(f"Invalid URL format: {self.loc}") from error


@dataclass(frozen=True)
class DeltaResult:
  """
  Represents the delta between two expansion versions.

  Contains immutable tuples instead of mutable lists for thread safety
  and to prevent accidental modifications.
  """

  target_version: VersionSlug
  previous_version: VersionSlug
  entity_type: EntityType
  all_entities: tuple[WowheadEntity, ...]
  added_entities: tuple[WowheadEntity, ...]
  removed_entities: tuple[WowheadEntity, ...]

  @property
  def change_count(self) -> int:
    """Total number of changes (added + removed)."""
    return len(self.added_entities) + len(self.removed_entities)

  @property
  def has_changes(self) -> bool:
    """True if there are any changes between versions."""
    return self.change_count > 0


@dataclass(frozen=True)
class VersionInfo:
  """
  Metadata for a WoW expansion version.

  Contains version ordering and metadata for proper delta calculation.
  """

  slug: VersionSlug
  display_name: str
  order_index: int

  def __lt__(self, other: "VersionInfo") -> bool:
    """Enable sorting by order index."""
    return self.order_index < other.order_index


# === PROTOCOLS FOR DEPENDENCY INJECTION ===


class SitemapFetcher(Protocol):
  """
  Protocol for fetching sitemap data from external sources.

  This protocol enables dependency injection and makes testing easier
  by allowing mock implementations.
  """

  def get_sitemap_index(self) -> list[str]:
    """
    Fetch the main sitemap index containing all sitemap URLs.

    Returns:
      List of sitemap URLs from the main index
    """
    ...

  def get_sitemap_entries(self, url: str, locale: Locale = Locale.enUS) -> list[SitemapEntry]:
    """
    Fetch and parse individual sitemap entries.

    Args:
      url: The sitemap URL to fetch
      locale: The language locale for entity

    Returns:
      List of parsed sitemap entries
    """
    ...


class DeltaExporter(Protocol):
  """
  Protocol for exporting delta results to different formats.

  Allows for different export implementations (files, databases, etc.)
  """

  def export_comparison(self, delta_result: DeltaResult, output_dir: str = ".") -> tuple[str, str]:
    """
    Export version comparison to files.

    Args:
      delta_result: The delta calculation result
      output_dir: Directory to save files

    Returns:
      Tuple of (previous_file_path, target_file_path)
    """
    ...


# === CONSTANTS ===

# Supported WoW expansion versions in chronological order
SUPPORTED_VERSIONS: tuple[VersionInfo, ...] = (
  VersionInfo(VersionSlug.CLASSIC, "Classic", 0),
  VersionInfo(VersionSlug.TBC, "The Burning Crusade", 1),
  VersionInfo(VersionSlug.WOTLK, "Wrath of the Lich King", 2),
  VersionInfo(VersionSlug.CATA, "Cataclysm", 3),
  VersionInfo(VersionSlug.MOP_CLASSIC, "Mists of Pandaria Classic", 4),
)

# Extract just the version slugs for backward compatibility
VERSION_SLUGS: tuple[VersionSlug, ...] = tuple(version.slug for version in SUPPORTED_VERSIONS)

# All supported locales (using enum values)
SUPPORTED_LOCALES: tuple[Locale, ...] = tuple(Locale)

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
