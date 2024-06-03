## Title: C_GossipInfo.GetActiveQuests

**Content:**
Returns the quests which can be turned in at a quest giver.
`info = C_GossipInfo.GetActiveQuests()`

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