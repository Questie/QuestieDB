if GetLocale() ~= "esMX" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.objectLookup["esMX"] = loadstring([[return {
[415106] = "Restos quemados",
[415107] = "Restos quemados",
[417072] = "Tabla clavada",
[581822] = "Bolsón manchado de sangre",
[610954] = "Recompensa disponible: ¡Vulgara, la Insaciable!",
[619896] = "Santuario olvidado",
[644438] = "Buzón",
[649051] = "Se busca: incinerador Gar'im",
[652323] = "Buzón",
[652324] = "Buzón",
[654925] = "Diario perdido",
[659159] = "Buzón",
[660964] = "Paquetes extraviados",
[671479] = "Sobre el Señor del Viento",
}]])
