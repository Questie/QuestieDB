---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")

-- Authored navigation, including identities absent from the fixture DBC.
ZoneDB.private.subZoneToParentZoneOverride = [[return {
    [10022] = 2557, -- Dire Maul - Gordok Commons
}]]

ZoneDB.private.subZoneToParentZone = [[return {
    [333] = -1, -- Preserve the authored no-parent sentinel.
    [444] = 555, -- Preserve an unrelated authored relationship.
}]]
