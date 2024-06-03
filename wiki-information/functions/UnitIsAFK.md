## Title: UnitIsAFK

**Content:**
Returns true if a friendly unit is AFK (Away from keyboard).
`isAFK = UnitIsAFK(unit)`

**Parameters:**
- `unit`
  - The UnitId to return AFK status of. A nil value throws an error.

**Returns:**
- `isAFK`
  - *boolean* - true if unit is AFK, false otherwise. An invalid or nonexistent unit value also returns false.

**Usage:**
If the player is AFK, the following script outputs "You are AFK" to the default chat window.
```lua
if UnitIsAFK("player") then
  DEFAULT_CHAT_FRAME:AddMessage("You are AFK");
end
```

If the player is AFK, the following script outputs "You are AFK" to the default chat window.
```lua
if UnitIsAFK("player") then
  DEFAULT_CHAT_FRAME:AddMessage("You are AFK");
end
```