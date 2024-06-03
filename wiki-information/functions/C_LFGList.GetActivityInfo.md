## Title: C_LFGList.GetActivityInfo

**Content:**
Returns information about an activity for premade groups.
`fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType, orderIndex, useHonorLevel, showQuickJoinToast, isMythicPlusActivity, isRatedPvpActivity, isCurrentRaidActivity = C_LFGList.GetActivityInfo(activityID)`

**Parameters:**
- `activityID`
  - *number* : GroupFinderActivity.ID - The activityID for which information is requested, as returned by `C_LFGList.GetAvailableActivities()`.

**Returns:**
- `fullName`
  - *string* - Full name of the activity.
- `shortName`
  - *string* - Short name of the activity, for example just "World Bosses" instead of the fullName "World Bosses (Pandaria)".
- `categoryID`
  - *number* - The categoryID of this activity, as returned by `C_LFGList.GetAvailableCategories()`.
- `groupID`
  - *number* - The groupID of this activity, as returned by `C_LFGList.GetAvailableActivityGroups()`.
- `itemLevel`
  - *number* - Minimum item level required for this activity. Returns 0 if no requirement.
- `filters`
  - *number* - Bit mask of filters for this activity. See details.
- `minLevel`
  - *number* - Minimum level required for this activity.
- `maxPlayers`
  - *number* - Maximum number of players allowed for this activity.
- `displayType`
  - *number* - The display type ID for this activity. See details.
- `orderIndex`
  - *number* - How the activity is ordered. See details.
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

**Description:**
**DisplayType:**
The display type determines how the current size of a group is displayed in the list. This number ranges from 1 to NUM_LE_LFG_LIST_DISPLAY_TYPES:
- `LE_LFG_LIST_DISPLAY_TYPE_ROLE_COUNT`
  - *1* - Display how many of each class role are present in the group. This is used for custom groups, for example.
- `LE_LFG_LIST_DISPLAY_TYPE_ROLE_ENUMERATE`
  - *2* - Each present and each missing player in the group is depicted with a role icon. This is used for 5-man dungeons, for example.
- `LE_LFG_LIST_DISPLAY_TYPE_CLASS_ENUMERATE`
  - *3* - ?
- `LE_LFG_LIST_DISPLAY_TYPE_HIDE_ALL`
  - *4* - Hide all group size indicators.
- `LE_LFG_LIST_DISPLAY_TYPE_PLAYER_COUNT`
  - *5* - Only display the total number of players in the group. This is used for questing groups, for example.

**ActivityOrder:**
Please add any available information to this section.

**Miscellaneous:**
**Filters:**
Please add any available information to this section.
- `LE_LFG_LIST_FILTER_RECOMMENDED`
  - *1* - ?
- `LE_LFG_LIST_FILTER_NOT_RECOMMENDED`
  - *2* - ?
- `LE_LFG_LIST_FILTER_PVE`
  - *4* - ?
- `LE_LFG_LIST_FILTER_PVP`
  - *8* - ?