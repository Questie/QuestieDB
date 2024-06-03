## Event: SPELLS_CHANGED

**Title:** SPELLS CHANGED

**Content:**
Fires when spells in the spellbook change in any way. Can be trivial (e.g.: icon changes only), or substantial (e.g.: learning or unlearning spells/skills).
`SPELLS_CHANGED`

**Payload:**
- `None`

**Content Details:**
In prior game versions, this event also fired every time the player navigated the spellbook (swapped pages/tabs), since that caused UpdateSpells to be called which in turn always triggered a SPELLS_CHANGED event. However, that API has been removed since Patch 4.0.1.

**Related Information:**
AddOn loading process