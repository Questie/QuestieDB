## Title: GetQuestsCompleted

**Content:**
Returns a list of quests the character has completed in its lifetime.
`questsCompleted = GetQuestsCompleted()`

**Parameters:**
- `table`
  - *table* - If supplied, fills this table with quests. Any other keys will be unchanged.

**Returns:**
- `questsCompleted`
  - *table* - The list of completed quests, keyed by quest IDs.

**Description:**
A quest appears in the list only after it has been completed and turned in, not while it is in your log.
Completing certain quests can cause other quests (alternate versions, etc.) to appear completed also.
Some quests are invisible. These quests are not offered to players but suddenly become "completed" due to some other in-game occurrence.
Daily quests appear completed only if they have been completed that day.
Pet Battle quests are account-wide and will be returned from this API across all characters. They can be discerned with `GetQuestTagInfo()` tagID 102.

**Usage:**
Prints completed questIds and their names (quest data gets cached from the server after the first query)
```lua
for id in pairs(GetQuestsCompleted()) do
    local name = C_QuestLog.GetQuestInfo(id)
    print(id, name)
end
```
For a fresh Human Priest who only completed two starter quests: Beating Them Back! (28763) and Lions for Lambs (28771)
```lua
/dump GetQuestsCompleted()
{
    [28763] = true, -- "Beating Them Back!" -- Mage
    [28763] = true, -- "Beating Them Back!" -- Paladin
    [28763] = true, -- "Beating Them Back!" -- Priest
    [28763] = true, -- "Beating Them Back!" -- Rogue
    [28763] = true, -- "Beating Them Back!" -- Warlock
    [28763] = true, -- "Beating Them Back!" -- Warrior
    [28763] = true, -- "Beating Them Back!" -- Hunter
    [28763] = true, -- "Beating Them Back!" -- unknown
    [28763] = true, -- "Beating Them Back!" -- Monk
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs" -- Priest
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs"
    [28771] = true, -- "Lions for Lambs"
}
```

**Reference:**
- `IsQuestFlaggedCompleted()`
- `C_QuestLog.GetQuestInfo()`

**Example Use Case:**
This function can be used to track a player's progress through questlines, especially useful for completionist players or for addons that provide quest tracking and management features.

**Addons Using This API:**
- **Questie:** A popular addon that provides a comprehensive quest tracking system, showing available and completed quests on the map. It uses `GetQuestsCompleted` to determine which quests the player has already completed to avoid showing redundant information.