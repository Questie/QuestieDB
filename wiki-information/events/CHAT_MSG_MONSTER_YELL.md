## Event: CHAT_MSG_MONSTER_YELL

**Title:** CHAT MSG MONSTER YELL

**Content:**
Fires when an NPC yells, such as a raid boss or in Alterac Valley.
`CHAT_MSG_MONSTER_YELL: text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons`

**Payload:**
1. `text`
   - *string* - The chat message payload.
2. `playerName`
   - *string* - Name of the NPC.
3. `languageName`
   - *string* - Localized name of the language if applicable, e.g. "Common" or "Thalassian"
4. `channelName`
   - *string* - Channel name with channelIndex, e.g. "2. Trade - City"
5. `playerName2`
   - *string* - If applicable, the player triggering the NPC message.
6. `specialFlags`
   - *string* - User flags if applicable, possible values are: "GM", "DEV", "AFK", "DND", "COM"
7. `zoneChannelID`
   - *number* - The static ID of the zone channel, e.g. 1 for General, 2 for Trade and 22 for LocalDefense.
8. `channelIndex`
   - *number* - Channel index, this usually is related to the order in which you joined each channel.
9. `channelBaseName`
   - *string* - Channel name without the number, e.g. "Trade - City"
10. `languageID`
    - *number* - LanguageID
11. `lineID`
    - *number* - Unique chat lineID for differentiating/reporting chat messages. Can be passed to `PlayerLocation:CreateFromChatLineID()`
12. `guid`
    - *string* - Sender's Unit GUID.
13. `bnSenderID`
    - *number* - ID of the Battle.net friend.
14. `isMobile`
    - *boolean* - If the sender is using the Blizzard Battle.net Mobile app.
15. `isSubtitle`
    - *boolean*
16. `hideSenderInLetterbox`
    - *boolean* - Whether this chat message is meant to show in the CinematicFrame only.
17. `supressRaidIcons`
    - *boolean* - Whether Target marker expressions like {rt7} and {diamond} should not be rendered with `C_ChatInfo.ReplaceIconAndGroupExpressions()`

**Related Information:**
- CHAT_MSG_MONSTER_EMOTE
- CHAT_MSG_MONSTER_SAY
- CHAT_MSG_MONSTER_PARTY
- CHAT_MSG_MONSTER_WHISPER