import os
import requests
import re


def download_loadDB(version: str) -> str:
  data = requests.get(f"https://raw.githubusercontent.com/mangos{version}/database/refs/heads/master/World/Setup/mangosdLoadDB.sql")
  table_list = []
  if data.status_code == 200:
    tables = re.findall(
      r"-- Table structure for table `locales_.*?`\n--(.*?)--",
      data.text,
      re.DOTALL | re.MULTILINE,
    )
    for table in tables:
      table_list.append(table.strip())

  return "\n".join(table_list)


def download_alterDB(version: str) -> str:
  data = requests.get(f"https://raw.githubusercontent.com/mangos{version}/database/refs/heads/master/Translations/2_Add_NewLocalisationFields.sql")
  if data.status_code == 200:
    return data.text
  return ""


def download_locales(locales: list[str], version: str, output_dir: str) -> None:
  """Downloads locale SQL files from the mangoszero repository."""

  types = [
    # ["CommandHelp"],
    ["Creature", "creature"],
    ["Gameobject", "gameobject"],
    # ["gossip_menu_option"],
    ["Items", "items"],
    ["NpcText", "npctext", "npcText", "Npctext"],
    ["pageText", "pagetext", "PageText", "Pagetext"],
    [
      "points_of_interest",
      "Points_of_interest",
      "Points_Of_Interest",
      "Points_of_Interest",
    ],
    ["Quest", "quest"],
  ]

  base_url = f"https://raw.githubusercontent.com/mangos{version}/database/refs/heads/master/Translations/Translations"

  for locale in locales:
    if locale == "Spanish_South_American" and version != "three":  # Cata uses the full name
      file_locale = "SpanishSA"
    else:
      file_locale = locale

    for type_names in types:
      anySuccess = ""
      for type_name in type_names:
        file_name = f"{file_locale}_{type_name}.sql"
        url = f"{base_url}/{locale}/{file_name}"
        # Create the directory if it doesn't exist
        os.makedirs(os.path.join(output_dir, locale), exist_ok=True)
        # Construct the full output path
        output_path = os.path.join(output_dir, locale, file_name)

        # print(f"Downloading {file_name}")
        try:
          response = requests.get(url)
          response.raise_for_status()  # Raise an exception for bad status codes
          with open(output_path, "w", encoding="utf-8") as file:
            file.write(response.text)
          # print(f"Downloaded {file_name} to {output_path}")
          anySuccess = file_name
          break
        except:
          # print(f"Error downloading trying other file: {file_name}")
          a = 1
      if anySuccess == "":
        print(f"Failed to download {', '.join(type_names)} for locale {version}/{locale}")
        continue
      else:
        print(f"Downloaded locale {version}\t{locale}\t - {anySuccess}")
