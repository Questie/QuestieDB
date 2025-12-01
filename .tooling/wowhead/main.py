from wowhead_fetcher import WowheadFetcher
from fetcher_controller import FetcherControlServer
from sitemap_types import VersionSlug, EntityType, Locale
import time

current_running_index = 0


def get_current_running_index() -> int:
  """Get the current running index for operations."""
  global current_running_index
  return current_running_index


def run_with_controller():
  """Run the fetcher with HTTP controller for monitoring and cancellation."""
  global current_running_index
  with WowheadFetcher(locale=Locale.enUS) as fetcher:
    # Run fetching operations
    operations: list[tuple[VersionSlug, EntityType, int | None, Locale]] = []

    for loc in Locale:
      # if loc == Locale.koKR or loc == Locale.zhCN or loc == Locale.zhTW or loc == Locale.ruRU:
      operations.append((VersionSlug.CLASSIC, "quest", None, loc))
      operations.append((VersionSlug.TBC, "quest", None, loc))
      operations.append((VersionSlug.WOTLK, "quest", None, loc))
      operations.append((VersionSlug.CATA, "quest", None, loc))
      operations.append((VersionSlug.MOP_CLASSIC, "quest", None, loc))

    for loc in Locale:
      # if loc == Locale.koKR or loc == Locale.zhCN or loc == Locale.zhTW or loc == Locale.ruRU:
      operations.append((VersionSlug.CLASSIC, "object", None, loc))
      operations.append((VersionSlug.TBC, "object", None, loc))
      operations.append((VersionSlug.WOTLK, "object", None, loc))
      operations.append((VersionSlug.CATA, "object", None, loc))
      operations.append((VersionSlug.MOP_CLASSIC, "object", None, loc))

    for loc in Locale:
      # if loc == Locale.koKR or loc == Locale.zhCN or loc == Locale.zhTW or loc == Locale.ruRU:
      operations.append((VersionSlug.CLASSIC, "npc", None, loc))
      operations.append((VersionSlug.TBC, "npc", None, loc))
      operations.append((VersionSlug.WOTLK, "npc", None, loc))
      operations.append((VersionSlug.CATA, "npc", None, loc))
      operations.append((VersionSlug.MOP_CLASSIC, "npc", None, loc))

    # Start the HTTP control server with configurable default refresh frequency
    # Options: 1000ms (1s), 2000ms (2s), 5000ms (5s), 10000ms (10s), 30000ms (30s), 60000ms (1m)
    controller = FetcherControlServer(fetcher, port=8000, default_refresh_ms=1000, get_current_running_index=get_current_running_index, operations=operations)  # 1 second default
    controller.start()

    try:
      print("=== Wowhead Fetcher with Controller ===")
      print("HTTP Controller available at http://localhost:8000")
      print("You can monitor progress and stop the fetcher using the web interface")
      print("Or press Ctrl+C to stop gracefully")
      print()

      print("=== Fetching Operations ===")
      print("Available locales:", [locale.value for locale in Locale])
      print("Operations to perform:")
      for version, entity_type, limit, locale in operations:
        print(f"- {version.value} {entity_type} (limit: {limit}, locale: {locale.value})")
      print()

      current_running_index = 0
      for version, entity_type, limit, locale in operations:
        fetcher.update_locale(locale)
        if fetcher.is_stopped():
          print("Fetcher has been stopped. Exiting...")
          break

        print(f"\nStarting: {entity_type} for {version.value} (limit: {limit}, locale: {locale.value})")

        if version == VersionSlug.CLASSIC:
          fetcher.fetch_version_entities(version, entity_type, limit=limit)
        else:
          fetcher.fetch_delta_entities(version, entity_type, limit=limit)

        # Small delay between operations to allow monitoring
        if not fetcher.is_stopped():
          time.sleep(2)

        current_running_index += 1

      if not fetcher.is_stopped():
        print("\n=== All operations completed successfully ===")
        time.sleep(10)  # Allow time for final updates to be processed
      else:
        print("\n=== Operations stopped by user request ===")
        time.sleep(5)  # Allow time for final updates to be processed

    finally:
      print("Shutting down HTTP controller...")
      controller.stop()


if __name__ == "__main__":
  run_with_controller()
