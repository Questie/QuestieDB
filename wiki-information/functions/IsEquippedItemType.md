## Title: IsEquippedItemType

**Content:**
Returns true if an item of a given type is equipped.
`isEquipped = IsEquippedItemType(type)`

**Parameters:**
- `type`
  - *string (ItemType)* - any valid inventory type, item class, or item subclass

**Returns:**
- `isEquipped`
  - *boolean* - is an item of the given type equipped

**Usage:**
```lua
if IsEquippedItemType("Shields") then
  DEFAULT_CHAT_FRAME:AddMessage("I have a shield")
end
```
**Result:**
Outputs "I have a shield" to the default chat window if the player has a shield equipped.