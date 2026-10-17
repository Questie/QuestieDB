if GetLocale() ~= "ptBR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.npcNameLookup["ptBR"] = loadstring([[return {
[247226] = {"Kelsey Fargo",nil},
[247229] = {"Daniel",nil},
[248242] = {"Hamish Montavarga",nil},
[248248] = {"Blixie Fitzpisca",nil},
[248362] = {"Narf Descobrilho",nil},
[248415] = {"Tordrin Caulâmina",nil},
[251905] = {"Zerril Brisabranda",nil},
[251906] = {"Teeri Benvento",nil},
[251991] = {"Taleen Cintilinha",nil},
[251993] = {"Indari Tramassol",nil},
[254100] = {"Cidadã de Zefras",nil},
[257019] = {"Nyassa Estiágil",nil},
[257024] = {"Mendalass Emendarrapo",nil},
[258568] = {"Antonio Bolero",nil},
[263664] = {"Raan Ventoferoz",nil},
[264936] = {"Vidente da Terra Farsen",nil},
[264943] = {"Afadra Dunwall",nil},
[265003] = {"Tom Mão-leve",nil},
[267118] = {"Gilberto Cinéreo",nil},
[270581] = {"Fyrenz Vishonar",nil},
[274781] = {"Guardarrégio de Ferro",nil},
}]])
