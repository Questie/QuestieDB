## Title: UseAction

**Content:**
Perform the action in the specified action slot.
`UseAction(slot)`

**Parameters:**
- `slot`
  - *number* - The action slot to use.
- `checkCursor`
  - *Flag (optional)* - Can be 0, 1, or nil. Appears to indicate whether the action button was clicked (1) or used via hotkey (0); probably involved in placing skills/items in the action bar after they've been picked up. If you pass 0 for checkCursor, it will use the action regardless of whether another item/skill is on the cursor. If you pass 1 for checkCursor, it will replace the spell/action on the slot with the new one.
- `onSelf`
  - *Flag (optional)* - Can be 0, 1, or nil. If present and 1, then the action is performed on the player, not the target. If "true" is passed instead of 1, Blizzard produces a Lua error.

**Reference:**
- `GetActionInfo`

**Example Usage:**
```lua
-- Use the action in slot 1
UseAction(1)

-- Use the action in slot 1, ensuring it replaces the current action if something is on the cursor
UseAction(1, 1)

-- Use the action in slot 1 on the player
UseAction(1, nil, 1)
```

**Addons:**
Many large addons, such as Bartender4 and Dominos, use `UseAction` to manage and execute actions from custom action bars. These addons provide enhanced customization and functionality for action bars, allowing players to configure their UI to better suit their playstyle.