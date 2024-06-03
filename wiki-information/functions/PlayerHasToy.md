## Title: PlayerHasToy

**Content:**
Determines if player has a specific toy in their toybox.
`hasToy = PlayerHasToy(itemId)`

**Parameters:**
- `itemId`
  - *number* - itemId of a toy.

**Returns:**
- `hasToy`
  - *boolean* - True if player has itemId in their toybox, false if not.

**Usage:**
```lua
if PlayerHasToy(92738) then 
  print('Remember to wear your Safari Hat!'); 
end
```

**Example Use Case:**
This function can be used in addons or macros to check if a player has a specific toy before attempting to use it or reminding the player to use it. For instance, an addon could use this function to ensure that a player has a necessary toy for a particular event or activity.

**Addons Using This Function:**
Many toy management addons, such as "ToyBoxEnhanced," use this function to manage and organize the player's toy collection, providing features like search, categorization, and usage tracking.