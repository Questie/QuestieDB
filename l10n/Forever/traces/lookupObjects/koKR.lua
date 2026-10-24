if GetLocale() ~= "koKR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["koKR"] = loadstring([[return {
[658919] = "우체통",
}]])
