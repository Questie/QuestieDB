## Event: CHAT_MSG_LOOT

**Title:** CHAT MSG LOOT

**Content:**
Fires when you or a group member loots an item or when someone selects need/greed/pass on an item.
`CHAT_MSG_LOOT: text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons`

**Payload:**
1. `text`
   - *string* - e.g. "You receive loot: |cffffffff|Hitem:2589::::::::20:257::::::|h|h|rx2."
2. `playerName`
   - *string* - Name of the user that initiated the chat message.
3. `languageName`
   - *string* - Localized name of the language if applicable, e.g. "Common" or "Thalassian"
4. `channelName`
   - *string* - Channel name with channelIndex, e.g. "2. Trade - City"
5. `playerName2`
   - *string* - The target name when there are two users involved, otherwise the same as playerName or an empty string.
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

**Content Details:**
This also fires messages like "Person creates <item>" via tradeskills, and "Person receives <item>" via a trade window. See also CHAT_MSG_MONEY and CHAT_MSG_CURRENCY.