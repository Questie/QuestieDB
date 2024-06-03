## Title: ChangeActionBarPage

**Content:**
Changes the current action bar page.
`ChangeActionBarPage(actionBarPage)`

**Parameters:**
- `actionBarPage`
  - *number* - Which page of your action bar to switch to. Expects an integer 1-6.

**Description:**
Notifies the UI that the current action button set has been updated to the current value of the `CURRENT_ACTIONBAR_PAGE` global variable.
Will cause an `ACTIONBAR_PAGE_CHANGED` event to fire only if there was actually a change (tested in 9.0.5).