## Title: GetShapeshiftFormID

**Content:**
Returns the ID of the form or stance the player is currently in.
`index = GetShapeshiftFormID()`

**Returns:**
- `index`
  - *number* - one of the following:
    - **All**
      - `nil` = humanoid form
    - **Druid**
      - Aquatic Form - 4
      - Bear Form - 5 (BEAR_FORM constant)
      - Cat Form - 1 (CAT_FORM constant)
      - Flight Form - 29
      - Moonkin Form - 31 - 35 (MOONKIN_FORM constant) (different races seem to have different numbers)
      - Swift Flight Form - 27
      - Travel Form - 3
      - Tree of Life - 2
      - Treant Form - 36
    - **Monk**
      - Stance of the Fierce Tiger - 24
      - Stance of the Sturdy Ox - 23
      - Stance of the Wise Serpent - 20
    - **Rogue**
      - Stealth - 30
    - **Shaman**
      - Ghost Wolf - 16
    - **Warlock**
      - Metamorphosis - 22
    - **Warrior**
      - Battle Stance - 17
      - Berserker Stance - 19
      - Defensive Stance - 18

**Description:**
Similar to the function `GetShapeshiftForm(flag)`, except the values returned are constant and not dependent on forms available to the unit or current class.