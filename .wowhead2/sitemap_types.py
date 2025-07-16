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

EntityType = Literal["quest", "item", "npc", "zone", "spell", "achievement"]
"""Literal type for supported Wowhead entity types."""

CanonicalUrl = NewType("CanonicalUrl", str)
"""Strong type for canonical URLs without version paths."""

VersionSpecificUrl = NewType("VersionSpecificUrl", str)
"""Strong type for version-specific URLs with expansion paths."""

EntityId = NewType("EntityId", int)
"""Strong type for Wowhead entity IDs extracted from URLs."""


# === IMMUTABLE DATA STRUCTURES ===


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
  all_urls: tuple[VersionSpecificUrl, ...]
  added_urls: tuple[VersionSpecificUrl, ...]
  removed_urls: tuple[VersionSpecificUrl, ...]

  @property
  def change_count(self) -> int:
    """Total number of changes (added + removed)."""
    return len(self.added_urls) + len(self.removed_urls)

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
  release_date: str

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


class UrlTransformer(Protocol):
  """
  Protocol for URL transformation operations.

  Enables different URL handling strategies while maintaining
  a consistent interface.
  """

  def canonicalize_url(self, url: str) -> CanonicalUrl:
    """Convert version-specific URL to canonical form."""
    ...

  def add_version_to_url(self, canonical_url: CanonicalUrl, version: VersionSlug) -> VersionSpecificUrl:
    """Add version segment to canonical URL."""
    ...

  def extract_entity_id(self, url: str) -> EntityId:
    """Extract numeric entity ID from URL."""
    ...


# === CONSTANTS ===

# Supported WoW expansion versions in chronological order
SUPPORTED_VERSIONS: tuple[VersionInfo, ...] = (
  VersionInfo(VersionSlug.CLASSIC, "Classic", 0, "2004-11-23"),
  VersionInfo(VersionSlug.TBC, "The Burning Crusade", 1, "2007-01-16"),
  VersionInfo(VersionSlug.WOTLK, "Wrath of the Lich King", 2, "2008-11-13"),
  VersionInfo(VersionSlug.CATA, "Cataclysm", 3, "2010-12-07"),
  VersionInfo(VersionSlug.MOP_CLASSIC, "Mists of Pandaria Classic", 4, "2012-09-25"),
)

# Extract just the version slugs for backward compatibility
VERSION_SLUGS: tuple[VersionSlug, ...] = tuple(version.slug for version in SUPPORTED_VERSIONS)

# All supported locales (using enum values)
SUPPORTED_LOCALES: tuple[Locale, ...] = tuple(Locale)
