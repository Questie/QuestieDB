#!/usr/bin/env python3
"""
Script to convert localization JSON files to Lua format for QuestieDB.

Reads JSON files from .output/<version>_locales.json and generates
Lua files in the Questie-data/Localization/lookups/ structure.
"""

import json
import sys
from pathlib import Path
from typing import Dict


class LocalizationGenerator:
  """Generate Lua localization files from JSON data."""

  # Mapping of data types to their lookup table names and file names
  DATA_TYPE_MAPPING = {
    "item": ("itemLookup", "lookupItems"),
    "npc": ("npcNameLookup", "lookupNpcs"),
    "object": ("objectNameLookup", "lookupObjects"),
    "quest": ("questNameLookup", "lookupQuests"),
    "zone": ("zoneNameLookup", "lookupZones"),
  }

  # Supported locales
  LOCALES = ["deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW"]

  # Supported versions/expansions
  VERSIONS = ["classic", "tbc", "wotlk", "cata", "mop-classic"]

  def __init__(self, base_path: str):
    """Initialize with the base path to the QuestieDB directory."""
    self.base_path = Path(base_path)
    self.input_dir = self.base_path / ".output"
    self.localization_base = self.base_path / ".output" / "Localization" / "lookups"

  def ensure_directories(self, version: str, data_type: str) -> Path:
    """Ensure the directory structure exists for the given version and data type."""
    version_dir = self.localization_base / version

    if data_type == "zone":
      # Zones go directly in the version directory
      version_dir.mkdir(parents=True, exist_ok=True)
      return version_dir
    else:
      # Other types go in subdirectories
      data_dir = version_dir / self.DATA_TYPE_MAPPING[data_type][1]
      data_dir.mkdir(parents=True, exist_ok=True)
      return data_dir

  # def escape_lua_string(self, text: str) -> str:
  #   """Escape special characters in Lua strings."""
  #   if not isinstance(text, str):
  #     return str(text)

  #   # Replace backslashes first, then quotes
  #   text = text.replace("\\", "\\\\")
  #   text = text.replace('"', '\\"')
  #   text = text.replace("\n", "\\n")
  #   text = text.replace("\r", "\\r")
  #   text = text.replace("\t", "\\t")
  #   return text

  def format_npc_value(self, data) -> str | None:
    """Format NPC values as {name, title} pairs."""
    # For NPCs, the format is {"Name", "Title"} or {"Name", nil}
    # For now, assume no title (nil) unless we have more data
    # {'name': 'Comedor de Carne'}
    if "name" not in data and "subName" not in data:
      return None

    name = "nil"
    if "name" in data:
      name = f'"{data["name"]}"'
    subname = "nil"
    if "subName" in data:
      subname = f'"{data["subName"]}"'
    return f"{{{name},{subname}}}"

  def format_quest_value(self, data) -> str | None:
    """Format Quest values as {"Title", {"Description"}, {"Text"}} pairs."""
    # For Quests, the format is {"Title", {Description}, {Text}}
    # If no title, description, or text, return None
    if ("Title" not in data or len(data["Title"]) == 0) and ("Description" not in data or len(data["Description"]) == 0) and ("Text" not in data or len(data["Text"]) == 0):
      return None
    title = "nil"
    if "Title" in data and len(data["Title"]) > 0:
      title = f'"{data["Title"]}"'
    description = "nil"  # We always set this to nil because we are not actually using the value
    text = "nil"
    if "Text" in data and len(data["Text"]) > 0:
      text = f'{{"{data["Text"]}"}}'
    return f"{{{title},{description},{text}}}"

  def generate_lua_content(self, locale: str, data_type: str, data: Dict[str, str]) -> str:
    """Generate the Lua file content for a specific locale and data type."""
    lookup_table_name = self.DATA_TYPE_MAPPING[data_type][0]

    # Header
    content = [
      f'if GetLocale() ~= "{locale}" then',
      "    return",
      "end",
      "",
      "-- - @type l10n",
      'local l10n = QuestieLoader:ImportModule("l10n")',
      "",
      f'l10n.{lookup_table_name}["{locale}"] = loadstring([[return {{',
    ]

    # Sort by numeric ID for consistent output
    sorted_items = sorted(data.items(), key=lambda x: int(x[0]))

    for entityId, value in sorted_items:
      if data_type == "npc":
        value = self.format_npc_value(value)
      elif data_type == "quest":
        value = self.format_quest_value(value)
      else:
        value = f'"{value}"'

      if value is not None:
        content.append(f"[{entityId}] = {value},")

    # Footer
    content.append("}]])")

    return "\n".join(content)

  def process_json_file(self, json_path: Path) -> None:
    """Process a single JSON localization file."""
    print(f"Processing {json_path.name}...")

    # Extract version from filename (e.g., "mop-classic_locales.json" -> "MoP")
    version_key = json_path.stem.split("_")[0]

    # Map version keys to directory names
    version_mapping = {"classic": "Classic", "tbc": "TBC", "wotlk": "Wotlk", "cata": "Cata", "mop-classic": "MoP"}

    version = version_mapping.get(version_key)
    if not version:
      print(f"Warning: Unknown version '{version_key}' in {json_path.name}")
      return

    # Load JSON data
    try:
      with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    except Exception as e:
      print(f"Error loading {json_path}: {e}")
      return

    # Process each data type
    for data_type, type_data in data.items():
      if data_type not in self.DATA_TYPE_MAPPING:
        print(f"Warning: Unknown data type '{data_type}' in {json_path.name}")
        continue

      print(f"  Processing {data_type} data...")

      # Ensure directory structure exists
      output_dir = self.ensure_directories(version, data_type)

      # Group data by locale
      locale_data = {}
      for item_id, translations in type_data.items():
        for locale, translation in translations.items():
          if locale not in self.LOCALES:
            continue  # Skip unsupported locales

          if locale not in locale_data:
            locale_data[locale] = {}
          locale_data[locale][item_id] = translation

      # Generate Lua files for each locale
      for locale, items in locale_data.items():
        if not items:  # Skip empty locales
          continue

        lua_content = self.generate_lua_content(locale, data_type, items)

        output_file = output_dir / f"{locale}.lua"

        try:
          with open(output_file, "w", encoding="utf-8") as f:
            f.write(lua_content)
          print(f"    Generated {output_file.relative_to(self.base_path)}")
        except Exception as e:
          print(f"    Error writing {output_file}: {e}")

  def run(self) -> None:
    """Main execution function."""
    print("QuestieDB Localization Generator")
    print("=" * 40)

    if not self.input_dir.exists():
      print(f"Error: Input directory {self.input_dir} does not exist")
      print("Expected JSON files in .output/<version>_locales.json format")
      return

    # Find all JSON files matching the pattern
    json_files = list(self.input_dir.glob("*_locales.json"))

    if not json_files:
      print("No localization JSON files found in .output/ directory")
      print("Expected files like: mop-classic_locales.json, cata_locales.json, etc.")
      return

    print(f"Found {len(json_files)} JSON file(s):")
    for json_file in json_files:
      print(f"  - {json_file.name}")
    print()

    # Process each JSON file
    for json_file in json_files:
      self.process_json_file(json_file)
      print()

    print("Localization generation complete!")


def main():
  """Main entry point."""
  # Get the script's directory (should be the QuestieDB root)
  script_dir = Path(__file__).parent.absolute()

  if len(sys.argv) > 1:
    base_path = sys.argv[1]
  else:
    base_path = script_dir

  generator = LocalizationGenerator(base_path)  # type: ignore
  generator.run()


if __name__ == "__main__":
  main()
