## Title: C_Seasons.GetActiveSeason

**Content:**
Returns the ID of the season that is active on the current realm.
`seasonID = C_Seasons.GetActiveSeason()`

**Returns:**
- `seasonID`
  - *Enum.SeasonID* - The currently active season ID.
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - `NoSeason` - Used for normal (non-seasonal) realms.
    - `1`
      - `SeasonOfMastery` - Season of Mastery realms.
    - `2`
      - `SeasonOfDiscovery` - Season of Discovery realms.
    - `3`
      - `Hardcore`

**Description:**
This function will not return nil when no season is active; instead, the NoSeason ID will be returned.