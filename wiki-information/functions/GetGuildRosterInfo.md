## Title: GetGuildRosterInfo

**Content:**
Returns info for a guild member.
`name, rankName, rankIndex, level, classDisplayName, zone, publicNote, officerNote, isOnline, status, class, achievementPoints, achievementRank, isMobile, canSoR, repStanding, guid = GetGuildRosterInfo(index)`

**Parameters:**
- `index`
  - *number* - Ranging from 1 to `GetNumGuildMembers()`

**Returns:**
- `name`
  - *string* - Name of character with realm (e.g. "Arthas-Silvermoon")
- `rankName`
  - *string* - Name of character's guild rank (e.g. Guild Master, Officer, Member, ...)
- `rankIndex`
  - *number* - Index of rank starting at 0 for GM (add 1 for `GuildControlGetRankName(index)`)
- `level`
  - *number* - Character's level
- `classDisplayName`
  - *string* - Localized class name (e.g. "Mage", "Warrior", "Guerrier", ...)
- `zone`
  - *string* - Character's location (last location if offline)
- `publicNote`
  - *string* - Character's public note, returns "" if you can't view notes or no note
- `officerNote`
  - *string* - Character's officer note, returns "" if you can't view notes or no note
- `isOnline`
  - *boolean* - true: online - false: offline
- `status`
  - *number* - 0: none - 1: AFK - 2: Busy (Do Not Disturb) (changed in 4.3.2)
- `class`
  - *string* - Localization-independent class name (e.g. "MAGE", "WARRIOR", "DEATHKNIGHT", ...)
- `achievementPoints`
  - *number* - Character's achievement points
- `achievementRank`
  - *number* - Where the character ranks in guild if sorted by achievement points
- `isMobile`
  - *boolean* - true: player logged into app with this character
- `canSoR`
  - *boolean* - true: can use Scroll of Resurrection on character (deprecated)
- `repStanding`
  - *number* - Standing ID for character's guild reputation
- `guid`
  - *string* - Character's GUID

**Description:**
- **Related API:**
  - `C_GuildInfo.GuildRoster`
- **Related Events:**
  - `GUILD_ROSTER_UPDATE`

**Example Usage:**
This function can be used to retrieve detailed information about each member of a guild, which can be useful for guild management addons. For example, an addon could use this function to display a list of all guild members along with their ranks, levels, and online status.

**Addons Using This API:**
- **ElvUI:** A comprehensive UI replacement addon that uses `GetGuildRosterInfo` to display guild member information in its guild panel.
- **Guild Roster Manager (GRM):** An addon designed to help guild leaders manage their guilds more effectively, using this API to fetch and display detailed member information.