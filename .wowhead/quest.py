import re
from bs4 import BeautifulSoup, Tag
from bs4.element import NavigableString

# Creating a lookup table for "Description", "Progress", and "Completion"

skip_lookup_table = {
  "Guides",
  "Guias",
  "Руководства",
  "Guides",
  "가이드",
  "Guías",
  "指南",
}

lookup_table = {
  # English
  "Description": "Description",
  "Progress": "Progress",
  "Completion": "Completion",
  "Rewards": "Rewards",
  # Portuguese
  "Descrição": "Description",
  "Progresso": "Progress",
  "Completo": "Completion",
  "Recompensas": "Rewards",
  "Ganancias": "Rewards",
  # Russian
  "Описание": "Description",
  "Прогресс": "Progress",
  "Завершено": "Completion",
  "Награды": "Rewards",
  "Дополнительные награды": "Rewards",
  # German
  "Beschreibung": "Description",
  "Fortschritt": "Progress",
  "Vervollständigung": "Completion",
  "Belohnungen": "Rewards",
  # Korean
  "서술": "Description",
  "진행 상황": "Progress",  # "진행 상황" and "보상" both map to "Progress"
  "보상": "Progress",
  "완료": "Completion",  # "완료" and "획득" both map to "Completion"
  "획득": "Completion",
  # Rewards: "보상" is already included in the table, mapping to "Progress".
  # This demonstrates a case where the same word can have multiple meanings based on context.
  # Spanish
  "Descripción": "Description",
  "Progreso": "Progress",
  "Terminación": "Completion",
  # ? REPEATED: "Recompensas": "Rewards",  # Same as in Portuguese
  # ? REPEATED: "Ganancias": "Rewards",  # Same as in Portuguese
  # Chinese
  "描述": "Description",
  "奖励": "Progress",
  "进度": "Progress",
  "收获": "Completion",
  "达成": "Completion",
  # Rewards: "奖励" is already in the table, mapping to "Progress".
  # Similar to Korean, this word has multiple meanings.
  # French
  # ? REPEATED: "Description": "Description",  # Same in English
  "Progrès": "Progress",
  "Achèvement": "Completion",
  "Récompenses": "Rewards",
  "Gains": "Rewards",  # Same as in Spanish
  # Italian
  "Descrizione": "Description",  # AI - HELPED
  "Progressi": "Progress",  # AI - HELPED
  "Completamento": "Completion",  # AI - HELPED
  "Ricompense": "Rewards",  # AI - HELPED
  "Guadagni": "Rewards",  # AI - HELPED
  # Mexican Spanish (esMX)
  # ? REPEATED: "Descripción": "Description",  # AI - HELPED
  # "": "Progress",   # AI - HELPED
  # "Terminación": "Completion",   # AI - HELPED
  # ? REPEATED: "Recompensas": "Rewards",  # AI - HELPED
  # ? REPEATED: "Ganancias": "Rewards",  # AI - HELPED
  # Traditional Chinese (zhTW)   # AI - HELPEDf
  # ? REPEATED: "描述": "Description",  # AI - HELPED
  "進度": "Progress",  # AI - HELPED
  "完成": "Completion",  # AI - HELPED
  "獎勵": "Rewards",  # AI - HELPED
  "收穫": "Rewards",  # AI - HELPED
}


def getQuestSections(locale, data, id, idType="quest"):
  # Use BeautifulSoup to parse the HTML content
  soup = BeautifulSoup(data, "lxml")

  # Remove all script tags
  for script in soup.find_all("script"):
    script.decompose()

  # Find the div with class "text"
  text_div = soup.find("div", class_="text")

  regex_space = re.compile(r" +")
  regex_run = re.compile(r"        [\s\S]+?\/run[\s\S]+?$")

  sections = {}
  # Check if the div was found
  if text_div:
    # Extract the title from the first <h1 class="heading-size-1"> element
    h1_tag = text_div.find("h1", class_="heading-size-1")  # type: ignore
    if h1_tag:
      title = h1_tag.get_text(strip=True)
      # print(f"Title: {title}")
      sections["Title"] = title

      # Extract the text following the <h1> tag until the next non-<a> element
      quest_text = []
      for element in h1_tag.next_siblings:
        if isinstance(element, Tag):
          if element.name != "a":
            break
          quest_text.append(element.get_text())
        elif isinstance(element, NavigableString):
          text = element.strip()
          if text:
            quest_text.append(element)

      # print("Quest Text:", ''.join(quest_text))
      sections["Text"] = "".join(quest_text)
    current_h2_text = None
    current_content = []

    # Iterate over all elements in the div
    for element in text_div.children:  # type: ignore
      if "Rewards" in sections:
        break
      if isinstance(element, Tag):
        if element.name == "h2" and "heading-size-3" in element.get("class", []):  # type: ignore
          # Save previous section if it exists
          if current_h2_text is not None:
            # Break if we have 3 sections
            if len(sections) == 3:
              break
            section_title = lookup_table.get(current_h2_text)
            if section_title is None:
              print(f"Section title is None for ({locale}:'{current_h2_text}') - {idType} {id}")
              with open("problematic_missing_sections.txt", "a", encoding="utf-8") as f:
                f.write(f"{locale}:'{current_h2_text}' - {idType} {id}\n")
            else:
              sections[section_title] = " ".join(current_content)
            current_content = []

          # Update current heading text
          current_h2_text = element.get_text(strip=True)
        elif current_h2_text is not None:
          current_content.append(element.get_text())
      elif isinstance(element, NavigableString) and current_h2_text is not None:
        text = element.strip()
        if text:
          current_content.append(element)

    # Add the last section
    if current_h2_text is not None and len(sections) < 3 and current_h2_text not in skip_lookup_table:
      section_title = lookup_table.get(current_h2_text)
      if section_title is None:
        print(f"Section title is None for ({locale}:'{current_h2_text}') - {idType} {id}")
        with open("problematic_missing_sections.txt", "a", encoding="utf-8") as f:
          f.write(f"{locale}:'{current_h2_text}' - {idType} {id}\n")
      else:
        sections[section_title] = " ".join(current_content)

    for section_title, section_content in sections.items():
      changed = False
      if "/run" in section_content:
        if section_title == "Text":
          print(f"Section: {section_title}")
          print(f"\nContent:\n{section_content}\n")
        section_content = re.sub(regex_run, "", section_content)
        if section_title == "Text":
          print(f"\nFixed Content:\n'''{section_content}'''\n")
        changed = True

      # Remove double spaces
      if "  " in section_content:
        # section_content = re.sub(r"\s+", " ", section_content)
        section_content = re.sub(regex_space, " ", section_content)
        changed = True

      if changed:
        # Remove leading and trailing whitespace
        section_content = section_content.strip()
        # Set the content
        sections[section_title] = section_content

      # Fix parts which contain how to check for completed quests
      # print(f"Section: {section_title}\nContent:\n{section_content}\n")
      # print(section_title)
      # continue
  else:
    print(f"No 'div' with class 'text' found. {idType} {id}")

  return sections
