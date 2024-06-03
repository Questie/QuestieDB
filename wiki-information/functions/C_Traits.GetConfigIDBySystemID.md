## Title: C_Traits.GetConfigIDBySystemID

**Content:**
Needs summary.
`configID = C_Traits.GetConfigIDBySystemID(systemID)`

**Parameters:**
- `systemID`
  - *number* - The systems are defined in TraitSystem.db2. E.g. Dragonriding is 1

**Returns:**
- `configID`
  - *number*

**Example Usage:**
This function can be used to retrieve the configuration ID for a specific trait system. For instance, if you want to get the configuration ID for the Dragonriding system, you would call this function with the systemID corresponding to Dragonriding.

**Addons:**
Large addons that manage or display trait systems, such as talent tree managers or custom UI enhancements, might use this function to dynamically load and display the correct configuration for different systems.