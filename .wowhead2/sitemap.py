# from xml.etree import ElementTree

from dataclasses import dataclass
from xml.dom.minidom import parseString
import requests


@dataclass
class Sitemap:
  """Represents a sitemap entry."""

  loc: str
  priority: float
  lastmod: str
  id: int

  # Constructor
  def __init__(self, loc: str, priority: float, lastmod: str):
    self.loc = loc
    self.priority = priority
    self.lastmod = lastmod
    self.id = int(loc.split("=")[1].split("/")[0])


@dataclass
class DeltaResult:
  """Represents the delta between two versions."""

  fixed: list[str]  # Combined added and removed IDs
  added: list[str]  # IDs that were added in target version
  removed: list[str]  # IDs that were removed from previous version


# # <sitemapindex>
# # <sitemap>
# # <loc>
# # https://www.wowhead.com/cata/de/sitemap/guides?page=1
# # </loc>
# # </sitemap>
# # <sitemap>
# # <loc>
# # https://www.wowhead.com/cata/de/sitemap/news?page=1
# # </loc>
# # </sitemap>
# # </sitemapindex>
def get_sitemaps() -> list[str]:
  """Fetches and parses the sitemap from Wowhead."""
  # Fetch the sitemap XML
  response = requests.get("https://www.wowhead.com/sitemap")
  # Parse the XML
  parsed_data = parseString(response.text)
  all_urls = []
  # Extract the <loc> elements
  for sitemap in parsed_data.getElementsByTagName("sitemap"):
    loc = sitemap.getElementsByTagName("loc")[0].firstChild.nodeValue  # type: ignore
    all_urls.append(loc)

  return all_urls


def get_all_base_urls(version: str, id_type: str) -> list[str]:
  """Fetches all URLs for a given version, and ID type."""
  all_urls = get_sitemaps()
  # Filter the URLs based on the provided parameters
  filtered_urls = [url for url in all_urls if f"/{version}/" in url and f"/{id_type}?" in url]
  print(filtered_urls)
  return filtered_urls


# <urlset>
# <url>
# <loc>
# https://www.wowhead.com/cata/quest=1/kanrethads-quest
# </loc>
# <priority>0.1</priority>
# <lastmod>2010-04-21T16:49:25+00:00</lastmod>
# </url>
# <url>
# <loc>
# </loc>
# <priority>0.1</priority>
# <lastmod>2010-04-21T16:49:25+00:00</lastmod>
# </url>
# </urlset>
def get_specific_sitemap(url, locale=""):
  """Fetches and parses the sitemap from Wowhead."""
  if locale and locale != "en" and locale != "enUS" and locale != "":
    url = url.replace("sitemap", f"{locale}/sitemap")
  print(f"Fetching sitemap for {url}")
  # Fetch the sitemap XML
  response = requests.get(url)
  # Parse the XML
  parsed_data = parseString(response.text)
  all_urls: list[Sitemap] = []
  # Extract the <loc> elements
  for sitemap in parsed_data.getElementsByTagName("url"):
    loc_node = sitemap.getElementsByTagName("loc")[0].firstChild
    priority_node = sitemap.getElementsByTagName("priority")[0].firstChild
    lastmod_node = sitemap.getElementsByTagName("lastmod")[0].firstChild

    if loc_node and priority_node and lastmod_node:
      loc = loc_node.nodeValue
      priority = priority_node.nodeValue
      lastmod = lastmod_node.nodeValue

      if loc and priority and lastmod:
        sitemap_entry = Sitemap(loc=loc, priority=float(priority), lastmod=lastmod)
        all_urls.append(sitemap_entry)

  return all_urls


def get_all_sites(version: str, id_type: str) -> list[Sitemap]:
  all_sites: list[Sitemap] = []
  urls = get_all_base_urls(version, id_type)
  for url in urls:
    data = get_specific_sitemap(url)
    all_sites.extend(data)

  return all_sites


def get_all_ids(version: str, id_type: str) -> list[int]:
  sites = get_all_sites(version, id_type)
  all_ids = []
  for site in sites:
    all_ids.append(site.id)
  return all_ids


def get_all_locs(version: str, id_type: str) -> list[str]:
  sites = get_all_sites(version, id_type)
  all_locs = []
  for site in sites:
    all_locs.append(site.loc)
  return all_locs


