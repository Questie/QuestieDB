-- Message contracts first, then the real CLI's failure and quiet-output behavior.
-- Entity IDs are synthetic; named AreaIDs/UiMapIDs are real, and expectations stay literal.
local config = dofile("src/config.lua")
local diagnostics = dofile("validators/diagnostics.lua")
local zones = dofile("validators/zones.lua")
local serialize = dofile("generator/serialize.lua")
local lib = dofile("generator/lib.lua")
local files = dofile("tools/validation/test-files.lua")
local questMeta = dofile("src/meta/questMeta.lua")
local npcMeta = dofile("src/meta/npcMeta.lua")
local objectMeta = dofile("src/meta/objectMeta.lua")
local itemMeta = dofile("src/meta/itemMeta.lua")

--------------------------------------------------------------------------------------------
-- Fixtures: entity fields and the relationships deliberately broken below
--------------------------------------------------------------------------------------------
-- Synthetic entity IDs keep these tests independent of live entity corrections.
local loaded = {
    Quest = {
        path = "data/Forever/foreverQuestDB.lua",
        meta = questMeta,
        entities = {
            [42] = { -- Synthetic delivery quest with deliberately inconsistent fields.
                [questMeta.keys.name] = "Fixture delivery quest",
                [questMeta.keys.startedBy] = {{73, 74}}, -- Synthetic guard NPC 73 and nameless NPC 74 start this quest.
                [questMeta.keys.finishedBy] = {{73}},
                [questMeta.keys.objectives] = {[3] = {{99}}}, -- Synthetic missing item 99 is an item objective.
                [questMeta.keys.requiredRaces] = 9999, -- Deliberately greater than the fixture's race limit.
                [questMeta.keys.preQuestSingle] = {51}, -- Synthetic alternative prerequisite quest.
                [questMeta.keys.preQuestGroup] = {52}, -- Synthetic required prerequisite quest.
                [questMeta.keys.parentQuest] = 53, -- Synthetic parent quest absent from this fixture.
                [questMeta.keys.childQuests] = {54}, -- Synthetic child quest absent from this fixture.
                [questMeta.keys.extraObjectives] = {
                    {{[16919] = {{-1, -1}}}}, -- Valid Hall of Thanes instance presence.
                    {{[16919] = {{10, 20}}}}, -- Invalid ordinary coordinates for that same area.
                },
            },
        },
    },
    Npc = {
        path = "data/Forever/foreverNpcDB.lua",
        meta = npcMeta,
        entities = {
            [73] = { -- Synthetic guard omits the quest that names it as starter.
                [npcMeta.keys.name] = "Fixture guard",
                [npcMeta.keys.questStarts] = {},
            },
            [74] = {}, -- Existing synthetic NPC without a name, not a missing NPC.
        },
    },
    Object = {
        path = "data/Forever/foreverObjectDB.lua",
        meta = objectMeta,
        entities = {
            [75] = { -- Synthetic chest with deliberately unmapped ordinary coordinates.
                [objectMeta.keys.name] = "Fixture chest",
                [objectMeta.keys.spawns] = {
                    [16919] = {{10, 20}}, -- The Hall of Thanes; an ordinary point cannot use its entrance marker route.
                },
            },
        },
    },
    Item = {
        path = "data/Forever/foreverItemDB.lua",
        meta = itemMeta,
        entities = {}, -- Missing item references must remain visibly missing.
    },
}
--------------------------------------------------------------------------------------------
-- Fixtures: spatial interpretation and race-mask limits
--------------------------------------------------------------------------------------------

local areaMaps = {
    [1537] = 1455, -- Ironforge AreaID -> Ironforge UiMapID.
}
local dungeonFixtures = {
    [16919] = { -- The Hall of Thanes instance presence resolves to its Ironforge entrance.
        "The Hall of Thanes",
        nil, -- No alternative AreaIDs in this fixture.
        1537, -- Ironforge parent area.
        {{1537, 27.63, 47.83}}, -- {outdoor AreaID, x, y}, in Ironforge percentages.
    },
}
local zoneIDs = {
    THE_HALL_OF_THANES = 16919,
    IRONFORGE = 1537,
}
local raceKeys = {
    HUMAN = 1, -- Human race-mask bit.
    ORC = 2, -- Orc race-mask bit; the synthetic flavor limit is their sum, 3.
}
--------------------------------------------------------------------------------------------
-- Expected messages: relationship failures and unmapped ordinary coordinates
--------------------------------------------------------------------------------------------

