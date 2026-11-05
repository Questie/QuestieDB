if GetLocale() ~= "koKR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["koKR"] = loadstring([[return {
[562131] = "사과주 증류기",
[581822] = "피로 물든 주머니",
[610954] = "진행 중인 현상 수배: 탐욕의 불가라",
[644436] = "우체통",
[644440] = "우체통",
[654846] = "잃어버린 일지",
[658919] = "우체통",
[658923] = "우체통",
[660739] = "의식의 불꽃",
[696265] = "우체통",
}]])
