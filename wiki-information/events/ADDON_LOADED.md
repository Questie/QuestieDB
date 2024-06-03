## Event: ADDON_LOADED

**Title:** ADDON LOADED

**Content:**
Fires after an AddOn has been loaded.
`ADDON_LOADED: addOnName, containsBindings`

**Payload:**
- `addOnName`
  - *string* - The name of the addon.
- `containsBindings`
  - *boolean*

**Content Details:**
An addon is loaded after all .lua files have been run and SavedVariables have loaded.
If there was an out-of-memory error, this event fires before SAVED_VARIABLES_TOO_LARGE. Otherwise, when saving variables between game sessions, this is the first time an AddOn can access its saved variables.