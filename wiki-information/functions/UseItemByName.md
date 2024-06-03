## Title: UseItemByName

**Content:**
Uses the specified item.
`UseItemByName(name)`

**Parameters:**
- `name`
  - *string* - name of the item to use.
- `target`
  - *string? : UnitId* - The unit to use the item on, defaults to "target" for items that can be used on others.

**Reference:**
- `UseContainerItem`
- `UseInventoryItem`

**Example Usage:**
```lua
-- Use a health potion on the player
UseItemByName("Health Potion")

-- Use a bandage on the target
UseItemByName("Heavy Runecloth Bandage", "target")
```

**Addons:**
Many large addons, such as **WeakAuras** and **ElvUI**, use `UseItemByName` to automate item usage based on specific conditions or user actions. For example, WeakAuras can trigger the use of a specific item when certain conditions are met, such as low health or a specific buff/debuff being present.