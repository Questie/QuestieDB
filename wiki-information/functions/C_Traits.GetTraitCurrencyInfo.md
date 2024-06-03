## Title: C_Traits.GetTraitCurrencyInfo

**Content:**
Returns meta information about a TraitCurrency. Use `C_Traits.GetTreeCurrencyInfo` if you're looking for TraitCurrency spent/available instead.
```lua
flags, type, currencyTypesID, icon = C_Traits.GetTraitCurrencyInfo(traitCurrencyID)
```

**Parameters:**
- `traitCurrencyID`
  - *number*

**Returns:**
- `flags`
  - *number* - any combination of bit flags of `Enum.TraitCurrencyFlag`
- `type`
  - *Enum.TraitCurrencyFlag* - indicates how the TraitCurrency is sourced
- `currencyTypesID`
  - *number?* - CurrencyID, if non-empty, the TraitCurrency is directly linked to the specified Currency
- `icon`
  - *number?* - IconID

**Enum.TraitCurrencyFlag:**
- `Value`
- `Field`
- `Description`
  - `0x1`
    - `ShowQuantityAsSpent`
    - Currently not used by any TraitCurrency
  - `0x2`
    - `TraitSourcedShowMax`
    - Currently not used by any TraitCurrency
  - `0x4`
    - `UseClassIcon`
    - Currently, all currencies with this flag are TalentTree class talent points
  - `0x8`
    - `UseSpecIcon`
    - Currently, all currencies with this flag are TalentTree spec talent points

**Enum.TraitCurrencyType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - `Gold`
    - Currency used is gold
  - `1`
    - `CurrencyTypesBased`
    - TraitCurrencies of this type will spend regular CurrencyID, see `currencyTypesID` return value
  - `2`
    - `TraitSourced`
    - This TraitCurrency can be earned through being above a certain level (e.g. for talent points), earning achievements (e.g. for some profession unlocks, or dragon riding), or by spending points in another TraitNode (e.g. profession unlocks). See `TraitCurrencySource.db2`