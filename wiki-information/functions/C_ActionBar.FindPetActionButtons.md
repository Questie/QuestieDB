## Title: C_ActionBar.FindPetActionButtons

**Content:**
Needs summary.
`slots = C_ActionBar.FindPetActionButtons(petActionID)`

**Parameters:**
- `petActionID`
  - *number*

**Returns:**
- `slots`
  - *number*

**Description:**
This function is used to find the action bar slots associated with a specific pet action. It returns the slot number where the pet action is located.

**Example Usage:**
```lua
local petActionID = 1 -- Example pet action ID
local slot = C_ActionBar.FindPetActionButtons(petActionID)
print("Pet action is located in slot:", slot)
```

**Addons:**
Large addons like Bartender4 and Dominos use this function to manage and customize pet action bars, allowing players to rearrange and configure their pet abilities more effectively.