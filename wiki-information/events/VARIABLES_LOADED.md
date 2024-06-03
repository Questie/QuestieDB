## Event: VARIABLES_LOADED

**Title:** VARIABLES LOADED

**Content:**
Fired in response to the CVars, Keybindings and other associated "Blizzard" variables being loaded.
`VARIABLES_LOADED`

**Payload:**
- `None`

**Content Details:**
Since key bindings and macros in particular may be stored on the server they event may be delayed a bit beyond the original loading sequence.
Previously (prior to 3.0.1) this event was part of the loading sequence. Although it still occurs within the same general timeframe as the other events, it no longer has a guaranteed order that can be relied on. This may be problematic to addons that relied on the order of VARIABLES_LOADED, specifically that it would fire before PLAYER_ENTERING_WORLD.
Addons should not use this event to check if their addon's saved variables have loaded. They can use ADDON_LOADED (testing for arg1 being the name of the addon) or another appropriate event to initialize, ensuring that the addon works when loaded on demand.

**Related Information:**
AddOn loading process