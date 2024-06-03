## Title: C_LFGList.GetApplicantMemberStats

**Content:**
Returns the Proving Grounds stats of an applicant.
`stats = C_LFGList.GetApplicantMemberStats(applicantID, memberIndex)`

**Parameters:**
- `applicantID`
  - *number* - ascending number of applicants since creation of the activity returned by `C_LFGList.GetApplicants()`
- `memberIndex`
  - *number* - iteration of `C_LFGList.GetApplicants()` argument #4 (numMembers)

**Returns:**
- `stats`
  - *table*

**Description:**
Currently used to check proving ground stats of an applicant group member
- **Entry**
  - **PG Tank**
    - `stats>0` - Gold
    - `stats>0` - Silver
    - `stats>0` - Bronze
- **Entry**
  - **PG Healer**
    - `stats>0` - Gold
    - `stats>0` - Silver
    - `stats>0` - Bronze
- **Entry**
  - **PG Damage**
    - `stats>0` - Gold
    - `stats>0` - Silver
    - `stats>0` - Bronze

**Reference:**
- `C_LFGList.GetApplicants()`
- `C_LFGList.GetApplicantMemberInfo(applicantID)`