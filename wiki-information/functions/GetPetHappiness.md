## Title: GetPetHappiness

**Content:**
Returns the pet's happiness, damage percentage, and loyalty gain rate.
`happiness, damagePercentage, loyaltyRate = GetPetHappiness()`

**Returns:**
- `happiness`
  - *number* - the numerical happiness value of the pet (1 = unhappy, 2 = content, 3 = happy)
- `damagePercentage`
  - *number* - damage modifier, happiness affects this (unhappy = 75%, content = 100%, happy = 125%)
- `loyaltyRate`
  - *number* - the rate at which your pet is currently gaining loyalty (< 0, losing loyalty, > 0, gaining loyalty)

**Usage:**
```lua
local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
if not happiness then
    print("No Pet")
else
    local happy = ({"Unhappy", "Content", "Happy"})
    local loyalty = loyaltyRate > 0 and "gaining" or "losing"
    print("Pet is " .. happy[happiness])
    print("Pet is doing " .. damagePercentage .. "% damage")
    print("Pet is " .. loyalty .. " loyalty")
end
```

**Example Use Case:**
This function can be used in a Hunter's pet management addon to display the pet's current happiness and loyalty status, which can affect the pet's performance in combat.

**Addons Using This Function:**
- **PetTracker:** This addon uses `GetPetHappiness` to provide detailed information about the player's pet, including its happiness and loyalty status, which can be crucial for maintaining optimal pet performance.