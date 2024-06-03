## Title: C_Commentator.SetCommentatorHistory

**Content:**
Needs summary.
`C_Commentator.SetCommentatorHistory(history)`

**Parameters:**
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

**CommentatorSeries:**
- `Field`
- `Type`
- `Description`
- `teams`
  - *CommentatorSeriesTeam*

**CommentatorSeriesTeam:**
- `Field`
- `Type`
- `Description`
- `name`
  - *string*
- `score`
  - *number*

**CommentatorTeamDirectoryEntry:**
- `Field`
- `Type`
- `Description`
- `playerName`
  - *string*
- `teamName`
  - *string*

**CommentatorOverrideNameEntry:**
- `Field`
- `Type`
- `Description`
- `originalName`
  - *string*
- `newName`
  - *string*