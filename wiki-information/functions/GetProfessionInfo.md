## Title: GetProfessionInfo

**Content:**
Gets details on a profession from its index including name, icon, and skill level.
`name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(index)`

**Parameters:**
- `index`
  - *number* - The skillLineIDs from GetProfessions

**Returns:**
- `name`
  - *string* - The localized skill name
- `icon`
  - *string* - the location of the icon image
- `skillLevel`
  - *number* - the current skill level
- `maxSkillLevel`
  - *number* - the current skill cap (75 for apprentice, 150 for journeyman etc.)
- `numAbilities`
  - *number* - The number of abilities/icons listed. These are the icons you put on your action bars.
- `spelloffset`
  - *number* - The offset id of the first Spell of this profession. (you can `CastSpell(spelloffset + 1, "Spell")` to use the first spell of this profession)
- `skillLine`
  - *number* - Reference to the profession.
- `skillModifier`
  - *number* - Additional modifiers to your profession levels. IE: Lures for Fishing.
- `specializationIndex`
  - *number* - A value indicating which specialization is known (ie. Transmute specialist for Alchemist)
- `specializationOffset`
  - *number* - Haven't figured this one out yet

**Description:**
This also seems to return some kind of data on the talent trees and guild perks.