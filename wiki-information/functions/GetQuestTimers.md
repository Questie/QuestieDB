## Title: GetQuestTimers

**Content:**
Returns all of the quest timers currently in progress.
`questTimers = GetQuestTimers()`

**Parameters:**
- None

**Returns:**
- `questTimers`
  - *Strings* - Values in seconds of all quest timers currently in progress

**Usage:**
```lua
QuestTimerFrame_Update(GetQuestTimers());

function QuestTimerFrame_Update(...)
  for i=1, arg.n, 1 do
    SecondsToTime(arg);
  end
end

QuestTimerFrame_Update(GetQuestTimers());

function QuestTimerFrame_Update(...)
  for i=1, arg.n, 1 do
    SecondsToTime(arg);
  end
end
```

**Miscellaneous:**
Result:
```
"300", "240", "100"
```