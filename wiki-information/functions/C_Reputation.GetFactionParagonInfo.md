## Title: C_Reputation.GetFactionParagonInfo

**Content:**
Returns Paragon info on a faction.
`currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)`

**Parameters:**
- `factionID`
  - *number* - FactionID

**Returns:**
- `currentValue`
  - *number* - The amount of reputation you have earned in the current level of Paragon.
- `threshold`
  - *number* - The amount of reputation until you gain the next Paragon level.
- `rewardQuestID`
  - *number* - The ID of the quest once you attain a new Paragon level (or your first).
- `hasRewardPending`
  - *boolean* - True if the player has attained a Paragon level but has not completed the reward quest.
- `tooLowLevelForParagon`
  - *boolean* - True if the player level is too low to complete the Paragon reward quest.

**Description:**
The `currentValue` return value contains a prefix that indicates the amount of paragon rewards you have gotten so far.
For example, having received a paragon reward for The Undying Army 12 times, if one calls the above function and the current rep level is 717, the result for `currentValue` will be 120717.

**Usage:**
Reading the current reputation points of the Venthyr covenant:
```lua
local factionID = 2413
local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)
-- total iterations (= Rewards Earned)
local level = math.floor(currentValue/threshold)-(hasRewardPending and 1 or 0)
local realValue = tonumber(string.sub(currentValue, string.len(level) + 1))
print("current rep: ", realValue, " (", threshold, "), level: ", level)
```