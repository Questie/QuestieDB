## Title: C_LFGList.GetActivityGroupInfo

**Content:**
Returns info for an activity group.
`name, groupOrder = C_LFGList.GetActivityGroupInfo(groupID)`

**Parameters:**
- `groupID`
  - *number* - The groupID for which information are requested, as returned by `C_LFGList.GetAvailableActivityGroups()`.

**Returns:**
- `name`
  - *string* - Name of the group.
- `groupOrder`
  - *number* - ?

**Example Usage:**
This function can be used to retrieve the name and order of a specific activity group in the Looking For Group (LFG) system. For instance, if you have a group ID and want to display the name of the group in your addon, you can use this function to get that information.

**Addons Using This Function:**
Large addons like **Deadly Boss Mods (DBM)** and **ElvUI** may use this function to display or organize LFG activities based on their group information. For example, DBM might use it to categorize different raid activities, while ElvUI could use it to enhance the user interface for LFG activities.