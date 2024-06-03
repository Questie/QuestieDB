## Title: UnitName

**Content:**
Returns the name and realm of the unit.
```lua
name, realm = UnitName(unit)
name, realm = UnitFullName(unit)
name, realm = UnitNameUnmodified(unit)
```

**Parameters:**
- `unit`
  - *string* : UnitId - For example "player" or "target"

**Returns:**
- `name`
  - *string?* - The name of the unit. Returns nil if the unit doesn't exist, e.g. the player has no target selected.
- `realm`
  - *string?* - The normalized realm the unit is from, e.g. "DarkmoonFaire". Returns nil if the unit is from the same realm.

**Description:**
Will return globalstring `UNKNOWNOBJECT` "Unknown Entity" if called before the unit in question has been fully loaded into the world.
The unit name will change if the unit is under the effects of or a similar effect, but `UnitNameUnmodified()` is unaffected by this.

**Usage:**
Prints your character's name.
```lua
/dump UnitName("player") -- "Leeroy", nil
```
Prints the name and realm of your target (if different).
```lua
/dump UnitName("target") -- "Thegnome", "DarkmoonFaire"
```
`UnitFullName()` is equivalent with `UnitName()` except it will always return realm if used with the "player" UnitId.
```lua
/dump UnitFullName("player") -- "Leeroy", "MoonGuard"
/dump UnitFullName("target") -- "Leeroy", nil
```

**Miscellaneous:**
`GetUnitName(unit, showServerName)` can return the combined unit and realm name.
- If `showServerName` is true and the queried unit is from a different server, then the return value will include the unit's name appended by a dash and the normalized realm name.
- If `showServerName` is false, then `FOREIGN_SERVER_LABEL` " (*)" will be appended to units from coalesced realms. Units from the player's own realm or Connected Realms get no additional suffix.

Examples:
- Unit is from the same realm.
  ```lua
  /dump GetUnitName("target", true) -- "Nephertiri"
  /dump GetUnitName("target", false) -- "Nephertiri"
  ```
- Unit is from a different realm but the same Connected Realm (`LE_REALM_RELATION_VIRTUAL`).
  ```lua
  /dump GetUnitName("target", true) -- "Standron-EarthenRing"
  /dump GetUnitName("target", false) -- "Standron"
  ```
- Unit is from a different, non-connected realm (`LE_REALM_RELATION_COALESCED`).
  ```lua
  /dump GetUnitName("target", true) -- "Celturio-Quel'Thalas"
  /dump GetUnitName("target", false) -- "Celturio (*)"
  ```

**Reference:**
- `Ambiguate()`