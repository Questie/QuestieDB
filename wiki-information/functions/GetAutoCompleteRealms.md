## Title: GetAutoCompleteRealms

**Content:**
Returns a table of realm names for auto-completion.
`realmNames = GetAutoCompleteRealms()`

**Parameters:**
- `realmNames`
  - *table?* - If a table is provided, it will be populated with realm names; otherwise, a new table will be created.

**Returns:**
- `realmNames`
  - *table* - An array of realm names the player can interact with through Connected Realms. Realm names will be in normalized format without spaces or hyphens (see GetNormalizedRealmName).

**Description:**
Certain characters are removed from realm names, most notably Space and - while others remain, such as ' and variants of Latin letters (e.g. umlauts and accented letters).
The supplied table is not wiped; only the array keys needed to return the result are modified.
May not be available at load time until PLAYER_LOGIN (i.e. found to not work during VARIABLES_LOADED).