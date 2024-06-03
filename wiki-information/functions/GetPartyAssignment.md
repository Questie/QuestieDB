## Title: GetPartyAssignment

**Content:**
Returns true if a group member is assigned the main tank/assist role.
`isAssigned = GetPartyAssignment(assignment)`

**Parameters:**
- `assignment`
  - *string* - The role to search, either "MAINTANK" or "MAINASSIST" (not case-sensitive).
- `raidmember`
  - *string* - UnitId
- `exactMatch`
  - *boolean*

**Returns:**
- `isAssigned`
  - *boolean*

**Example Usage:**
```lua
local isMainTank = GetPartyAssignment("MAINTANK", "player")
if isMainTank then
    print("You are the main tank!")
else
    print("You are not the main tank.")
end
```

**Addons Using This Function:**
- **Deadly Boss Mods (DBM):** Utilizes this function to determine and announce the roles of players during raid encounters.
- **Grid:** Uses this function to display role-specific indicators on the unit frames.