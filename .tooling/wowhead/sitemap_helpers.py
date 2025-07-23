import re
from sitemap_types import (
  VersionSlug,
  # Locale,
  # EntityType,
  # SitemapEntry,
  # DeltaResult,
  # SitemapFetcher,
  # WowheadEntity,
  # EntityId,
)

# Pre‑compiled regular‑expression patterns covering the main Unicode ranges
# for each script.  (No third‑party libraries required.)
_PATTERNS = {
  "koKR": re.compile(
    r"[\u1100-\u11FF"  # Hangul Jamo
    r"\u3130-\u318F"  # Hangul Compatibility Jamo
    r"\uA960-\uA97F"  # Hangul Jamo Extended‑A
    r"\uAC00-\uD7AF"  # Hangul Syllables
    r"\uD7B0-\uD7FF]"  # Hangul Jamo Extended‑B
  ),
  "zhCN": re.compile(
    r"[\u3400-\u4DBF"  # CJK Unified Ideographs Ext. A
    r"\u4E00-\u9FFF"  # CJK Unified Ideographs
    r"\U00020000-\U0002A6DF"  # Ext. B
    r"\U0002A700-\U0002B73F"  # Ext. C
    r"\U0002B740-\U0002B81F"  # Ext. D
    r"\U0002B820-\U0002CEAF"  # Ext. E & F
    r"\U0002CEB0-\U0002EBEF]"  # Ext. G
  ),
  "zhTW": re.compile(
    r"[\u3100-\u312F"  # Bopomofo
    r"\u31A0-\u31BF]"  # Bopomofo Extended
  ),
  "ruRU": re.compile(
    r"[\u0400-\u04FF"  # Cyrillic
    r"\u0500-\u052F"  # Cyrillic Supplement
    r"\u2DE0-\u2DFF"  # Cyrillic Extended‑A
    r"\uA640-\uA69F]"  # Cyrillic Extended‑B
  ),
}


def contains_scripts(text: str) -> dict[str, bool]:
  """
  Return a dict telling whether *text* contains any characters from:
  Korean Hangul, Chinese Han, Taiwanese Bopomofo, or Russian Cyrillic.

  Example result:
      {'koKR': False, 'zhCN': True, 'zhTW': False, 'ruRU': True}
  """
  return {name: bool(pattern.search(text)) for name, pattern in _PATTERNS.items()}


def contains_any_scripts(text: str) -> bool:
  """
  Check if the given text contains any characters from the specified scripts.

  Example usage:
      if contains_any_scripts(some_text):
          # Do something
  """
  return any(pattern.search(text) for pattern in _PATTERNS.values())


# All supported versions as a tuple for iteration
VERSIONS: tuple[VersionSlug, ...] = tuple(VersionSlug)


# === UTILITY FUNCTIONS ===


def validate_version(version: VersionSlug) -> None:
  """Validate that a version slug is supported."""
  if version not in VERSIONS:
    raise ValueError(f"Version '{version}' not found in supported versions: {VERSIONS}")


def get_previous_version(target_version: VersionSlug) -> VersionSlug:
  """Get the previous version in the chronological sequence."""
  validate_version(target_version)
  target_index = VERSIONS.index(target_version)

  if target_index == 0:
    raise ValueError(f"Cannot get previous version for first version '{target_version}'")

  return VERSIONS[target_index - 1]
