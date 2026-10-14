if GetLocale() ~= "esES" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["esES"] = loadstring([[return {
[581822] = "Bolsa manchada de sangre",
[610954] = "Recompensa disponible: ¡Vulgara el Insaciable!",
[630865] = "Cámara de la hermandad",
[650593] = "Buzón",
[652323] = "Buzón",
[696264] = "Buzón",
[696265] = "Buzón",
[696434] = "Buzón",
[703257] = "Mailbox",
}]])
