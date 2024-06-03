## Event: SAVED_VARIABLES_TOO_LARGE

**Title:** SAVED VARIABLES TOO LARGE

**Content:**
Fired when unable to load saved variables due to an out-of-memory error.
`SAVED_VARIABLES_TOO_LARGE: addOnName`

**Payload:**
- `addOnName`
  - *string* - Name of the AddOn.

**Content Details:**
Fires after ADDON_LOADED.
The error could affect SavedVariables and/or SavedVariablesPerCharacter.
SavedVariables will not save on the next logout.

**Related Information:**
AddOn loading process