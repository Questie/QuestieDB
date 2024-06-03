## Title: C_GossipInfo.GetAvailableQuests

**Content:**
Returns the available quests at a quest giver.
`info = C_GossipInfo.GetAvailableQuests()`

**Returns:**
- `info`
  - *GossipQuestUIInfo*
    - `Field`
    - `Type`
    - `Description`
    - `title`
      - *string*
    - `questLevel`
      - *number*
    - `isTrivial`
      - *boolean*
    - `frequency`
      - *number?*
    - `repeatable`
      - *boolean?*
    - `isComplete`
      - *boolean?*
    - `isLegendary`
      - *boolean*
    - `isIgnored`
      - *boolean*
    - `questID`
      - *number*

**Description:**
Available quests are quests that the player does not yet have in their quest log.
This list is available after `GOSSIP_SHOW` has fired.