## Title: TargetNearestFriend

**Content:**
Targets the nearest friendly unit.
`TargetNearestFriend()`

**Parameters:**
- `reverse`
  - *boolean* - if true, reverses the order of targeting units.

**Example Usage:**
```lua
-- Target the nearest friendly unit
TargetNearestFriend()

-- Target the nearest friendly unit in reverse order
TargetNearestFriend(true)
```

**Description:**
This function is useful in scenarios where you need to quickly target a friendly unit, such as in PvP or PvE situations where healing or buffing allies is critical. By using the `reverse` parameter, you can cycle through friendly units in the opposite order, which can be helpful in crowded environments.

**Addons Using This Function:**
- **HealBot**: A popular healing addon that uses this function to quickly target friendly units for healing spells.
- **Clique**: An addon that allows for click-casting on unit frames, which may use this function to target friendly units efficiently.