---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")

ZoneDB.private.areaIdToUiMapIdOverride = [[return {
    [0] = 0,
    [2257] = 0, -- Authored suppression, not missing geometry.
    [10073] = 1414, -- Authored continent identity.
    [10022] = 235, -- Retain the pre-entrance dungeon lookup.
}]]

ZoneDB.private.areaIdToUiMapId = [[return {
    [215] = 1412,
}]]
