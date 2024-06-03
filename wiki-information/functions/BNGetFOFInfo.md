## Title: BNGetFOFInfo

**Content:**
Returns info for the specified friend of a Battle.net friend.
`friendID, accountName, isMutual = BNGetFOFInfo(mutual, nonMutual, index)`

**Parameters:**
- `mutual`
  - *boolean* - Should the list include mutual friends (i.e., people who you and the person referenced by presenceID are both friends with).
- `nonMutual`
  - *boolean* - Should the list include non-mutual friends.
- `index`
  - *number* - The index of the entry in the list to retrieve (1 to BNGetNumFOF(...)).

**Returns:**
- `friendID`
  - *number* - a unique numeric identifier for this friend for this session.
- `accountName`
  - *string* - a Kstring representing the friend's name (As of 4.0).
- `isMutual`
  - *boolean* - true if this person is a direct friend of yours, false otherwise.