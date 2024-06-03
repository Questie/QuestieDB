## Title: C_PetJournal.IsFilterChecked

**Content:**
Returns true if the selected filter is checked.
`isFiltered = C_PetJournal.IsFilterChecked(filter)`

**Parameters:**
- `filter`
  - *number* - Bitfield for each filter
    - `LE_PET_JOURNAL_FILTER_COLLECTED`: Pets you have collected
    - `LE_PET_JOURNAL_FILTER_NOT_COLLECTED`: Pets you have not collected

**Returns:**
- `isFiltered`
  - *boolean* - True if the filter is checked, false if the filter is unchecked

**Reference:**
- `C_PetJournal.SetFilterChecked`