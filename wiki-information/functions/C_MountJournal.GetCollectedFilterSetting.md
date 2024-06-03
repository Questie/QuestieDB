## Title: C_MountJournal.GetCollectedFilterSetting

**Content:**
Indicates whether the specified mount journal filter is enabled.
`isChecked = C_MountJournal.GetCollectedFilterSetting(filterIndex)`

**Parameters:**
- `filterIndex`
  - *number*
    - **Value** | **Enum** | **Description**
    - `1` | `LE_MOUNT_JOURNAL_FILTER_COLLECTED`
    - `2` | `LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED`
    - `3` | `LE_MOUNT_JOURNAL_FILTER_UNUSABLE`

**Returns:**
- `isChecked`
  - *boolean* - true if the filter is enabled (mounts matching the filter are displayed), or false if the filter is disabled (mounts matching the filter are hidden)

**Description:**
Returns true if the specified ID is not associated with an existing filter.