## Title: C_AzeriteEssence.GetMilestoneInfo

**Content:**
Needs summary.
`info = C_AzeriteEssence.GetMilestoneInfo(milestoneID)`

**Parameters:**
- `milestoneID`
  - *number*

**Returns:**
- `info`
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
        - *number?* (Added in 8.3.0)
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
            - PassiveThreeSlot (Added in 8.3.0)