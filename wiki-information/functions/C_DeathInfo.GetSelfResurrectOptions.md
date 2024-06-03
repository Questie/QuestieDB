## Title: C_DeathInfo.GetSelfResurrectOptions

**Content:**
Returns self resurrect options for your character, including from soulstones.
`options = C_DeathInfo.GetSelfResurrectOptions()`

**Returns:**
- `options`
  - *structure* - SelfResurrectOption
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `optionType`
      - *Enum.SelfResurrectOptionType*
    - `id`
      - *number*
    - `canUse`
      - *boolean*
    - `isLimited`
      - *boolean*
    - `priority`
      - *number*

**Enum.SelfResurrectOptionType:**
- `Value`
  - `Field`
  - `Description`
  - `0`
    - Spell
  - `1`
    - Item