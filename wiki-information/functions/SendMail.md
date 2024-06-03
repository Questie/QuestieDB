## Title: SendMail

**Content:**
Sends in-game mail.
`SendMail(recipient, subject)`

**Parameters:**
- `recipient`
  - *string* - Intended recipient of the mail.
- `subject`
  - *string* - Subject of the mail. Cannot be an empty string or nil, but may be whitespace, e.g. " ".
- `body`
  - *string?* - Body of the mail.

**Description:**
Triggers `MAIL_SEND_SUCCESS` if mail was sent to the recipient's inbox, or `MAIL_FAILED` otherwise. Repeated calls to `SendMail()` are ignored until one of these events fire.

**Usage:**
Assuming a friendly player named Bob exists on your server:
```lua
SendMail("Bob", "Hey Bob", "Hows it going, Bob?")
```