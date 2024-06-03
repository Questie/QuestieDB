## Title: UnitRace

**Content:**
Returns the race of the unit.
`localizedRaceName, englishRaceName, raceID = UnitRace(name)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Values:**
The table below lists observed race IDs alongside the race name and the locale-independent string identifier for the race ("clientFileString").
Note: This list is up to date as of patch 9.0.1

| ID  | Race.raceName (enUS) | Race.clientFileString | Faction.name (enUS) | Faction.groupTag |
|-----|-----------------------|-----------------------|---------------------|------------------|
| 1   | Human                 | Human                 | Alliance            | Alliance         |
| 2   | Orc                   | Orc                   | Horde               | Horde            |
| 3   | Dwarf                 | Dwarf                 | Alliance            | Alliance         |
| 4   | Night Elf             | NightElf              | Alliance            | Alliance         |
| 5   | Undead                | Scourge               | Horde               | Horde            |
| 6   | Tauren                | Tauren                | Horde               | Horde            |
| 7   | Gnome                 | Gnome                 | Alliance            | Alliance         |
| 8   | Troll                 | Troll                 | Horde               | Horde            |
| 9   | Goblin                | Goblin                | Horde               | Horde            |
| 10  | Blood Elf             | BloodElf              | Horde               | Horde            |
| 11  | Draenei               | Draenei               | Alliance            | Alliance         |
| 12  | Fel Orc               | FelOrc                | Alliance            | Alliance         |
| 13  | Naga                  | Naga_                 | Alliance            | Alliance         |
| 14  | Broken                | Broken                | Alliance            | Alliance         |
| 15  | Skeleton              | Skeleton              | Alliance            | Alliance         |
| 16  | Vrykul                | Vrykul                | Alliance            | Alliance         |
| 17  | Tuskarr               | Tuskarr               | Alliance            | Alliance         |
| 18  | Forest Troll          | ForestTroll           | Alliance            | Alliance         |
| 19  | Taunka                | Taunka                | Alliance            | Alliance         |
| 20  | Northrend Skeleton    | NorthrendSkeleton     | Alliance            | Alliance         |
| 21  | Ice Troll             | IceTroll              | Alliance            | Alliance         |
| 22  | Worgen                | Worgen                | Alliance            | Alliance         |
| 23  | Gilnean               | Human                 | Alliance            | Alliance         |
| 24  | Pandaren              | Pandaren              | Neutral             |                  |
| 25  | Pandaren              | Pandaren              | Alliance            | Alliance         |
| 26  | Pandaren              | Pandaren              | Horde               | Horde            |
| 27  | Nightborne            | Nightborne            | Horde               | Horde            |
| 28  | Highmountain Tauren   | HighmountainTauren    | Horde               | Horde            |
| 29  | Void Elf              | VoidElf               | Alliance            | Alliance         |
| 30  | Lightforged Draenei   | LightforgedDraenei    | Alliance            | Alliance         |
| 31  | Zandalari Troll       | ZandalariTroll        | Horde               | Horde            |
| 32  | Kul Tiran             | KulTiran              | Alliance            | Alliance         |
| 33  | Human                 | ThinHuman             | Alliance            | Alliance         |
| 34  | Dark Iron Dwarf       | DarkIronDwarf         | Alliance            | Alliance         |
| 35  | Vulpera               | Vulpera               | Horde               | Horde            |
| 36  | Mag'har Orc           | MagharOrc             | Horde               | Horde            |
| 37  | Mechagnome            | Mechagnome            | Alliance            | Alliance         |
| 52  | Dracthyr              | Dracthyr              | Alliance            | Alliance         |
| 70  | Dracthyr              | Dracthyr              | Horde               | Horde            |

**Returns:**
- `localizedRaceName`
  - *string* - Localized race name, suitable for use in user interfaces.
- `englishRaceName`
  - *string* - Localization-independent race name, suitable for use as table keys.
- `raceID`
  - *number* - RaceId. Localization-independent raceID.

**Usage:**
The following command prints your character's name and race to chat:
```lua
/run print(UnitName("player").." is a "..UnitRace("player"))
```

**Reference:**
- `UnitClass()`
- `C_CreatureInfo.GetRaceInfo()`