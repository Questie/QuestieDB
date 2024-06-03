## Title: C_LFGList.GetSearchResultInfo

**Content:**
Needs summary.
`searchResultData = C_LFGList.GetSearchResultInfo(searchResultID)`

**Parameters:**
- `searchResultID`
  - *number*

**Returns:**
- `searchResultData`
  - *LfgSearchResultData*
    - `Field`
    - `Type`
    - `Description`
    - `searchResultID`
      - *number*
    - `activityID`
      - *number* - Activity ID for the found group. This field is not present in Classic.
    - `activityIDs`
      - *number* - List of activity IDs for the found group. This field is exclusive to Classic.
    - `leaderName`
      - *string?*
    - `name`
      - *string* - Protected string
    - `comment`
      - *string* - Protected string
    - `voiceChat`
      - *string*
    - `requiredItemLevel`
      - *number*
    - `requiredHonorLevel`
      - *number*
    - `hasSelf`
      - *boolean* - Added in 10.0.0
    - `numMembers`
      - *number*
    - `numBNetFriends`
      - *number*
    - `numCharFriends`
      - *number*
    - `numGuildMates`
      - *number*
    - `isDelisted`
      - *boolean*
    - `autoAccept`
      - *boolean*
    - `isWarMode`
      - *boolean*
    - `age`
      - *number*
    - `questID`
      - *number?*
    - `leaderOverallDungeonScore`
      - *number?*
    - `leaderDungeonScoreInfo`
      - *BestDungeonScoreMapInfo?*
    - `leaderPvpRatingInfo`
      - *PvpRatingInfo?*
    - `requiredDungeonScore`
      - *number?*
    - `requiredPvpRating`
      - *number?*
    - `playstyle`
      - *Enum.LFGEntryPlaystyle?*
    - `crossFactionListing`
      - *boolean?* - Added in 9.2.5
    - `leaderFactionGroup`
      - *number* - Added in 9.2.5

**BestDungeonScoreMapInfo**
- `Field`
- `Type`
- `Description`
- `mapScore`
  - *number*
- `mapName`
  - *string*
- `bestRunLevel`
  - *number*
- `finishedSuccess`
  - *boolean*

**PvpRatingInfo**
- `Field`
- `Type`
- `Description`
- `bracket`
  - *number*
- `rating`
  - *number*
- `activityName`
  - *string*
- `tier`
  - *number*

**Enum.LFGEntryPlaystyle**
- `Value`
- `Field`
- `Description`
- `0`
  - None
- `1`
  - Standard
- `2`
  - Casual
- `3`
  - Hardcore