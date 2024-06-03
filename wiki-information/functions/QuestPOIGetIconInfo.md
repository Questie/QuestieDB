## Title: QuestPOIGetIconInfo

**Content:**
Returns WorldMap POI icon information for the given quest.
`completed, posX, posY, objective = QuestPOIGetIconInfo(questId)`

**Parameters:**
- `questId`
  - *number* - you can get this from the quest link or from `GetQuestLogTitle(questLogIndex)`.

**Returns:**
- `completed`
  - *boolean* - is the quest completed (the icon is a question mark).
- `posX`
  - *number* (between 0 and 1 inclusive) - the X position where the icon is shown on the map.
- `posY`
  - *number* (between 0 and 1 inclusive) - the Y position where the icon is shown on the map.
- `objective`
  - *number* - which is sometimes negative and doesn't appear to have anything to do with the quest's actual objectives.

**Usage:**
```lua
local playerX, playerY = GetPlayerMapPosition("player")
local _, questX, questY = QuestPOIGetIconInfo(12345)
local diffX, diffY = abs(playerX - questX), abs(playerY - questY)
local distanceToTarget = math.sqrt(math.pow(diffX, 2) + math.pow(diffY, 2))
print("You are ", floor(distanceToTarget * 100), " clicks from the target location.")
```

**Example Use Case:**
This function can be used to determine the distance between the player's current position and the quest objective on the map. This can be particularly useful for addons that provide navigation assistance or quest tracking features.

**Addons Using This Function:**
- **TomTom**: A popular navigation addon that provides waypoints and directional arrows to guide players to their destinations. It uses functions like `QuestPOIGetIconInfo` to fetch quest objective locations and display them on the map.
- **QuestHelper**: An addon that helps players complete quests by showing the optimal path and locations of quest objectives. It utilizes this function to gather information about where to direct the player.