## Title: QuestLogPushQuest

**Content:**
Shares the current quest in the quest log with other players.
`QuestLogPushQuest()`

**Usage:**
```lua
local i = 0;
while (GetQuestLogTitle(i+1) ~= nil) do
  i = i + 1;
  local title, level, tag, header = GetQuestLogTitle(i);
  if (not header) then
    SelectQuestLogEntry(i);
    if (GetQuestLogPushable()) then
      QuestLogPushQuest();
      DEFAULT_CHAT_FRAME:AddMessage(string.format("Attempting to share %s with your group...", title, level));
      return;
    end
  end
end
local i = 0;
while (GetQuestLogTitle(i+1) ~= nil) do
  i = i + 1;
  local title, level, tag, header = GetQuestLogTitle(i);
  if (not header) then
    SelectQuestLogEntry(i);
    if (GetQuestLogPushable()) then
      QuestLogPushQuest();
      DEFAULT_CHAT_FRAME:AddMessage(string.format("Attempting to share %s with your group...", title, level));
      return;
    end
  end
end
```

**Miscellaneous:**
Result:
Finds and shares the first sharable quest in your quest log.

**Description:**
The system only attempts to push the quest to grouped players and will fail if a recipient does not qualify for the quest (too low level or hasn't completed prior chain-quests), currently is on the quest or has already completed it.