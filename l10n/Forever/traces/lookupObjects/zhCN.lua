if GetLocale() ~= "zhCN" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["zhCN"] = loadstring([[return {
[644440] = "邮箱",
[654925] = "遗失的日记",
[658919] = "邮箱",
[658920] = "邮箱",
[660739] = "仪式火焰",
[660964] = "遗失的包裹",
[696264] = "邮箱",
}]])
