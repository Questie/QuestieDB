## Title: SendChatMessage

**Content:**
Sends a chat message.
`SendChatMessage(msg)`

**Parameters:**
- `msg`
  - *string* - The message to be sent. Large messages are truncated to max 255 characters, and only valid chat message characters are permitted.
- `chatType`
  - *string?* - The type of message to be sent, e.g. "PARTY". If omitted, this defaults to "SAY".
- `languageID`
  - *number?* - The languageID used for the message. Only works with chatTypes "SAY" and "YELL", and only if not in a group. If omitted the default language will be used: Orcish for the Horde and Common for the Alliance, as returned by `GetDefaultLanguage()`.
- `target`
  - *string|number?* - The player name or channel number receiving the message for "WHISPER" or "CHANNEL" chatTypes.

**Miscellaneous:**
- HW - denotes if the chatType requires a hardware event when in the outdoor world, i.e. not in an instance/battleground.
- `chatType`
  - `Command`
  - `HW`
  - `Description`
  - `"SAY"`
    - `/s, /say`
    - ✔️
    - Chat message to nearby players
  - `"EMOTE"`
    - `/e, /emote`
    - Custom text emote to nearby players (See `DoEmote` for normal emotes)
  - `"YELL"`
    - `/y, /yell`
    - ✔️
    - Chat message to far away players
  - `"PARTY"`
    - `/p, /party`
    - Chat message to party members
  - `"RAID"`
    - `/ra, /raid`
    - Chat message to raid members
  - `"RAID_WARNING"`
    - `/rw`
    - Audible warning message to raid members
  - `"INSTANCE_CHAT"`
    - `/i, /instance`
    - Chat message to the instance group (Dungeon finder / Battlegrounds / Arena)
  - `"GUILD"`
    - `/g, /guild`
    - Chat message to guild members
  - `"OFFICER"`
    - `/o, /officer`
    - Chat message to guild officers
  - `"WHISPER"`
    - `/w, /whisper/t, /tell`
    - Whisper to a specific other player, use player name as target argument
  - `"CHANNEL"`
    - `/1, /2, ...`
    - ✔️
    - Chat message to a specific global/custom chat channel, use channel number as target argument
  - `"AFK"`
    - `/afk`
    - Not a real channel; Sets your AFK message. Send an empty message to clear AFK status.
  - `"DND"`
    - `/dnd`
    - Not a real channel; Sets your DND message. Send an empty message to clear DND status.
  - `"VOICE_TEXT"`
    - Sends text-to-speech to the in-game voice chat.

**Description:**
Fires `CHAT_MSG_*` events, e.g. `CHAT_MSG_SAY` and `CHAT_MSG_CHANNEL`.
- `"RAID_WARNING"` is accessible to raid leaders/assistants, or to all members of a party (when not in a raid).
- `"WHISPER"` works across all realms in a region, it's not restricted to connected realms and you don't need to have interacted with the recipient before.

**Usage:**
- Sends a message, defaults to "SAY".
  ```lua
  SendChatMessage("Hello world")
  ```
- Sends a /yell message.
  ```lua
  SendChatMessage("For the Horde!", "YELL")
  DoEmote("FORTHEHORDE")
  ```
- Sends a message to General Chat which is usually on channel index 1.
  ```lua
  SendChatMessage("Hello friends", "CHANNEL", nil, 1)
  ```
- Whispers your target.
  ```lua
  SendChatMessage("My, you're a tall one!", "WHISPER", nil, UnitName("target"))
  ```
- Sets your /dnd message.
  ```lua
  SendChatMessage("Grabbing a beer", "DND")
  ```
- Speaks in Thalassian, provided your character knows the language.
  ```lua
  SendChatMessage("Ugh, I hate Thunder Bluff! You can't find a good burger anywhere.", "SAY", 10)
  ```
- Sends a message to an instance group, raid, or party.
  ```lua
  SendChatMessage("Hello there o/", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
  ```