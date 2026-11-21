---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

local itemOverrides = {
    deDE = {
        [3825] = "Elixier der geringen Seelenstärke",
    },
    esES = {
        [3825] = "Elixir de entereza inferior",
    },
    esMX = {
        [3825] = "Elixir de entereza inferior",
    },
    frFR = {
        [3825] = "Elixir de Robustesse inférieur",
    },
    koKR = {
        [3825] = "하급 인내의 비약",
    },
    ptBR = {
        [3825] = "Elixir de Fortitude Inferior",
    },
    ruRU = {
        [3825] = "Эликсир стойкости I ступени",
    },
    zhCN = {
        [3825] = "次级坚韧药剂",
    },
    zhTW = {
        [3825] = "次級堅韌藥劑",
    },
}

l10n.itemLookupOverrides = itemOverrides[GetLocale()]
