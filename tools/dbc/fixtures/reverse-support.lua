---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")

ZoneDB.private.uiMapIdToAreaIdOverride = [[return {
    [1414] = 10073, -- Canonical continent alias.
    [235] = 10022, -- Retain the pre-entrance dungeon lookup.
}]]

ZoneDB.private.uiMapIdToAreaId = [[return {
    [1412] = 215,
}]]
