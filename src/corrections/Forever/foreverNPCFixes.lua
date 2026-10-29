---@class ForeverNpcFixes
local ForeverNpcFixes = QuestieLoader:CreateModule("ForeverNpcFixes")

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
---@type Phasing
local Phasing = QuestieLoader:ImportModule("Phasing")

-- Static Corrections: shared by all characters and folded in during Generation.
function ForeverNpcFixes:Load()
    local npcKeys = QuestieDB.npcKeys
    local zoneIDs = ZoneDB.zoneIDs
    local npcFlags = QuestieDB.npcFlags
    local waypointPresets = QuestieDB.waypointPresets
    local phases = Phasing.phases

    return {
        [352] = { -- Dungar Longdrink
            [npcKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{71.29,72.23}}},
        },
        [384] = { -- Katie Hunter <Horse Breeder>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [464] = { -- Guard Parker
            [npcKeys.spawns] = {[zoneIDs.REDRIDGE_MOUNTAINS] = {{10.37,71.26}}},
            [npcKeys.waypoints] = {},
        },
        [663] = { -- Calor
            [npcKeys.waypoints] = {},
        },
        [1261] = { -- Veron Amberstill <Ram Breeder>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [1440] = { -- Milton Sheaf
            [npcKeys.npcFlags] = npcFlags.QUEST_GIVER + npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [1481] = { -- Bart Tidewater
            [npcKeys.spawns] = {[zoneIDs.WETLANDS] = {{8.66,58.12}}},
            [npcKeys.waypoints] = {},
        },
        [1654] = { -- Gregor Agamand
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{45.79,29.39}}},
        },
        [1656] = { -- Thurman Agamand
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{42.84,32.54}}},
        },
        [1657] = { -- Devlin Agamand
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{47.23,40.02}}},
        },
        [1738] = { -- Deathguard Terrence
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{61.5,53.5}}},
            [npcKeys.waypoints] = {},
        },
        [2089] = { -- Giant Wetlands Crocolisk
            [npcKeys.spawns_add] = {[zoneIDs.WETLANDS] = {{16.79,59.7},{17.33,57.78},{18.72,60.49},{18.26,59.22},{17.67,60.69},{16.6,61.58}}},
        },
        [2150] = { -- Zenn Foulhoof
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{60.35,56.16}}},
        },
        [2155] = { -- Sentinel Shayla Nightbreeze
            [npcKeys.questEnds_add] = {490},
            [npcKeys.questStarts_add] = {490},
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{40.46,50.73}}},
        },
        [2756] = { -- Grund Drokda
            [npcKeys.name] = "Grund Drokda",
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{28.67,67.52}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [3362] = { -- Ogunaro Wolfrunner <Kennel Master>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [3519] = { -- Sentinel Arynia Cloudsbreak
            [npcKeys.questStarts_remove] = {940},
        },
        [3605] = { -- Nadyia Maneweaver
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.QUEST_GIVER + npcFlags.TRAINER + npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [3685] = { -- Harb Clawhoof <Kodo Mounts>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [4047] = { -- Zor Lonetree
            [npcKeys.npcFlags] = npcFlags.QUEST_GIVER + npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [4612] = { -- Boyle
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [4730] = { -- Lelanai <Saber Handler>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [4731] = { -- Zachariah Post <Undead Horse Merchant>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [4949] = { -- Thrall
            [npcKeys.questEnds_add] = {93739},
        },
        [5497] = { -- Jennea Cannon
            [npcKeys.questStarts_add] = {84395,84396,84397,84398,84399,84400,84401,84402},
            [npcKeys.questEnds_add] = {84395,84396,84397,84398,84399,84400,84401,84402},
        },
        [5891] = { -- Minor Manifestation of Earth
            [npcKeys.spawns_add] = {[zoneIDs.DUN_MOROGH] = {{24.84,61.86}}},
        },
        [5893] = { -- Minor Manifestation of Fire
            [npcKeys.spawns_add] = {[zoneIDs.LOCH_MODAN] = {{31.96,64.42}}},
        },
        [7825] = { -- Oran Snakewrithe
            [npcKeys.questStarts_add] = {84395,84396,84397,84398,84399,84400,84401,84402},
            [npcKeys.questEnds_add] = {84395,84396,84397,84398,84399,84400,84401,84402},
        },
        [7952] = { -- Zjolnir <Raptor Handler>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [7955] = { -- Milli Featherwhistle <Mechanostrider Merchant>
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [9087] = { -- Bashana Runetotem
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- base data adds a wrong innkeeper bit
        },
        [10667] = { -- Chromie
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.QUEST_GIVER + npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [10880] = { -- Warcaller Gorlach
            [npcKeys.waypoints] = {[zoneIDs.ORGRIMMAR] = {{{52.25,74.98},{51.78,73.88},{51.46,73.20},{51.15,72.52},{50.90,71.86},{50.80,71.21},{50.94,70.25},{50.97,70.03},{51.21,68.75},{51.47,68.29},{51.88,67.52},{52.11,66.98},{52.04,66.12},{51.87,65.49},{51.75,64.90},{51.51,64.10},{51.12,63.66},{50.59,63.02},{50.40,62.80},{50.01,62.32},{49.74,61.37},{49.55,60.56},{49.65,60.00},{50.08,59.55},{50.97,58.60},{51.48,58.11},{52.23,57.50},{52.76,57.03},{53.32,56.84},{53.58,56.91},{54.11,57.03},{54.49,57.12},{55.27,57.50},{55.87,57.77},{56.18,57.94},{56.96,57.91},{57.69,57.60},{58.32,57.36},{58.71,56.97},{58.98,56.61},{59.43,56.02},{59.86,55.41},{60.32,54.78},{60.70,54.20},{60.67,53.35},{60.62,52.76},{60.59,52.39},{60.51,51.32},{60.45,50.24},{60.50,49.58},{60.53,49.18},{60.61,47.97},{60.66,47.27},{60.70,46.40},{60.71,45.70},{60.75,44.98},{60.75,44.39},{60.58,43.26},{60.49,42.60},{60.58,41.74},{60.95,41.28},{61.04,41.14},{61.65,40.31},{61.93,39.85},{61.40,40.06},{60.99,40.28},{60.49,40.58},{60.02,40.78},{59.70,40.45},{59.26,39.91},{58.83,39.39},{58.27,38.74},{57.45,38.09},{56.88,37.58},{56.43,37.21},{56.26,37.07},{55.64,36.71},{54.96,36.30},{54.61,36.13},{53.98,35.81},{53.45,35.52},{52.92,35.51},{52.31,35.68},{51.82,35.84},{51.36,35.96},{50.83,36.11},{50.18,36.33},{49.81,36.35},{49.17,36.39},{48.47,36.44},{48.37,36.45},{47.76,36.49},{47.26,36.54},{46.63,36.57},{46.08,36.54},{45.48,36.54},{45.03,36.56},{44.48,36.55},{44.15,36.54},{43.67,37.26},{43.36,37.80},{43.03,38.47},{43.02,39.06},{43.04,39.96},{43.04,40.69},{42.73,41.43},{42.49,41.72},{42.19,42.10},{41.75,42.72},{41.15,43.54},{40.90,44.00},{40.57,44.69},{40.30,45.27},{40.17,45.83},{40.05,46.62},{39.89,47.51},{39.70,48.52},{39.55,49.25},{39.39,50.11},{39.39,50.14},{39.23,50.90},{38.99,52.08},{39.02,52.66},{39.62,53.15},{40.43,54.12},{40.66,55.01},{40.68,55.08},{41.18,56.39},{41.68,57.19},{42.06,57.65},{42.34,57.65},{42.85,57.54},{43.32,57.28},{43.99,56.63},{44.20,56.07},{44.63,55.00},{44.77,54.39},{44.34,53.87},{43.98,53.36},{44.08,52.71},{44.46,52.10},{44.77,51.93},{45.27,51.58},{45.60,51.40},{46.13,51.01},{46.67,50.65},{47.02,50.39},{47.48,49.99},{47.86,49.68},{48.41,49.20},{48.87,48.78},{49.35,48.36},{49.70,48.05},{50.30,47.47},{50.68,47.13},{50.94,46.90},{51.58,46.32},{51.82,45.94},{52.14,45.19},{52.45,44.58},{52.56,43.69},{52.59,42.92},{52.63,42.42},{52.88,41.37},{53.00,41.04},{53.34,40.59},{53.87,40.43},{54.57,40.50},{55.04,40.75},{55.45,40.97},{56.09,41.16},{56.43,41.27},{57.10,40.65},{57.22,39.84},{57.47,38.37},{57.35,38.12},{56.71,37.47},{55.94,36.80},{55.37,36.46},{55.13,36.33},{54.31,35.90},{53.31,35.44},{52.69,35.54},{51.61,35.86},{51.47,35.90},{50.69,36.10},{50.23,36.25},{50.22,36.26},{48.89,36.35},{48.63,36.37},{47.90,36.41},{47.86,36.42},{46.96,36.49},{46.35,36.50},{46.05,36.49},{45.86,36.49},{44.86,36.50},{44.24,36.48},{43.72,37.20},{43.17,38.01},{42.95,38.57},{42.99,39.40},{43.00,39.59},{42.99,40.90},{42.38,41.85},{41.29,43.30},{41.03,43.73},{40.87,44.02},{40.84,44.08},{40.32,45.18},{40.08,46.43},{39.78,48.14},{39.49,49.67},{39.19,51.19},{39.15,51.41},{38.81,52.84},{38.53,53.81},{38.33,54.53},{38.14,55.37},{38.18,56.08},{38.25,56.72},{38.25,57.49},{38.44,58.04},{38.93,59.41},{39.37,60.69},{39.59,61.29},{39.93,62.15},{40.11,62.49},{40.54,63.35},{40.88,64.37},{41.05,64.99},{41.25,65.52},{41.52,66.27},{41.71,66.75},{41.99,67.49},{42.08,68.19},{41.86,69.00},{41.43,69.92},{41.03,70.42},{40.92,70.57},{40.44,71.21},{39.80,72.10},{39.75,72.17},{39.07,72.83},{38.54,73.30},{38.26,73.55},{37.68,74.16},{37.68,75.16},{37.72,75.80},{37.73,76.33},{37.73,77.17},{37.73,77.95},{37.42,78.01},{36.67,77.77},{36.41,77.70},{35.75,77.50},{35.63,77.13},{35.57,76.09},{35.57,75.10},{35.59,74.71},{35.96,74.37},{36.50,74.29},{36.85,74.23},{37.70,74.08},{38.19,73.70},{39.15,72.88},{40.00,71.95},{40.44,71.28},{41.03,70.41},{41.50,69.69},{41.55,69.56},{41.64,68.38},{41.59,67.72},{41.54,67.16},{41.49,66.37},{41.31,65.48},{41.15,65.00},{40.97,64.27},{41.02,64.26},{42.23,64.35},{43.32,64.43},{44.23,64.51},{44.44,64.52},{45.10,64.56},{45.53,64.57},{46.10,64.71},{46.59,64.76},{46.94,64.33},{46.93,63.66},{46.56,63.66},{46.34,64.17},{46.72,64.62},{46.95,64.37},{46.89,63.87},{46.45,63.86},{46.49,64.51},{46.92,64.51},{46.99,64.10},{46.66,63.70},{46.36,64.09},{46.59,64.65},{47.04,64.80},{47.49,65.19},{47.82,65.61},{48.18,66.03},{48.77,65.89},{49.25,65.76},{49.65,65.43},{49.94,65.08},{50.37,64.55},{50.62,64.17},{50.73,63.26},{50.37,62.71},{50.05,62.27},{49.68,61.73},{49.51,61.19},{49.31,60.51},{49.02,59.49},{48.80,59.19},{48.28,58.59},{48.00,58.32},{47.59,58.03},{46.75,58.06},{46.23,58.16},{45.65,58.46},{45.09,58.72},{44.70,58.97},{44.35,59.40},{44.10,59.71},{43.52,60.74},{43.29,61.34},{43.03,62.00},{42.83,62.50},{42.81,62.55},{42.23,64.12},{42.14,65.12},{42.10,65.86},{42.07,66.52},{42.30,67.36},{42.53,68.06},{42.76,68.73},{43.10,69.35},{43.43,69.99},{43.67,70.32},{43.84,70.77},{44.15,71.63},{44.31,72.11},{44.52,72.76},{44.84,73.65},{45.07,74.16},{45.24,74.55},{45.77,75.79},{46.13,76.82},{46.54,77.90},{46.95,78.69},{47.62,78.92},{48.30,79.08},{48.74,79.23},{49.32,79.43},{49.87,79.62},{50.37,79.80},{50.80,79.78},{51.24,79.45},{51.71,79.16},{52.20,78.82},{52.52,78.27},{52.56,77.55},{52.63,76.54},{52.61,75.99},{52.39,75.38},{52.25,74.98}}}},
        },
        [10993] = { -- Twizwick Sprocketgrind
            [npcKeys.questEnds_add] = {97930},
        },
        [11051] = { -- Vhan
            [npcKeys.questEnds_add] = {97937},
        },
        [14242] = { -- Sulhasa
            [npcKeys.name] = "Sulhasa",
        },
        [14624] = { -- Master Smith Burninate <The Thorium Brotherhood>
            [npcKeys.npcFlags] = npcFlags.REPAIR + npcFlags.VENDOR, -- base data adds a wrong auctioneer bit
        },
        [15734] = { -- Ironforge Commendation Officer
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.QUEST_GIVER + npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [15736] = { -- Orgrimmar Commendation Officer
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.QUEST_GIVER + npcFlags.VENDOR, -- Era flags, sells Forever items
        },
        [185317]= { -- Incubus
            [npcKeys.name] = "Incubus",
        },
        [205729] = { -- Boarton Shadetotem
            [npcKeys.spawns] = {[zoneIDs.THUNDER_BLUFF] = {{39.44,65.82}}},
        },
        [211022] = { -- Owen Thadd
            [npcKeys.spawns] = {[zoneIDs.UNDERCITY] = {{73.4,33}}}, -- TBD
            [npcKeys.questStarts_add] = {78150,79536,82208,78124,78127,78142,78143,78145,78146,78147,78148,78149,79091,79092,79093,79094,79095,79096,79097,79535,79947,79948,79949,79950,79951,79952,79953,81947,81949,81951,81952,81953,81954,81955,81956,97286},
            [npcKeys.questEnds_add] = {78124,78127,78142,78143,78145,78146,78147,78148,78149,79091,79092,79093,79094,79095,79096,79097,79535,79947,79948,79949,79950,79951,79952,79953,81947,81949,81951,81952,81953,81954,81955,81956,97286},
        },
        [211033] = { -- Garion Wendell
            [npcKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{48.94,86.54}}}, -- TBD
            [npcKeys.questStarts_add] = {78150,79536,82208,78124,78127,78142,78143,78145,78146,78147,78148,78149,79091,79092,79093,79094,79095,79096,79097,79535,79947,79948,79949,79950,79951,79952,79953,81947,81949,81951,81952,81953,81954,81955,81956,97286},
            [npcKeys.questEnds_add] = {78124,78127,78142,78143,78145,78146,78147,78148,78149,79091,79092,79093,79094,79095,79096,79097,79535,79947,79948,79949,79950,79951,79952,79953,81947,81949,81951,81952,81953,81954,81955,81956,97286},
        },
        [214519] = { -- Incinerator Gar'im
            [npcKeys.spawns] = {[zoneIDs.REDRIDGE_MOUNTAINS] = {{72.82,86.33}}},
        },
        [214954] = { -- Rix Xizzix
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- traces record no flags
        },
        [227853] = { -- Pix Xizzix
            [npcKeys.npcFlags] = npcFlags.VENDOR, -- traces record no flags
        },
        [246143] = { -- Frightened Paladin
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{27.69,63.82}}},
        },
        [246378] = { -- Danitha Morr
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{22.09,44.66}}},
        },
        [246389] = { -- Hilda the Breaker
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{21.96,47.25}}},
        },
        [246393] = { -- Jorin Croge
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{22.69,44.7}}},
        },
        [246394] = { -- Ander Solliden
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{25.41,50.41}}},
            [npcKeys.waypoints] = {[zoneIDs.TIRISFAL_GLADES] = {{{25.41,50.41},{25.39,50.43},{25.31,50.49},{25.27,50.50},{25.16,50.51},{25.13,50.51},{25.08,50.52},{24.96,50.55},{24.86,50.61},{24.75,50.67},{24.67,50.64},{24.58,50.53},{24.47,50.40},{24.35,50.26},{24.25,50.13},{24.14,49.96},{24.07,49.93},{23.98,49.92},{23.93,49.91},{23.86,49.90},{23.78,49.89},{23.72,49.87},{23.64,49.85},{23.57,49.82},{23.52,49.80},{23.42,49.79},{23.41,49.78},{23.27,49.77},{23.27,49.77},{23.24,49.77},{23.15,49.76},{23.10,49.76},{23.08,49.76},{22.99,49.74},{22.98,49.74},{22.92,49.74},{22.86,49.74},{22.79,49.73},{22.75,49.73},{22.70,49.72},{22.63,49.70},{22.54,49.67},{22.47,49.65},{22.42,49.64},{22.33,49.62},{22.30,49.60},{22.28,49.59},{22.24,49.52},{22.21,49.47},{22.20,49.45},{22.19,49.42},{22.18,49.40}}}},
        },
        [247223] = { -- Nancy Songflower
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{52.41,43.87}}},
        },
        [247226] = { -- Kelsey Fargo
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{47.18,32.16}}},
        },
        [247227] = { -- Riley Peltskinner
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{46.96,39.92}}},
        },
        [247229] = { -- Daniel
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{49.48,40.67}}},
        },
        [248242] = { -- Hamish Bergwort
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{65.1,69.84}}},
        },
        [248248] = { -- Blixie Fitzwink
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{63.2,72.6}}},
        },
        [248265] = { -- Ormin Pelford
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{76.54,71.92}}},
        },
        [248266] = { -- Hagar Lowe
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{82.47,63.83}}},
        },
        [248277] = { -- Merell Ross
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{84.75,79.3}}},
        },
        [248362] = { -- Shinyfinder Narf
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{49.22,28.01}}},
        },
        [248415] = { -- Tordrin Sternblade
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{51.21,40.8}}},
        },
        [248464] = { -- Nimsy
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{41.62,79.9}}},
        },
        [248474] = { -- Geosculptor Yip
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{61.38,48.93}}},
        },
        [249713] = { -- Odd Child
            [npcKeys.spawns] = {[zoneIDs.WESTFALL] = {{42.83,72.76}}},
        },
        [250929] = { -- Malfunctioning Cyclone Construct
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.87,78.25}}},
        },
        [251001] = { -- Deathguard Kristof
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{65.25,60.2}}},
        },
        [251115] = { -- Urs'anah
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.65,26.07}}},
        },
        [251145] = { -- Al'Aketh Brute
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [251160] = { -- Al'Aketh Convert
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [251166] = { -- Minor Manifestation of Earth
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{49.67,23.8}}},
        },
        [251261] = { -- Hippogryph Matriarch
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{33.04,54.63},{35.23,54.08}}},
        },
        [251361] = { -- Rorian the Dayseeker
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.05,23.49}}},
        },
        [251364] = { -- Destin Thriceforged
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.43,23.5}}},
        },
        [251365] = { -- Jolee Brightmeadows
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.52,23.6}}},
        },
        [251404] = { -- Cirrusfly Queen
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.41,28.53}}},
        },
        [251448] = { -- Al'Aketh Neophyte
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [251451] = { -- Al'Aketh Ambusher
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [251507] = { -- Josephine Carson
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{41.15,66.23}}},
        },
        [251537] = { -- Uualia Suncrest
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.75,24.49}}},
        },
        [251684] = { -- Strange Hermit
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{53.96,38.9}}},
        },
        [251905] = { -- Zerril Softbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.85,43.84}}},
        },
        [251965] = { -- Fevrath Skyhammer
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.37,23.44}}},
        },
        [251966] = { -- Commander Cyclas
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.39,56.96}}},
        },
        [251968] = { -- Ayessa Dawnsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.15,79.78}}},
        },
        [251993] = { -- Indari Sunseam
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{44.68,44.52}}},
        },
        [252068] = { -- Al'Aketh Stormcaller
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252172] = { -- Danarii Bellowveil
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.24,45.18}}},
        },
        [252373] = { -- Anathamaas Aetherwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.91,80.57}}},
        },
        [252376] = { -- Emerii Tallgust
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{63.73,80.68}}},
        },
        [252379] = { -- Eltheen Nightbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.9,72.48}}},
        },
        [252380] = { -- Othesia Evengale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.41,81.17}}},
        },
        [252388] = { -- Halavuul Cragwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.44,80.47}}},
        },
        [252390] = { -- Antelariaa Cloudgaze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{63.02,77.81}}},
        },
        [252449] = { -- Iallion Featherfall
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{58.96,75.55}}},
        },
        [252475] = { -- Elaadrin Evengale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.63,79.94}}},
        },
        [252476] = { -- Talaanis Shadowsong
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.17,76.51}}},
        },
        [252479] = { -- Daeann Steelwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.47,80.28}}},
        },
        [252664] = { -- Al'Aketh Stormchaser
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252665] = { -- Al'Aketh Footsoldier
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252666] = { -- Commander Belguilos
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.58,65.62}}},
        },
        [252762] = { -- Al'Aketh Guardian
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252763] = { -- Al'Aketh Spiritcaller
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252764] = { -- Al'Aketh Skypriest
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252765] = { -- Al'Aketh Blademaster
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252767] = { -- Al'Aketh Honor Guard
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [252800] = { -- Aamelia Windfield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.7,81.95}}},
        },
        [253004] = { -- Iaadaria Bitterwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.34,79.5}}},
        },
        [253195] = { -- Al'Aketh Preacher
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [253204] = { -- Dondallion Whisperwind
            [npcKeys.questEnds_remove] = {92850},
        },
        [253370] = { -- [DNT] Kill Credit: Place Explosives
            [npcKeys.spawns] = {[zoneIDs.THE_DEADMINES] = {{-1,-1}}},
            [npcKeys.zoneID] = zoneIDs.THE_DEADMINES,
        },
        [253511] = { -- Al'Aketh Pillager
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [253622] = { -- Commander Haalien
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.53,36.32}}},
        },
        [253782] = { -- Al'Aketh Attacker
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [253847] = { -- Elaadrin Evengale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.17,52.57}}},
        },
        [253849] = { -- Ayessa Dawnsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.05,52.63}}},
        },
        [254056] = { -- Mr. Barber
            [npcKeys.spawns] = {[zoneIDs.ORGRIMMAR] = {{47.15,53.89}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.BARBER,
            [npcKeys.friendlyToFaction] = "H", -- blizzard totally forgot to readd this barber after the exchange
        },
        [254081] = { -- Naeluna Swiftmend
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.16,44.22}}},
        },
        [254082] = { -- Aarnor Galestrike
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.45,44.87}}},
            [npcKeys.questStarts] = {97243},
        },
        [254084] = { -- Elayaa Easewind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.26,44.24}}},
        },
        [254086] = { -- Shenaan Spellwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.1,45.87}}},
        },
        [254087] = { -- Miriaan Mistblade
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.15,43.26}}},
        },
        [254088] = { -- Corsan Earthrazer
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{44.95,45.1}}},
        },
        [254089] = { -- Coriella Calmbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.01,43.23}}},
        },
        [254128] = { -- Wardrobe
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.84,53.93}}},
        },
        [254358] = { -- Veena Vericloud
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{44.71,45.48}}},
        },
        [254360] = { -- Belandiel Farflight
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{44.77,45.05}}},
        },
        [254589] = { -- Vulgara the Insatiable
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.66,52.8}}},
        },
        [254596] = { -- Al'Aketh Healer
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [254626] = { -- Al'Aketh Assassin
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [255013] = { -- DNT KILL CREDIT
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.16,60.59}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [255534] = { -- "Badwind" Bennic
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.62,34.27}}},
        },
        [255940] = { -- Donaal Downbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{62.19,72.61}}},
        },
        [256386] = { -- Dokimi
            [npcKeys.questStarts_add] = {91905},
        },
        [256388] = { -- Jornah
            [npcKeys.questEnds_add] = {95819},
        },
        [256390] = { -- Marcy Baker
            [npcKeys.questStarts_add] = {91901},
            [npcKeys.questEnds_add] = {91901},
        },
        [256391] = { -- Elaine Compton
            [npcKeys.questEnds_add] = {95816},
        },
        [256507] = { -- Belann Windwood
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{62.89,77.44}}},
        },
        [256935] = { -- Malduko Cloudcrush
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.05,33.53}}},
        },
        [256996] = { -- Al'Aketh Warrior
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [257003] = { -- Ishlee Breezewhisper
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.63,76.06}}},
        },
        [257004] = { -- Eaysaa Brightgust
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.19,76.4}}},
        },
        [257005] = { -- Valiena Swiftgale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.25,76.32}}},
        },
        [257006] = { -- Nyalah Brightfire
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{60.64,72.66}}},
        },
        [257007] = { -- Melasa Fairmend
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{63.17,72.56}}},
        },
        [257008] = { -- Baelann Swiftcurrent
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{63.27,75.72}}},
        },
        [257021] = { -- Halassa Fernbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.96,43.54}}},
        },
        [257036] = { -- Baelann Favorbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{57.63,77.17}}},
        },
        [257037] = { -- Zelena Favorbreeze
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{57.91,77.12}}},
            [npcKeys.npcFlags] = npcFlags.AUCTIONEER,
        },
        [257196] = { -- Zaal Stormshield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.63,50.37}}},
        },
        [257421] = { -- Tephri Thriceforged
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{44.79,44.17}}},
        },
        [257422] = { -- Railee Thriceforged
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{58.98,75.46}}},
        },
        [257446] = { -- Teo Hammerstorm
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{28.79,66.18}}},
            [npcKeys.questStarts_add] = {94375},
        },
        [257597] = { -- Bruegs Kindleborn
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{87.94,44.8}}},
        },
        [257648] = { -- Tanis Alderwood
            [npcKeys.spawns] = {[zoneIDs.UNDERCITY] = {{65.48,37.49}}},
        },
        [257655] = { -- Deathguard Billmuth
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{21.916,44.4979}}},
        },
        [257808] = { -- Braldir Ashmantle
            [npcKeys.spawns] = {[zoneIDs.LOCH_MODAN] = {{32.17,65.97}}},
        },
        [258113] = { -- Ingrid Dunwald
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{47.58,51.95}}},
        },
        [258130] = { -- Jorel Windsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.48,34.74}}},
        },
        [258134] = { -- Naaleos Leafwhisper
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.96,34.95}}},
        },
        [258137] = { -- Telenos Leafwhisper
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.69,35.02}}},
        },
        [258138] = { -- Nayeela Snarlfang
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.52,34.89}}},
        },
        [258275] = { -- Neyasteel Mossmender
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.01,31.96}}},
        },
        [258277] = { -- Bryaes Galechaser
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.43,31.9}}},
        },
        [258288] = { -- Mithraless Sterngale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.8,32.96}}},
        },
        [258289] = { -- Baeo Sharpstrike
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.92,33.55}}},
        },
        [258930] = { -- Isaac Chan
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{41.79,66.37}}},
        },
        [259013] = { -- Resaan Nimbuswalker
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{57.05,29.35}}},
        },
        [259431] = { -- Rudolph Gelhardt
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{11.51,64.18}}},
        },
        [261319] = { -- Durgen Dirgehammer
            [npcKeys.spawns] = {[zoneIDs.THE_HALL_OF_THANES] = {{-1,-1}}},
            [npcKeys.zoneID] = zoneIDs.THE_HALL_OF_THANES,
        },
        [263389] = { -- Enraged Apparition
            [npcKeys.spawns] = {[zoneIDs.THE_HALL_OF_THANES] = {{-1,-1}}},
            [npcKeys.zoneID] = zoneIDs.THE_HALL_OF_THANES,
        },
        [263390] = { -- Tormented Soul
            [npcKeys.spawns] = {[zoneIDs.THE_HALL_OF_THANES] = {{-1,-1}}},
            [npcKeys.zoneID] = zoneIDs.THE_HALL_OF_THANES,
        },
        [263399] = { -- Sam Sarsaparilla
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{44.9,63.36}}},
        },
        [264936] = { -- Earthseer Farsen
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{64.87,58.47}}},
        },
        [265654] = { -- Faladriaal Featherfall
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{61.14,76.74}}},
        },
        [265756] = { -- Genn Fairweather
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{53.83,81.33}}},
        },
        [265810] = { -- Kaga Wildhoof
            [npcKeys.questStarts_add] = {97930},
        },
        [265811] = { -- Lyreena Duskblade
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{57.58,56.64}}},
        },
        [266940] = { -- Turroc
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{53.95,42.59}}},
        },
        [267009] = { -- Hadric Harlson
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{65.93,61.13}}},
        },
        [267324] = { -- Margaret Weaver
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{32.6,65.81}}},
        },
        [267325] = { -- Walter Mason
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{32.22,65.82}}},
        },
        [267326] = { -- Florence Nightshade
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{32.46,65.14}}},
        },
        [267327] = { -- Kagil
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{40.78,67.86}}},
        },
        [267328] = { -- Norzsh
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{40.53,68.14}}},
        },
        [267329] = { -- Zor'la
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{42.66,67.39}}},
        },
        [267330] = { -- Nawka Wildsong
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{44.49,76.69}}},
        },
        [267331] = { -- Vartha Rockmane
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{44.29,78.36}}},
        },
        [267332] = { -- Garan Sunstrider
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{44.13,77.97}}},
        },
        [267333] = { -- Terunne Bearshaper
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{59.39,38.63}}},
        },
        [267334] = { -- Fanorran Stilloak
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{58.16,41.42}}},
        },
        [267335] = { -- Eleyna Duskbreeze
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{59.86,41.31}}},
        },
        [267336] = { -- Brighid Stormflayer
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{29.19,67.73}}},
        },
        [267337] = { -- Sally Swiftwrench
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{28.93,67.72}}},
        },
        [267338] = { -- Emrys Flintbeard
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{28.95,66.59}}},
        },
        [267806] = { -- "Flipfin"
            [npcKeys.questEnds_add] = {97065,97066,97067},
        },
        [268238] = { -- Nordun Steadysight
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{42.01,66.39}}},
        },
        [268511] = { -- Manifest Clerk Philmor
            [npcKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{30.49,28.75}}},
        },
        [268530] = { -- Bloodtalon Matriarch
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{68.81,71.78}}},
        },
        [268558] = { -- Chakuyak
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{39.46,66.18}}},
        },
        [268602] = { -- Skypriest Faladiel
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{64.43,63.71}}},
        },
        [268605] = { -- Kuramaa
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.44,68.75}}},
        },
        [268679] = { -- Brazier of Eternal Flame
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{58.35,78.84}}},
        },
        [268762] = { -- Brazier of Offering
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{51.2,85.9}}},
        },
        [269068] = { -- Eylah Sunhorn
            [npcKeys.spawns] = {[zoneIDs.THUNDER_BLUFF] = {{38,55.9}}},
        },
        [269075] = { -- Snow Leopard Prowler
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{27.37,62.86}}},
        },
        [270201] = { -- Al'Aketh Brawler
            [npcKeys.friendlyToFaction] = {}, -- Clear incorrect trace data. These are hostile
        },
        [270263] = { -- Farseer Maret Firetend
            [npcKeys.spawns] = {[zoneIDs.THE_HINTERLANDS] = {{14.4,42.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
            [npcKeys.friendlyToFaction] = "A",
            [npcKeys.npcFlags] = npcFlags.TRAINER,
        },
        [270278] = { -- Bordolf Axegrim
            [npcKeys.spawns] = {[zoneIDs.THE_HINTERLANDS] = {{14.4,43.0}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
            [npcKeys.friendlyToFaction] = "A",
            [npcKeys.npcFlags] = npcFlags.TRAINER,
        },
        [270280] = { -- Torin Treehame
            [npcKeys.spawns] = {[zoneIDs.THE_HINTERLANDS] = {{14.6,43.0}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
            [npcKeys.friendlyToFaction] = "A",
            [npcKeys.npcFlags] = npcFlags.TRAINER,
        },
        [270418] = { -- Credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[zoneIDs.DARNASSUS] = {{33.39,16.77}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [270419] = { -- Credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[zoneIDs.DARNASSUS] = {{41.04,43.55}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [270420] = { -- Credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[zoneIDs.DARNASSUS] = {{66.46,15.35}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [270421] = { -- Credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[zoneIDs.DARNASSUS] = {{89.14,34.76}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [270581] = { -- Fyrenz Vishonar
            [npcKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{47.96,84.6}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.TRANSMOGRIFIER,
        },
        [270582] = { -- Mon'ye
            [npcKeys.spawns] = {[zoneIDs.ORGRIMMAR] = {{46.14,53.97}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.TRANSMOGRIFIER,
        },
        [271465] = { -- Falfaan Halfwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.4,75.73}}},
        },
        [271478] = { -- Elaria Anvilwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.54,76.14}}},
        },
        [271480] = { -- Taliaa Brightsky
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.33,76.24}}},
        },
        [271483] = { -- Ergaan Eastwind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{59.72,75.95}}},
        },
        [271546] = { -- Mountaineer Gretchen
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{44.1,57.07}}},
        },
        [271587] = { -- Frosthowl
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{39.33,48.79}}},
        },
        [272034] = { -- Hatescreech
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{35.05,39.29}}},
        },
        [272044] = { -- Windmistress Gaedress
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{33.18,36.13}}},
        },
        [272046] = { -- Witchmother Arysa
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{34.22,27.94}}},
        },
        [272173] = { -- Venture Co. Clearclutter
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{56.76,42.75}}},
        },
        [272526] = { -- Glix Xizzix
            [npcKeys.spawns] = {[zoneIDs.UNDERCITY] = {{70.03,47.31}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.BARBER,
        },
        [273264] = { -- Talisara Valewind
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.49,45.37}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [275491] = { -- Randal Emerson
            [npcKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{78.98,45}}},
        },
        [275657] = { -- Heglan Shadeeye
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{58.6,45.6}}},
        },
        [275666] = { -- Aggor the Young
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{59.22,17.6}}},
        },
        [275683] = { -- Sentinel Eralya Leafshadow
            [npcKeys.spawns] = {[zoneIDs.TELDRASSIL] = {{37.54,36.81}}},
        },
        [275789] = { -- Malah Longwind
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{57.62,63.18}}},
        },
        [275811] = { -- Pal'juh
            [npcKeys.spawns] = {[zoneIDs.DUROTAR] = {{46.3,78.64}}},
        },
        [276009] = { -- Avala
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{58.34,42.06}}},
        },
        [277024] = { -- Jelinek Sharpshear
            [npcKeys.spawns] = {[zoneIDs.STORMWIND_CITY] = {{61.44,64.94}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.BARBER,
        },
        [277037] = { -- Donovan Steelbeard
            [npcKeys.spawns] = {[zoneIDs.IRONFORGE] = {{26.71,50.27}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.BARBER,
            [npcKeys.friendlyToFaction] = "A",
        },
        [277042] = { -- Teuren Vineshade
            [npcKeys.name] = "Teuren Vineshade",
            [npcKeys.spawns] = {[zoneIDs.DARNASSUS] = {{58.85,50.23}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.BARBER,
        },
        [277055] = { -- Edine Sharphorn
            [npcKeys.name] = "Edine Sharphorn",
            [npcKeys.spawns] = {[zoneIDs.THUNDER_BLUFF] = {{35.51,54.15}}},
            [npcKeys.npcFlags] = npcFlags.GOSSIP + npcFlags.BARBER,
        },
        [277154] = { -- Kyle the Frenzied
            [npcKeys.name] = "Kyle the Frenzied",
            [npcKeys.minLevelHealth] = 272,
            [npcKeys.maxLevelHealth] = 272,
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.rank] = 0,
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{46.28,62.34}}},
            [npcKeys.waypoints] = {[zoneIDs.MULGORE] = {{{46.28,62.34},{46.27,62.50},{46.20,62.60},{46.12,62.74},{46.07,62.85},{46.07,63.05},{46.13,63.18},{46.23,63.30},{46.34,63.41},{46.45,63.52},{46.56,63.62},{46.69,63.67},{46.81,63.74},{46.91,63.87},{47.01,64.01},{47.09,64.16},{47.17,64.32},{47.25,64.48},{47.33,64.64},{47.38,64.83},{47.39,64.97},{47.40,65.18},{47.43,65.38},{47.45,65.49},{47.48,65.69},{47.53,65.88},{47.60,66.05},{47.68,66.22},{47.76,66.35},{47.86,66.45},{47.97,66.51},{48.05,66.48},{48.12,66.39},{48.10,66.30},{48.04,66.12},{47.97,65.94},{47.90,65.76},{47.83,65.59},{47.75,65.41},{47.68,65.24},{47.63,65.05},{47.66,64.92},{47.74,64.75},{47.82,64.58},{47.91,64.42},{47.99,64.25},{48.07,64.08},{48.13,63.89},{48.18,63.69},{48.23,63.49},{48.24,63.29},{48.24,63.15},{48.23,62.94},{48.22,62.73},{48.21,62.52},{48.19,62.36},{48.16,62.18},{48.08,61.99},{48.00,61.82},{47.92,61.65},{47.85,61.59},{47.74,61.53},{47.60,61.47},{47.46,61.44},{47.35,61.45},{47.21,61.49},{47.06,61.52},{46.96,61.54},{46.81,61.54},{46.75,61.55},{46.74,61.55},{46.63,61.54},{46.52,61.54},{46.40,61.55},{46.34,61.69},{46.30,61.85},{46.29,62.02},{46.28,62.20},{46.28,62.34}}}},
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = nil,
            [npcKeys.questEnds] = nil,
            [npcKeys.factionID] = 35,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [277182] = { -- Ahab Wheathoof
            [npcKeys.name] = "Ahab Wheathoof",
            [npcKeys.minLevelHealth] = 4208,
            [npcKeys.maxLevelHealth] = 4208,
            [npcKeys.minLevel] = 62,
            [npcKeys.maxLevel] = 62,
            [npcKeys.rank] = 0,
            [npcKeys.spawns] = {[zoneIDs.MULGORE] = {{47.28,57.63}}},
            [npcKeys.waypoints] = {},
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {99411},
            [npcKeys.questEnds] = {99411},
            [npcKeys.factionID] = 105,
            [npcKeys.friendlyToFaction] = "H",
            [npcKeys.subName] = "The Old Rancher",
            [npcKeys.npcFlags] = 3,
        },
        [277410] = { -- Ahab Wheathoof
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{43.03,43.13}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [278166] = { -- Mountaineer Cornelius
            [npcKeys.name] = "Mountaineer Cornelius",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[zoneIDs.DUN_MOROGH] = {{43.03,49.62}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
    }
end

-- Dynamic Corrections: selected from character/game facts such as faction, race or class.
-- These override legacy Dynamic Corrections and all Static Corrections at query time.
function ForeverNpcFixes:LoadDynamic()
    local npcKeys = QuestieDB.npcKeys
    local zoneIDs = ZoneDB.zoneIDs
    local npcFlags = QuestieDB.npcFlags
    local waypointPresets = QuestieDB.waypointPresets
    local phases = Phasing.phases

    return {
        -- [npcId] = { [npcKeys.name] = "Character-specific name" },
    }
end
