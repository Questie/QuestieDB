if GetLocale() ~= "ptBR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.itemLookup["ptBR"] = loadstring([[return {
[203755] = "Diário de Pesquisa do Arquimago Teócrito",
[247834] = "Livro Mordiscado",
[247839] = "Livro Roubado",
[247886] = "Saco de Livros com \"Ilustrações\"",
[270228] = "Báculo do Coração de Golem",
[270231] = "Guantes Punhoflama",
[270261] = "Vestes do Thane Desonrado",
[271096] = "Braçadeiras de Fogo-fátuo Etéreo",
[274286] = "Cabeça de Durgen Martelúgubre",
[274289] = "Herança Enânica",
}]])
