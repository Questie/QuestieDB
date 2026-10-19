---@class ForeverObjectFixes
local ForeverObjectFixes = QuestieLoader:CreateModule("ForeverObjectFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverObjectFixes:Load()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs

    return {
        [61934] = { -- Brazier of the Dormant Flame
            [objectKeys.spawns_add] = {[zoneIDs.LOCH_MODAN] = {{31.79,64.52}}},
        },
        [386691] = { -- Library Book
            [objectKeys.spawns] = {[zoneIDs.IRONFORGE] = {{76,10.4}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
            [objectKeys.questStarts] = {79091},
        },
        [386759] = { -- Library Book
            [objectKeys.name] = "Library Book",
            [objectKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{65.4,70.1}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [objectKeys.questStarts] = {79092},
        },
        [403041] = { -- Blasting Supplies
            [objectKeys.name] = "Blasting Supplies",
            [objectKeys.spawns] = {[zoneIDs.MULGORE] = {{57.4,48.8},{57.5,48.8},{58.4,47.8},{59.2,46.9},{59.5,49.0},{59.9,46.1},{60.2,50.0}}},
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [403105] = { -- Windfury Cone
            [objectKeys.name] = "Windfury Cone",
            [objectKeys.spawns] = {[zoneIDs.MULGORE] = {{30.9,30.8},{31.3,32.8},{31.5,32.6},{31.8,35.2},{32.8,32.2},{37.2,23.7},{37.3,22.5},{38.1,21.6},{38.1,23.3},{38.2,23.5},{38.4,21.4},{38.8,21.7},{39.4,20.3},{50.7,17.8},{51.2,20.7},{51.5,21.1},{52.0,21.6},{52.7,26.7},{53.1,22.7}}},
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [405149] = { -- Mural of Ta'zo
            [objectKeys.name] = "Mural of Ta'zo",
            [objectKeys.spawns] = {[zoneIDs.ORGRIMMAR] = {{38.7,78.4}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [objectKeys.questStarts] = {79094},
        },
        [405879] = { -- Apothecary Society Primer
            [objectKeys.questStarts] = {79095},
        },
        [407566] = { -- Goblin Tome
            [objectKeys.name] = "Goblin Tome",
            [objectKeys.spawns] = {[zoneIDs.THE_BARRENS] = {{62.7,36.3}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
            [objectKeys.questStarts] = {79097},
        },
        [408014] = { -- Gnomish Tome
            [objectKeys.name] = "Gnomish Tome",
            [objectKeys.spawns] = {[zoneIDs.LOCH_MODAN] = {{35.6,48.9}},[zoneIDs.WESTFALL] = {{52.7,53.8}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [objectKeys.questStarts] = {79093},
        },
        [409496] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.DARKSHORE] = {{59.6,22.2}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
            [objectKeys.questStarts] = {78124},
        },
        [409501] = { -- Dalaran Digest
            [objectKeys.name] = "Dalaran Digest",
            [objectKeys.spawns] = {[zoneIDs.SILVERPINE_FOREST] = {{63.5,63.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [objectKeys.questStarts] = {78127},
        },
        [409562] = { -- Spellbook
            [objectKeys.name] = "Spellbook",
            [objectKeys.spawns] = {[zoneIDs.WESTFALL] = {{45.4,70.4}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
            [objectKeys.questStarts] = {78142},
        },
        [409692] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.THE_BARRENS] = {{49.3,32.88}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
            [objectKeys.questStarts] = {78143},
        },
        [409700] = { -- Manual
            [objectKeys.name] = "Manual",
            [objectKeys.spawns] = {[zoneIDs.THE_BARRENS] = {{56.3,8.8}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
            [objectKeys.questStarts] = {78145},
        },
        [409711] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.STONETALON_MOUNTAINS] = {{74.4,85.7}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
            [objectKeys.questStarts] = {78149},
        },
        [409717] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.WETLANDS] = {{33.6,47.9}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
            [objectKeys.questStarts] = {78146},
        },
        [409731] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.LOCH_MODAN] = {{77.4,14}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [objectKeys.questStarts] = {78148},
        },
        [409735] = { -- Spellbook
            [objectKeys.name] = "Spellbook",
            [objectKeys.spawns] = {[zoneIDs.DUSKWOOD] = {{16.7,28.4}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
            [objectKeys.questStarts] = {78147},
        },
        [410299] = { -- Arcane Secrets
            [objectKeys.name] = "Arcane Secrets",
            [objectKeys.spawns] = {[zoneIDs.SILVERPINE_FOREST] = {{43.4,41.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [objectKeys.questStarts] = {79096},
        },
        [415107] = { -- Burned-Out Remains
            [objectKeys.spawns] = {[zoneIDs.WESTFALL] = {{37.41,50.7}}},
        },
        [421526] = { -- Research Notes
            [objectKeys.questStarts] = {79535},
        },
        [423895] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.THOUSAND_NEEDLES] = {{34.4,40.1},{34.5,40.1}}},
            [objectKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
            [objectKeys.questStarts] = {79947},
        },
        [423896] = { -- Manual
            [objectKeys.name] = "Manual",
            [objectKeys.spawns] = {[zoneIDs.ALTERAC_MOUNTAINS] = {{48.4,57.6},{48.5,57.7}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [objectKeys.questStarts] = {79948},
        },
        [423897] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.ARATHI_HIGHLANDS] = {{73.6,65.2}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
            [objectKeys.questStarts] = {79949},
        },
        [423898] = { -- Mysterious Book
            [objectKeys.name] = "Mysterious Book",
            [objectKeys.spawns] = {[zoneIDs.DESOLACE] = {{55,26.2}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
            [objectKeys.questStarts] = {79950},
        },
        [423899] = { -- Scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[zoneIDs.BADLANDS] = {{56.7,39.9}}},
            [objectKeys.zoneID] = zoneIDs.BADLANDS,
            [objectKeys.questStarts] = {79951},
        },
        [423900] = { -- Waterlogged Book
            [objectKeys.name] = "Waterlogged Book",
            [objectKeys.spawns] = {[zoneIDs.DUSTWALLOW_MARSH] = {{57.2,20.8}}},
            [objectKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
            [objectKeys.questStarts] = {79952},
        },
        [423901] = { -- Book
            [objectKeys.spawns] = {[zoneIDs.SWAMP_OF_SORROWS] = {{61.5,22.5}}},
            [objectKeys.questStarts] = {79953},
        },
        [441247] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.SWAMP_OF_SORROWS] = {{70,51}}},
            [objectKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
            [objectKeys.questStarts] = {81947},
        },
        [441248] = { -- Book
            [objectKeys.questStarts] = {81949},
        },
        [441249] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.FERALAS] = {{50.6,15.7}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
            [objectKeys.questStarts] = {81951},
        },
        [441250] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.AZSHARA] = {{20.7,62}}},
            [objectKeys.zoneID] = zoneIDs.AZSHARA,
            [objectKeys.questStarts] = {81952},
        },
        [441251] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.BURNING_STEPPES] = {{28.96,28.93}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
            [objectKeys.questStarts] = {81953},
        },
        [441252] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.THE_HINTERLANDS] = {{36,72.8}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
            [objectKeys.questStarts] = {81954},
        },
        [441253] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.SEARING_GORGE] = {{37.8,49.3},{37.9,49.6}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
            [objectKeys.questStarts] = {81955},
        },
        [441254] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.BLASTED_LANDS] = {{55.4,32.2},{55.4,32.5},{55.5,32.2}}},
            [objectKeys.zoneID] = zoneIDs.BLASTED_LANDS,
            [objectKeys.questStarts] = {81956},
        },
        [463206] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.BURNING_STEPPES] = {{26.4,24.45}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
            [objectKeys.questStarts] = {84396},
        },
        [463207] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.EASTERN_PLAGUELANDS] = {{71.86,48.27}}},
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [objectKeys.questStarts] = {84398},
        },
        [463208] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.EASTERN_PLAGUELANDS] = {{47.30,42.23}}},
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [objectKeys.questStarts] = {84400},
        },
        [463209] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.FELWOOD] = {{65.2,3.3}}},
            [objectKeys.zoneID] = zoneIDs.FELWOOD,
            [objectKeys.questStarts] = {84397},
        },
        [463211] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.WESTERN_PLAGUELANDS] = {{69.41,72.84}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
            [objectKeys.questStarts] = {84402},
        },
        [463212] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.EASTERN_PLAGUELANDS] = {{26.43,15.13}}},
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [objectKeys.questStarts] = {84401},
        },
        [463213] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.WESTERN_PLAGUELANDS] = {{38.2,54.6}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
            [objectKeys.questStarts] = {84395},
        },
        [463214] = { -- Book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[zoneIDs.WINTERSPRING] = {{60.7,37.7}}},
            [objectKeys.zoneID] = zoneIDs.WINTERSPRING,
            [objectKeys.questStarts] = {84399},
        },
        [562131] = { -- Applejack Still
            [objectKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{24.55,58.04}}},
            [objectKeys.questStarts] = {91736},
            [objectKeys.questEnds] = {91736},
        },
        [563442] = { -- Kobold Tracks
            [objectKeys.name] = "Kobold Tracks",
            [objectKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{47.73,45.86},{47.94,52.07},{48.38,53.48},{41.96,62.32},{42.74,61.82},{43.43,61.01},{44.11,60.61},{44.81,59.61},{45.15,58.06},{45.76,56.45},{46.53,54.69},{45.95,52.61},{45.4,51.01}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [576179] = { -- Supply Cache
            [objectKeys.name] = "Supply Cache",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.5,55.8},{49.0,53.6},{49.4,57.1},{49.5,54.8},{49.8,57.3},{49.9,56.0}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578937] = { -- Ripe Stormapple
            [objectKeys.name] = "Ripe Stormapple",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.2,78.4},{46.3,79.2},{46.4,80.2},{46.5,78.4},{46.5,78.5},{46.6,80.3},{46.6,80.7},{47.4,83.1},{47.6,83.6},{48.0,83.0},{48.7,83.6},{48.8,83.2},{48.8,84.5}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578959] = { -- Flutterfly Dust
            [objectKeys.name] = "Flutterfly Dust",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.9,76.9},{47.8,76.4},{47.8,76.5},{48.0,79.5},{48.2,78.4},{48.2,78.5},{48.4,73.7},{48.7,75.5},{48.7,79.1},{48.8,75.4},{48.9,82.0},{49.3,74.1},{49.6,77.3},{50.0,75.2},{50.0,81.1},{50.3,72.5},{50.3,73.5},{50.3,79.7},{50.4,77.6},{50.4,82.4},{50.4,82.5},{50.5,77.5},{50.5,79.6},{50.5,82.6},{50.8,80.9},{51.1,83.5},{51.2,81.8},{51.4,76.0},{51.4,77.0},{51.5,75.9},{51.5,77.1},{51.8,83.4},{51.8,83.5},{51.9,82.1},{52.7,79.4},{52.8,79.7},{53.6,81.8},{54.5,80.0}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [581792] = { -- Detonator
            [objectKeys.spawns] = {[zoneIDs.WESTFALL] = {{38.72,83.6}}},
        },
        [581820] = { -- Dusty Bedroll
            [objectKeys.name] = "Dusty Bedroll",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{52.08,69.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [586726] = { -- Portal To Rohashi Spires
            [objectKeys.name] = "Portal To Rohashi Spires",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.55,50.33}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [613286] = { -- Raw Windstone
            [objectKeys.name] = "Raw Windstone",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.8,30.77},{39.31,27.71},{38.28,29.99},{38.55,34.39},{40.38,30.47},{42.87,28.75},{45.33,29.14},{44.27,27.28},{41.51,26.94},{43.82,25.43},{44.23,24.95},{43.48,23.85},{42.82,22.27},{41.92,23.71},{44.17,22.29},{44.98,19.78},{46.59,17.83},{48.28,19.05},{46.94,20.9},{47.19,23.55},{46.61,24.6},{49.92,24.2},{48.29,25.67},{47.4,26.43},{46.76,27.94},{48.13,29.3},{46.62,31.21}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616466] = { -- Construct Parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{49.4,46.0},{49.6,45.9},{50.0,44.8},{50.7,44.3},{50.7,44.5},{51.6,46.6},{52.4,45.8},{52.5,45.8},{52.8,49.7},{52.9,51.7},{53.1,47.7},{53.1,51.4},{53.5,50.4},{53.6,50.5}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616467] = { -- Construct Parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.3,74.5},{43.9,75.4},{43.9,75.5},{44.7,73.4},{44.8,74.2},{44.8,76.7}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616468] = { -- Construct Parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{51.4,67.5},{51.5,67.6},{51.9,65.6},{51.9,67.1},{52.8,64.8},{52.9,66.1}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617674] = { -- Arvensus Shadowsong
            [objectKeys.name] = "Arvensus Shadowsong",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{40.98,64.09}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617675] = { -- Raani Windgazer
            [objectKeys.name] = "Raani Windgazer",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{41.13,64.07}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617704] = { -- Bloody Note
            [objectKeys.name] = "Bloody Note",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.37,62.07}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617839] = { -- Hippogryph Down
            [objectKeys.name] = "Hippogryph Down",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.63,59.11},{33.19,54.37},{33.99,55.29},{35.11,54.07},{35.79,55.33},{36.02,54.29},{36.75,54.67},{36.84,53.31},{36.82,52.45},{36.03,52},{36.5,50.88},{37.19,51.2},{37.84,51.04}}}, -- WIP
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [623295] = { -- Abandoned Belongings
            [objectKeys.name] = "Abandoned Belongings",
        },
        [631299] = { -- Skyborne Portal to Stormwind
            [objectKeys.name] = "Skyborne Portal to Stormwind",
            [objectKeys.spawns] = {[zoneIDs.ALTERAC_MOUNTAINS] = {{12.04,56.21}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [649094] = { -- Rock Pile
            [objectKeys.name] = "Rock Pile",
            [objectKeys.spawns] = {[zoneIDs.RIVERGLADES] = {{65.2,25},{66.4,25.5},{67.1,29},{68.4,29.2},{68.5,29.1},{74.8,39.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [652227] = { -- Dwarven Heirloom
            [objectKeys.name] = "Dwarven Heirloom",
            [objectKeys.spawns] = {[zoneIDs.THE_HALL_OF_THANES] = {{-1,-1}}},
            [objectKeys.zoneID] = zoneIDs.THE_HALL_OF_THANES,
        },
        [652228] = { -- Dwarven Heirloom
            [objectKeys.name] = "Dwarven Heirloom",
            [objectKeys.spawns] = {[zoneIDs.THE_HALL_OF_THANES] = {{-1,-1}}},
            [objectKeys.zoneID] = zoneIDs.THE_HALL_OF_THANES,
        },
        [654846] = { -- Lost Journal
            [objectKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{59.07,39.55}}},
        },
        [656180] = { -- Raider's Bow
            [objectKeys.spawns] = {[zoneIDs.DUROTAR] = {{59.39,56.41}}},
        },
        [656181] = { -- Raider's Battleaxe
            [objectKeys.spawns] = {[zoneIDs.DUROTAR] = {{57.37,56.43}}},
        },
        [656182] = { -- Raider's Shield
            [objectKeys.spawns] = {[zoneIDs.DUROTAR] = {{56.54,53}}},
        },
        [658924] = { -- Mailbox
            [objectKeys.questStarts_remove] = {5752},
        },
        [659159] = { -- Mailbox
            [objectKeys.questStarts_remove] = {1486},
        },
        [660729] = { -- The Forsaken Ally
            [objectKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{76.48,30.4}}},
        },
        [660730] = { -- Trollbane Conquests
            [objectKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{75.62,30.49}}},
        },
        [660731] = { -- Field Accounts of Horde Razings
            [objectKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{76.02,31.01}}},
        },
        [660732] = { -- Cycles of Morality
            [objectKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{76.25,29.19}}},
        },
        [660739] = { -- Ritual Fire
            [objectKeys.questEnds_add] = {95805},
            [objectKeys.spawns] = {[zoneIDs.MULGORE] = {{56.61,88.7}}},
        },
        [660848] = { -- Kuramaa's Stump
            [objectKeys.name] = "Kuramaa's Stump",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.35,68.82}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [664122] = { -- Gozwin's Mechanic's Log
            [objectKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{27.27,62.86}}},
        },
        [665373] = { -- Incense Burner
            [objectKeys.name] = "Incense Burner",
            [objectKeys.spawns] = {[zoneIDs.THUNDER_BLUFF] = {{53.02,87.84}}},
            [objectKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
        },
        [673378] = { -- Oracle Tree Bark
            [objectKeys.questStarts_add] = {940},
        },
        [673474] = { -- Treaty of Understanding
            [objectKeys.name] = "Treaty of Understanding",
            [objectKeys.spawns] = {[zoneIDs.THE_HALL_OF_THANES] = {{-1,-1}}},
            [objectKeys.zoneID] = zoneIDs.THE_HALL_OF_THANES,
        },
        [673494] = { -- Shredder Operation Instructions
            [objectKeys.spawns] = {[zoneIDs.MULGORE] = {{58.63,47.31}}},
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673496] = { -- Barrens Operations Best Practices
            [objectKeys.spawns] = {[zoneIDs.MULGORE] = {{61.67,47.31}}},
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673497] = { -- One "Gerenzo", of Stonetalon
            [objectKeys.spawns] = {[zoneIDs.MULGORE] = {{59.02,46.41}}},
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [693669] = { -- Weapon Piece
            [objectKeys.spawns] = {[zoneIDs.DUROTAR] = {{60.11,44.8}}},
        },
        [693670] = { -- Strange Debris
            [objectKeys.spawns] = {[zoneIDs.DUROTAR] = {{60.08,42.45}}},
        },
        [693674] = { -- Abandoned Dagger
            [objectKeys.spawns] = {[zoneIDs.DUROTAR] = {{58.85,44.35}}},
        },
        [694895] = { -- Glowing Crystal Fragment
            [objectKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{9.74,69.43}}},
        },
        [695222] = { -- Coalbeard's Rifle
            [objectKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{52.1,44.04}}},
        },
        [695277] = { -- Stoneanvil's Rifle
            [objectKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{53.16,58.78}}},
        },
        [696264] = { -- Mailbox
            [objectKeys.questStarts_remove] = {151},
        },
        [697118] = { -- Windstone Formation
            [objectKeys.name] = "Windstone Formation",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{47.0,69.0},{47.3,69.7},{47.4,68.3},{47.5,68.6},{47.7,70.0},{47.8,67.5},{48.6,68.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        -- For Forever fixes 460001-469999
        [460001] = { -- Elemental Convergence
            [objectKeys.name] = "Elemental Convergence",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.28,20.62}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [460002] = { -- Ley Line
            [objectKeys.name] = "Ley Line",
            [objectKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.29,17.87}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [460003] = { -- Basic Campfire
            [objectKeys.name] = "Basic Campfire",
            [objectKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{46.68,53.84}},[zoneIDs.TIRISFAL_GLADES] = {{57.17,55.55}},[zoneIDs.TELDRASSIL] = {{57.66,56.74}},[zoneIDs.MULGORE] = {{46.21,67.31}},[zoneIDs.DUROTAR] = {{52.09,47.39}},[zoneIDs.ELWYNN_FOREST] = {{44.94,63.2}},[zoneIDs.ZEPHRAS_ISLE] = {{41.73,44.78}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [460004] = { -- Gatehouse Door
            [objectKeys.name] = "Gatehouse Door",
            [objectKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{66.48,74.8}}},
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [460005] = { -- Jansen Stead Water Well
            [objectKeys.name] = "Jansen Stead Water Well",
            [objectKeys.spawns] = {[zoneIDs.WESTFALL] = {{56.62,18.69}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [460006] = { -- Molsen Farm Water Well
            [objectKeys.name] = "Molsen Farm Water Well",
            [objectKeys.spawns] = {[zoneIDs.WESTFALL] = {{46.08,38.14}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverObjectFixes:LoadDynamic()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs

    return {
        -- [objectId] = { [objectKeys.name] = "Character-specific name" },
    }
end