versions = [
  "classic",
  "tbc",
  "wotlk",
  "cata",
  "mop-classic",
]


def canonicalize_url(url: str) -> str:
  """
  Convert a version-specific Wowhead URL to its canonical form.

  Examples:
    https://www.wowhead.com/classic/quest=123/name -> https://www.wowhead.com/quest=123/name
    https://www.wowhead.com/tbc/quest=456/name -> https://www.wowhead.com/quest=456/name

  Args:
    url: The version-specific URL to canonicalize

  Returns:
    The canonical URL without version path
  """
  # Remove version segments like /classic/, /tbc/, /wotlk/, etc.
  for version in versions:
    version_path = f"/{version}/"
    if version_path in url:
      return url.replace(version_path, "/")
  return url


def add_version_to_url(canonical_url: str, version: str) -> str:
  """
  Convert a canonical Wowhead URL to a version-specific URL.

  Examples:
    https://www.wowhead.com/quest=123/name, "tbc" -> https://www.wowhead.com/tbc/quest=123/name
    https://www.wowhead.com/item=456/name, "wotlk" -> https://www.wowhead.com/wotlk/item=456/name

  Args:
    canonical_url: The canonical URL to add version to
    version: The version slug to insert

  Returns:
    The version-specific URL
  """
  if version not in versions:
    raise ValueError(f"Unknown version '{version}'. Supported versions: {versions}")

  # Insert version after the domain
  # https://www.wowhead.com/quest=123 -> https://www.wowhead.com/tbc/quest=123
  return canonical_url.replace("https://www.wowhead.com/", f"https://www.wowhead.com/{version}/")


def get_canonical_locs(version: str, id_type: str) -> set[str]:
  """
  Get all canonical URLs for a given version and ID type.

  Args:
    version: The WoW version (e.g., "classic", "tbc")
    id_type: The entity type (e.g., "quest", "item", "npc")

  Returns:
    Set of canonical URLs without version paths
  """
  version_specific_locs = get_all_locs(version, id_type)
  canonical_locs = {canonicalize_url(loc) for loc in version_specific_locs}
  return canonical_locs


def get_version_delta(target_version: str, id_type: str) -> DeltaResult:
  """
  Calculate the delta between target_version and the previous version using canonical URLs.

  Args:
    target_version: The version to compare (e.g., "tbc", "wotlk")
    id_type: The type of ID to compare (e.g., "quest", "item", "npc")

  Returns:
    DeltaResult containing fixed (combined), added, and removed canonical URL lists

  Raises:
    ValueError: If target_version is not found or is the first version
  """
  if target_version not in versions:
    raise ValueError(f"Version '{target_version}' not found in supported versions: {versions}")

  target_index = versions.index(target_version)

  if target_index == 0:
    raise ValueError(f"Cannot calculate delta for first version '{target_version}'. No previous version available.")

  previous_version = versions[target_index - 1]

  print(f"Calculating delta from '{previous_version}' to '{target_version}' for type '{id_type}'")

  # Get canonical URLs for both versions
  previous_canonical = get_canonical_locs(previous_version, id_type)
  target_canonical = get_canonical_locs(target_version, id_type)

  # Calculate deltas using canonical URLs
  added_canonical = list(target_canonical - previous_canonical)
  removed_canonical = list(previous_canonical - target_canonical)

  # Convert canonical URLs back to version-specific URLs
  added_versioned = [add_version_to_url(url, target_version) for url in added_canonical]
  removed_versioned = [add_version_to_url(url, previous_version) for url in removed_canonical]
  fixed_versioned = added_versioned + removed_versioned

  # Sort by the actual ID number (extracted from URL) for consistent output
  def extract_id_from_url(url: str) -> int:
    """Extract the numeric ID from a Wowhead URL."""
    return int(url.split("=")[1].split("/")[0])

  added_versioned.sort(key=extract_id_from_url)
  removed_versioned.sort(key=extract_id_from_url)
  fixed_versioned.sort(key=extract_id_from_url)

  print(f"Found {len(added_versioned)} added IDs, {len(removed_versioned)} removed IDs")

  return DeltaResult(fixed=fixed_versioned, added=added_versioned, removed=removed_versioned)


