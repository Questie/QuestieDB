## Title: GetTrainerServiceDescription

**Content:**
Returns the description of a specific trainer service.
`serviceDescription = GetTrainerServiceDescription(index)`

**Parameters:**
- `index`
  - *number* - The index of the specific trainer service.

**Returns:**
- `serviceDescription`
  - *string* - The description of a specific trainer service. Not readily available on function call, see `SpellMixin:ContinueOnSpellLoad`.

**Usage:**
Prints the description of the trainer service with index 3, in the chat window:
```lua
print(GetTrainerServiceDescription(3))
-- Output: "Permanently enchant a weapon to often deal 20 Nature damage to an enemy damaged by your spells or struck by your melee attacks. Cannot be applied to items higher than level 136."
```