if GetLocale() ~= "zhTW" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["zhTW"] = loadstring([[return {
[696271] = "郵箱",
}]])
