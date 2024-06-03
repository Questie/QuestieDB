## Title: GetCompanionInfo

**Content:**
Returns info for a companion.
`creatureID, creatureName, creatureSpellID, icon, issummoned, mountType = GetCompanionInfo(type, id)`

**Parameters:**
- `type`
  - *string* - Companion type to query: "CRITTER" or "MOUNT".
- `id`
  - *number* - Index of the slot to query. Starting at 1 and going up to `GetNumCompanions("type")`.

**Returns:**
- `creatureID`
  - *number* - The NPC ID of the companion.
- `creatureName`
  - *string* - The name of the companion.
- `creatureSpellID`
  - *number* - The spell ID to cast the companion. This is not passed to `CallCompanion`, but can be used with, e.g., `GetSpellInfo`.
- `icon`
  - *string* - The texture of the icon for the companion.
- `issummoned`
  - *boolean* - 1 if the companion is summoned, nil if it's not.
- `mountType`
  - *number* - Bitfield for air/ground/water mounts
    - 0x1: Ground
    - 0x2: Can fly
    - 0x4: ? (set for most mounts)
    - 0x8: Underwater
    - 0x10: Can jump (turtles cannot)

**Description:**
The indices are unstable: you may not rely on the ("type", id) mapping to the same companion after an arbitrary amount of time, even if the player does not learn/unlearn any companions during the period.
Generally, the indices are ordered alphabetically, though this order may be violated during the initial loading process and upon zoning.

**Reference:**
- `GetNumCompanions`
- `CallCompanion`
- `C_PetJournal` function