## Title: SetActiveTalentGroup

**Content:**
Sets the active talent group of the player. This is the 5-second cast that occurs when clicking the Activate These Talents button in the talent pane.
`SetActiveTalentGroup(groupIndex);`

**Parameters:**
- `groupIndex`
  - *number* - Ranging from 1 to 2 (primary/secondary talent group). To get the current one use `GetActiveTalentGroup()`

**Notes and Caveats:**
Nothing will happen if the `groupIndex` is the currently active talent group.

**Usage:**
The following line will toggle between the player's talent groups:
```lua
SetActiveTalentGroup(3 - GetActiveTalentGroup())
```

**Example Use Case:**
This function can be used in macros or addons to allow players to quickly switch between their primary and secondary talent specializations without manually opening the talent pane.

**Addon Usage:**
Large addons like "ElvUI" or "Bartender4" might use this function to provide users with an easy way to switch talent groups through their custom interfaces. For example, they could add a button to the UI that, when clicked, automatically switches the player's talent group.