local relationshipCases = {
    {
        name = "Quest starter and NPC questStarts disagree",
        key = "npcQuestStarts|Npc:73|quest 42 is missing in questStarts",
        fragments = {
            "NPC 73", "Fixture guard", "questStarts = {}", "Quest 42", "startedBy = {{73,74}}", "must name each other",
        },
    },
    {
        name = "Existing NPC is missing its name, not its row",
        key = "questStarters|Quest:42|NPC starter 74 has no name",
        fragments = {"NPC 74 (name is missing)", "NPC starters also need a name", "foreverNpcDB.lua"},
    },
    {
        name = "Quest objective references a missing item",
        key = "objectives|Quest:42|Item objective 99 is missing in the database", -- Synthetic item 99 is absent.
        fragments = {"Item 99 (missing from this database)", "must exist", "foreverItemDB.lua"},
    },
    {
        name = "Quest parent relationship references a missing quest",
        key = "parentChildQuestRelations|Quest:42|parent quest 53 is missing/hidden in the database",
        fragments = {"parentQuest = 53", "childQuests = {54}", "Parent and child quests must exist", "Quest 53"},
    },
    {
        name = "Conflicting prerequisite modes explain any versus all",
        key = "preQuestExclusiveness|Quest:42|entity",
        fragments = {
            "Both preQuestSingle and preQuestGroup", "preQuestSingle = {51}", "preQuestGroup = {52}",
            "any listed quest", "all listed quests",
        },
    },
    {
        name = "Race eligibility exceeds the configured mask limit",
        key = "requiredRaces|Quest:42|requiredRaces is too high",
        fragments = {"requiredRaces = 9999", "no greater than 3", "src/corrections/enum/expansions.lua"},
    },
}

local spawnFragments = {
    "Fixture chest",
    "The Hall of Thanes", -- AreaID 16919, not a mapped outdoor zone.
    "spawns[16919] = {{10,20}}", -- Ordinary coordinates, not the instance marker.
    "areaIdToUiMapId[16919] is nil",
    "not the dungeon marker",
    "support/Forever/Zones/dungeons.lua",
    "foreverObjectDB.lua",
    "Do not invent a UiMap",
    "--raw", -- The report must distinguish corrected values from the raw input.
}

--------------------------------------------------------------------------------------------
-- Formatter checks: use the real schema and spawn-area predicate
--------------------------------------------------------------------------------------------

