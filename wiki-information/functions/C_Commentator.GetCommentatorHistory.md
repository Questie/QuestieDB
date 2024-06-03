## Title: C_Commentator.GetCommentatorHistory

**Content:**
Needs summary.
`history = C_Commentator.GetCommentatorHistory()`

**Returns:**
- `history`
  - *CommentatorHistory*
    - `Field`
    - `Type`
    - `Description`
    - `series`
      - *CommentatorSeries*
    - `teamDirectory`
      - *CommentatorTeamDirectoryEntry*
    - `overrideNameDirectory`
      - *CommentatorOverrideNameEntry*

**CommentatorSeries**
- `Field`
- `Type`
- `Description`
- `teams`
  - *CommentatorSeriesTeam*

**CommentatorSeriesTeam**
- `Field`
- `Type`
- `Description`
- `name`
  - *string*
- `score`
  - *number*

**CommentatorTeamDirectoryEntry**
- `Field`
- `Type`
- `Description`
- `playerName`
  - *string*
- `teamName`
  - *string*

**CommentatorOverrideNameEntry**
- `Field`
- `Type`
- `Description`
- `originalName`
  - *string*
- `newName`
  - *string*