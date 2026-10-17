if GetLocale() ~= "ptBR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["ptBR"] = loadstring([[return {
[610954] = "Recompensa: Vulgara, Insaciável!",
[696276] = "Caixa de Correio",
[696751] = "Caixa de Correio",
}]])
