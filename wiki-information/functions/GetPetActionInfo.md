## Title: GetPetActionInfo

**Content:**
Returns info for an action on the pet action bar.
`name, texture, isToken, isActive, autoCastAllowed, autoCastEnabled, spellID, checksRange, inRange = GetPetActionInfo(index)`

**Parameters:**
- `index`
  - *number* - The index of the pet action button you want to query.

**Returns:**
- `name`
  - *string* - The name of the action (or its global ID if isToken is true).
- `texture`
  - *string* - The name (or its global ID, if isToken is true) of the texture for the action.
- `isToken`
  - *boolean* - Indicates if the action is a reference to a global action, or not (guess).
- `isActive`
  - *boolean* - Returns true if the ability is currently active.
- `autoCastAllowed`
  - *boolean* - Returns true if this ability can use autocast.
- `autoCastEnabled`
  - *boolean* - Returns true if autocast is currently enabled for this ability.
- `spellID`
  - *number* - Returns the spell ID associated with this ability.
- `checksRange`
  - *boolean* - Returns true if this ability has a numeric range requirement.
- `inRange`
  - *boolean* - Returns true if this ability is currently in range.

**Description:**
Information based on a post from Sarf plus some guesswork, so may not be 100% accurate.