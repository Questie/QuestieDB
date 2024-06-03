## Title: GetLFGBootProposal

**Content:**
Returns info for a LFG votekick in progress.
`inProgress, didVote, myVote, targetName, totalVotes, bootVotes, timeLeft, reason = GetLFGBootProposal()`

**Returns:**
- `inProgress`
  - *boolean* - true if a Kick vote is currently in progress, false otherwise.
- `didVote`
  - *boolean* - true if you have already voted, false otherwise.
- `myVote`
  - *boolean* - true if you've voted to kick the player, false otherwise.
- `targetName`
  - *string* - name of the player being voted on.
- `totalVotes`
  - *number* - total votes cast so far.
- `bootVotes`
  - *number* - votes in favor of kicking the player cast so far.
- `timeLeft`
  - *number* - amount of time left to vote.
- `reason`
  - *string* - reason given for initiating a vote kick vote against a player.

**Reference:**
- `LFG_BOOT_PROPOSAL_UPDATE`

**Example Usage:**
This function can be used in addons that manage or monitor group activities, such as those that provide enhanced LFG (Looking For Group) functionalities. For instance, an addon could use this function to display a custom UI element showing the status of a votekick, including who is being voted on and how much time is left to vote.

**Addons Using This Function:**
Large addons like Deadly Boss Mods (DBM) or ElvUI might use this function to provide additional context or alerts during group activities, ensuring that players are aware of ongoing votekicks and can participate in the decision-making process.