## Title: ItemTextGetPage

**Content:**
Returns the page number of the currently displayed page.
`pageNum = ItemTextGetPage()`

**Returns:**
- `pageNum`
  - *number* - The page number of the currently displayed page, starting at 1.

**Description:**
This is used once the `ITEM_TEXT_READY` event has been received for a page.
Note that there is no function to return the total number of pages of the text, it must be found by iterating through until `ItemTextHasNextPage` returns nil.