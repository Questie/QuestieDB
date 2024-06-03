## Title: InCombatLockdown

**Content:**
Returns true if the combat lockdown restrictions are active.
`inLockdown = InCombatLockdown()`

**Returns:**
- `inLockdown`
  - *boolean* - true if lockdown restrictions are currently in effect, false otherwise.

**Description:**
Combat lockdown begins after the `PLAYER_REGEN_DISABLED` event fires, and ends before the `PLAYER_REGEN_ENABLED` event fires.

**Restrictions:**
While in combat:
- Programmatic modification of macros or bindings is not allowed.
- Some actions can't be performed on "Protected" frames, their parents, or any frame they are anchored to. These include, but are not restricted to:
  - Hiding the frame using the `Hide` widget method.
  - Showing the frame using the `Show` widget method.
  - Changing the frame's attributes (custom attributes are used by Blizzard secure templates to set up their behavior).
  - Moving the frame by resetting the frame's points or anchors (movements initiated by the user are still allowed while in combat).

**Example Usage:**
This function is often used in addons to check if the player is in combat before attempting to perform actions that are restricted during combat. For instance, an addon that modifies the user interface might use `InCombatLockdown` to ensure it doesn't try to change protected frames while the player is in combat.

**Addons Using This Function:**
Many large addons, such as ElvUI and Bartender4, use `InCombatLockdown` to manage their behavior during combat. These addons often need to modify the user interface, and they use this function to avoid performing restricted actions while the player is in combat.