## Title: C_GossipInfo.SelectOptionByIndex

**Content:**
Needs summary.
`C_GossipInfo.SelectOptionByIndex(optionID)`

**Parameters:**
- `optionID`
  - *number* - orderIndex from `C_GossipInfo.GetOptions()`
- `text`
  - *string?*
- `confirmed`
  - *boolean?*

**Example Usage:**
This function can be used to programmatically select a gossip option in a conversation with an NPC. For instance, if an NPC offers multiple dialogue options, you can use this function to select a specific option based on its index.

**Addons:**
Large addons like "Questie" or "Zygor Guides" might use this function to automate quest interactions, allowing the addon to select the appropriate dialogue options without user intervention.