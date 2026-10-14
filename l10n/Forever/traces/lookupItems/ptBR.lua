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
[252022] = "Carne-seca do Vagaventos",
[252028] = "Pão de Lufopomo Fresco",
[252030] = "Cheddar Celeste Pungente",
[252031] = "Água da Fonte Cristalina",
[252032] = "Maçã-dos-raios Deliciosa Vermelha",
[253591] = "Maçã-dos-raios Madura",
[253595] = "Pó de Asaleve",
[253596] = "Máscara de Bandido Manchada de Sangue",
[253597] = "Lombo de Vagaventos das Terras Baixas",
[255663] = "Pedra Eólica",
[257941] = "Carne de Rastejante Cantéolo",
[260880] = "Núcleo de Constructo de Ar",
[260881] = "Raio Cristalizado",
[267474] = "Cogumelo-do-bosque Lufado",
[270228] = "Báculo do Coração de Golem",
[270231] = "Guantes Punhoflama",
[270261] = "Vestes do Thane Desonrado",
[271096] = "Braçadeiras de Fogo-fátuo Etéreo",
[274286] = "Cabeça de Durgen Martelúgubre",
[274289] = "Herança Enânica",
}]])
