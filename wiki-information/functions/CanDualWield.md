## Title: CanDualWield

**Content:**
Returns whether the player can dual wield weapons.
`canDualWield = CanDualWield()`

**Returns:**
- `canDualWield`
  - *boolean* - This returns true if One-Hand weapons can be equipped into both `INVSLOT_MAINHAND` and `INVSLOT_OFFHAND`.

**Description:**
Fury Warriors can dual wield one-hand weapons, and two-hand weapons (or a combination) from the baseline passive.

**Parameters:**
- **Retail:**
  - **Class**
  - **CanDualWield**
  - **IsSpellKnown**
  - **IsPlayerSpell**
    - Rogue
      - ✔️
      - ❌ 674
      - ✔️ 674
    - Hunter
      - ✔️
      - ❌ 674
      - ✔️ 674
    - Demon Hunter
      - ✔️
      - ❌ 674
      - ✔️ 674
    - Frost Death Knight
      - ✔️
      - ❌ 674
      - ✔️ 674
    - Brewmaster Monk
      - ✔️
      - ❌ 674
      - ❌ 674
    - Windwalker Monk
      - ✔️
      - ❌ 674
      - ❌ 674
    - Enhancement Shaman
      - ✔️
      - ❌ 674
      - ❌ 674
    - Fury Warrior
      - ✔️
      - ❌ 674, ✔️ 46917
      - ❌ 674, ✔️ 46917

- **Classic:**
  - **Class**
  - **CanDualWield**
  - **IsSpellKnown**
  - **IsPlayerSpell**
    - Rogue (level 10)
      - ✔️
      - ✔️ 674
      - ✔️ 674
    - Hunter (level 20)
      - ✔️
      - ✔️ 674
      - ✔️ 674
    - Warrior (level 20)
      - ✔️
      - ✔️ 674
      - ✔️ 674

**Reference:**
- `Enum.InventoryType`
- `InventorySlotId`