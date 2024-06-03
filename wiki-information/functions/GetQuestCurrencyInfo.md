## Title: GetQuestCurrencyInfo

**Content:**
Returns information about a currency token rewarded from the quest currently being viewed in the quest info frame.
`name, texture, numItems, quality = GetQuestCurrencyInfo(itemType, index)`

**Parameters:**
- `itemType`
  - *string* - The category of the currency to query. Currently "reward" is the only category in use for currencies.
- `index`
  - *number* - The index of the currency to query, in the range.

**Returns:**
- `name`
  - *string* - The localized name of the currency.
- `texture`
  - *string* - The path to the icon texture used for the currency.
- `numItems`
  - *number* - The amount of the currency that will be rewarded.
- `quality`
  - *number* - Indicates the rarity of the currency.

**Description:**
This function does not work for quests being viewed from the player's quest log. Use `GetQuestLogRewardCurrencyInfo` instead. Check `QuestInfoFrame.questLog` to determine whether the quest info frame is currently displaying a quest log quest or not.

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
- `GetNumRewardCurrencies`
- `GetQuestLogRewardCurrencyInfo`