if GetLocale() ~= "ptBR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["ptBR"] = loadstring([[return {
[415106] = "Restos Queimados",
[581822] = "Algibeira Manchada de Sangue",
[610954] = "Recompensa: Vulgara, Insaciável!",
[644436] = "Caixa de Correio",
[644437] = "Caixa de Correio",
[644438] = "Caixa de Correio",
[644440] = "Caixa de Correio",
[644441] = "Caixa de Correio",
[644488] = "Caixa de Correio",
[650593] = "Caixa de Correio",
[652323] = "Caixa de Correio",
[652324] = "Caixa de Correio",
[654846] = "Diário Perdido",
[654925] = "Diário Perdido",
[658919] = "Caixa de Correio",
[658924] = "Caixa de Correio",
[658927] = "Caixa de Correio",
[658970] = "Caixa de Correio",
[659159] = "Caixa de Correio",
[660739] = "Fogo Ritualístico",
[660964] = "Pacotes Perdidos",
[673378] = "Oráculo da Casca de Árvore",
[696276] = "Caixa de Correio",
[696751] = "Caixa de Correio",
[703257] = "Caixa de Correio",
[703896] = "Caixa de Correio",
}]])
