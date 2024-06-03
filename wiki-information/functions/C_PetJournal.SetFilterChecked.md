## Title: C_PetJournal.SetFilterChecked

**Content:**
Sets the filters in the filter menu.
`C_PetJournal.SetFilterChecked(filter, value)`

**Parameters:**
- `filter`
  - *number* - Bitfield for each filter
    - `LE_PET_JOURNAL_FILTER_COLLECTED`: Pets you have collected
    - `LE_PET_JOURNAL_FILTER_NOT_COLLECTED`: Pets you have not collected
- `value`
  - *boolean* - True to set the filter, false to clear the filter

**Reference:**
- `C_PetJournal.IsFilterChecked`