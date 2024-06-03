## Title: GetRealmName

**Content:**
Returns the realm name.
```lua
realm = GetRealmName()
normalizedRealm = GetNormalizedRealmName()
```

**Returns:**
- `realm`
  - *string* - The name of the realm.
- `normalizedRealm`
  - *string?* - The name of the realm without spaces or hyphens.

**Description:**
- **Related API:**
  - `GetRealmID`
- The normalized realm name is used for addressing whispers and in-game mail.
- When logging in, `GetNormalizedRealmName()` only returns information starting from as early as the `PLAYER_LOGIN` event.
- When transitioning through a loading screen, `GetNormalizedRealmName()` may return nil between the `LOADING_SCREEN_ENABLED` and `LOADING_SCREEN_DISABLED` events.

**Usage:**
A small list of realm IDs and names.
```lua
-- /dump GetRealmID(), GetRealmName(), GetNormalizedRealmName()
503, "Azjol-Nerub", "AzjolNerub"
513, "Twilight's Hammer", "Twilight'sHammer"
635, "Defias Brotherhood", "DefiasBrotherhood"
1049, "愤怒使者", "愤怒使者"
1093, "Ahn'Qiraj", "Ahn'Qiraj"
1413, "Aggra (Português)", "Aggra(Português)"
1925, "Вечная Песня", "ВечнаяПесня"
```

**Reference:**
- `UnitName()` - Returns a character name and the server (if different from the player's current server).