## Title: SwapRaidSubgroup

**Content:**
Swaps two raid members into different groups.
`SwapRaidSubgroup(index1, index2)`

**Parameters:**
- `index1`
  - *number* - ID of first raid member (1 to MAX_RAID_MEMBERS)
- `index2`
  - *number* - ID of second raid member (1 to MAX_RAID_MEMBERS)

**Reference:**
- `SetRaidSubgroup`

**Example Usage:**
This function can be used in a raid management addon to quickly reorganize raid groups. For instance, if a raid leader wants to swap a healer and a DPS between groups for better group composition, they can use this function to automate the process.

**Addons Using This Function:**
- **ElvUI**: A popular UI overhaul addon that includes raid management features. It uses `SwapRaidSubgroup` to allow raid leaders to easily manage and swap raid members between groups.
- **oRA3**: A raid management addon that provides additional raid leader tools, including the ability to swap raid members between groups using this function.