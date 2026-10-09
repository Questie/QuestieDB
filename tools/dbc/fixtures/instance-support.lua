---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")

-- Keep symbolic authored identities and legacy rows outside the snapshot.
ZoneDB.instanceIdToAreaId = {
    [33] = ZoneDB.zoneIDs.SHADOWFANG_KEEP, -- Authored symbolic identity.
    [999] = 9000, -- Absent legacy Map and Area, preserved verbatim.
}
