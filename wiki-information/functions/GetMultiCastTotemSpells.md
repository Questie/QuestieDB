## Title: GetMultiCastTotemSpells

**Content:**
Returns a list of valid spells for a totem bar slot.
`totem1, totem2, totem3, totem4, totem5, totem6, totem7 = GetMultiCastTotemSpells(slot)`

**Parameters:**
- `slot`
  - *number* - The totem bar slot number:
    - Call of the Elements
      - 133 - Fire
      - 134 - Earth
      - 135 - Water
      - 136 - Air
    - Call of the Ancestors
      - 137 - Fire
      - 138 - Earth
      - 139 - Water
      - 140 - Air
    - Call of the Spirits
      - 141 - Fire
      - 142 - Earth
      - 143 - Water
      - 144 - Air

**Returns:**
- `totem1`
  - *number* - The spell Id of the first valid spell for the slot
- `totem2`
  - *number* - The spell Id of the second valid spell for the slot
- `totem3`
  - *number* - The spell Id of the third valid spell for the slot
- `totem4`
  - *number* - The spell Id of the fourth valid spell for the slot
- `totem5`
  - *number* - The spell Id of the fifth valid spell for the slot
- `totem6`
  - *number* - The spell Id of the sixth valid spell for the slot
- `totem7`
  - *number* - The spell Id of the seventh valid spell for the slot

**Usage:**
```lua
totem1, totem2, totem3, totem4, totem5, totem6, totem7 = GetMultiCastTotemSpells(134)
totem1, totem2, totem3, totem4, totem5, totem6, totem7 = GetMultiCastTotemSpells(134)
```

**Miscellaneous:**
Result:
A list of spell ids that can go in totem bar slot number 134. Slot 134 is the Earth slot for the Call of the Elements spell.