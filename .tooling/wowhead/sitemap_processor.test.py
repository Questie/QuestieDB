from sitemap_types import (
  VersionSlug,
  Locale,
  EntityType,
  SitemapFetcher,
  # SitemapEntry,
  # DeltaResult,
  # WowheadEntity,
  # EntityId,
)
from sitemap_helpers import validate_version, get_previous_version
from sitemap_processor import get_entities, calculate_version_delta, RequestsSitemapFetcher
import os

# ! === FILE EXPORT UTILITIES (FOR DEBUGGING) ===


def export_version_comparison(
  target_version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  output_dir: str = ".",
  locale: Locale = Locale.enUS,
) -> tuple[str, str]:
  """Export version comparison to separate files for manual inspection."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Exporting comparison files for '{previous_version}' vs '{target_version}' ({entity_type}, {locale.value})")

  previous_entities = get_entities(previous_version, entity_type, fetcher, locale)
  target_entities = get_entities(target_version, entity_type, fetcher, locale)

  previous_file = f"{output_dir}/_{previous_version.value}_{entity_type}_{locale.value}_ids"
  target_file = f"{output_dir}/_{target_version.value}_{entity_type}_{locale.value}_ids"

  with open(previous_file + "_fullurl.txt", "w", encoding="utf-8") as f:
    f.write(f"# {previous_version.value.upper()} {entity_type.upper()} IDs ({len(previous_entities)} total)\n")
    for entity in previous_entities:
      f.write(f"{entity.generate_url()}\n")

  with open(target_file + "_fullurl.txt", "w", encoding="utf-8") as f:
    f.write(f"# {target_version.value.upper()} {entity_type.upper()} IDs ({len(target_entities)} total)\n")
    for entity in target_entities:
      f.write(f"{entity.generate_url()}\n")

  with open(previous_file + "_tooltip.txt", "w", encoding="utf-8") as f:
    f.write(f"# {previous_version.value.upper()} {entity_type.upper()} IDs ({len(previous_entities)} total)\n")
    for entity in previous_entities:
      f.write(f"{entity.generate_tooltip_url()}\n")

  with open(target_file + "_tooltip.txt", "w", encoding="utf-8") as f:
    f.write(f"# {target_version.value.upper()} {entity_type.upper()} IDs ({len(target_entities)} total)\n")
    for entity in target_entities:
      f.write(f"{entity.generate_tooltip_url()}\n")

  print(f"Files created:")
  print(f"  Previous ({previous_version.value}): {previous_file}")
  print(f"  Target ({target_version.value}): {target_file}")

  return previous_file, target_file


# === MAIN ENTRY POINT ===

if __name__ == "__main__":
  fetcher = None
  try:
    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_dir = os.path.join(script_dir, "debug-output")
    os.makedirs(output_dir, exist_ok=True)

    print("=== Functional Sitemap Processing Demo ===")
    fetcher = RequestsSitemapFetcher()

    print("\n--- Calculating Delta (Classic -> TBC, NPC) ---")
    delta_result = calculate_version_delta(VersionSlug.TBC, "npc", fetcher, locale=Locale.deDE)

    print(f"\nDelta Results:")
    print(f"  Target Version: {delta_result.target_version.value}")
    print(f"  Previous Version: {delta_result.previous_version.value}")
    print(f"  Entity Type: {delta_result.entity_type}")
    print(f"  Total changes: {delta_result.change_count}")
    print(f"  Added: {len(delta_result.added_entities)}")
    print(f"  Removed: {len(delta_result.removed_entities)}")

    # Check if id 1 exists in both added and removed
    # if any(entity.entity_id == EntityId(1) for entity in delta_result.added_entities):
    #   print("Quest ID 1 was added in TBC!")

    # if any(entity.entity_id == EntityId(1) for entity in delta_result.removed_entities):
    #   print("Quest ID 1 was removed in TBC!")

    if delta_result.added_entities:
      print("\nFirst 30 added quest URLs:")
      for entity in delta_result.added_entities[:30]:
        print(f"  {entity.generate_url()}")

    if delta_result.removed_entities:
      print("\nFirst 30 removed quest URLs:")
      for entity in delta_result.removed_entities[:30]:
        print(f"  {entity.generate_url()}")

    print("\n--- Exporting Comparison Files ---")
    export_version_comparison(VersionSlug.TBC, "npc", fetcher, output_dir=output_dir, locale=Locale.deDE)
    # export_version_comparison(VersionSlug.TBC, "quest", fetcher, output_dir=output_dir)

  except Exception as error:
    print(f"Error during demo: {error}")
    raise
  finally:
    if fetcher is not None:
      del fetcher
