## Title: C_LFGList.GetActiveEntryInfo

**Content:**
Returns information about your currently listed group.
`entryData = C_LFGList.GetActiveEntryInfo()`

**Returns:**
- `entryData`
  - *LfgEntryData*
    - `activityID`
      - *number* - The activityID of the group. Use `C_LFGList.GetActivityInfo(activityID)` to get more information about the activity. This field is not present in Classic.
    - `activityIDs`
      - *number* - List of activity IDs for the listed group. This field is exclusive to Classic.
    - `requiredItemLevel`
      - *number* - Item level requirement for applications. Returns 0 if no requirement is set.
    - `requiredHonorLevel`
      - *number* - Honor level requirement for applications.
    - `name`
      - *string* - Protected string.
    - `comment`
      - *string* - Protected string.
    - `voiceChat`
      - *string* - Voice chat specified by group creator. Returns an empty string if no voice chat is specified.
    - `duration`
      - *number* - Expiration time of the group in seconds. Currently starts at 1800 seconds (30 minutes). If no player joins the group within this time, the group is delisted for inactivity.
    - `autoAccept`
      - *boolean* - If new applicants are automatically invited.
    - `privateGroup`
      - *boolean* - Indicates if the group is private.
    - `questID`
      - *number?* - Quest ID associated with the group, if any.
    - `requiredDungeonScore`
      - *number?* - Required dungeon score for applications.
    - `requiredPvpRating`
      - *number?* - Required PvP rating for applications.
    - `playstyle`
      - *Enum.LFGEntryPlaystyle?* - Playstyle of the group.
    - `isCrossFactionListing`
      - *boolean* - Indicates if the group is cross-faction. Added in 9.2.5.

**Enum.LFGEntryPlaystyle:**
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