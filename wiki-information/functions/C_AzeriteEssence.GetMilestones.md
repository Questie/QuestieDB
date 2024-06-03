## Title: C_AzeriteEssence.GetMilestones

**Content:**
Needs summary.
`milestones = C_AzeriteEssence.GetMilestones()`

**Returns:**
- `milestones`
  - *structure* - AzeriteMilestoneInfo
    - `AzeriteMilestoneInfo`
      - `Field`
      - `Type`
      - `Description`
      - `ID`
        - *number*
      - `requiredLevel`
        - *number*
      - `canUnlock`
        - *boolean*
      - `unlocked`
        - *boolean*
      - `rank`
        - *number?* - Added in 8.3.0
      - `slot`
        - *Enum.AzeriteEssenceSlot?*
          - `Enum.AzeriteEssenceSlot`
            - `Value`
            - `Field`
            - `Description`
            - `0`
              - MainSlot
            - `1`
              - PassiveOneSlot
            - `2`
              - PassiveTwoSlot
            - `3`
              - PassiveThreeSlot - Added in 8.3.0