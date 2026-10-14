if GetLocale() ~= "zhTW" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["zhTW"] = loadstring([[return {
[406918] = "信差包",
[415107] = "燒焦的遺骸",
[417072] = "上釘的木板",
[424005] = "口袋垃圾",
[424006] = "匆忙收拾的背袋",
[424007] = "雕紋刻像",
[424012] = "一堆泥土",
[696264] = "郵箱",
[696271] = "郵箱",
}]])
