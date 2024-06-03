## Event: SPELL_UPDATE_USABLE

**Title:** SPELL UPDATE USABLE

**Content:**
This event is fired when a spell becomes "useable" or "unusable".
`SPELL_UPDATE_USABLE`

**Payload:**
- `None`

**Content Details:**
The definition of useable and unusable is somewhat confusing. Firstly, range is not taken into account. Secondly if a spell requires a valid target and doesn't have one it gets marked as useable. If it requires mana or rage and there isn't enough then it gets marked as unusable. This results in the following behaviour:
Start) Feral druid in bear form out of combat, no target selected.
) Target enemy. Event is fired as some spells that require rage become marked as unusable. On the action bar the spell is marked in red as unusable.
) Use Enrage to gain rage. Event is fired as we now have enough rage. On the action bar the spell is marked unusable as out of range.
) Move into range. Event is not fired. On the action bar the spell is marked usable.
) Rage runs out. Event is fired as we no longer have enough rage.
) Remove target. Event is fired and spell is marked as useable on action bar.
It appears that the definition of useable is a little inaccurate and relates more to how it is displayed on the action bar than whether you can use the spell. Also after being attacked the event started firing every two seconds and this continued until well after the attacker was dead. Targetting a fresh enemy seemed to stop it.