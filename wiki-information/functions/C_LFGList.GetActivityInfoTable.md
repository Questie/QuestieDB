## Title: C_LFGList.GetActivityInfoTable

**Content:**
Needs summary.
`activityInfo = C_LFGList.GetActivityInfoTable(activityID)`

**Parameters:**
- `activityID`
  - *number*
- `questID`
  - *number?*
- `showWarmode`
  - *boolean?*

**Returns:**
- `activityInfo`
  - *GroupFinderActivityInfo*
    - `Field`
    - `Type`
    - `Description`
    - `fullName`
      - *string*
    - `shortName`
      - *string*
    - `categoryID`
      - *number*
    - `groupFinderActivityGroupID`
      - *number*
    - `ilvlSuggestion`
      - *number*
    - `filters`
      - *number*
    - `minLevel`
      - *number*
    - `maxNumPlayers`
      - *number*
    - `displayType`
      - *Enum.LFGListDisplayType*
    - `orderIndex`
      - *number*
    - `useHonorLevel`
      - *boolean*
    - `showQuickJoinToast`
      - *boolean*
    - `isMythicPlusActivity`
      - *boolean*
    - `isRatedPvpActivity`
      - *boolean*
    - `isCurrentRaidActivity`
      - *boolean*
    - `isPvpActivity`
      - *boolean*
    - `isMythicActivity`
      - *boolean*
    - `allowCrossFaction`
      - *boolean*
      - *Added in 9.2.5*
    - `useDungeonRoleExpectations`
      - *boolean*
      - *Added in 10.0.0*

**Enum.LFGListDisplayType:**
- `Value`
- `Field`
- `Description`
- `0`
  - *RoleCount*
- `1`
  - *RoleEnumerate*
- `2`
  - *ClassEnumerate*
- `3`
  - *HideAll*
- `4`
  - *PlayerCount*
- `5`
  - *Comment*
  - *Added in 10.0.0*