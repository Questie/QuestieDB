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
        [247226] = { -- Kelsey Fargo
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{47.18,32.16}}},
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
        [251001] = { -- Deathguard Kristof
            [npcKeys.spawns] = {[zoneIDs.TIRISFAL_GLADES] = {{65.25,60.2}}},
        },
        [251115] = { -- Urs'anah
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{35.65,26.07}}},
        },
        [251166] = { -- Minor Manifestation of Earth
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{49.67,23.8}}},
        },
        [251361] = { -- Rorian the Dayseeker
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.05,23.49}}},
        },
        [251966] = { -- Commander Cyclas
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.39,56.96}}},
        },
        [251261] = { -- Hippogryph Matriarch
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{33.04,54.63},{35.23,54.08}}},
        },
        [251404] = { -- Cirrusfly Queen
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.41,28.53}}},
        },
        [251507] = { -- Josephine Carson
            [npcKeys.spawns] = {[zoneIDs.ELWYNN_FOREST] = {{41.15,66.23}}},
        },
        [251684] = { -- Strange Hermit
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{53.96,38.9}}},
        },
        [252172] = { -- Danarii Bellowveil
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.24,45.18}}},
        },
        [252476] = { -- Talaanis Shadowsong
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{66.17,76.51}}},
        },
        [252666] = { -- Commander Belguilos
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.58,65.62}}},
        },
        [252800] = { -- Aamelia Windfield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{46.7,81.95}}},
        },
        [253204] = { -- Dondallion Whisperwind
            [npcKeys.questEnds_remove] = {92850},
        },
        [253370] = { -- [DNT] Kill Credit: Place Explosives
            [npcKeys.spawns] = {[zoneIDs.THE_DEADMINES] = {{-1,-1}}},
            [npcKeys.zoneID] = zoneIDs.THE_DEADMINES,
        },
        [253622] = { -- Commander Haalien
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{65.53,36.32}}},
        },
        [253847] = { -- Elaadrin Evengale
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.17,52.57}}},
        },
        [253849] = { -- Ayessa Dawnsinger
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{74.05,52.63}}},
        },
        [254082] = { -- Aarnor Galestrike
            [npcKeys.questStarts] = {97243},
        },
        [254084] = { -- Elayaa Easewind
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{45.26,44.24}}},
        },
        [254128] = { -- Wardrobe
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{48.84,53.93}}},
        },
        [254589] = { -- Vulgara the Insatiable
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{42.66,52.8}}},
        },
        [255013] = { -- DNT KILL CREDIT
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.16,60.59}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [255534] = { -- "Badwind" Bennic
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{50.62,34.27}}},
        },
        [256388] = { -- Jornah
            [npcKeys.questEnds_add] = {95819},
        },
        [256391] = { -- Elaine Compton
            [npcKeys.questEnds_add] = {95816},
        },
        [256935] = { -- Malduko Cloudcrush
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{36.05,33.53}}},
        },
        [257196] = { -- Zaal Stormshield
            [npcKeys.spawns] = {[zoneIDs.ZEPHRAS_ISLE] = {{56.63,50.37}}},
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
        [267806] = { -- "Flipfin"
            [npcKeys.questEnds_add] = {97065,97066,97067},
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