return function(check, equal)
    local context = {
        loaded = loaded,
        flavor = config.flavorByName.Forever,
        zoneIDs = zoneIDs,
        raceKeys = raceKeys,
        canResolveSpawnArea = zones.BuildSpawnAreaValidator(function(area) return areaMaps[area] end, dungeonFixtures),
    }
    local before = serialize.value(loaded.Object.entities)

    -- Reciprocal relationships, missing records, prerequisites and race eligibility.
    for _, case in ipairs(relationshipCases) do
        local text = diagnostics.format(case.key, context, "NEW")
        for _, fragment in ipairs(case.fragments) do
            check(text:find(fragment, 1, true) ~= nil,
                case.name .. ": diagnostic must explain " .. fragment .. "\n" .. text)
        end
        check(text:find("Finding key: " .. case.key, 1, true) ~= nil, "Diagnostics preserve the exact baseline key")
        check(text:find("Inspect:", 1, true) ~= nil, "Diagnostics identify input files")
    end

    -- Unmapped ordinary coordinates: name the area, show the point, explain the missing route.
    local spatialKey = "objectSpawnAreaIds|Object:75|areaIds 16919"
    local spatial = diagnostics.format(spatialKey, context, "NEW")
    for _, fragment in ipairs(spawnFragments) do
        check(spatial:find(fragment, 1, true) ~= nil, "Spawn diagnostic must explain " .. fragment .. "\n" .. spatial)
    end
    check(#spatial < 2500, "Sparse AreaIDs do not produce thousands of nil slots")

    -- Shared AreaID: report the bad objective, not its valid instance-marker neighbor.
    local extraKey = "questExtraObjectiveSpawnAreaIds|Quest:42|areaIds 16919, 16919"
    local extra = diagnostics.format(extraKey, context, "NEW")
    check(extra:find("extraObjectives[2][1][16919]", 1, true) ~= nil,
        "Extra-objective diagnostic identifies the failing ordinary coordinate entry")
    check(not extra:find("extraObjectives[1][1][16919]", 1, true),
        "A valid dungeon marker sharing the AreaID is not reported as broken")
    local _, areaCount = extra:gsub("Location: The Hall of Thanes", "")
    equal(areaCount, 1, "Duplicate finding AreaIDs do not repeat the same explanation")
    equal(serialize.value(loaded.Object.entities), before, "Formatting does not mutate entity data")

    -- Display suppression cannot stand in for an outdoor entrance map.
    local marker = {{-1, -1}} -- Instance presence, not outdoor coordinates.
    areaMaps[1537] = 0
    local valid, reason = context.canResolveSpawnArea(16919, marker)
    equal(valid, false, "Suppressed outdoor entrance remains invalid")
    check(reason:find("area 1537", 1, true) and reason:find("lookup is 0", 1, true) and
        reason:find("positive outdoor UiMap", 1, true), "Entrance diagnostic explains why 0 is not drawable")
    areaMaps[1537] = 1455

    -- Raw-mode reports must not claim Static Corrections supplied the inspected value.
    context.raw = true
    local raw = diagnostics.format(spatialKey, context, "KNOWN")
    check(not raw:find("include Static Corrections", 1, true), "Raw diagnostics do not claim corrections were applied")

    ----------------------------------------------------------------------------------------
    -- CLI checks: child-process failures, reports and quiet mode
    ----------------------------------------------------------------------------------------
    -- The child injects bad rows in memory. Only this owned temporary directory is written.
    local root = files.temporaryDirectory()
    local lua = os.getenv("LUA") or "lua5.1"
    local function runFailureFixture(mode, quiet)
        local name = mode .. (quiet and "-quiet" or "")
        local output = root .. "/" .. name .. ".txt"
        local directory = root .. "/" .. name
        local command = lib.shellQuote(lua) .. " validators/fixtures/diagnostic-failures.lua " .. mode .. " " ..
            lib.shellQuote(directory) .. (quiet and " --quiet" or "") .. " >" .. lib.shellQuote(output) .. " 2>&1"
        local status = lib.execute(command)
        check(status ~= 0 and status ~= true, quiet and "--quiet does not change the failure exit code" or
            ("Injected invalid data must make validation fail: " .. mode))
        return {
            console = lib.readAll(output),
            report = lib.readAll(directory .. "/Forever/report.txt"),
        }
    end

    local ok, err = pcall(function()
        -- All 16 synthetic objects reach both outputs, including the last ID, 9000016.
        local spawns = runFailureFixture("spawns")
        local _, count = spawns.console:gsub("NEW: Forever Object", "")
        equal(count, 16, "The console explains all 16 new findings, not only the first 15")
        check(spawns.console:find("Object 9000016", 1, true) and
            spawns.console:find("areaIdToUiMapId[16919] is nil", 1, true),
            "Last synthetic object still has its routing explanation")
        check(spawns.report:find("FINDING: Forever Object 9000016", 1, true) and
            spawns.report:find("objectSpawnAreaIds|Object:9000016|areaIds 16919", 1, true),
            "Saved report includes full explanations and original baseline keys")

        -- Synthetic quest 9000042 references missing NPC 9000099; the error must name both.
        local starter = runFailureFixture("missing-starter")
        check(starter.console:find("ERROR: Forever could not finish npcQuestStarts", 1, true) and
            starter.console:find("Quest 9000042 lists NPC 9000099", 1, true) and
            starter.console:find("npcData[9000099] is missing", 1, true),
            "Missing starter names the quest, NPC and missing table instead of a nil-index error")

        -- File-write failures explain the output destination, not only a nil file handle.
        local writeError = runFailureFixture("write-error")
        check(writeError.console:find("npcQuestStartsCorrections.lua", 1, true) and
            writeError.console:find("synthetic permission denied", 1, true),
            "Correction-file write errors name the destination and operating-system error")

        -- Quiet mode hides console messages, never the failure status or the detailed report.
        local quiet = runFailureFixture("spawns", true)
        equal(quiet.console, "", "--quiet suppresses console output")
        check(quiet.report:find("FINDING: Forever Object 9000016", 1, true) ~= nil,
            "--quiet still writes all detailed findings")
    end)
    files.removeTree(root) -- Cleanup also runs when an unexpected Lua error aborts a case.
    assert(ok, err)
end
