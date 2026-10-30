if GetLocale() ~= "frFR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["frFR"] = loadstring([[return {
[406918] = "Sac de messager",
[410369] = "Piquet boîte morte",
[415107] = "Restes brûlés",
[424006] = "Besace roulée à la hâte",
[424007] = "Figurine sculptée",
[581822] = "Sacoche tachée de sang",
[610954] = "Prime disponible : Vulgara l’Insatiable",
[630865] = "Coffre-fort de guilde",
[644436] = "Boîte aux lettres",
[644437] = "Boîte aux lettres",
[644438] = "Boîte aux lettres",
[644439] = "Boîte aux lettres",
[644440] = "Boîte aux lettres",
[644441] = "Boîte aux lettres",
[644488] = "Boîte aux lettres",
[649051] = "Avis de recherche : incinérateur Gar’im",
[652323] = "Boîte aux lettres",
[652324] = "Boîte aux lettres",
[654846] = "Journal perdu",
[658838] = "La Rébellion d’Eldre’thalas I",
[658923] = "Boîte aux lettres",
[658970] = "Boîte aux lettres",
[659159] = "Boîte aux lettres",
[660739] = "Feu rituel",
[660964] = "Paquets égarés",
[678602] = "Livre",
[696264] = "Boîte aux lettres",
[696751] = "Boîte aux lettres",
[703257] = "Boîte aux lettres",
}]])
