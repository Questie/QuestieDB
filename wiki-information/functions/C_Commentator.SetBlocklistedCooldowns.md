## Title: C_Commentator.SetBlocklistedCooldowns

**Content:**
Needs summary.
`C_Commentator.SetBlocklistedCooldowns(specID, spellIDs)`

**Parameters:**
- `specID`
  - *number*
- `spellIDs`
  - *number*

**Description:**
This function is used to set a list of cooldowns that should be blocklisted for a specific specialization in the commentator mode. This can be useful for customizing the display of cooldowns during esports events or other broadcasts where certain cooldowns should not be shown.

**Example Usage:**
```lua
-- Example: Blocklist specific cooldowns for a specialization
local specID = 71 -- Arms Warrior
local spellIDs = { 12345, 67890 } -- Example spell IDs to blocklist
C_Commentator.SetBlocklistedCooldowns(specID, spellIDs)
```

**Usage in Addons:**
This function is particularly useful in addons designed for esports broadcasting, such as the official Blizzard esports tools or third-party commentator addons. It allows broadcasters to control which cooldowns are visible to the audience, enhancing the viewing experience by hiding less relevant information.