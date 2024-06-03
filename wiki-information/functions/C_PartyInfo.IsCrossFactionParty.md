## Title: C_PartyInfo.IsCrossFactionParty

**Content:**
Needs summary.
`isCrossFactionParty = C_PartyInfo.IsCrossFactionParty()`

**Parameters:**
- `category`
  - *number?* - If not provided, the active party is used.

**Returns:**
- `isCrossFactionParty`
  - *boolean*

**Example Usage:**
This function can be used to determine if the current party is a cross-faction party, which can be useful for addons that need to handle faction-specific logic differently.

**Addons:**
Large addons like "ElvUI" or "DBM" might use this function to adjust their behavior based on whether the party is cross-faction, ensuring compatibility and proper functionality across different faction members.