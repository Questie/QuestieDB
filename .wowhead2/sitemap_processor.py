import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
from xml.dom.minidom import parseString
from functools import cache
from sitemap_types import (
  VersionSlug,
  Locale,
  EntityType,
  SitemapEntry,
  DeltaResult,
  SitemapFetcher,
  WowheadEntity,
  EntityId,
)
from wowhead_mappings import parse_url, LOCALE_TO_URL_SEGMENT
from sitemap_helpers import contains_scripts, validate_version, get_previous_version

# === CONCRETE IMPLEMENTATION ===


class RequestsSitemapFetcher:
  """HTTP requests-based implementation of the SitemapFetcher protocol."""

  def __init__(self, base_url: str = "https://www.wowhead.com", timeout: float = 30.0):
    self.base_url = base_url
    self.timeout = timeout
    self.session = requests.Session()
    retry_strategy = Retry(
      total=3,
      backoff_factor=1,
      status_forcelist=[429, 500, 502, 503, 504],
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    self.session.mount("https://", adapter)
    self.session.mount("http://", adapter)

  def get_sitemap_index(self) -> list[str]:
    """Fetch the main sitemap index containing all sitemap URLs."""
    print(f"Fetching sitemap index from: {self.base_url}/sitemap")
    response = self.session.get(f"{self.base_url}/sitemap", timeout=self.timeout)
    response.raise_for_status()
    parsed_data = parseString(response.text)
    urls = [loc.firstChild.nodeValue for sitemap in parsed_data.getElementsByTagName("sitemap") if (loc := sitemap.getElementsByTagName("loc")[0]) and loc.firstChild and loc.firstChild.nodeValue]
    print(f"Found {len(urls)} sitemap URLs")
    return urls

  def get_sitemap_entries(self, url: str, locale: Locale = Locale.enUS) -> list[SitemapEntry]:
    """Fetch and parse individual sitemap entries."""
    if locale != Locale.enUS:
      locale_segment = LOCALE_TO_URL_SEGMENT.get(locale, None)
      if locale_segment:
        url = url.replace("sitemap", f"{locale_segment}/sitemap")
      else:
        raise ValueError(f"Unsupported locale: {locale}")

    print(f"  → Fetching entries from: {url}")
    response = self.session.get(url, timeout=self.timeout)
    response.raise_for_status()
    parsed_data = parseString(response.text)
    entries = []
    for url_node in parsed_data.getElementsByTagName("url"):
      try:
        loc_element = url_node.getElementsByTagName("loc")[0]
        priority_element = url_node.getElementsByTagName("priority")[0]
        lastmod_element = url_node.getElementsByTagName("lastmod")[0]

        loc_value = loc_element.firstChild.nodeValue if loc_element.firstChild and loc_element.firstChild.nodeValue is not None else None
        priority_value = priority_element.firstChild.nodeValue if priority_element.firstChild and priority_element.firstChild.nodeValue is not None else None
        lastmod_value = lastmod_element.firstChild.nodeValue if lastmod_element.firstChild and lastmod_element.firstChild.nodeValue is not None else None

        if loc_value and priority_value and lastmod_value:
          entries.append(
            SitemapEntry(
              loc=loc_value,
              priority=float(priority_value),
              lastmod=lastmod_value,
              entity_id=EntityId(0),  # Placeholder, replaced by __post_init__
            )
          )
      except (ValueError, TypeError, IndexError) as e:
        print(f"Warning: Skipping invalid sitemap entry: {e}")
    print(f"    Found {len(entries)} entries")
    return entries

  def __del__(self):
    if hasattr(self, "session"):
      self.session.close()


# === CORE BUSINESS LOGIC ===


@cache
def get_version_sitemap_urls(version: VersionSlug, entity_type: EntityType, fetcher: SitemapFetcher) -> list[str]:
  """Get all sitemap URLs for a specific version and entity type."""
  validate_version(version)
  all_urls = fetcher.get_sitemap_index()
  return [url for url in all_urls if f"/{version.value}/" in url and f"/{entity_type}?" in url]


@cache
def get_entities(
  version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  locale: Locale = Locale.enUS,
) -> tuple[WowheadEntity, ...]:
  """Get all WowheadEntitys for a given version and entity type."""
  sitemap_urls = get_version_sitemap_urls(version, entity_type, fetcher)
  all_entries: list[SitemapEntry] = []
  for url in sitemap_urls:
    entries = fetcher.get_sitemap_entries(url, locale)
    all_entries.extend(entries)

  # Parse all URLs into structured entities
  entities = [parse_url(entry.loc, entry.lastmod) for entry in all_entries]

  # Sort by entity_id for consistent ordering
  return tuple(sorted(entities, key=lambda e: e.entity_id))


@cache
def calculate_version_delta(
  target_version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  locale: Locale = Locale.enUS,
) -> DeltaResult:
  """Calculate the delta between target_version and the previous version."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Calculating delta from '{previous_version}' to '{target_version}' for type '{entity_type}'")

  print(f"  Fetching {previous_version} sitemap entries...")
  previous_entities = get_entities(previous_version, entity_type, fetcher, locale)

  print(f"  Fetching {target_version} sitemap entries...")
  target_entities = get_entities(target_version, entity_type, fetcher, locale)

  # Use sets of a composite key (ID, name) for efficient and accurate comparison
  previous_keys = {(entity.entity_id, entity.name_slug) for entity in previous_entities}
  target_keys = {(entity.entity_id, entity.name_slug) for entity in target_entities}

  added_keys = target_keys - previous_keys
  removed_keys = previous_keys - target_keys

  # Filter the full entity objects based on the delta keys
  # Sort by entity_id for consistent ordering
  added_entities = tuple(sorted([entity for entity in target_entities if (entity.entity_id, entity.name_slug) in added_keys], key=lambda e: e.entity_id))
  removed_entities = tuple(sorted([entity for entity in previous_entities if (entity.entity_id, entity.name_slug) in removed_keys], key=lambda e: e.entity_id))
  all_entities = tuple(sorted(added_entities + removed_entities, key=lambda e: e.entity_id))

  print(f" Found {len(added_entities)} added, {len(removed_entities)} removed")

  return DeltaResult(
    target_version=target_version,
    previous_version=previous_version,
    entity_type=entity_type,
    all_entities=all_entities,
    added_entities=added_entities,
    removed_entities=removed_entities,
  )


@cache
def calculate_version_delta_smart(
  target_version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  locale: Locale = Locale.enUS,
) -> DeltaResult:
  """Calculate the delta between target_version and the previous version."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Calculating delta from '{previous_version}' to '{target_version}' for type '{entity_type}'")

  # print(f"Fetching enUS {previous_version} sitemap entries...")
  # previous_english_entities = get_entities(previous_version, entity_type, fetcher, Locale.enUS)

  # print(f"Fetching enUS {target_version} sitemap entries...")
  # target_english_entities = get_entities(target_version, entity_type, fetcher, Locale.enUS)

  # # Use sets of a composite key (ID, name) for efficient and accurate comparison
  # previous_english_keys = {(entity.entity_id, entity.name_slug) for entity in previous_english_entities}
  # target_english_keys = {(entity.entity_id, entity.name_slug) for entity in target_english_entities}

  print(f"Fetching {previous_version} sitemap entries...")
  previous_entities = get_entities(previous_version, entity_type, fetcher, locale)

  print(f"Fetching {target_version} sitemap entries...")
  target_entities = get_entities(target_version, entity_type, fetcher, locale)

  # Use sets of a composite key (ID, name) for efficient and accurate comparison
  previous_keys = {(entity.entity_id, entity.name_slug) for entity in previous_entities}
  target_keys = {(entity.entity_id, entity.name_slug) for entity in target_entities}

  # # Remove all english entities from the previous and target sets
  # print("Removing English entities from comparison...")
  # print(len(previous_keys), "previous keys before filtering")
  # previous_keys -= previous_english_keys
  # print(len(previous_keys), "previous keys after filtering")
  # print(len(target_keys), "target keys before filtering")
  # target_keys -= target_english_keys
  # print(len(target_keys), "target keys after filtering")

  # Remove all english entities from the previous and target sets
  # print("Removing English entities from comparison...")
  # print(len(previous_keys), "previous keys before filtering")
  # suspected_previous_english_keys = previous_keys & previous_english_keys
  # print(len(suspected_previous_english_keys), "previous keys after filtering")
  # print(len(target_keys), "target keys before filtering")
  # suspected_target_english_keys = target_keys & target_english_keys
  # print(len(suspected_target_english_keys), "target keys after filtering")
  # added_suspected_english_keys = suspected_target_english_keys - previous_english_keys
  # removed_suspected_english_keys = suspected_previous_english_keys - target_english_keys

  added_keys = target_keys - previous_keys
  removed_keys = previous_keys - target_keys

  # Filter the full entity objects based on the delta keys
  # Sort by entity_id for consistent ordering
  added_entities = tuple(sorted([entity for entity in target_entities if (entity.entity_id, entity.name_slug) in added_keys], key=lambda e: e.entity_id))
  removed_entities = tuple(sorted([entity for entity in previous_entities if (entity.entity_id, entity.name_slug) in removed_keys], key=lambda e: e.entity_id))
  # added_sus_english_entities = tuple(sorted([entity for entity in target_entities if (entity.entity_id, entity.name_slug) in added_suspected_english_keys], key=lambda e: e.entity_id))
  # removed_sus_english_entities = tuple(sorted([entity for entity in previous_entities if (entity.entity_id, entity.name_slug) in removed_suspected_english_keys], key=lambda e: e.entity_id))
  all_entities = tuple(sorted(added_entities + removed_entities, key=lambda e: e.entity_id))

  if locale in [Locale.koKR, Locale.zhCN, Locale.zhTW, Locale.ruRU]:
    # For Asian locales, filter out entries that contain scripts
    # entities = [entity for entity in entities if not contains_scripts(entity.generate_url())]
    with open(f"debug-output/{target_version.value}_{locale.value}_{entity_type}_filtered_entities.txt", "w", encoding="utf-8") as f:
      for entity in added_entities:
        if entity.name_slug:
          data = contains_scripts(entity.name_slug)
          if not data[locale.value]:
            f.write(f"{entity.generate_url()}\n")
    # added_entities = tuple(sorted([entity for entity in added_entities if not contains_any_scripts(entity.generate_url())], key=lambda e: e.entity_id))

  print(f"Found {len(added_entities)} added, {len(removed_entities)} removed")

  return DeltaResult(
    target_version=target_version,
    previous_version=previous_version,
    entity_type=entity_type,
    all_entities=all_entities,
    added_entities=added_entities,
    removed_entities=removed_entities,
  )
