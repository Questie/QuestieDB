## Title: GetFactionInfo

**Content:**
Returns info for a faction.
```lua
name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus 
= GetFactionInfo(factionIndex)
= GetFactionInfoByID(factionID)
```

**Parameters:**
- **GetFactionInfo:**
  - `factionIndex`
    - *number* - Index from the currently displayed row in the player's reputation pane, including headers but excluding factions that are hidden because their parent header is collapsed.

- **GetFactionInfoByID:**
  - `factionID`
    - *number* - FactionID

**Returns:**
1. `name`
   - *string* - Name of the faction
2. `description`
   - *string* - Description as shown in the detail pane that appears when you click on the faction row
3. `standingID`
   - *number* - StandingId representing the current standing (e.g., 4 for Neutral, 5 for Friendly).
4. `barMin`
   - *number* - Minimum reputation since beginning of Neutral to reach the current standing.
5. `barMax`
   - *number* - Maximum reputation since the beginning of Neutral before graduating to the next standing.
6. `barValue`
   - *number* - Total reputation earned with the faction versus 0 at the beginning of Neutral.
7. `atWarWith`
   - *boolean* - True if the player is at war with the faction
8. `canToggleAtWar`
   - *boolean* - True if the player can toggle the "At War" checkbox
9. `isHeader`
   - *boolean* - True if the faction is a header (collapsible group title)
10. `isCollapsed`
    - *boolean* - True if the faction is a header and is currently collapsed
11. `hasRep`
    - *boolean* - True if the faction is a header and has its own reputation (e.g., The Tillers)
12. `isWatched`
    - *boolean* - True if the "Show as Experience Bar" checkbox for the faction is currently checked
13. `isChild`
    - *boolean* - True if the faction is a second-level header (e.g., Sholazar Basin) or is the child of a second-level header (e.g., The Oracles)
14. `factionID`
    - *number* - Unique FactionID.
15. `hasBonusRepGain`
    - *boolean* - True if the player has purchased a Grand Commendation to unlock bonus reputation gains with this faction
16. `canSetInactive`
    - *boolean*

**Description:**
- **Headers:**
  - Top-level headers (e.g., Cataclysm or Classic) return values for standingID, barMin, and barMax as if the player were at 0/3000 Neutral with a faction (4, 0, and 3000 respectively) except for the Inactive header, which returns values of 0.
  - Other headers that do not have their own reputation (e.g., Sholazar Basin or Steamwheedle Cartel) return values for their child faction with which the player has the highest reputation. For example, if the player is 999/1000 Exalted with Booty Bay, 2900/21000 Revered with Everlook, 5300/12000 Honored with Gadgetzan, and 10/6000 Friendly with Ratchet, querying the Steamwheedle Cartel header will return the standingId, barMin, and barMax values for Booty Bay.

- **Total Reputation:**
  - Within the game, reputation is shown as a formatted value of XXXX/YYYYY (e.g., 1234/12000) but outside of the reputation tab these values are not available directly. The game uses a flat value for reputation.
  - The earnedValue returned by `GetFactionInfo()` is NOT the value on your reputation bars, but instead the distance your reputation has moved from 0 (1/3000 Neutral). All reputations given by the game are simply the number of reputation points from the 0 point, Neutral and above are positive reputations, anything below Neutral is a negative value and must be treated as such for any reputation calculations.

  - **Game Value Breakdown:**
    - 1/3000 Neutral: Earned Value = 1
    - 1600/6000 Friendly: Earned Value = 4600 (3000 + 1600)
    - 11000/12000 Honored: Earned Value = 20000 (3000 + 6000 + 11000)
    - 1400/3000 Unfriendly: Earned Value = -1600
    - 2500/3000 Hostile: Earned Value = -3500 (-3000 + -500)

  - Notice that for negative reputation, the Earned value is how far below 0 your reputation is, not how far till Hated or Exalted.

**Usage:**
Prints the name and total reputation earned for every faction currently displayed in the player's reputation pane:
```lua
for factionIndex = 1, GetNumFactions() do
    local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar,
        isHeader, isCollapsed, hasRep, isWatched, isChild, factionID = GetFactionInfo(factionIndex)
    if hasRep or not isHeader then
        DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. name .. " - " .. earnedValue)
    end
end
```

Prints the name and total reputation for all factions:
```lua
local numFactions = GetNumFactions()
local factionIndex = 1
while (factionIndex <= numFactions) do
    local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar,
        isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(factionIndex)
    if isHeader and isCollapsed then
        ExpandFactionHeader(factionIndex)
        numFactions = GetNumFactions()
    end
    if hasRep or not isHeader then
        DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. name .. " - " .. earnedValue)
    end
    factionIndex = factionIndex + 1
end
```

**Reference:**
- `GetFriendshipReputation()`
- `GetFriendshipReputationRanks()`