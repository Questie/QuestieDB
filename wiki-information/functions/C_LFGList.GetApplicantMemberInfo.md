## Title: C_LFGList.GetApplicantMemberInfo

**Content:**
Returns info for an applicant.
`name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship, dungeonScore, pvpItemLevel = C_LFGList.GetApplicantMemberInfo(applicantID, memberIndex)`

**Parameters:**
- `applicantID`
  - *number* - ascending number of applicants since creation of the activity returned by `C_LFGList.GetApplicants()`
- `memberIndex`
  - *number* - iteration of `C_LFGList.GetApplicants()` argument #4 (numMembers)

**Returns:**
1. `name`
   - *string* - Character name and realm
2. `class`
   - *string* - English class name (uppercase)
3. `localizedClass`
   - *string* - Localized class name
4. `level`
   - *number*
5. `itemLevel`
   - *number*
6. `honorLevel`
   - *number*
7. `tank`
   - *boolean* - true if applicant offers tank role
8. `healer`
   - *boolean* - true if applicant offers healer role
9. `damage`
   - *boolean* - true if applicant offers damage role
10. `assignedRole`
    - *string* - English role name (uppercase)
11. `relationship`
    - *boolean?* - true if a friend, otherwise nil
12. `dungeonScore`
    - *number*
13. `pvpItemLevel`
    - *number*

**Example Usage:**
This function can be used to retrieve detailed information about applicants for a group activity in the Looking For Group (LFG) system. For instance, an addon could use this to display a list of applicants along with their roles, item levels, and other relevant information to help the group leader make informed decisions about who to invite.

**Addons Using This Function:**
- **ElvUI**: This popular UI overhaul addon uses `C_LFGList.GetApplicantMemberInfo` to enhance the LFG interface, providing more detailed information about applicants directly in the UI.
- **Raider.IO**: This addon uses the function to fetch and display dungeon scores and other relevant information about applicants, helping group leaders to assess the suitability of applicants for high-level Mythic+ dungeons.