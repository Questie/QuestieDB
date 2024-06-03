## Title: C_ChatInfo.SendAddonMessage

**Content:**
Sends a message over an addon comm channel.
`result = C_ChatInfo.SendAddonMessage(prefix, message )`
`result = C_ChatInfo.SendAddonMessageLogged`

**Parameters:**
- `prefix`
  - *string* - Message prefix, can be used as your addon identifier; at most 16 characters.
- `message`
  - *string* - Text to send, at most 255 characters. All characters (decimal ID 1-255) are permissible except NULL (ASCII 0).
- `chatType`
  - *string? = PARTY* - The addon channel to send to.
- `target`
  - *string|number?* - The player name or custom channel number receiving the message for "WHISPER" or "CHANNEL" chatTypes.

**Returns:**
- `result`
  - *Enum.SendAddonMessageResult* - Result code indicating if the message has been enqueued by the API for submission. This does not mean that the message has yet been sent, and may still be subject to any server-side throttling.

**Miscellaneous:**
- **chatType**
  - **Retail**
  - **Classic**
  - **Description**
  - `"PARTY"`
    - ✔️
    - ✔️
    - Addon message to party members.
  - `"RAID"`
    - ✔️
    - ✔️
    - Addon message to raid members. If not in a raid group, the message will instead be sent on the PARTY chat type.
  - `"INSTANCE_CHAT"`
    - ✔️
    - ✔️
    - Addon message to grouped players in instanced content such as dungeons, raids, and battlegrounds.
  - `"GUILD"`
    - ✔️
    - ✔️
    - Addon message to guild members. Prints a "You are not in a guild." system message if you're not in a guild.
  - `"OFFICER"`
    - ✔️
    - ✔️
    - Addon message to guild officers.
  - `"WHISPER"`
    - ✔️
    - ✔️
    - Addon message to a player. Only works for players on the same or any connected realms. Use player name as target argument. Prints a "Player is offline." system message if the target is offline.
  - `"CHANNEL"`
    - ✔️
    - ❌
    - Addon message to a custom chat channel. Use channel number as target argument. Disabled on Classic to prevent players communicating over custom chat channels.
  - `"SAY"`
    - ❌
    - ✔️
    - Addon message to players within /say range. Subject to heavy throttling and certain specific characters are disallowed.
  - `"YELL"`
    - ❌
    - ✔️
    - Addon message to players within /yell range. Subject to heavy throttling and certain specific characters are disallowed.

**Message throttling:**
Communications on all chat types are subject to a per-prefix throttle. Additionally, if too much data is being sent simultaneously on separate prefixes then the client may be disconnected. For this reason, it is strongly recommended to use ChatThrottleLib or AceComm to manage the queueing of messages.
- Each registered prefix is given an allowance of 10 addon messages that can be sent.
- Each message sent on a prefix reduces this allowance by 1.
- If the allowance reaches zero, further attempts to send messages on the same prefix will fail, returning Enum.SendAddonMessageResult.AddonMessageThrottle to the caller.
- Each prefix regains its allowance at a rate of 1 message per second, up to the original maximum of 10 messages.
- This restriction does not apply to whispers outside of instanced content.
- All numbers provided above are the default values, however, these can be dynamically reconfigured by the server at any time.

**Libraries:**
There is a server-side throttle on in-game addon communication so it's recommended to serialize, compress and encode data before you send them over the addon comms channel.
- **Serialize:**
  - LibSerialize
  - AceSerializer
- **Compress/Encode:**
  - LibDeflate
  - LibCompress
- **Comms:**
  - ChatThrottleLib
  - AceComm

The LibSerialize project page has detailed examples and documentation for using LibSerialize + LibDeflate and AceComm:
```lua
-- Dependencies: AceAddon-3.0, AceComm-3.0, LibSerialize, LibDeflate
MyAddon = LibStub("AceAddon-3.0"):NewAddon("MyAddon", "AceComm-3.0")
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

function MyAddon:OnEnable()
  self:RegisterComm("MyPrefix")
end

-- With compression (recommended):
function MyAddon:Transmit(data)
  local serialized = LibSerialize:Serialize(data)
  local compressed = LibDeflate:CompressDeflate(serialized)
  local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
  self:SendCommMessage("MyPrefix", encoded, "WHISPER", UnitName("player"))
end

function MyAddon:OnCommReceived(prefix, payload, distribution, sender)
  local decoded = LibDeflate:DecodeForWoWAddonChannel(payload)
  if not decoded then return end
  local decompressed = LibDeflate:DecompressDeflate(decoded)
  if not decompressed then return end
  local success, data = LibSerialize:Deserialize(decompressed)
  if not success then return end
  -- Handle `data`
end
```

**Description:**
Recipients must register a prefix using `C_ChatInfo.RegisterAddonMessagePrefix()` to receive its messages via `CHAT_MSG_ADDON`. This prefix can be max 16 characters long and it's recommended to use the addon name if possible so other authors can easily see which addon a registered prefix belongs to.

Prior to Patch 11.0.0, Blizzard has provided a deprecation wrapper for this API that shifts the result code to the second return position. A forward-compatible way to reliably access the enum return value is to use a negative select index to grab the last return value.

**C_ChatInfo.SendAddonMessageLogged:**
Addons transmitting user-generated content should use this API so recipients can report violations of the Code of Conduct.
Fires `CHAT_MSG_ADDON_LOGGED` when receiving messages sent via this function.
The message has to be plain text for the game masters to read it. Moreover, the messages will silently fail to be sent if it contains an unsupported non-printable character. Some amount of metadata is tolerated, but should be kept as minimal as possible to keep the messages readable for Blizzard's game masters.

This function has been introduced as a solution to growing issues of harassment and doxxing via addon communications, where players would use addons to send content against the terms of service to other players (roleplaying addons are particularly affected as they offer a free form canvas to share RP profiles). As regular addon messages are not logged they cannot be seen by game masters, they had no way to act upon this content. If you use this function, game masters will be able to check the addon communication logs in case of a report and act upon the content. Users should report addon content that is against the terms of service using Blizzard's support website via the Harassment in addon text option.

**Usage:**
Whispers yourself an addon message when you login or /reload
```lua
local prefix = "SomePrefix123"
local playerName = UnitName("player")
local function OnEvent(self, event, ...)
  if event == "CHAT_MSG_ADDON" then
    print(event, ...)
  elseif event == "PLAYER_ENTERING_WORLD" then
    local isLogin, isReload = ...
    if isLogin or isReload then
      C_ChatInfo.SendAddonMessage(prefix, "You can't see this message", "WHISPER", playerName)
      C_ChatInfo.RegisterAddonMessagePrefix(prefix)
      C_ChatInfo.SendAddonMessage(prefix, "Hello world!", "WHISPER", playerName)
    end
  end
end
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", OnEvent)
```

**Reference:**
- `C_ChatInfo.GetRegisteredAddonMessagePrefixes()`
- `C_ChatInfo.IsAddonMessagePrefixRegistered()`
- `BNSendGameData()` - Battle.net equivalent.