## Title: GetActionInfo

**Content:**
Returns info for an action.
`actionType, id, subType = GetActionInfo(slot)`

**Parameters:**
- `slot`
  - *number* - Action slot to retrieve information about.

**Returns:**
- `actionType`
  - *string* - Type of action button. (e.g. spell, item, macro, companion, equipmentset, flyout)
- `id`
  - *Mixed* - Appropriate identifier for the action specified by actionType -- e.g. spell IDs for spells, item IDs for items, equipment set names for equipment sets.
- `subType`
  - *Mixed* - Additional identifier for the action specified by actionType -- e.g. whether the companion ID is for a MOUNT or a CRITTER companion.

**Usage:**
```lua
local actionType, id, subType = GetActionInfo(1);
if (actionType == "companion" and subType == "MOUNT") then
    print("Button 1 is a mount:", GetSpellLink(id))
end
```

**Example Use Case:**
This function can be used to determine what type of action is assigned to a specific action bar slot. For instance, if you want to check if a particular slot is assigned to a mount, you can use this function to retrieve the action type and subtype, and then perform actions based on that information.

**Addons Using This Function:**
Many popular addons like Bartender4 and Dominos use `GetActionInfo` to manage and customize action bars. These addons rely on this function to retrieve and display the correct icons and tooltips for the actions assigned to each slot.