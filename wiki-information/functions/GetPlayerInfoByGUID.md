## Title: GetPlayerInfoByGUID

**Content:**
Returns character info for another player from their GUID.
`localizedClass, englishClass, localizedRace, englishRace, sex, name, realm = GetPlayerInfoByGUID(guid)`

**Parameters:**
- `guid`
  - *string* - The GUID of the player you're querying.

**Returns:**
- `localizedClass`
  - *string* - Localized class name.
- `englishClass`
  - *string* - Localization-independent class name.
- `localizedRace`
  - *string* - Localized race name.
- `englishRace`
  - *string* - Localization-independent race name.
- `sex`
  - *number* - Gender ID of the character. 2 for male, or 3 for female.
- `name`
  - *string* - The name of the character.
- `realm`
  - *string* - Normalized realm name of the character. Returns an empty string if the character is from the same realm as the player.

**Usage:**
When used on yourself.
```lua
/dump UnitGUID("target"), GetPlayerInfoByGUID(UnitGUID("target"))
> "Player-1096-06DF65C1", "Priest", "PRIEST", "Human", "Human", 3, "Xiaohuli", ""
```
When used on a player from another realm, in this case from the same connected realm.
```lua
> "Player-1096-0971D0BE", "Monk", "MONK", "Night Elf", "NightElf", 2, "Coldbits", "DarkmoonFaire"
```