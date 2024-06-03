## Title: C_QuestInfoSystem.GetQuestRewardSpellInfo

**Content:**
Needs summary.
`info = C_QuestInfoSystem.GetQuestRewardSpellInfo(questID, spellID)`

**Parameters:**
- `questID`
  - *number?*
- `spellID`
  - *number* - Spell Ids from C_QuestInfoSystem.GetQuestRewardSpells

**Returns:**
- `info`
  - *QuestRewardSpellInfo?*
    - `Field`
    - `Type`
    - `Description`
    - `texture`
      - *number* : fileID
    - `name`
      - *string*
    - `garrFollowerID`
      - *number?*
    - `isTradeskill`
      - *boolean*
    - `isSpellLearned`
      - *boolean*
    - `hideSpellLearnText`
      - *boolean*
    - `isBoostSpell`
      - *boolean*
    - `genericUnlock`
      - *boolean*
    - `type`
      - *Enum.QuestCompleteSpellType*
        - `Enum.QuestCompleteSpellType`
          - `Value`
          - `Field`
          - `Description`
          - `0`
            - LegacyBehavior
          - `1`
            - Follower
          - `2`
            - Tradeskill
          - `3`
            - Ability
          - `4`
            - Aura
          - `5`
            - Spell
          - `6`
            - Unlock
          - `7`
            - Companion