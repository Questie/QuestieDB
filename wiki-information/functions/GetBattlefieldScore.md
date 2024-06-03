## Title: GetBattlefieldScore

**Content:**
Returns info for a player's score in battlefields.
`name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange, preMatchMMR, mmrChange, talentSpec = GetBattlefieldScore(index)`

**Parameters:**
- `index`
  - *number* - The character's index in battlegrounds, going from 1 to `GetNumBattlefieldScores()`.

**Returns:**
- `name`
  - *string* - The player's name, with their server name attached if from a different server to the player.
- `killingBlows`
  - *number* - Number of killing blows.
- `honorableKills`
  - *number* - Number of honorable kills.
- `deaths`
  - *number* - The number of deaths.
- `honorGained`
  - *number* - The amount of honor gained so far (Bonus Honor).
- `faction`
  - *number* - (Battlegrounds: Horde = 0, Alliance = 1 / Arenas: Green Team = 0, Yellow Team = 1).
- `race`
  - *string* - The player's race (Orc, Undead, Human, etc).
- `class`
  - *string* - The player's class (Mage, Hunter, Warrior, etc).
- `classToken`
  - *string* - The player's class name in English given in all capitals (MAGE, HUNTER, WARRIOR, etc).
- `damageDone`
  - *number* - The amount of damage done.
- `healingDone`
  - *number* - The amount of healing done.
- `bgRating`
  - *number* - The player's battleground rating.
- `ratingChange`
  - *number* - The change in the player's rating.
- `preMatchMMR`
  - *number* - The player's matchmaking rating before the match.
- `mmrChange`
  - *number* - The change in the player's matchmaking rating.
- `talentSpec`
  - *string* - Localized name of player build.

**Usage:**
How to count the number of players in each faction.
```lua
local numScores = GetNumBattlefieldScores()
local numHorde = 0
local numAlliance = 0
for i = 1, numScores do
    name, killingBlows, honorableKills, deaths, honorGained, faction = GetBattlefieldScore(i)
    if (faction) then
        if (faction == 0) then
            numHorde = numHorde + 1
        else
            numAlliance = numAlliance + 1
        end
    end
end
```

**Example Use Case:**
This function can be used in addons that track player performance in battlegrounds or arenas. For example, an addon like "Recount" or "Details!" could use this function to display detailed statistics about each player's performance, such as damage done, healing done, and number of kills.