## Title: GetPVPRankInfo

**Content:**
Returns information about a specific PvP rank.
`rankName, rankNumber = GetPVPRankInfo(rankID)`

**Parameters:**
- `rankID`
  - *number* - The PvP rank ID as returned by `UnitPVPRank()`
- `faction`
  - *number?* - 0 for Horde, 1 for Alliance. Defaults to the player's faction. Previously accepted a UnitId but now takes a faction ID.

**Values:**
Dishonorable ranks like "Pariah" exist but were never used in Vanilla.

| Rank ID | Alliance           | Horde             | Rank Number |
|---------|--------------------|-------------------|-------------|
| 0       | Pariah             | Pariah            | -4          |
| 1       | Outlaw             | Outlaw            | -3          |
| 2       | Exiled             | Exiled            | -2          |
| 3       | Dishonored         | Dishonored        | -1          |
| 4       | Private            | Scout             | 1           |
| 5       | Corporal           | Grunt             | 2           |
| 6       | Sergeant           | Sergeant          | 3           |
| 7       | Master Sergeant    | Senior Sergeant   | 4           |
| 8       | Sergeant Major     | First Sergeant    | 5           |
| 9       | Knight             | Stone Guard       | 6           |
| 10      | Knight-Lieutenant  | Blood Guard       | 7           |
| 11      | Knight-Captain     | Legionnaire       | 8           |
| 12      | Knight-Champion    | Centurion         | 9           |
| 13      | Lieutenant Commander | Champion       | 10          |
| 14      | Commander          | Lieutenant General| 11          |
| 15      | Marshal            | General           | 12          |
| 16      | Field Marshal      | Warlord           | 13          |
| 17      | Grand Marshal      | High Warlord      | 14          |

**Returns:**
- `rankName`
  - *string* - The localized name of the PvP rank.
- `rankNumber`
  - *number* - The PvP rank number.