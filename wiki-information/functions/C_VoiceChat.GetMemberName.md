## Title: C_VoiceChat.GetMemberName

**Content:**
Needs summary.
`memberName = C_VoiceChat.GetMemberName(memberID, channelID)`

**Parameters:**
- `memberID`
  - *number*
- `channelID`
  - *number*

**Returns:**
- `memberName`
  - *string?*

**Description:**
This function retrieves the name of a member in a specified voice chat channel. It can be useful for addons that manage or display voice chat information, such as showing who is speaking in a voice channel.

**Example Usage:**
An addon could use this function to display the names of all members in a voice chat channel, helping users to identify who is currently connected and speaking.

**Addons:**
Large addons like **DBM (Deadly Boss Mods)** or **ElvUI** might use this function to enhance their voice chat features, providing better integration and user experience by displaying member names in their custom UI elements.