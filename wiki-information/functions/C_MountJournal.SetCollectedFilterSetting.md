## Title: C_MountJournal.SetCollectedFilterSetting

**Content:**
Enables or disables the specified mount journal filter.
`C_MountJournal.SetCollectedFilterSetting(filterIndex, isChecked)`

**Parameters:**
- `filterIndex`
  - *number*
    - `Value`
    - `Enum`
    - `Description`
    - `1`
      - `LE_MOUNT_JOURNAL_FILTER_COLLECTED`
    - `2`
      - `LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED`
    - `3`
      - `LE_MOUNT_JOURNAL_FILTER_UNUSABLE`
- `isChecked`
  - *boolean*

**Description:**
Does nothing if the specified ID is not associated with an existing filter.