def dump_version_comparison(target_version: str, id_type: str, output_dir: str = "."):
  """
  Dump IDs from previous and target versions to separate files for manual comparison.

  Args:
    target_version: The version to compare (e.g., "tbc", "wotlk")
    id_type: The type of ID to compare (e.g., "quest", "item", "npc")
    output_dir: Directory to save the dump files (defaults to current directory)

  Returns:
    Tuple of (previous_file_path, target_file_path)
  """
  if target_version not in versions:
    raise ValueError(f"Version '{target_version}' not found in supported versions: {versions}")

  target_index = versions.index(target_version)

  if target_index == 0:
    raise ValueError(f"Cannot compare first version '{target_version}'. No previous version available.")

  previous_version = versions[target_index - 1]

  print(f"Dumping comparison files for '{previous_version}' vs '{target_version}' ({id_type})")

  # Get canonical URLs for both versions
  previous_canonical = get_canonical_locs(previous_version, id_type)
  target_canonical = get_canonical_locs(target_version, id_type)

  # Convert sets back to sorted lists with version-specific URLs
  previous_ids = [url for url in previous_canonical]
  target_ids = [url for url in target_canonical]

  # Sort by the actual ID number (extracted from URL) for consistent comparison
  def extract_id_from_url(url: str) -> int:
    """Extract the numeric ID from a Wowhead URL."""
    return int(url.split("=")[1].split("/")[0])

  previous_ids.sort(key=extract_id_from_url)
  target_ids.sort(key=extract_id_from_url)

  # Create file names
  previous_file = f"{output_dir}/_{previous_version}_{id_type}_ids.txt"
  target_file = f"{output_dir}/_{target_version}_{id_type}_ids.txt"

  # Write previous version IDs
  with open(previous_file, "w", encoding="utf-8") as f:
    f.write(f"# {previous_version.upper()} {id_type.upper()} IDs ({len(previous_ids)} total)\n")
    f.write(f"# Generated on {__import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
    for quest_id in previous_ids:
      f.write(f"{quest_id}\n")

  # Write target version IDs
  with open(target_file, "w", encoding="utf-8") as f:
    f.write(f"# {target_version.upper()} {id_type.upper()} IDs ({len(target_ids)} total)\n")
    f.write(f"# Generated on {__import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
    for quest_id in target_ids:
      f.write(f"{quest_id}\n")
  #     f.write(f"{quest_id.replace('/classic/', '/tbc/')}\n")

  print(f"Files created:")
  print(f"  Previous ({previous_version}): {previous_file} ({len(previous_ids)} IDs)")
  print(f"  Target ({target_version}): {target_file} ({len(target_ids)} IDs)")
  print(f"\nYou can now compare these files in VS Code using:")
  print(f'  code --diff "{previous_file}" "{target_file}"')

  return previous_file, target_file


def get_delta_sitemap(id_type: str):
  """Fetches the delta sitemap for a given ID type."""
  # base_urls = get_all_base_urls("classic", idType)
  pass


def main():
  """Main function to test the delta calculation implementation."""
  try:
    # Test delta calculation between classic and tbc for quests
    print("=== Testing Delta Calculation ===")

    # Example: Calculate delta from classic to tbc for quests
    delta_result = get_version_delta("tbc", "quest")

    print(f"\nDelta Results (Classic -> TBC, Quest):")
    print(f"Total changes: {len(delta_result.fixed)}")
    print(f"Added quests: {len(delta_result.added)}")
    print(f"Removed quests: {len(delta_result.removed)}")

    # Show first few IDs as examples
    if delta_result.added:
      print(f"First 10 added quest IDs: \n{'\n'.join(delta_result.added[:10])}")
    if delta_result.removed:
      print(f"First 10 removed quest IDs: \n{'\n'.join(delta_result.removed[:10])}")

    # Test with different version and type
    print("\n" + "=" * 50)
    print("Creating dump files for manual comparison...")
    dump_version_comparison("tbc", "quest")

    # # Test with different version and type
    # print("\n" + "=" * 50)
    # delta_result_2 = get_version_delta("mop-classic", "quest")

    # print(f"\nDelta Results (CATA -> MOP-CLASSIC, Quest):")
    # print(f"Total changes: {len(delta_result_2.fixed)}")
    # print(f"Added quests: {len(delta_result_2.added)}")
    # print(f"Removed quests: {len(delta_result_2.removed)}")

  except Exception as e:
    print(f"Error during testing: {e}")


if __name__ == "__main__":
  main()
