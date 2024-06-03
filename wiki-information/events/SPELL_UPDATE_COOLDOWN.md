## Event: SPELL_UPDATE_COOLDOWN

**Title:** SPELL UPDATE COOLDOWN

**Content:**
This event is fired immediately whenever you cast a spell, as well as every second while you channel spells.
`SPELL_UPDATE_COOLDOWN`

**Payload:**
- `None`

**Content Details:**
The spell you cast doesn't need to have any explicit "cooldown" of its own, since this event also triggers off of anything that incurs a GCD (global cooldown). In other words, it basically fires whenever you cast any spell or channel any spell.
(It may possibly even trigger from spells that are "off the GCD" and which don't have any cooldown of their own; but there's no way to verify that, since all spells in game that are "off the GCD" are special class "burst" abilities with long cooldowns.)
It's worth noting that this event does NOT fire when spells finish their cooldown!

**Usage:**
Whenever you cast a spell, this event triggers twice in a row. Most likely to signal that a spell cast has begun, and then to signal that the GCD has been triggered.
When a hunter auto-shoots, they're actually casting the "Auto Shot" spell (which repeatedly auto-casts itself until cancelled, and has a cooldown of its own, but is otherwise completely "off the GCD" and doesn't trigger the GCD at all when it's cast/shooting/aborted). So every time the hunter shoots a projectile, this event will fire to signal that the "Auto Shot" spell has begun its internal cooldown. Note that this behavior is unique to "Auto Shot"; and that the regular melee spell "Attack" (or melee swings) do NOT trigger this event.
Furthermore, any channeled spells will fire this event once per second while the channeling is ongoing. As an example, if you cast Volley, this event first fires once to signal that a spell with a cooldown (Volley) has been cast. Then it immediately fires again to signal that channeling of Volley has begun. And after that, it fires every second while the channeling is ongoing.

**Related Information:**
GetSpellCooldown