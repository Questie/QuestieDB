## Title: C_LFGList.GetApplicantInfo

**Content:**
Returns status information and a custom message of an applicant.
`applicantData = C_LFGList.GetApplicantInfo(applicantID)`

**Parameters:**
- `applicantID`
  - *number* - Ascending number of applicants since the creation of the activity.

**Returns:**
- `applicantData`
  - *structure* - LfgApplicantData
    - `Field`
    - `Type`
    - `Description`
    - `applicantID`
      - *number* - Same as applicantID or nil
    - `applicationStatus`
      - *string*
    - `pendingApplicationStatus`
      - *string?* - "applied", "cancelled"
    - `numMembers`
      - *number* - 1 or higher if a group
    - `isNew`
      - *boolean*
    - `comment`
      - *string* - Applicant custom message
    - `displayOrderID`
      - *number*
    - `applicationStatus`
      - *Value* - Description
        - `applied`
        - `invited`
        - `failed`
        - `cancelled`
        - `declined`
        - `declined_full`
        - `declined_delisted`
        - `timedout`
        - `inviteaccepted`
        - `invitedeclined`

**Example Usage:**
This function can be used to retrieve detailed information about an applicant to a group activity, such as a dungeon or raid. For instance, it can be used to display the applicant's status and custom message in a custom LFG (Looking For Group) addon.

**Addons Using This Function:**
Large addons like "ElvUI" and "DBM" (Deadly Boss Mods) may use this function to manage group applications and display relevant information to the user. For example, ElvUI could use it to enhance the LFG interface, while DBM might use it to track the status of group members.