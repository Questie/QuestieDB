## Title: UnitAura

**Content:**
Returns the buffs/debuffs for the unit.
```lua
name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal,
spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, ...
 = UnitAura(unit, index)
 = UnitBuff(unit, index)
 = UnitDebuff(unit, index)
```

**Parameters:**
- `unit`
  - *string* : UnitId
- `index`
  - *number* - Index of an aura to query.
- `filter`
  - *string?* - A list of filters, separated by pipe chars or spaces. Otherwise defaults to "HELPFUL".

**Miscellaneous:**
- `UnitBuff()` is an alias for `UnitAura(unit, index, "HELPFUL")`, returning only buffs.
- `UnitDebuff()` is an alias for `UnitAura(unit, index, "HARMFUL")`, returning only debuffs.

**Filter Descriptions:**
- `"HELPFUL"`: Buffs
- `"HARMFUL"`: Debuffs
- `"PLAYER"`: Auras/Debuffs applied by the player
- `"RAID"`: Buffs the player can apply and debuffs the player can dispel
- `"CANCELABLE"`: Buffs that can be cancelled with `/cancelaura` or `CancelUnitBuff()`
- `"NOT_CANCELABLE"`: Buffs that cannot be cancelled
- `"INCLUDE_NAME_PLATE_ONLY"`: Auras that should be shown on nameplates
- `"MAW"`: Torghast Anima Powers

**Aura Util:**

**ForEachAura:**
```lua
AuraUtil.ForEachAura(unit, filter, func)
```
This is recommended for iterating over auras. For example, to print all buffs:
```lua
AuraUtil.ForEachAura("player", "HELPFUL", nil, function(name, icon, ...)
    print(name, icon, ...)
end)
```
The callback function should return true once it's fine to stop processing further auras.
```lua
local function foo(name, icon, _, _, _, _, _, _, _, spellId, ...)
    if spellId == 21562 then -- Power Word: Fortitude
        -- do stuff
        return true
    end
end
AuraUtil.ForEachAura("player", "HELPFUL", nil, foo)
```

**FindAuraByName:**
```lua
AuraUtil.FindAuraByName(name, unit)
```
Finds the first aura that matches the name, but note that:
- Aura names are not unique, this will only find the first match.
- Aura names are localized, what works in one locale might not work in another.
```lua
/dump AuraUtil.FindAuraByName("Power Word: Fortitude", "player")
```
Remember to specify the "HARMFUL" filter for debuffs.
```lua
/dump AuraUtil.FindAuraByName("Weakened Soul", "player", "HARMFUL")
```

**Returns:**
Returns nil when there is no aura for that index or when the aura doesn't pass the filter.
1. `name`
   - *string* - The localized name of the aura, otherwise nil if there is no aura for the index.
2. `icon`
   - *number* : FileID - The icon texture.
3. `count`
   - *number* - The amount of stacks, otherwise 0.
4. `dispelType`
   - *string?* - The locale-independent magic type of the aura: Curse, Disease, Magic, Poison, otherwise nil.
5. `duration`
   - *number* - The full duration of the aura in seconds.
6. `expirationTime`
   - *number* - Time the aura expires compared to `GetTime()`, e.g. to get the remaining duration: `expirationTime - GetTime()`
7. `source`
   - *string* : UnitId - The unit that applied the aura.
8. `isStealable`
   - *boolean* - If the aura may be stolen.
9. `nameplateShowPersonal`
   - *boolean* - If the aura should be shown on the player/pet/vehicle nameplate.
10. `spellId`
    - *number* - The spell ID for e.g. `GetSpellInfo()`
11. `canApplyAura`
    - *boolean* - If the player can apply the aura.
12. `isBossDebuff`
    - *boolean* - If the aura was cast by a boss.
13. `castByPlayer`
    - *boolean* - If the aura was applied by a player.
14. `nameplateShowAll`
    - *boolean* - If the aura should be shown on nameplates.
15. `timeMod`
    - *number* - The scaling factor used for displaying time left.
16. `shouldConsolidate`
    - *boolean* - Whether to consolidate auras, only exists in Classic Era/Wrath.
17. `...`
    - Variable returns - Some auras return additional values that typically correspond to something shown in the tooltip, such as the remaining strength of an absorption effect.

**Description:**
- `UnitBuff()` will ignore any HARMFUL filter, and vice versa `UnitDebuff()` will ignore any HELPFUL filter.
- Filters can be mutually exclusive, e.g. "HELPFUL|HARMFUL" will always return nothing.
- On retail, a unit can have an unlimited amount of buffs/debuffs.
- The debuff limit is at 16 for Classic Era and 40 for BCC.

**Related Events:**
- `UNIT_AURA`

**World Buffs:**
If the unit has the buff, then the world buffs can be selected from the return values. For example:
```lua
select(20, UnitBuff("player", index))
```

**Buff Types and Descriptions:**
- `Fengus' Ferocity`
  - *number* - Duration
- `Mol'dar's Moxie`
  - *number* - Duration
- `Slip'kik's Savvy`
  - *number* - Duration
- `Rallying Cry of the Dragonslayer`
  - *number* - Duration
- `Warchief's Blessing`
  - *number* - Duration
- `Spirit of Zandalar`
  - *number* - Duration
- `Songflower Serenade`
  - *number* - Duration
- `Sayge's Fortune`
  - *number* - Duration of the chosen buff
- `Sayge's Fortune`
  - *number* - spellID of the chosen buff
- `Boon of Blackfathom`
  - *number* - Duration
- `Spark of Inspiration`
  - *number* - Duration
- `Fervor of the Temple Explorer`
  - *number* - Duration

**Usage:**
Prints the third aura on the target.
```lua
/dump UnitAura("target", 3)
```
Returns:
- `"Power Word: Fortitude"` -- name
- `135987` -- icon
- `0` -- count
- `"Magic"` -- dispelType
- `3600` -- duration
- `112994.871` -- expirationTime
- `"player"` -- source
- `false` -- isStealable
- `false` -- nameplateShowPersonal
- `21562` -- spellID
- `true` -- canApplyAura
- `false` -- isBossDebuff
- `true` -- castByPlayer
- `false` -- nameplateShowAll
- `1` -- timeMod
- `5` -- attribute1: Stamina increased by 5%
- `0` -- attribute2: Magic damage taken reduced by 0% (Thorghast Enchanted Shroud power)

The following are equivalent. Prints the first debuff applied by the player on the target.
```lua
/dump UnitAura("target", 1, "PLAYER|HARMFUL")
/dump UnitDebuff("target", 1, "PLAYER")
```

`GetPlayerAuraBySpellID()` is useful for checking only a specific aura on the player character.
```lua
/dump GetPlayerAuraBySpellID(21562)
```