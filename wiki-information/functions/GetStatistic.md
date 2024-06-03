## Title: GetStatistic

**Content:**
Returns a character statistic.
`value, skip, id = GetStatistic(category)`

**Parameters:**
- `category`
  - *number* - AchievementID of a statistic or statistic category.
- `index`
  - *number* - Entry within a statistic category, if applicable.

**Returns:**
- `value`
  - *string* - Value of the statistic as displayed in-game.
- `skip`
  - *boolean* - Prevents a statistic from being shown in the default UI.
- `id`
  - *string* - Unknown.

**Description:**
Using the achievementID's of actual Achievements, as opposed to statistics, generates strange results. More testing is needed.
Wrapping the returned value with `tonumber()` is necessary to do comparisons using math operators.

**Usage:**
Here is a function that will take any statistic title (like Battlegrounds played) and will return the statistic ID for that statistic, so it can be used in other functions.
```lua
function GetStatisticId(StatisticTitle)
    for _, CategoryId in pairs(GetStatisticsCategoryList()) do    
        for i = 1, GetCategoryNumAchievements(CategoryId) do
            local IDNumber, Name = GetAchievementInfo(CategoryId, i)
            if Name == StatisticTitle then
                return IDNumber
            end
        end        
    end
    return -1
end
```

**Reference:**
- 2013-09-09, Blizzard_AchievementUI.lua, version 5.4.0.17359, near line 1957, archived at Townlong-Yak