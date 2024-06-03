## Title: ItemTextPrevPage

**Content:**
Moves to the previous page of the item text.
`ItemTextPrevPage()`

**Description:**
This simply requests the previous page, you will receive an `ITEM_TEXT_READY` event when the new page is ready.
Try only to call this after receiving an `ITEM_TEXT_READY` event for the current page, and don't call it IN the event handler for that event, things get a little odd (Looks like a synchronization issue in the client) and your page cache might get corrupted.
Does nothing if called while viewing the first page.