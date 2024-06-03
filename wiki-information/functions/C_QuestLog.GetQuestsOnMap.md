## Title: C_QuestLog.GetQuestsOnMap

**Content:**
Needs summary.
`quests = C_QuestLog.GetQuestsOnMap(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `quests`
  - *QuestOnMapInfo* - a table containing the following fields:
    - `Field`
    - `Type`
    - `Description`
    - `questID`
      - *number*
    - `x`
      - *number*
    - `y`
      - *number*
    - `type`
      - *number*
    - `isMapIndicatorQuest`
      - *boolean*

**Example Usage:**
This function can be used to retrieve a list of quests available on a specific map. For instance, an addon could use this to display all quests on the player's current map, allowing for a more interactive and informative map interface.

**Addon Usage:**
Large addons like **Questie** use this function to populate the world map with available quests, providing players with visual indicators of where they can pick up new quests. This enhances the questing experience by making it easier to find and track quests.