## Title: C_LFGList.GetApplicants

**Content:**
Returns the list of applicants to your group.
`applicants = C_LFGList.GetApplicants()`

**Returns:**
- `applicants`
  - *table* - a simple table with applicantIDs (numbers)

**Example Usage:**
This function can be used to retrieve the list of players who have applied to join your group in the Looking For Group (LFG) system. For instance, you can loop through the returned table to get details about each applicant.

```lua
local applicants = C_LFGList.GetApplicants()
for _, applicantID in ipairs(applicants) do
    -- Process each applicantID
    print("Applicant ID:", applicantID)
end
```

**Addon Usage:**
Large addons like "ElvUI" and "DBM" (Deadly Boss Mods) may use this function to manage group applications more effectively, providing custom notifications or automating group management tasks based on the list of applicants.