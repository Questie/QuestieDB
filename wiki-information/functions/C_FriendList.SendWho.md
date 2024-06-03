## Title: C_FriendList.SendWho

**Content:**
Requests a list of other online players.
`C_FriendList.SendWho(filter, origin)`

**Parameters:**
- `filter`
  - *string* - The criteria for which you want to perform a Who query. This can be anything for which you could normally search in a Who query:
    - Any string, which will be matched against players' names, guild names, zones, and levels.
    - Name (`n-"<char_name>"`)
    - Zone (`z-"<zone_name>"`)
    - Race (`r-"<race_name>"`)
    - Class (`c-"<class_name>"`)
    - Guild (`g-"<guild_name>"`)
    - Level ranges: (`<lower_limit>-<higher_limit>`)
    - These can be combined, but no more than one of each type can be searched for at once. Note that the quotation marks around the zone, race, and class must be present. Double quotation marks are required, as single quotation marks won't work.
- `origin`
  - *Enum.SocialWhoOrigin*
    - `Value`
    - `Field`
    - `Description`
    - `0` - Unknown
    - `1` - Social
    - `2` - Chat
    - `3` - Item

**Description:**
Fires `WHO_LIST_UPDATE` when the requested query has been processed. Note that there is a server-side cooldown; queries are not guaranteed to generate a response.

**Usage:**
- Searches for players in the level 20 to 40 range.
  ```lua
  C_FriendList.SendWho("20-40")
  ```
- Searches for Night Elf Rogues in Teldrassil, of levels 10-15, with the string "bob" in their (guild) names.
  ```lua
  C_FriendList.SendWho('bob z-"Teldrassil" r-"Night Elf" c-"Rogue" 10-15')
  ```

**Reference:**
- `C_FriendList.GetWhoInfo()`
- `C_FriendList.SetWhoToUi()`

**Example Use Case:**
This function can be used in addons that need to search for players based on specific criteria, such as finding potential group members or guild recruits. For example, an addon like "LookingForGroup" might use this function to find players who meet certain level and class requirements for a dungeon run.