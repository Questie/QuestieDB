## Title: TakeInboxMoney

**Content:**
Take the attached money from the mailbox message at index.
`TakeInboxMoney(index)`

**Parameters:**
- `index`
  - *number* - a number representing a message in the inbox

**Usage:**
```lua
for i = GetInboxNumItems(), 1, -1 do
  TakeInboxMoney(i); -- BUG IN CHINA GAME. if number > 1, takeInboxMoney(N) = InboxMoney(1);
end;
```

**Example Use Case:**
This function can be used in an addon that automates the process of collecting gold from mailbox messages, such as an auction house addon that retrieves earnings from sold items.

**Addon Usage:**
Large addons like "TradeSkillMaster" use similar functions to automate mailbox operations, ensuring that users can efficiently manage their auction house transactions by quickly collecting gold and items from their mailbox.