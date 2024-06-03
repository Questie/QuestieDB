## Title: C_Traits.GetTraitSystemFlags

**Content:**
Returns flags for "Generic Trait" trees, such as dragonriding talents. Not related to player talent trees.
`flags = C_Traits.GetTraitSystemFlags(configID)`

**Parameters:**
- `configID`
  - *number*

**Returns:**
- `flags`
  - *number* - See `Enum.TraitSystemFlag`

**Description:**
This function is used to retrieve flags associated with generic trait systems, which are different from the player talent trees. An example of such a system is the dragonriding talents. The flags returned can be used to determine specific properties or states of the trait system.

**Example Usage:**
```lua
local configID = 12345 -- Example config ID for a dragonriding talent tree
local flags = C_Traits.GetTraitSystemFlags(configID)
print(flags) -- Outputs the flags associated with the given config ID
```

**Addons:**
Large addons that manage or enhance talent systems, such as WeakAuras or ElvUI, might use this function to display or modify information related to generic trait systems like dragonriding talents.