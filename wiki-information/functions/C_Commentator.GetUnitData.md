## Title: C_Commentator.GetUnitData

**Content:**
Needs summary.
`data = C_Commentator.GetUnitData(unitToken)`

**Parameters:**
- `unitToken`
  - *string* : UnitId

**Returns:**
- `data`
  - *CommentatorUnitData*
    - `Field`
    - `Type`
    - `Description`
    - `healthMax`
      - *number*
    - `health`
      - *number*
    - `absorbTotal`
      - *number*
    - `isDeadOrGhost`
      - *boolean*
    - `isFeignDeath`
      - *boolean*
    - `powerTypeToken`
      - *string*
    - `power`
      - *number*
    - `powerMax`
      - *number*

**Example Usage:**
This function can be used in addons or scripts that need to retrieve detailed information about a unit in a commentator mode, such as in esports broadcasting tools or advanced unit frame addons.

**Addons Using This Function:**
- **Blizzard's Esports Tools**: Utilized for providing real-time data about units during esports events, allowing commentators to give detailed insights into the game state.