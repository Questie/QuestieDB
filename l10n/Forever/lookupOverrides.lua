---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

local itemOverrides = {
    deDE = {
        [3825] = "Elixier der geringen Seelenstärke",
        [3830] = "Rezept: Elixier der geringen Seelenstärke",
    },
    esES = {
        [3825] = "Elixir de entereza inferior",
        [3830] = "Receta: elixir de entereza inferior",
    },
    esMX = {
        [3825] = "Elixir de entereza inferior",
        [3830] = "Receta: elixir de entereza inferior",
    },
    frFR = {
        [3825] = "Élixir de robustesse inférieure",
        [3830] = "Recette : élixir de robustesse inférieure",
    },
    koKR = {
        [3825] = "하급 인내의 비약",
        [3830] = "조제법: 하급 인내의 비약",
    },
    ptBR = {
        [3825] = "Elixir de Fortitude Inferior",
        [3830] = "Receita: Elixir de Fortitude Inferior",
    },
    ruRU = {
        [3825] = "Эликсир стойкости I ступени",
        [3830] = "Рецепт: малый эликсир стойкости",
    },
    zhCN = {
        [3825] = "次级坚韧药剂",
        [3830] = "配方：次级坚韧药剂",
    },
    zhTW = {
        [3825] = "次級堅韌藥劑",
        [3830] = "配方：次級堅韌藥劑",
    },
}

l10n.itemLookupOverrides = itemOverrides[GetLocale()]
