## Title: IsPassiveSpell

**Content:**
Returns true if the specified spell is a passive ability.
`isPassive = IsPassiveSpell(spellId or index, bookType)`

**Parameters:**
- `spellId`
  - *number* - spell ID to query.
- `index`
  - *number* - spellbook slot index, ascending from 1.
- `bookType`
  - *string* - Either BOOKTYPE_SPELL ("spell") or BOOKTYPE_PET ("pet"). "spell" is linked to your General Spellbook tab.

**Returns:**
- `isPassive`
  - *Flag* : 1 if the spell is passive, nil otherwise.

**Description:**
With my Human Paladin, here are the "spells" I found to be Passive:
- Block (Passive)
- Diplomacy (Racial Passive)
- Dodge (Passive)
- Mace Specialization (Passive)
- Parry (Passive)
- Sword Specialization (Passive)
- The Human Spirit (Racial Passive)