## Title: SetTracking

**Content:**
Sets a minimap tracking method.
`SetTracking(id, enabled)`

**Parameters:**
- `id`
  - The id of the tracking you would like to change. The id is assigned by the client, 1 is the first tracking method available on the tracking list, 2 is the next and so on. To get information about a specific id, use `GetTrackingInfo`.
- `enabled`
  - *boolean* - flag if the specified tracking id is to be enabled or disabled.

**Usage:**
Enables the first tracking method on the list:
```lua
SetTracking(1, true)
```

**Example Use Case:**
This function can be used in addons that manage or enhance the minimap tracking features. For instance, an addon that automatically switches tracking types based on the player's current activities (e.g., switching to herb tracking when the player is in a zone with many herbs).

**Addons Using This Function:**
Many popular addons like "GatherMate2" use this function to help players track resources more efficiently by automatically enabling and disabling tracking types based on the player's needs.