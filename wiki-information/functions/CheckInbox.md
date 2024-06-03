## Title: CheckInbox

**Content:**
Queries the server for mail.
`CheckInbox()`

**Description:**
This function requires that the mailbox window is open.
After it is called and the inbox populated, the client's stored mailbox information can be accessed from anywhere in the world. That is, functions like `GetInboxHeaderInfo()` and `GetInboxNumItems()` may be called from anywhere. Note that only the *stored* information can be accessed -- to get current inbox info, you have to call `CheckInbox()` again.