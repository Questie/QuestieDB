## Title: HasPetUI

**Content:**
Returns true if the player currently has an active (hunter) pet out.
`hasUI, isHunterPet = HasPetUI()`

**Returns:**
- `hasUI`
  - *boolean* - True if the player has a pet User Interface, False if he does not.
- `isHunterPet`
  - *boolean* - True if the pet is a hunter pet, False if it is not.

**Usage:**
```lua
local hasUI, isHunterPet = HasPetUI();
if hasUI then
  if isHunterPet then
    DoHunterPetStuff(); -- For hunters
  else
    DoMinionStuff(); -- For Warlock minions
  end
end
```

**Example Use Case:**
This function can be used to determine if a player has a pet UI active and whether the pet is a hunter pet or another type of minion. This is particularly useful for addons that need to differentiate between hunter pets and other types of pets, such as warlock minions, to execute specific code based on the type of pet.

**Addon Usage:**
Large addons like **ElvUI** and **Bartender4** use this function to manage pet action bars and pet-related UI elements. For example, ElvUI uses it to show or hide pet action bars based on whether the player has a pet out and if it is a hunter pet.