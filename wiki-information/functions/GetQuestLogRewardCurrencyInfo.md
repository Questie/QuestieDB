## Title: GetQuestLogRewardCurrencyInfo

**Content:**
Provides information about a currency reward for the quest currently being viewed in the quest log, or of the provided questId.
`name, texture, numItems, currencyId, quality = GetQuestLogRewardCurrencyInfo(index)`

**Parameters:**
- `index`
  - *number* - The index of the currency to query, in the range of 
- `questId`
  - *number* - The id of a quest

**Returns:**
- `name`
  - *string* - The localized name of the currency
- `texture`
  - *string* - The path to the icon texture used for the currency
- `numItems`
  - *number* - The amount of the currency that will be rewarded
- `currencyId`
  - *number* - The id of the currency
- `quality`
  - *number* - The quality of the currency

**Description:**
When no questId is provided, this function only works for the quest currently viewed in the quest log.
When a questId is provided, the function will provide information only if the quest reward data is loaded (QUEST_LOG_UPDATE).
For quests being viewed from NPCs, use `GetQuestCurrencyInfo` instead. Check `QuestInfoFrame.questLog` to determine whether the quest info frame is currently displaying a quest log quest or not.

**Usage:**
Print a list of currencies rewarded by the currently viewed quest to the chat frame:
```lua
local numRewardCurrencies = GetNumRewardCurrencies()
if numRewardCurrencies > 0 then
  print("This quest rewards", numRewardCurrencies, "currencies:")
  for i = 1, numRewardCurrencies do
    local name, texture, numItems
    if QuestInfoFrame.questLog then
      name, texture, numItems = GetQuestLogRewardCurrencyInfo(i)
    else
      name, texture, numItems = GetQuestCurrencyInfo("reward", i)
    end
    print(format("|T%s:0|t %dx %s", texture, numItems, name))
  end
else
  print("This quest does not reward any currencies.")
end
```

**Reference:**
- `GetNumQuestCurrencies`
- `GetNumRewardCurrencies`
- `GetQuestCurrencyInfo`