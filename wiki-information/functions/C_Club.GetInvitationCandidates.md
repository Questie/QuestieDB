## Title: C_Club.GetInvitationCandidates

**Content:**
Returns a list of players that you can send a request to a Battle.net club. Returns an empty list for Character based clubs.
`candidates = C_Club.GetInvitationCandidates(filter, maxResults, cursorPosition, allowFullMatch, clubId)`

**Parameters:**
- `filter`
  - *string?* - Optional filter string to narrow down the search.
- `maxResults`
  - *number?* - Optional maximum number of results to return.
- `cursorPosition`
  - *number?* - Optional cursor position for pagination.
- `allowFullMatch`
  - *boolean?* - Optional boolean to allow full match.
- `clubId`
  - *string* - The ID of the club to which you want to send invitations.

**Returns:**
- `candidates`
  - *ClubInvitationCandidateInfo* - A table containing information about each candidate.
    - `Field`
    - `Type`
    - `Description`
    - `memberId`
      - *number* - The unique ID of the candidate.
    - `name`
      - *string* - The name of the candidate.
    - `priority`
      - *number* - The priority of the candidate.
    - `status`
      - *Enum.ClubInvitationCandidateStatus* - The status of the candidate.

**Enum.ClubInvitationCandidateStatus:**
- `Value`
- `Field`
- `Description`
  - `0`
    - `Available` - The candidate is available for an invitation.
  - `1`
    - `InvitePending` - An invitation is already pending for the candidate.
  - `2`
    - `AlreadyMember` - The candidate is already a member of the club.