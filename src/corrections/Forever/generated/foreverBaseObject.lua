-- Generated delta-base. Apply after inherited Static Corrections, before authored Forever Static Corrections.
-- Import provenance and refresh policy: docs/forever-delta-base.md.
local ForeverBaseObject = QuestieLoader:CreateModule("ForeverBaseObject")
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
function ForeverBaseObject:Load()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs
    return {
        [3972] = { -- WANTED : https://wowhead.com/forever/object=3972/wanted
            [objectKeys.questStarts_add] = {92706},
        },
        [12666] = { -- Twilight Tome : https://wowhead.com/forever/object=12666/twilight-tome
            [objectKeys.questStarts_add] = {98042},
        },
        [61934] = { -- Brazier of the Dormant Flame : https://wowhead.com/forever/object=61934/brazier-of-the-dormant-flame
            [objectKeys.questStarts_add] = {94468},
            [objectKeys.questEnds_add] = {94467},
        },
        [142487] = { -- The Sparklematic 5200 : https://wowhead.com/forever/object=142487/the-sparklematic-5200
            [objectKeys.questStarts_add] = {79987, 80140, 80155, 80157, 80158},
            [objectKeys.questEnds_add] = {79986, 80155, 80157, 80158},
        },
        [148512] = { -- Essence Font : https://wowhead.com/forever/object=148512/essence-font
            [objectKeys.questEnds_add] = {82102},
        },
        [148836] = { -- Altar of Hakkar : https://wowhead.com/forever/object=148836/altar-of-hakkar
            [objectKeys.questEnds_add] = {82096},
        },
        [175084] = { -- The Sparklematic 5200 : https://wowhead.com/forever/object=175084/the-sparklematic-5200
            [objectKeys.questStarts_add] = {80153, 80160, 80161},
            [objectKeys.questEnds_add] = {80153, 80160, 80161},
        },
        [175320] = { -- WANTED: Murkdeep! : https://wowhead.com/forever/object=175320/wanted-murkdeep
            [objectKeys.questStarts_add] = {98025},
        },
        [175725] = { -- The Old Gods and the Ordering of Azeroth : https://wowhead.com/forever/object=175725/the-old-gods-and-the-ordering-of-azeroth
            [objectKeys.name] = "The Old Gods and the Ordering of Azeroth",
            [objectKeys.spawns] = {[11] = {{9.9, 57.4}, {9.9, 57.5}}, [1497] = {{55.9, 50.9}}, [1537] = {{75.6, 10.4}, {75.9, 11.5}, {76.1, 11}}, [1657] = {{55.4, 24}, {55.4, 24.5}, {55.5, 24}, {55.5, 24.5}}},
        },
        [175736] = { -- Ironforge - the Awakening of the Dwarves : https://wowhead.com/forever/object=175736/ironforge-the-awakening-of-the-dwarves
            [objectKeys.name] = "Ironforge - the Awakening of the Dwarves",
            [objectKeys.spawns] = {[17] = {{49.4, 84.4}, {49.5, 84.4}}, [38] = {{35.4, 49}, {35.6, 49}}, [440] = {{36.9, 77}}, [1537] = {{74.9, 9.1}, {74.9, 9.6}}},
        },
        [175739] = { -- War of the Three Hammers : https://wowhead.com/forever/object=175739/war-of-the-three-hammers
            [objectKeys.name] = "War of the Three Hammers",
            [objectKeys.spawns] = {[17] = {{49.1, 84.2}}, [1537] = {{75.1, 9.1}}},
        },
        [175740] = { -- The Last Guardian : https://wowhead.com/forever/object=175740/the-last-guardian
            [objectKeys.name] = "The Last Guardian",
            [objectKeys.spawns] = {[38] = {{37.2, 47}}, [40] = {{52.4, 53.1}, {52.5, 53.1}}},
        },
        [175742] = { -- Rise of the Horde : https://wowhead.com/forever/object=175742/rise-of-the-horde
            [objectKeys.name] = "Rise of the Horde",
            [objectKeys.spawns] = {[8] = {{47.9, 54.9}}, [14] = {{59.6, 58.2}}, [1537] = {{76.8, 12.4}, {77.1, 13}}},
        },
        [175755] = { -- The Alliance Splinters : https://wowhead.com/forever/object=175755/the-alliance-splinters
            [objectKeys.name] = "The Alliance Splinters",
            [objectKeys.zoneID] = zoneIDs.BLACKROCK_DEPTHS,
        },
        [179551] = { -- Hydraxis' Coffer : https://wowhead.com/forever/object=179551/hydraxis-coffer
            [objectKeys.questEnds_add] = {84545},
        },
        [180715] = { -- Holly Preserver : https://wowhead.com/forever/object=180715/holly-preserver
            [objectKeys.questEnds_add] = {79501, 79502},
        },
        [375548] = { -- Unlit Torch : https://wowhead.com/forever/object=375548/unlit-torch
            [objectKeys.name] = "Unlit Torch",
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [375878] = { -- Sandpile : https://wowhead.com/forever/object=375878/sandpile
            [objectKeys.name] = "Sandpile",
            [objectKeys.zoneID] = zoneIDs.BLACKWING_LAIR,
        },
        [386675] = { -- Buried Treasure : https://wowhead.com/forever/object=386675/buried-treasure
            [objectKeys.name] = "Buried Treasure",
            [objectKeys.spawns] = {[1] = {{47, 43.7}}, [12] = {{80.4, 79.4}, {80.5, 79.2}}, [14] = {{62.1, 94.8}}, [85] = {{52.9, 54}}, [141] = {{55.3, 90.8}}},
        },
        [386691] = { -- Library Book : https://wowhead.com/forever/object=386691/library-book
            [objectKeys.name] = "Library Book",
            [objectKeys.spawns] = {[12] = {{65.4, 70.1}}, [1537] = {{75.4, 11}, {75.6, 10.4}, {75.7, 10.5}}},
        },
        [386759] = { -- Library Book : https://wowhead.com/forever/object=386759/library-book
            [objectKeys.name] = "Library Book",
            [objectKeys.spawns] = {[12] = {{65.4, 70.1}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [386777] = { -- Dusty Chest : https://wowhead.com/forever/object=386777/dusty-chest
            [objectKeys.name] = "Dusty Chest",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [387466] = { -- Rusty Lockbox : https://wowhead.com/forever/object=387466/rusty-lockbox
            [objectKeys.name] = "Rusty Lockbox",
            [objectKeys.spawns] = {[1] = {{47, 52}}, [12] = {{46.2, 62.1}}, [14] = {{53.8, 27.2}}},
        },
        [387477] = { -- Defias Stashbox : https://wowhead.com/forever/object=387477/defias-stashbox
            [objectKeys.name] = "Defias Stashbox",
            [objectKeys.spawns] = {[12] = {{52.6, 51.8}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [392029] = { -- Swordsman's Reward : https://wowhead.com/forever/object=392029/swordsmans-reward
            [objectKeys.name] = "Swordsman's Reward",
            [objectKeys.spawns] = {[1] = {{53.4, 47.8}, {53.5, 47.8}}, [12] = {{22.3, 73.3}, {25.3, 70.2}, {30, 73.4}, {38.6, 75.6}, {40.9, 74.7}}, [14] = {{40.9, 49.3}}},
        },
        [397987] = { -- Kobold Stashbox : https://wowhead.com/forever/object=397987/kobold-stashbox
            [objectKeys.name] = "Kobold Stashbox",
            [objectKeys.spawns] = {[12] = {{50.6, 27.2}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [403041] = { -- Blasting Supplies : https://wowhead.com/forever/object=403041/blasting-supplies
            [objectKeys.name] = "Blasting Supplies",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [403102] = { -- Bristleback Loot Cache : https://wowhead.com/forever/object=403102/bristleback-loot-cache
            [objectKeys.name] = "Bristleback Loot Cache",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [403105] = { -- Windfury Cone : https://wowhead.com/forever/object=403105/windfury-cone
            [objectKeys.name] = "Windfury Cone",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [404352] = { -- Artifact Storage : https://wowhead.com/forever/object=404352/artifact-storage
            [objectKeys.name] = "Artifact Storage",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [404402] = { -- Blooming Satyrweed : https://wowhead.com/forever/object=404402/blooming-satyrweed
            [objectKeys.name] = "Blooming Satyrweed",
            [objectKeys.spawns] = {[405] = {{74.4, 19}, {74.5, 19}, {75.9, 16.6}, {75.9, 21.1}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [404433] = { -- Lunar Chest : https://wowhead.com/forever/object=404433/lunar-chest
            [objectKeys.name] = "Lunar Chest",
            [objectKeys.spawns] = {[141] = {{52.8, 78.8}}},
        },
        [404695] = { -- Waterlogged Stashbox : https://wowhead.com/forever/object=404695/waterlogged-stashbox
            [objectKeys.name] = "Waterlogged Stashbox",
            [objectKeys.spawns] = {[14] = {{43, 54.4}, {43, 54.5}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [404830] = { -- Dusty Chest : https://wowhead.com/forever/object=404830/dusty-chest
            [objectKeys.name] = "Dusty Chest",
            [objectKeys.spawns] = {[1637] = {{55.9, 44.7}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [404911] = { -- Hidden Cache : https://wowhead.com/forever/object=404911/hidden-cache
            [objectKeys.name] = "Hidden Cache",
            [objectKeys.spawns] = {[14] = {{43.2, 69.6}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [404941] = { -- Relic Coffer : https://wowhead.com/forever/object=404941/relic-coffer
            [objectKeys.name] = "Relic Coffer",
            [objectKeys.spawns] = {[85] = {{52.5, 25.8}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [405149] = { -- Mural of Ta'zo : https://wowhead.com/forever/object=405149/mural-of-tazo
            [objectKeys.name] = "Mural of Ta'zo",
            [objectKeys.spawns] = {[1637] = {{33.9, 84.4}, {37.9, 79.4}, {38, 77.3}, {38.4, 78}, {38.5, 78.6}, {38.6, 78.4}, {38.8, 77.4}}},
        },
        [405201] = { -- Shipwreck Cache : https://wowhead.com/forever/object=405201/shipwreck-cache
            [objectKeys.name] = "Shipwreck Cache",
            [objectKeys.spawns] = {[85] = {{66.7, 24.6}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [405628] = { -- Frostmane Loot Cache : https://wowhead.com/forever/object=405628/frostmane-loot-cache
            [objectKeys.name] = "Frostmane Loot Cache",
            [objectKeys.spawns] = {[1] = {{30.8, 80.1}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [405633] = { -- Rockjaw Footlocker : https://wowhead.com/forever/object=405633/rockjaw-footlocker
            [objectKeys.name] = "Rockjaw Footlocker",
            [objectKeys.spawns] = {[1] = {{26.8, 72.6}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [405879] = { -- Apothecary Society Primer : https://wowhead.com/forever/object=405879/apothecary-society-primer
            [objectKeys.name] = "Apothecary Society Primer",
            [objectKeys.spawns] = {[85] = {{59.4, 52.3}, {59.5, 52.3}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [405946] = { -- Dusty Chest : https://wowhead.com/forever/object=405946/dusty-chest
            [objectKeys.name] = "Dusty Chest",
            [objectKeys.spawns] = {[1537] = {{51.9, 13}, {52, 13.6}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [406006] = { -- Idol : https://wowhead.com/forever/object=406006/idol
            [objectKeys.name] = "Idol",
            [objectKeys.spawns] = {[141] = {{59.7, 42.6}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [406736] = { -- Lost Stash : https://wowhead.com/forever/object=406736/lost-stash
            [objectKeys.name] = "Lost Stash",
            [objectKeys.spawns] = {[85] = {{24.6, 59.5}, {24.7, 59.4}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [406918] = { -- Messenger Bag : https://wowhead.com/forever/object=406918/messenger-bag
            [objectKeys.name] = "Messenger Bag",
            [objectKeys.questStarts] = {79976},
            [objectKeys.questEnds] = {79975},
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.5, 24.2}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [407347] = { -- Altar of Thorns : https://wowhead.com/forever/object=407347/altar-of-thorns
            [objectKeys.name] = "Altar of Thorns",
            [objectKeys.spawns] = {[17] = {{58.2, 26.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [407352] = { -- Gnarlpine Stash : https://wowhead.com/forever/object=407352/gnarlpine-stash
            [objectKeys.name] = "Gnarlpine Stash",
            [objectKeys.spawns] = {[141] = {{37.9, 82.5}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [407505] = { -- Etched Carving : https://wowhead.com/forever/object=407505/etched-carving
            [objectKeys.name] = "Etched Carving",
            [objectKeys.spawns] = {[17] = {{44.8, 81.4}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [407510] = { -- Etched Carving : https://wowhead.com/forever/object=407510/etched-carving
            [objectKeys.name] = "Etched Carving",
            [objectKeys.spawns] = {[17] = {{45.4, 80}, {45.5, 80}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [407566] = { -- Goblin Tome : https://wowhead.com/forever/object=407566/goblin-tome
            [objectKeys.name] = "Goblin Tome",
            [objectKeys.spawns] = {[17] = {{62.7, 36.3}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [407731] = { -- Stonemason's Toolbox : https://wowhead.com/forever/object=407731/stonemasons-toolbox
            [objectKeys.name] = "Stonemason's Toolbox",
            [objectKeys.spawns] = {[38] = {{46.4, 12.7}, {46.5, 12.7}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [407734] = { -- Gnarlpine Cache : https://wowhead.com/forever/object=407734/gnarlpine-cache
            [objectKeys.name] = "Gnarlpine Cache",
            [objectKeys.spawns] = {[141] = {{43.1, 60.8}, {44.1, 61.2}, {44.5, 62.4}, {44.5, 62.5}, {44.7, 59}, {44.8, 59.9}, {45, 61.4}, {45.3, 58.1}, {45.7, 57}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [407844] = { -- Libram of Blessings : https://wowhead.com/forever/object=407844/libram-of-blessings
            [objectKeys.name] = "Libram of Blessings",
            [objectKeys.spawns] = {[38] = {{35.7, 49.4}, {35.8, 49.5}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [407850] = { -- Sunken Reliquary : https://wowhead.com/forever/object=407850/sunken-reliquary
            [objectKeys.name] = "Sunken Reliquary",
            [objectKeys.spawns] = {[38] = {{36.8, 91.4}, {36.8, 91.5}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [407918] = { -- Empty Trophy Display : https://wowhead.com/forever/object=407918/empty-trophy-display
            [objectKeys.name] = "Empty Trophy Display",
            [objectKeys.spawns] = {[38] = {{83.6, 65.4}, {83.6, 65.5}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [407983] = { -- Pile of Stolen Books : https://wowhead.com/forever/object=407983/pile-of-stolen-books
            [objectKeys.name] = "Pile of Stolen Books",
            [objectKeys.spawns] = {[38] = {{54.2, 27}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [408004] = { -- Tangled Blight Pile : https://wowhead.com/forever/object=408004/tangled-blight-pile
            [objectKeys.name] = "Tangled Blight Pile",
            [objectKeys.spawns] = {[38] = {{71.7, 21.4}, {71.8, 21.6}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [408014] = { -- Gnomish Tome : https://wowhead.com/forever/object=408014/gnomish-tome
            [objectKeys.name] = "Gnomish Tome",
            [objectKeys.spawns] = {[38] = {{35.4, 48.2}, {35.5, 48.3}, {35.6, 48.9}}, [40] = {{52.7, 53.8}, {52.9, 53.4}}},
        },
        [408802] = { -- Gnarled Harpoon : https://wowhead.com/forever/object=408802/gnarled-harpoon
            [objectKeys.name] = "Gnarled Harpoon",
            [objectKeys.spawns] = {[148] = {{44.1, 20.8}, {47.3, 15.3}, {48.3, 18}, {49.2, 16.2}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [409131] = { -- Rusty Chest : https://wowhead.com/forever/object=409131/rusty-chest
            [objectKeys.name] = "Rusty Chest",
            [objectKeys.spawns] = {[130] = {{45.2, 67.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [409289] = { -- Strange Orb : https://wowhead.com/forever/object=409289/strange-orb
            [objectKeys.name] = "Strange Orb",
            [objectKeys.questStarts] = {78088},
            [objectKeys.spawns] = {[148] = {{56.2, 26.4}, {56.2, 26.5}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [409311] = { -- Spear of Mannoroth : https://wowhead.com/forever/object=409311/spear-of-mannoroth
            [objectKeys.name] = "Spear of Mannoroth",
            [objectKeys.questEnds] = {78092},
            [objectKeys.spawns] = {[331] = {{89.4, 77.1}, {89.5, 77}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [409315] = { -- Shattered Orb : https://wowhead.com/forever/object=409315/shattered-orb
            [objectKeys.name] = "Shattered Orb",
            [objectKeys.questStarts] = {78093},
            [objectKeys.spawns] = {[331] = {{89.4, 77}, {89.5, 77}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [409496] = { -- Scrolls : https://wowhead.com/forever/object=409496/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[148] = {{59.6, 22.2}}},
        },
        [409501] = { -- Dalaran Digest : https://wowhead.com/forever/object=409501/dalaran-digest
            [objectKeys.name] = "Dalaran Digest",
            [objectKeys.spawns] = {[130] = {{63.5, 63.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [409562] = { -- Spellbook : https://wowhead.com/forever/object=409562/spellbook
            [objectKeys.name] = "Spellbook",
            [objectKeys.spawns] = {[40] = {{45.4, 70.4}, {45.4, 70.5}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [409700] = { -- Manual : https://wowhead.com/forever/object=409700/manual
            [objectKeys.name] = "Manual",
            [objectKeys.spawns] = {[17] = {{56.3, 8.8}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [409711] = { -- Scrolls : https://wowhead.com/forever/object=409711/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[406] = {{74.4, 85.7}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [409717] = { -- Scrolls : https://wowhead.com/forever/object=409717/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[11] = {{33.6, 47.9}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [409731] = { -- Scrolls : https://wowhead.com/forever/object=409731/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[38] = {{77.4, 14}, {77.5, 14}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [409735] = { -- Spellbook : https://wowhead.com/forever/object=409735/spellbook
            [objectKeys.name] = "Spellbook",
            [objectKeys.spawns] = {[10] = {{16.6, 28.5}, {16.7, 28.4}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [409754] = { -- Wall-Mounted Shield : https://wowhead.com/forever/object=409754/wall-mounted-shield
            [objectKeys.name] = "Wall-Mounted Shield",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [409758] = { -- Discarded Helm : https://wowhead.com/forever/object=409758/discarded-helm
            [objectKeys.name] = "Discarded Helm",
            [objectKeys.zoneID] = zoneIDs.SHADOWFANG_KEEP,
        },
        [410034] = { -- Carved Stone : https://wowhead.com/forever/object=410034/carved-stone
            [objectKeys.name] = "Carved Stone",
            [objectKeys.spawns] = {[10] = {{49.4, 34}, {49.5, 34}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [410082] = { -- Carved Stone : https://wowhead.com/forever/object=410082/carved-stone
            [objectKeys.name] = "Carved Stone",
            [objectKeys.spawns] = {[331] = {{86.9, 43.2}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [410158] = { -- Altar of Reverence : https://wowhead.com/forever/object=410158/altar-of-reverence
            [objectKeys.name] = "Altar of Reverence",
            [objectKeys.questEnds] = {84124},
            [objectKeys.spawns] = {[46] = {{39.4, 27.9}, {39.6, 28}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [410168] = { -- Voodoo Pile : https://wowhead.com/forever/object=410168/voodoo-pile
            [objectKeys.name] = "Voodoo Pile",
            [objectKeys.questEnds] = {78199},
            [objectKeys.spawns] = {[14] = {{68.7, 71.2}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [410220] = { -- Gift of the Wisp : https://wowhead.com/forever/object=410220/gift-of-the-wisp
            [objectKeys.name] = "Gift of the Wisp",
            [objectKeys.spawns] = {[361] = {{39.5, 22}, {41.1, 19}, {41.8, 19.9}, {42.2, 16.3}, {42.3, 17.1}, {42.3, 17.9}, {42.4, 14.7}, {42.6, 17.2}, {42.6, 18.4}, {42.6, 20.2}, {42.8, 16.1}, {43, 15.1}}},
            [objectKeys.zoneID] = zoneIDs.FELWOOD,
        },
        [410299] = { -- Arcane Secrets : https://wowhead.com/forever/object=410299/arcane-secrets
            [objectKeys.name] = "Arcane Secrets",
            [objectKeys.spawns] = {[130] = {{43.4, 41.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [410369] = { -- Dead Drop : https://wowhead.com/forever/object=410369/dead-drop
            [objectKeys.name] = "Dead Drop",
            [objectKeys.questStarts] = {78261, 78676, 80455},
            [objectKeys.questEnds] = {78261, 78307, 78676, 78699, 80454},
            [objectKeys.spawns] = {[130] = {{47.1, 71.1}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [410528] = { -- Ornamented Chest : https://wowhead.com/forever/object=410528/ornamented-chest
            [objectKeys.name] = "Ornamented Chest",
            [objectKeys.zoneID] = zoneIDs.SHADOWFANG_KEEP,
        },
        [410779] = { -- Offering Box : https://wowhead.com/forever/object=410779/offering-box
            [objectKeys.name] = "Offering Box",
            [objectKeys.spawns] = {[10] = {{81.2, 71.8}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [410847] = { -- Rusty Safe : https://wowhead.com/forever/object=410847/rusty-safe
            [objectKeys.name] = "Rusty Safe",
            [objectKeys.spawns] = {[28] = {{59.4, 84.6}, {59.5, 84.5}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [411348] = { -- Dusty Coffer : https://wowhead.com/forever/object=411348/dusty-coffer
            [objectKeys.name] = "Dusty Coffer",
            [objectKeys.spawns] = {[10] = {{26, 31}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [411674] = { -- Prophecy of a King's Demise : https://wowhead.com/forever/object=411674/prophecy-of-a-kings-demise
            [objectKeys.name] = "Prophecy of a King's Demise",
            [objectKeys.spawns] = {[130] = {{65.8, 23.4}, {65.8, 23.6}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [411710] = { -- Demonic Reliquary : https://wowhead.com/forever/object=411710/demonic-reliquary
            [objectKeys.name] = "Demonic Reliquary",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [411715] = { -- Bough of Altek : https://wowhead.com/forever/object=411715/bough-of-altek
            [objectKeys.name] = "Bough of Altek",
            [objectKeys.spawns] = {[148] = {{56.2, 26.4}, {56.3, 26.5}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [412147] = { -- Supply Locker : https://wowhead.com/forever/object=412147/supply-locker
            [objectKeys.name] = "Supply Locker",
            [objectKeys.spawns] = {[85] = {{81.1, 32.1}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [412198] = { -- Stone Coffer : https://wowhead.com/forever/object=412198/stone-coffer
            [objectKeys.name] = "Stone Coffer",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [412224] = { -- Dark Ritual Stone : https://wowhead.com/forever/object=412224/dark-ritual-stone
            [objectKeys.name] = "Dark Ritual Stone",
            [objectKeys.questEnds] = {78681},
            [objectKeys.spawns] = {[331] = {{79, 80.3}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [412261] = { -- Padlocked Reliquary : https://wowhead.com/forever/object=412261/padlocked-reliquary
            [objectKeys.name] = "Padlocked Reliquary",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [414197] = { -- Bough of Shadows : https://wowhead.com/forever/object=414197/bough-of-shadows
            [objectKeys.name] = "Bough of Shadows",
            [objectKeys.spawns] = {[331] = {{89.8, 37.3}, {89.8, 37.5}, {91.2, 37.5}, {92.5, 40.4}, {92.8, 35.7}, {94, 41.7}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [414532] = { -- Clliffspring Chest : https://wowhead.com/forever/object=414532/clliffspring-chest
            [objectKeys.name] = "Clliffspring Chest",
            [objectKeys.spawns] = {[148] = {{56.3, 34.9}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [414624] = { -- Lighthouse Stash : https://wowhead.com/forever/object=414624/lighthouse-stash
            [objectKeys.name] = "Lighthouse Stash",
            [objectKeys.spawns] = {[148] = {{32.7, 37.1}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [414646] = { -- Remnant : https://wowhead.com/forever/object=414646/remnant
            [objectKeys.name] = "Remnant",
            [objectKeys.spawns] = {[148] = {{30.4, 48}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [414663] = { -- Shatterspear Idol : https://wowhead.com/forever/object=414663/shatterspear-idol
            [objectKeys.name] = "Shatterspear Idol",
            [objectKeys.spawns] = {[148] = {{59.2, 22.6}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [414713] = { -- Storage Locker : https://wowhead.com/forever/object=414713/storage-locker
            [objectKeys.name] = "Storage Locker",
            [objectKeys.spawns] = {[267] = {{79.7, 41}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [415106] = { -- Burned-Out Remains : https://wowhead.com/forever/object=415106/burned-out-remains
            [objectKeys.name] = "Burned-Out Remains",
            [objectKeys.questStarts] = {79007, 79192},
            [objectKeys.questEnds] = {79008},
            [objectKeys.spawns] = {[17] = {{46.4, 73.9}}, [40] = {{37.4, 50.6}, {37.5, 50.7}}},
        },
        [415107] = { -- Burned-Out Remains : https://wowhead.com/forever/object=415107/burned-out-remains
            [objectKeys.name] = "Burned-Out Remains",
            [objectKeys.questStarts] = {79008, 79192},
            [objectKeys.questEnds] = {79007},
            [objectKeys.spawns] = {[40] = {{37.4, 50.6}, {37.5, 50.7}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [415614] = { -- Mysterious Formulae : https://wowhead.com/forever/object=415614/mysterious-formulae
            [objectKeys.name] = "Mysterious Formulae",
            [objectKeys.zoneID] = zoneIDs.BLACKFATHOM_DEEPS,
        },
        [417072] = { -- Nailed Plank : https://wowhead.com/forever/object=417072/nailed-plank
            [objectKeys.name] = "Nailed Plank",
            [objectKeys.questStarts] = {79192},
            [objectKeys.questEnds] = {79008},
            [objectKeys.spawns] = {[17] = {{46.4, 73.8}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [417353] = { -- Extinguished Campfire : https://wowhead.com/forever/object=417353/extinguished-campfire
            [objectKeys.name] = "Extinguished Campfire",
            [objectKeys.questStarts] = {79229},
            [objectKeys.spawns] = {[405] = {{47.4, 54.6}, {47.5, 54.6}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [418855] = { -- Illari's Loot Cache : https://wowhead.com/forever/object=418855/illaris-loot-cache
            [objectKeys.name] = "Illari's Loot Cache",
            [objectKeys.questEnds] = {79242},
            [objectKeys.spawns] = {[45] = {{94.1, 69.3}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [420054] = { -- Rowboat : https://wowhead.com/forever/object=420054/rowboat
            [objectKeys.name] = "Rowboat",
            [objectKeys.spawns] = {[11] = {{58.1, 6.9}}, [45] = {{53.7, 91.7}, {89.6, 78}}},
        },
        [421526] = { -- Research Notes : https://wowhead.com/forever/object=421526/research-notes
            [objectKeys.name] = "Research Notes",
            [objectKeys.spawns] = {[33] = {{41.4, 50.9}, {41.5, 50.9}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [421568] = { -- Weathered Cache : https://wowhead.com/forever/object=421568/weathered-cache
            [objectKeys.name] = "Weathered Cache",
            [objectKeys.spawns] = {[400] = {{46.8, 53.4}, {46.8, 53.5}}},
            [objectKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [422483] = { -- The Salvagematic 9000 : https://wowhead.com/forever/object=422483/the-salvagematic-9000
            [objectKeys.name] = "The Salvagematic 9000",
            [objectKeys.questStarts] = {79626},
            [objectKeys.questEnds] = {79626, 79704},
            [objectKeys.zoneID] = zoneIDs.GNOMEREGAN,
        },
        [422896] = { -- Tear of Theradras : https://wowhead.com/forever/object=422896/tear-of-theradras
            [objectKeys.name] = "Tear of Theradras",
            [objectKeys.spawns] = {[405] = {{27.7, 57.4}, {27.8, 57.7}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [422902] = { -- Crystal Waters of Lake Elune'ara : https://wowhead.com/forever/object=422902/crystal-waters-of-lake-eluneara
            [objectKeys.name] = "Crystal Waters of Lake Elune'ara",
            [objectKeys.spawns] = {[493] = {{55.7, 66.3}, {55.8, 66.5}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [422911] = { -- Sealed Barrel : https://wowhead.com/forever/object=422911/sealed-barrel
            [objectKeys.name] = "Sealed Barrel",
            [objectKeys.spawns] = {[45] = {{21.3, 84}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [422919] = { -- Tapped Shadowforge Keg : https://wowhead.com/forever/object=422919/tapped-shadowforge-keg
            [objectKeys.name] = "Tapped Shadowforge Keg",
            [objectKeys.spawns] = {[3] = {{41.3, 27.9}, {41.5, 28.1}}},
            [objectKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [423569] = { -- Dropped Pouch : https://wowhead.com/forever/object=423569/dropped-pouch
            [objectKeys.name] = "Dropped Pouch",
            [objectKeys.spawns] = {[45] = {{93.4, 71.1}, {93.5, 70.4}, {93.8, 71.4}, {93.8, 71.5}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [423695] = { -- Libram of Deliverance : https://wowhead.com/forever/object=423695/libram-of-deliverance
            [objectKeys.name] = "Libram of Deliverance",
            [objectKeys.spawns] = {[405] = {{66.5, 7.4}, {66.5, 7.5}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [423703] = { -- Broken Warhammer : https://wowhead.com/forever/object=423703/broken-warhammer
            [objectKeys.name] = "Broken Warhammer",
            [objectKeys.questStarts] = {79939},
            [objectKeys.spawns] = {[405] = {{52.7, 84.8}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [423841] = { -- Frozen Remains : https://wowhead.com/forever/object=423841/frozen-remains
            [objectKeys.name] = "Frozen Remains",
            [objectKeys.spawns] = {[36] = {{39.7, 60.8}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [423895] = { -- Scrolls : https://wowhead.com/forever/object=423895/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[400] = {{34.4, 40.1}, {34.5, 40.1}}},
            [objectKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [423896] = { -- Manual : https://wowhead.com/forever/object=423896/manual
            [objectKeys.name] = "Manual",
            [objectKeys.spawns] = {[36] = {{48.4, 57.6}, {48.5, 57.7}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [423897] = { -- Scrolls : https://wowhead.com/forever/object=423897/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[45] = {{73.6, 65.2}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [423898] = { -- Mysterious Book : https://wowhead.com/forever/object=423898/mysterious-book
            [objectKeys.name] = "Mysterious Book",
            [objectKeys.spawns] = {[405] = {{55.1, 26.2}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [423899] = { -- Scrolls : https://wowhead.com/forever/object=423899/scrolls
            [objectKeys.name] = "Scrolls",
            [objectKeys.spawns] = {[3] = {{56.7, 39.9}}},
            [objectKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [423900] = { -- Waterlogged Book : https://wowhead.com/forever/object=423900/waterlogged-book
            [objectKeys.name] = "Waterlogged Book",
            [objectKeys.spawns] = {[15] = {{57.2, 20.8}}},
            [objectKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [423901] = { -- Book : https://wowhead.com/forever/object=423901/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[8] = {{61.4, 22.4}, {61.4, 22.5}, {61.5, 22.6}, {61.6, 22.4}}, [618] = {{60.7, 37.7}}},
        },
        [423920] = { -- Warrior's Bounty : https://wowhead.com/forever/object=423920/warriors-bounty
            [objectKeys.name] = "Warrior's Bounty",
            [objectKeys.spawns] = {[400] = {{67.9, 89.3}, {68, 89.5}}},
            [objectKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [423926] = { -- Conspicuous Cache : https://wowhead.com/forever/object=423926/conspicuous-cache
            [objectKeys.name] = "Conspicuous Cache",
            [objectKeys.spawns] = {[8] = {{42.7, 30.9}}},
            [objectKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
        },
        [423930] = { -- Sizable Stolen Strongbox : https://wowhead.com/forever/object=423930/sizable-stolen-strongbox
            [objectKeys.name] = "Sizable Stolen Strongbox",
            [objectKeys.spawns] = {[400] = {{18.7, 21}}},
            [objectKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [424002] = { -- Kurzen Supply Crate : https://wowhead.com/forever/object=424002/kurzen-supply-crate
            [objectKeys.name] = "Kurzen Supply Crate",
            [objectKeys.spawns] = {[33] = {{49.6, 7.7}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [424005] = { -- Pocket Litter : https://wowhead.com/forever/object=424005/pocket-litter
            [objectKeys.name] = "Pocket Litter",
            [objectKeys.questStarts] = {79980},
            [objectKeys.questEnds] = {79192},
            [objectKeys.spawns] = {[406] = {{40.7, 52.4}, {40.8, 52.6}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [424006] = { -- Hastily Rolled-Up Satchel : https://wowhead.com/forever/object=424006/hastily-rolled-up-satchel
            [objectKeys.name] = "Hastily Rolled-Up Satchel",
            [objectKeys.questEnds] = {79976},
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.5, 24.2}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [424007] = { -- Carved Figurine : https://wowhead.com/forever/object=424007/carved-figurine
            [objectKeys.name] = "Carved Figurine",
            [objectKeys.questStarts] = {79975},
            [objectKeys.questEnds] = {79974},
            [objectKeys.spawns] = {[38] = {{49.4, 12.9}, {49.5, 12.8}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [424010] = { -- Nailed Plank : https://wowhead.com/forever/object=424010/nailed-plank
            [objectKeys.name] = "Nailed Plank",
            [objectKeys.questStarts] = {79192},
            [objectKeys.questEnds] = {79007},
            [objectKeys.spawns] = {[40] = {{37.4, 50.9}, {37.5, 50.8}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [424012] = { -- Mound of Dirt : https://wowhead.com/forever/object=424012/mound-of-dirt
            [objectKeys.name] = "Mound of Dirt",
            [objectKeys.questStarts] = {79974},
            [objectKeys.questEnds] = {79980},
            [objectKeys.spawns] = {[406] = {{39.6, 49.9}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [424073] = { -- Wondergear Worldporter : https://wowhead.com/forever/object=424073/wondergear-worldporter
            [objectKeys.name] = "Wondergear Worldporter",
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [424082] = { -- Firepit : https://wowhead.com/forever/object=424082/firepit
            [objectKeys.name] = "Firepit",
            [objectKeys.questStarts] = {80001},
            [objectKeys.questEnds] = {80001},
            [objectKeys.spawns] = {[406] = {{40.6, 52.4}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [424110] = { -- Swordsman's Reward : https://wowhead.com/forever/object=424110/swordsmans-reward
            [objectKeys.name] = "Swordsman's Reward",
            [objectKeys.spawns] = {[3] = {{14.5, 44.8}, {23.2, 60}, {23.6, 59.5}, {23.7, 59}, {24.4, 58.3}, {24.5, 61.7}, {24.8, 59}, {24.9, 57.6}, {25.2, 57.4}, {26.6, 68.7}, {26.8, 67.8}, {27.1, 72.8}, {27.3, 65.9}, {27.4, 67}, {27.5, 70.5}, {27.6, 66.3}, {27.9, 69}, {28, 68.2}, {28, 69.5}, {28.5, 68.1}, {32.6, 69.5}, {32.7, 70.6}, {33.2, 68.1}, {33.4, 68.6}, {33.7, 68}, {33.8, 69.5}, {34.2, 68.8}, {34.7, 69.5}, {34.8, 57.3}, {35.2, 58.2}, {35.4, 58.6}, {35.4, 59.6}, {35.6, 56.9}, {35.6, 59.1}, {35.7, 59.7}, {36.4, 57.9}, {36.7, 56.6}}},
            [objectKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [424264] = { -- Grave : https://wowhead.com/forever/object=424264/grave
            [objectKeys.name] = "Grave",
            [objectKeys.spawns] = {[15] = {{63.7, 42.4}, {63.7, 42.5}}},
            [objectKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [424265] = { -- Grave : https://wowhead.com/forever/object=424265/grave
            [objectKeys.name] = "Grave",
            [objectKeys.spawns] = {[8] = {{16.7, 53.7}}},
            [objectKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
        },
        [424266] = { -- Grave : https://wowhead.com/forever/object=424266/grave
            [objectKeys.name] = "Grave",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [424267] = { -- Grave : https://wowhead.com/forever/object=424267/grave
            [objectKeys.name] = "Grave",
            [objectKeys.spawns] = {[45] = {{62.2, 54.3}, {62.2, 54.5}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [424373] = { -- Remnant : https://wowhead.com/forever/object=424373/remnant
            [objectKeys.name] = "Remnant",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [425896] = { -- Archivists of the Monastery : https://wowhead.com/forever/object=425896/archivists-of-the-monastery
            [objectKeys.name] = "Archivists of the Monastery",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [425897] = { -- Archivists of the Monastery : https://wowhead.com/forever/object=425897/archivists-of-the-monastery
            [objectKeys.name] = "Archivists of the Monastery",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [425898] = { -- Archivists of the Monastery : https://wowhead.com/forever/object=425898/archivists-of-the-monastery
            [objectKeys.name] = "Archivists of the Monastery",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [425899] = { -- Archivists of the Monastery : https://wowhead.com/forever/object=425899/archivists-of-the-monastery
            [objectKeys.name] = "Archivists of the Monastery",
            [objectKeys.zoneID] = zoneIDs.SCARLET_MONASTERY,
        },
        [428144] = { -- Fount : https://wowhead.com/forever/object=428144/fount
            [objectKeys.name] = "Fount",
            [objectKeys.spawns] = {[33] = {{23.6, 8}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [428228] = { -- Conspicuous Cache : https://wowhead.com/forever/object=428228/conspicuous-cache
            [objectKeys.name] = "Conspicuous Cache",
            [objectKeys.spawns] = {[8] = {{42.6, 30.7}}},
            [objectKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
        },
        [433066] = { -- Sandfury Cache : https://wowhead.com/forever/object=433066/sandfury-cache
            [objectKeys.name] = "Sandfury Cache",
            [objectKeys.zoneID] = zoneIDs.ZUL_FARRAK,
        },
        [433067] = { -- Clay Vessel : https://wowhead.com/forever/object=433067/clay-vessel
            [objectKeys.name] = "Clay Vessel",
            [objectKeys.zoneID] = zoneIDs.ZUL_FARRAK,
        },
        [433591] = { -- Shallow Grave : https://wowhead.com/forever/object=433591/shallow-grave
            [objectKeys.name] = "Shallow Grave",
            [objectKeys.zoneID] = zoneIDs.ZUL_FARRAK,
        },
        [433593] = { -- Zum'Rah's Satchel : https://wowhead.com/forever/object=433593/zumrahs-satchel
            [objectKeys.name] = "Zum'Rah's Satchel",
            [objectKeys.zoneID] = zoneIDs.ZUL_FARRAK,
        },
        [433594] = { -- Antu'Sul's Satchel : https://wowhead.com/forever/object=433594/antusuls-satchel
            [objectKeys.name] = "Antu'Sul's Satchel",
            [objectKeys.zoneID] = zoneIDs.ZUL_FARRAK,
        },
        [433596] = { -- Spellbound War Chest : https://wowhead.com/forever/object=433596/spellbound-war-chest
            [objectKeys.name] = "Spellbound War Chest",
            [objectKeys.zoneID] = zoneIDs.ZUL_FARRAK,
        },
        [439557] = { -- Nightmare Moss : https://wowhead.com/forever/object=439557/nightmare-moss
            [objectKeys.name] = "Nightmare Moss",
            [objectKeys.spawns] = {[10] = {{32.2, 69.3}, {35.2, 64.2}, {35.2, 71.8}, {37.3, 84.6}, {40.4, 67}, {40.5, 67.1}, {44.2, 36.6}, {46.3, 55.1}, {47.8, 42.9}, {48.8, 77.9}, {50.9, 76.6}, {53.9, 62.7}, {56.8, 71.3}, {61.4, 76.1}, {61.6, 75.8}, {64.3, 72.8}, {64.4, 72.4}, {65.2, 58.7}, {65.7, 67.1}, {66.3, 76.4}, {66.3, 76.5}, {66.5, 76.7}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [439558] = { -- Cold Iron Deposit : https://wowhead.com/forever/object=439558/cold-iron-deposit
            [objectKeys.name] = "Cold Iron Deposit",
            [objectKeys.spawns] = {[10] = {{33.2, 67.9}, {33.7, 76.7}, {35.4, 68.1}, {35.5, 68}, {36.9, 84.7}, {38, 84.1}, {41.2, 75.4}, {41.2, 75.5}, {42.4, 34.7}, {42.5, 34.6}, {44.9, 63.9}, {46.8, 56.2}, {46.8, 56.5}, {50.2, 78.8}, {50.3, 46.4}, {50.3, 46.5}, {52.1, 72.1}, {55.8, 74.4}, {55.8, 74.5}, {59.1, 56.5}, {59.2, 56.4}, {63.2, 64.4}, {63.2, 64.5}, {64.2, 65}, {67.6, 78.1}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [439627] = { -- Dreamroot : https://wowhead.com/forever/object=439627/dreamroot
            [objectKeys.name] = "Dreamroot",
            [objectKeys.spawns] = {[331] = {{78.3, 43.3}, {80.7, 50.6}, {81, 44.8}, {82.7, 50.2}, {82.7, 55}, {84.3, 44.9}, {85.6, 60}, {85.9, 56.4}, {85.9, 56.5}, {86.2, 47}, {86.4, 54.6}, {86.5, 54.4}, {86.5, 54.5}, {87.3, 52.3}, {87.7, 62.6}, {89.5, 44.7}, {89.7, 58}, {89.8, 50.7}, {93.4, 38.3}, {93.5, 38.3}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [439628] = { -- Fool's Gold Vein : https://wowhead.com/forever/object=439628/fools-gold-vein
            [objectKeys.name] = "Fool's Gold Vein",
            [objectKeys.spawns] = {[331] = {{79.2, 49.9}, {81.6, 52.1}, {82.7, 45.8}, {84.8, 55.4}, {85.8, 46.7}, {86, 49.7}, {87.7, 64.9}, {88.1, 62.1}, {89, 45.6}, {89.8, 42.9}, {91, 56.3}, {91.3, 37.4}, {91.3, 37.6}, {92.6, 35.2}, {93.4, 42.4}, {93.4, 42.5}, {94.1, 36.6}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [439762] = { -- Star Lotus : https://wowhead.com/forever/object=439762/star-lotus
            [objectKeys.name] = "Star Lotus",
            [objectKeys.spawns] = {[47] = {{45.1, 43.2}, {46.1, 38.4}, {46.1, 38.5}, {49.4, 38}, {49.5, 38}, {57.3, 41.9}, {58.9, 43.4}, {59.1, 43.7}, {61.7, 25.5}, {61.8, 25.3}, {66.1, 42.9}, {66.6, 32.9}, {68.4, 46.6}, {68.5, 46.6}, {70.4, 45.5}, {70.5, 45.4}, {70.5, 45.5}, {71.3, 48.4}, {71.3, 48.5}, {73, 53.2}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [439778] = { -- Starsilver Vein : https://wowhead.com/forever/object=439778/starsilver-vein
            [objectKeys.name] = "Starsilver Vein",
            [objectKeys.spawns] = {[47] = {{45.4, 39.4}, {45.4, 39.5}, {46.9, 34.8}, {48.8, 45.5}, {56.6, 43.3}, {56.9, 43.6}, {57.9, 49.8}, {58.1, 41}, {58.9, 43.2}, {63.7, 43.4}, {63.8, 43.5}, {66.3, 50.7}, {72.2, 52.3}, {73.6, 53.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [439810] = { -- Moonroot : https://wowhead.com/forever/object=439810/moonroot
            [objectKeys.name] = "Moonroot",
            [objectKeys.spawns] = {[357] = {{37.4, 17.3}, {37.5, 17.4}, {38.2, 11.1}, {39.1, 11.1}, {40.4, 11.5}, {40.5, 11.4}, {40.5, 11.5}, {41.6, 18.4}, {41.6, 18.5}, {41.9, 13.9}, {44.7, 23.1}, {45.4, 10.9}, {46.5, 18.3}, {50.8, 18.3}, {52, 12.1}, {53.5, 17.4}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [439815] = { -- Greater Moonstone Formation : https://wowhead.com/forever/object=439815/greater-moonstone-formation
            [objectKeys.name] = "Greater Moonstone Formation",
            [objectKeys.spawns] = {[357] = {{37.6, 16.8}, {40.3, 19.7}, {40.8, 9.9}, {40.8, 12.5}, {42.8, 23.2}, {47.4, 21.9}, {47.5, 21.8}, {51, 19.8}, {51.2, 14.8}, {54, 13.4}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [441061] = { -- Weathered Etching : https://wowhead.com/forever/object=441061/weathered-etching
            [objectKeys.name] = "Weathered Etching",
            [objectKeys.questStarts] = {81900},
            [objectKeys.spawns] = {[51] = {{14.4, 36.3}, {14.5, 36.4}, {14.5, 36.5}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [441113] = { -- Ogre Magi Text : https://wowhead.com/forever/object=441113/ogre-magi-text
            [objectKeys.name] = "Ogre Magi Text",
            [objectKeys.spawns] = {[10] = {{35.7, 80.1}, {37.9, 84.3}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [441114] = { -- Mysterious Box : https://wowhead.com/forever/object=441114/mysterious-box
            [objectKeys.name] = "Mysterious Box",
            [objectKeys.spawns] = {[10] = {{65.7, 67.4}, {65.7, 67.5}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [441119] = { -- Unhatched Green Dragon Egg : https://wowhead.com/forever/object=441119/unhatched-green-dragon-egg
            [objectKeys.name] = "Unhatched Green Dragon Egg",
            [objectKeys.spawns] = {[10] = {{48.9, 72.8}, {49, 72.2}, {49.5, 72.4}, {49.5, 72.5}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [441124] = { -- Dream-Touched Dragon Egg : https://wowhead.com/forever/object=441124/dream-touched-dragon-egg
            [objectKeys.name] = "Dream-Touched Dragon Egg",
            [objectKeys.spawns] = {[331] = {{86.1, 45.9}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [441128] = { -- Vibrating Crate : https://wowhead.com/forever/object=441128/vibrating-crate
            [objectKeys.name] = "Vibrating Crate",
            [objectKeys.spawns] = {[331] = {{88.4, 55.4}, {88.4, 55.5}, {88.5, 55.1}, {91, 58.1}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [441129] = { -- Azsharan Prophecy : https://wowhead.com/forever/object=441129/azsharan-prophecy
            [objectKeys.name] = "Azsharan Prophecy",
            [objectKeys.spawns] = {[331] = {{80.7, 48.9}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [441133] = { -- Star-Touched Dragon Egg : https://wowhead.com/forever/object=441133/star-touched-dragon-egg
            [objectKeys.name] = "Star-Touched Dragon Egg",
            [objectKeys.spawns] = {[47] = {{45.4, 38.8}, {45.5, 38.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [441140] = { -- Humming Box : https://wowhead.com/forever/object=441140/humming-box
            [objectKeys.name] = "Humming Box",
            [objectKeys.spawns] = {[47] = {{56.1, 44.1}, {56.6, 43.4}, {56.7, 43.5}, {57.5, 40.8}, {57.8, 43.3}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [441141] = { -- Dreampearl : https://wowhead.com/forever/object=441141/dreampearl
            [objectKeys.name] = "Dreampearl",
            [objectKeys.spawns] = {[47] = {{72.3, 54.1}, {72.7, 54.2}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [441222] = { -- Grave Mound : https://wowhead.com/forever/object=441222/grave-mound
            [objectKeys.name] = "Grave Mound",
            [objectKeys.zoneID] = zoneIDs.MARAUDON,
        },
        [441247] = { -- Book : https://wowhead.com/forever/object=441247/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
        },
        [441248] = { -- Book : https://wowhead.com/forever/object=441248/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[440] = {{72.6, 47.8}}},
            [objectKeys.zoneID] = zoneIDs.TANARIS,
        },
        [441249] = { -- Book : https://wowhead.com/forever/object=441249/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[357] = {{50.6, 15.7}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [441250] = { -- Book : https://wowhead.com/forever/object=441250/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[16] = {{20.7, 62}}},
            [objectKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [441251] = { -- Book : https://wowhead.com/forever/object=441251/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [441252] = { -- Book : https://wowhead.com/forever/object=441252/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[47] = {{36, 72.8}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [441253] = { -- Book : https://wowhead.com/forever/object=441253/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[51] = {{37.8, 49.3}, {37.9, 49.6}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [441254] = { -- Book : https://wowhead.com/forever/object=441254/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[4] = {{55.4, 32.2}, {55.4, 32.5}, {55.5, 32.2}}},
            [objectKeys.zoneID] = zoneIDs.BLASTED_LANDS,
        },
        [441310] = { -- Moonglow Dragon Egg : https://wowhead.com/forever/object=441310/moonglow-dragon-egg
            [objectKeys.name] = "Moonglow Dragon Egg",
            [objectKeys.spawns] = {[357] = {{50.7, 17.2}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [441312] = { -- Mad Keeper's Notes : https://wowhead.com/forever/object=441312/mad-keepers-notes
            [objectKeys.name] = "Mad Keeper's Notes",
            [objectKeys.spawns] = {[357] = {{45, 20}, {46.6, 19}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [441314] = { -- Harpy Screed : https://wowhead.com/forever/object=441314/harpy-screed
            [objectKeys.name] = "Harpy Screed",
            [objectKeys.spawns] = {[357] = {{38.4, 15.9}, {38.6, 15.7}, {38.9, 13.3}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [441865] = { -- Traveller's Knapsack : https://wowhead.com/forever/object=441865/travellers-knapsack
            [objectKeys.name] = "Traveller's Knapsack",
            [objectKeys.spawns] = {[16] = {{20.6, 61.9}}},
            [objectKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [441870] = { -- Satyrweed Bramble : https://wowhead.com/forever/object=441870/satyrweed-bramble
            [objectKeys.name] = "Satyrweed Bramble",
            [objectKeys.spawns] = {[16] = {{18.5, 61.3}, {18.5, 63}, {19.3, 59.6}, {19.7, 58.9}, {19.8, 60.5}, {19.8, 61.6}, {19.9, 64}, {20.9, 58.4}, {20.9, 58.5}, {21.1, 63.6}, {21.3, 60.1}, {21.3, 60.8}, {21.6, 63.5}, {21.9, 59.3}, {22, 62.7}, {22.2, 60.3}, {22.2, 61}, {22.2, 61.8}}},
            [objectKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [441912] = { -- Giant Golem Foot : https://wowhead.com/forever/object=441912/giant-golem-foot
            [objectKeys.name] = "Giant Golem Foot",
            [objectKeys.spawns] = {[51] = {{43.9, 32.4}, {44, 32.9}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [441913] = { -- Giant Golem Foot : https://wowhead.com/forever/object=441913/giant-golem-foot
            [objectKeys.name] = "Giant Golem Foot",
            [objectKeys.spawns] = {[51] = {{42.3, 30.4}, {42.4, 30.7}, {42.5, 30.4}, {42.5, 30.5}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [441914] = { -- Giant Golem Arm : https://wowhead.com/forever/object=441914/giant-golem-arm
            [objectKeys.name] = "Giant Golem Arm",
            [objectKeys.spawns] = {[51] = {{49.4, 37.3}, {49.6, 37.5}, {49.7, 37.4}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [441915] = { -- Giant Golem Arm : https://wowhead.com/forever/object=441915/giant-golem-arm
            [objectKeys.name] = "Giant Golem Arm",
            [objectKeys.spawns] = {[51] = {{41.9, 44.3}, {41.9, 44.5}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [441946] = { -- Shrine of the Moon : https://wowhead.com/forever/object=441946/shrine-of-the-moon
            [objectKeys.name] = "Shrine of the Moon",
            [objectKeys.spawns] = {[47] = {{66.2, 53.1}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [441947] = { -- Shrine of the Beast : https://wowhead.com/forever/object=441947/shrine-of-the-beast
            [objectKeys.name] = "Shrine of the Beast",
            [objectKeys.spawns] = {[16] = {{34.6, 49}}},
            [objectKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [441948] = { -- Shrine of the Warden : https://wowhead.com/forever/object=441948/shrine-of-the-warden
            [objectKeys.name] = "Shrine of the Warden",
            [objectKeys.spawns] = {[357] = {{58.6, 52.2}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [442397] = { -- Treasure of the Bat : https://wowhead.com/forever/object=442397/treasure-of-the-bat
            [objectKeys.name] = "Treasure of the Bat",
            [objectKeys.spawns] = {[47] = {{72.8, 53}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [442398] = { -- Treasure of the Bat : https://wowhead.com/forever/object=442398/treasure-of-the-bat
            [objectKeys.name] = "Treasure of the Bat",
            [objectKeys.spawns] = {[47] = {{72.7, 52.9}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [442404] = { -- Stormcrow Egg : https://wowhead.com/forever/object=442404/stormcrow-egg
            [objectKeys.name] = "Stormcrow Egg",
            [objectKeys.spawns] = {[51] = {{53.1, 56}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [442688] = { -- Old Crate : https://wowhead.com/forever/object=442688/old-crate
            [objectKeys.name] = "Old Crate",
            [objectKeys.spawns] = {[357] = {{76.6, 48}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [442728] = { -- Chest : https://wowhead.com/forever/object=442728/chest
            [objectKeys.name] = "Chest",
            [objectKeys.spawns] = {[440] = {{45.8, 37.6}}},
            [objectKeys.zoneID] = zoneIDs.TANARIS,
        },
        [442742] = { -- Box of Scarlet Dye : https://wowhead.com/forever/object=442742/box-of-scarlet-dye
            [objectKeys.name] = "Box of Scarlet Dye",
            [objectKeys.spawns] = {[28] = {{45.2, 15.2}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [443727] = { -- Grimtotem Chest : https://wowhead.com/forever/object=443727/grimtotem-chest
            [objectKeys.name] = "Grimtotem Chest",
            [objectKeys.spawns] = {[357] = {{69.6, 43.3}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [443728] = { -- Woodpaw Bag : https://wowhead.com/forever/object=443728/woodpaw-bag
            [objectKeys.name] = "Woodpaw Bag",
            [objectKeys.spawns] = {[357] = {{66.4, 50.9}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [445036] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445036/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[4] = {{49.8, 14.6}}},
            [objectKeys.zoneID] = zoneIDs.BLASTED_LANDS,
        },
        [445037] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445037/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[51] = {{43.8, 45.8}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [445039] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445039/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[47] = {{58.4, 72.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [445040] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445040/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[440] = {{56.4, 73.8}, {56.5, 73.8}}},
            [objectKeys.zoneID] = zoneIDs.TANARIS,
        },
        [445041] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445041/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[357] = {{57.2, 68.8}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [445042] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445042/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[361] = {{36.4, 55.7}, {36.5, 55.8}}},
            [objectKeys.zoneID] = zoneIDs.FELWOOD,
        },
        [445044] = { -- Extraplanar Eye : https://wowhead.com/forever/object=445044/extraplanar-eye
            [objectKeys.name] = "Extraplanar Eye",
            [objectKeys.spawns] = {[33] = {{32.9, 88.3}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [446468] = { -- Wondergear Worldporter : https://wowhead.com/forever/object=446468/wondergear-worldporter
            [objectKeys.name] = "Wondergear Worldporter",
            [objectKeys.spawns] = {[357] = {{85.2, 43.8}}},
            [objectKeys.zoneID] = zoneIDs.FERALAS,
        },
        [447821] = { -- Torn Scroll : https://wowhead.com/forever/object=447821/torn-scroll
            [objectKeys.name] = "Torn Scroll",
            [objectKeys.zoneID] = zoneIDs.BLACKROCK_DEPTHS,
        },
        [448042] = { -- Idol of Hakkar : https://wowhead.com/forever/object=448042/idol-of-hakkar
            [objectKeys.name] = "Idol of Hakkar",
            [objectKeys.questEnds] = {82097},
            [objectKeys.zoneID] = zoneIDs.THE_TEMPLE_OF_ATAL_HAKKAR,
        },
        [454487] = { -- Monument to Grom Hellscream : https://wowhead.com/forever/object=454487/monument-to-grom-hellscream
            [objectKeys.name] = "Monument to Grom Hellscream",
            [objectKeys.zoneID] = zoneIDs.DEMON_FALL_CANYON,
        },
        [455023] = { -- Regurgitated Skeleton : https://wowhead.com/forever/object=455023/regurgitated-skeleton
            [objectKeys.name] = "Regurgitated Skeleton",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [455812] = { -- Squire Cuthbert's Sword : https://wowhead.com/forever/object=455812/squire-cuthberts-sword
            [objectKeys.name] = "Squire Cuthbert's Sword",
            [objectKeys.spawns] = {[28] = {{45.7, 53.9}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [456674] = { -- Altar of Reverence : https://wowhead.com/forever/object=456674/altar-of-reverence
            [objectKeys.name] = "Altar of Reverence",
            [objectKeys.spawns] = {[46] = {{39.4, 27.9}, {39.6, 28}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [456682] = { -- Half-Buried Mech : https://wowhead.com/forever/object=456682/half-buried-mech
            [objectKeys.name] = "Half-Buried Mech",
            [objectKeys.questStarts] = {84135},
            [objectKeys.spawns] = {[440] = {{59.2, 91.5}, {59.3, 91.4}}},
            [objectKeys.zoneID] = zoneIDs.TANARIS,
        },
        [456685] = { -- Access Hatch : https://wowhead.com/forever/object=456685/access-hatch
            [objectKeys.name] = "Access Hatch",
            [objectKeys.questStarts] = {84137},
            [objectKeys.questEnds] = {84135},
            [objectKeys.spawns] = {[440] = {{59.3, 91.4}, {59.3, 91.5}}},
            [objectKeys.zoneID] = zoneIDs.TANARIS,
        },
        [456775] = { -- Remnant : https://wowhead.com/forever/object=456775/remnant
            [objectKeys.name] = "Remnant",
            [objectKeys.zoneID] = zoneIDs.STRATHOLME,
        },
        [456814] = { -- Vertically Composited Patch Hampler : https://wowhead.com/forever/object=456814/vertically-composited-patch-hampler
            [objectKeys.name] = "Vertically Composited Patch Hampler",
            [objectKeys.spawns] = {[46] = {{52.3, 25}, {53.2, 26.2}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [456815] = { -- Brass-fitted Flam-Tamp Flange : https://wowhead.com/forever/object=456815/brass-fitted-flam-tamp-flange
            [objectKeys.name] = "Brass-fitted Flam-Tamp Flange",
            [objectKeys.spawns] = {[46] = {{52.3, 25}, {52.5, 25.1}, {52.5, 25.5}, {53, 23.9}, {53.2, 26.8}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [456883] = { -- Adon's Trunk : https://wowhead.com/forever/object=456883/adons-trunk
            [objectKeys.name] = "Adon's Trunk",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [457088] = { -- Advanced Swordplay : https://wowhead.com/forever/object=457088/advanced-swordplay
            [objectKeys.name] = "Advanced Swordplay",
            [objectKeys.spawns] = {[41] = {{43, 74.4}, {43.1, 74.6}}},
            [objectKeys.zoneID] = zoneIDs.DEADWIND_PASS,
        },
        [457089] = { -- The Shadow Connection : https://wowhead.com/forever/object=457089/the-shadow-connection
            [objectKeys.name] = "The Shadow Connection",
            [objectKeys.spawns] = {[4] = {{33.6, 48.7}}},
            [objectKeys.zoneID] = zoneIDs.BLASTED_LANDS,
        },
        [457090] = { -- Famous (and Infamous) Rangers of Azeroth : https://wowhead.com/forever/object=457090/famous-and-infamous-rangers-of-azeroth
            [objectKeys.name] = "Famous (and Infamous) Rangers of Azeroth",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [457091] = { -- Chen's Training Manual : https://wowhead.com/forever/object=457091/chens-training-manual
            [objectKeys.name] = "Chen's Training Manual",
            [objectKeys.spawns] = {[16] = {{76.9, 44.2}}},
            [objectKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [457092] = { -- The Fury of Stormrage : https://wowhead.com/forever/object=457092/the-fury-of-stormrage
            [objectKeys.name] = "The Fury of Stormrage",
            [objectKeys.spawns] = {[361] = {{62.8, 7.4}, {62.8, 7.5}}},
            [objectKeys.zoneID] = zoneIDs.FELWOOD,
        },
        [457093] = { -- Blunt Justice: A Dwarf's Tale : https://wowhead.com/forever/object=457093/blunt-justice-a-dwarfs-tale
            [objectKeys.name] = "Blunt Justice: A Dwarf's Tale",
            [objectKeys.spawns] = {[11] = {{74, 69.1}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [457094] = { -- The True Nature of the Light : https://wowhead.com/forever/object=457094/the-true-nature-of-the-light
            [objectKeys.name] = "The True Nature of the Light",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [457095] = { -- Elements for Dummies Volume I: Frost : https://wowhead.com/forever/object=457095/elements-for-dummies-volume-i-frost
            [objectKeys.name] = "Elements for Dummies Volume I: Frost",
            [objectKeys.spawns] = {[618] = {{58.9, 59.9}}},
            [objectKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [457096] = { -- Be First: A Brawler's Guide to Boxing : https://wowhead.com/forever/object=457096/be-first-a-brawlers-guide-to-boxing
            [objectKeys.name] = "Be First: A Brawler's Guide to Boxing",
            [objectKeys.spawns] = {[1377] = {{38.1, 45.4}, {38.2, 45.5}}},
            [objectKeys.zoneID] = zoneIDs.SILITHUS,
        },
        [457097] = { -- Elements for Dummies Volume II: Fire : https://wowhead.com/forever/object=457097/elements-for-dummies-volume-ii-fire
            [objectKeys.name] = "Elements for Dummies Volume II: Fire",
            [objectKeys.spawns] = {[51] = {{40.4, 35}, {40.5, 35.4}, {40.5, 35.5}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [457098] = { -- Finding Your Inner Feline: A Guide to Modern Druidism : https://wowhead.com/forever/object=457098/finding-your-inner-feline-a-guide-to-modern-druidism
            [objectKeys.name] = "Finding Your Inner Feline: A Guide to Modern Druidism",
            [objectKeys.spawns] = {[618] = {{49.6, 8.8}}},
            [objectKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [457100] = { -- Renzik's Thoughts on "Fair" Fighting : https://wowhead.com/forever/object=457100/renziks-thoughts-on-fair-fighting
            [objectKeys.name] = "Renzik's Thoughts on \"Fair\" Fighting",
            [objectKeys.spawns] = {[1377] = {{20, 85.1}}},
            [objectKeys.zoneID] = zoneIDs.SILITHUS,
        },
        [457101] = { -- The Rites of Mak'Gora : https://wowhead.com/forever/object=457101/the-rites-of-makgora
            [objectKeys.name] = "The Rites of Mak'Gora",
            [objectKeys.spawns] = {[46] = {{39.9, 34.2}, {40, 34.5}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [457102] = { -- Elements for Dummies Volume III: Arcane : https://wowhead.com/forever/object=457102/elements-for-dummies-volume-iii-arcane
            [objectKeys.name] = "Elements for Dummies Volume III: Arcane",
            [objectKeys.spawns] = {[28] = {{47.3, 13.7}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [457387] = { -- Dwarven Heirloom : https://wowhead.com/forever/object=457387/dwarven-heirloom
            [objectKeys.name] = "Dwarven Heirloom",
            [objectKeys.spawns] = {[28] = {{54.8, 81.2}}},
        },
        [457389] = { -- Family Records : https://wowhead.com/forever/object=457389/family-records
            [objectKeys.name] = "Family Records",
            [objectKeys.spawns] = {[28] = {{53.9, 80.3}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [457390] = { -- Survivor Journal : https://wowhead.com/forever/object=457390/survivor-journal
            [objectKeys.name] = "Survivor Journal",
            [objectKeys.spawns] = {[28] = {{54.1, 80.6}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [457443] = { -- Scarlet Ledger : https://wowhead.com/forever/object=457443/scarlet-ledger
            [objectKeys.name] = "Scarlet Ledger",
            [objectKeys.questStarts] = {84322},
            [objectKeys.questEnds] = {84321, 84406},
            [objectKeys.spawns] = {[28] = {{42.2, 18.1}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [459259] = { -- Mech Arm : https://wowhead.com/forever/object=459259/mech-arm
            [objectKeys.name] = "Mech Arm",
            [objectKeys.questEnds] = {84213},
            [objectKeys.spawns] = {[40] = {{52.3, 40.8}, {52.3, 48.9}, {52.5, 38.4}, {53.1, 40.2}, {53.2, 41.3}, {53.3, 37.1}, {53.3, 41.8}, {53.5, 38.7}, {53.5, 40.7}, {54.1, 41.6}, {54.4, 39.8}, {54.8, 40}}, [85] = {{52.4, 57.7}, {53, 55.8}, {53.2, 57}, {53.3, 57.5}, {53.7, 56.6}, {54.2, 57.5}, {54.2, 58.7}, {54.5, 56.7}, {54.5, 58.2}, {54.8, 56.4}, {57.9, 56.9}}},
        },
        [459388] = { -- Artifact Cache : https://wowhead.com/forever/object=459388/artifact-cache
            [objectKeys.name] = "Artifact Cache",
            [objectKeys.questStarts] = {84323, 84407},
            [objectKeys.questEnds] = {84322},
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [461632] = { -- Marked Crate : https://wowhead.com/forever/object=461632/marked-crate
            [objectKeys.name] = "Marked Crate",
            [objectKeys.spawns] = {[28] = {{45.8, 18.4}, {45.9, 18.5}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [461633] = { -- Belavus' Safe Box : https://wowhead.com/forever/object=461633/belavus-safe-box
            [objectKeys.name] = "Belavus' Safe Box",
            [objectKeys.spawns] = {[28] = {{46.5, 14.1}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [461639] = { -- Orthas' Hammer : https://wowhead.com/forever/object=461639/orthas-hammer
            [objectKeys.name] = "Orthas' Hammer",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [462233] = { -- Shimmering Molten Crag : https://wowhead.com/forever/object=462233/shimmering-molten-crag
            [objectKeys.name] = "Shimmering Molten Crag",
            [objectKeys.spawns] = {[51] = {{48.7, 37.3}, {48.7, 37.5}}},
            [objectKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [462236] = { -- Mysterious Chest : https://wowhead.com/forever/object=462236/mysterious-chest
            [objectKeys.name] = "Mysterious Chest",
            [objectKeys.questStarts] = {84332},
            [objectKeys.questEnds] = {84332, 84414},
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [463206] = { -- Book : https://wowhead.com/forever/object=463206/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [463207] = { -- Book : https://wowhead.com/forever/object=463207/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [463208] = { -- Book : https://wowhead.com/forever/object=463208/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [463209] = { -- Book : https://wowhead.com/forever/object=463209/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[361] = {{65.2, 3.3}}},
            [objectKeys.zoneID] = zoneIDs.FELWOOD,
        },
        [463211] = { -- Book : https://wowhead.com/forever/object=463211/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [463212] = { -- Book : https://wowhead.com/forever/object=463212/book
            [objectKeys.name] = "Book",
            [objectKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [463213] = { -- Book : https://wowhead.com/forever/object=463213/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[28] = {{38.2, 54.6}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [463214] = { -- Book : https://wowhead.com/forever/object=463214/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[618] = {{60.7, 37.7}}},
            [objectKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [463540] = { -- Scarlet Toolbox : https://wowhead.com/forever/object=463540/scarlet-toolbox
            [objectKeys.name] = "Scarlet Toolbox",
            [objectKeys.spawns] = {[28] = {{45, 14.1}}},
            [objectKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [464128] = { -- Gift of the Wisp : https://wowhead.com/forever/object=464128/gift-of-the-wisp
            [objectKeys.name] = "Gift of the Wisp",
            [objectKeys.spawns] = {[361] = {{33.5, 66.5}, {39.4, 21}, {39.5, 22}, {40.3, 20.1}, {41.2, 18.9}, {41.3, 20.3}, {41.5, 18.6}, {41.6, 21.2}, {41.7, 21.6}, {41.8, 20.1}, {42.1, 16.2}, {42.3, 17.1}, {42.3, 18.4}, {42.4, 15.4}, {42.5, 14.4}, {42.5, 15.1}, {42.5, 17.8}, {42.6, 20.2}, {42.8, 15.5}, {43, 17.3}, {43.6, 14.3}, {45, 13.9}, {45.6, 18.7}, {48.2, 16.4}}},
            [objectKeys.zoneID] = zoneIDs.FELWOOD,
        },
        [467315] = { -- Old Campsite : https://wowhead.com/forever/object=467315/old-campsite
            [objectKeys.name] = "Old Campsite",
            [objectKeys.questStarts] = {84950},
            [objectKeys.questEnds] = {84853},
            [objectKeys.spawns] = {[618] = {{57.9, 20.9}}},
            [objectKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [469796] = { -- Campsite : https://wowhead.com/forever/object=469796/campsite
            [objectKeys.name] = "Campsite",
            [objectKeys.questStarts] = {85525},
            [objectKeys.questEnds] = {84950, 85525},
            [objectKeys.spawns] = {[618] = {{58, 21}}},
            [objectKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [489943] = { -- Shallow Grave : https://wowhead.com/forever/object=489943/shallow-grave
            [objectKeys.name] = "Shallow Grave",
            [objectKeys.questEnds] = {85559},
            [objectKeys.spawns] = {[490] = {{21.4, 36.8}}},
            [objectKeys.zoneID] = zoneIDs.UN_GORO_CRATER,
        },
        [495500] = { -- Shadowflame Cache : https://wowhead.com/forever/object=495500/shadowflame-cache
            [objectKeys.name] = "Shadowflame Cache",
            [objectKeys.zoneID] = zoneIDs.BLACKWING_LAIR,
        },
        [495503] = { -- Chromatic Hoard : https://wowhead.com/forever/object=495503/chromatic-hoard
            [objectKeys.name] = "Chromatic Hoard",
            [objectKeys.zoneID] = zoneIDs.BLACKWING_LAIR,
        },
        [495505] = { -- Favored Riches : https://wowhead.com/forever/object=495505/favored-riches
            [objectKeys.name] = "Favored Riches",
            [objectKeys.zoneID] = zoneIDs.BLACKWING_LAIR,
        },
        [495577] = { -- Chromatic Stash : https://wowhead.com/forever/object=495577/chromatic-stash
            [objectKeys.name] = "Chromatic Stash",
            [objectKeys.zoneID] = zoneIDs.BLACKWING_LAIR,
        },
        [499987] = { -- Spellbook : https://wowhead.com/forever/object=499987/spellbook
            [objectKeys.name] = "Spellbook",
            [objectKeys.spawns] = {[45] = {{34.1, 80.4}, {34.1, 80.6}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [499988] = { -- Spellbook : https://wowhead.com/forever/object=499988/spellbook
            [objectKeys.name] = "Spellbook",
            [objectKeys.spawns] = {[400] = {{80.1, 77.1}}},
            [objectKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [554626] = { -- Lumber Pile : https://wowhead.com/forever/object=554626/lumber-pile
            [objectKeys.name] = "Lumber Pile",
            [objectKeys.spawns] = {[85] = {{8.5, 67.1}, {8.8, 66}, {9.1, 67.7}, {9.3, 64.4}, {9.3, 64.6}, {9.6, 63.4}, {9.6, 63.5}, {10, 64.7}, {10, 66.4}, {10, 68.1}, {10.4, 67.1}, {10.5, 67}, {10.6, 65.3}, {11.2, 65.7}, {12.4, 66.2}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [556626] = { -- Corpse Laden Boat : https://wowhead.com/forever/object=556626/corpse-laden-boat
            [objectKeys.name] = "Corpse Laden Boat",
            [objectKeys.spawns] = {[130] = {{58.4, 34.9}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [556641] = { -- Dusty Shelf : https://wowhead.com/forever/object=556641/dusty-shelf
            [objectKeys.name] = "Dusty Shelf",
            [objectKeys.spawns] = {[130] = {{65.3, 24.8}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [556646] = { -- Mailbox : https://wowhead.com/forever/object=556646/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[267] = {{62.4, 19.9}, {62.6, 19.9}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556650] = { -- Decorated Headstone : https://wowhead.com/forever/object=556650/decorated-headstone
            [objectKeys.name] = "Decorated Headstone",
            [objectKeys.spawns] = {[267] = {{51.8, 52.9}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556669] = { -- Dangerous! : https://wowhead.com/forever/object=556669/dangerous
            [objectKeys.name] = "Dangerous!",
            [objectKeys.spawns] = {[267] = {{62.4, 19.8}, {62.5, 19.7}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556670] = { -- WANTED : https://wowhead.com/forever/object=556670/wanted
            [objectKeys.name] = "WANTED",
            [objectKeys.spawns] = {[267] = {{62.6, 20.7}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [556683] = { -- Shallow Grave : https://wowhead.com/forever/object=556683/shallow-grave
            [objectKeys.name] = "Shallow Grave",
            [objectKeys.spawns] = {[130] = {{67.8, 24.8}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [556693] = { -- Mailbox : https://wowhead.com/forever/object=556693/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[267] = {{50.4, 58.6}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [560880] = { -- Mailbox : https://wowhead.com/forever/object=560880/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{18.1, 64.5}}},
        },
        [560881] = { -- Mailbox : https://wowhead.com/forever/object=560881/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{19, 66.4}, {19, 66.6}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560883] = { -- Mailbox : https://wowhead.com/forever/object=560883/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{12.4, 68.1}, {12.5, 68.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560884] = { -- Mailbox : https://wowhead.com/forever/object=560884/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{14.4, 66.9}, {14.5, 66.4}, {14.6, 66.8}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560885] = { -- Mailbox : https://wowhead.com/forever/object=560885/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{13.2, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560886] = { -- Mailbox : https://wowhead.com/forever/object=560886/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{14.9, 69.2}, {15, 69.9}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560887] = { -- Mailbox : https://wowhead.com/forever/object=560887/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{18.4, 61.4}, {18.4, 61.5}, {18.6, 61.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560888] = { -- Mailbox : https://wowhead.com/forever/object=560888/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{18, 71.4}, {18, 71.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [560901] = { -- Mailbox : https://wowhead.com/forever/object=560901/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{19.2, 73.9}}},
        },
        [561073] = { -- Mailbox : https://wowhead.com/forever/object=561073/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{20.7, 65.7}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [561074] = { -- Mailbox : https://wowhead.com/forever/object=561074/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{20.4, 64.6}, {20.7, 64.8}, {21, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [561075] = { -- Mailbox : https://wowhead.com/forever/object=561075/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{15.2, 63}, {15.5, 63.3}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [561159] = { -- Stolen Enchanting Supplies : https://wowhead.com/forever/object=561159/stolen-enchanting-supplies
            [objectKeys.name] = "Stolen Enchanting Supplies",
            [objectKeys.spawns] = {[12] = {{64.6, 40.4}, {65, 41.1}, {66, 40.4}, {66.1, 40.7}, {66.3, 39}, {66.3, 43}, {66.4, 41.9}, {66.5, 38.8}, {66.6, 41.8}, {67.4, 42.7}, {67.5, 42.7}, {67.8, 39.1}, {67.8, 45.2}, {67.9, 49.3}, {67.9, 49.6}, {68, 41.6}, {68.1, 39.9}, {68.1, 41.4}, {68.3, 45.5}, {68.5, 45.6}, {68.8, 51.1}, {69.4, 38.4}, {69.5, 38.4}, {69.8, 39}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562103] = { -- Waterlogged Saw : https://wowhead.com/forever/object=562103/waterlogged-saw
            [objectKeys.name] = "Waterlogged Saw",
            [objectKeys.spawns] = {[12] = {{74.2, 76.3}, {74.2, 76.5}, {74.5, 76.4}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562105] = { -- Waterlogged Axe : https://wowhead.com/forever/object=562105/waterlogged-axe
            [objectKeys.name] = "Waterlogged Axe",
            [objectKeys.spawns] = {[12] = {{76.7, 82.4}, {76.7, 82.5}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562106] = { -- Waterlogged Toolbox : https://wowhead.com/forever/object=562106/waterlogged-toolbox
            [objectKeys.name] = "Waterlogged Toolbox",
            [objectKeys.spawns] = {[12] = {{77.3, 86.7}, {77.5, 86.8}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562111] = { -- Poor Copper Vein : https://wowhead.com/forever/object=562111/poor-copper-vein
            [objectKeys.name] = "Poor Copper Vein",
            [objectKeys.spawns] = {[1] = {{19.7, 75.3}, {19.8, 73.4}, {19.8, 75.5}, {20.3, 77.4}, {20.3, 77.5}, {20.7, 71.2}, {21.4, 78.6}, {21.6, 69.2}, {22.1, 79.4}, {23, 68.7}, {24, 72}, {24.4, 80.4}, {24.5, 80.4}, {24.9, 62.1}, {25.7, 61.6}, {26.4, 67.8}, {26.4, 79.7}, {26.7, 66}, {26.8, 81}, {27.1, 64}, {27.1, 65.4}, {27.1, 80.3}, {27.2, 62.3}, {27.5, 64.4}, {27.6, 81}, {28, 63}, {28.4, 81.6}, {28.8, 78.9}, {29.1, 82.5}, {29.4, 81.5}, {29.6, 75.6}, {29.6, 80}, {30.3, 79.3}, {30.4, 80.7}, {30.4, 81.7}, {30.5, 81}, {30.5, 82.1}, {30.6, 79.6}}, [12] = {{43.8, 38.4}, {44.1, 38.5}, {44.2, 34.4}, {44.3, 34.5}, {44.3, 43}, {44.6, 39.5}, {44.6, 41.4}, {44.6, 41.5}, {44.7, 39.4}, {44.9, 42.9}, {45.1, 33.9}, {45.1, 36.4}, {47.4, 30}, {47.4, 32}, {47.5, 30.1}, {47.5, 32.1}, {48, 31.2}, {48.2, 29.3}, {48.6, 29.9}, {48.7, 47.7}, {48.9, 27.9}, {49, 49.7}, {49.1, 26.1}, {49.1, 29.1}, {49.1, 33.3}, {49.5, 25.7}, {49.6, 28}, {50.2, 27.1}, {50.2, 31.4}, {50.2, 31.5}, {50.5, 26.6}, {51.3, 52.2}, {52.6, 33.4}, {52.8, 52.8}, {53.4, 34.4}, {53.4, 34.6}, {53.5, 34.5}, {53.5, 52.9}, {54.1, 33.4}, {54.1, 33.5}, {54.2, 37}, {55.1, 35.3}, {55.6, 38.3}, {55.8, 35.7}, {56.1, 39.2}, {56.6, 50.7}, {56.9, 44.8}, {57.1, 46.1}, {57.2, 39.7}, {58, 50}}, [14] = {{39.2, 63.1}, {39.3, 60.9}, {39.8, 67.6}, {39.9, 66.3}, {40, 64.2}, {40, 65.4}, {40, 66.5}, {40.1, 68.5}, {40.2, 60.6}, {40.4, 70.7}, {41.1, 61.5}, {41.1, 68.4}, {41.2, 58.7}, {41.4, 72.6}, {41.5, 66.2}, {41.5, 72.5}, {42, 62.2}, {42.2, 53.9}, {42.3, 57.1}, {42.6, 54.6}, {42.6, 60.4}, {42.6, 60.5}, {42.7, 59.2}, {42.8, 53}, {42.9, 63}, {43, 52.3}, {43.1, 71.6}, {43.1, 73}, {43.2, 54.2}, {43.4, 58.2}, {43.4, 61.7}, {43.5, 51.9}, {43.5, 61.5}, {43.9, 53.1}, {43.9, 73.3}, {44.4, 54.5}, {44.6, 69.5}, {44.8, 54}, {44.9, 52.6}, {45.1, 55.1}, {45.1, 61.7}, {45.2, 56.5}, {45.2, 71.7}, {45.2, 72.5}, {45.4, 56}, {45.4, 66.1}, {45.5, 55.1}, {45.5, 67.2}, {45.5, 73.8}, {45.6, 56.8}, {45.6, 70.7}, {45.9, 58.7}, {46, 58.1}, {46, 69.7}, {46.1, 66}, {46.2, 59.5}, {46.2, 61.5}, {46.5, 57}, {46.9, 67}, {47.1, 59.2}, {47.2, 69.7}, {47.3, 61.6}, {47.3, 63.3}, {47.6, 64.5}}, [85] = {{23.1, 59.8}, {23.3, 58.8}, {23.8, 58.7}, {23.9, 58}, {24, 60.8}, {24.3, 59.6}, {24.6, 60.5}, {25, 59.2}, {25.3, 59.6}, {25.8, 59.4}, {26.1, 60.3}, {26.2, 60.5}, {27, 59.1}, {27.4, 59.9}, {27.5, 59.9}, {27.7, 57.7}, {28.9, 60.9}, {28.9, 68.8}, {29.1, 64.8}, {29.1, 65.9}, {29.1, 70.8}, {29.3, 63.7}, {29.3, 71.6}, {30.3, 73}, {30.4, 67.3}, {31.3, 67.8}, {31.3, 72.2}, {32.1, 72.2}, {32.2, 55.9}, {32.4, 68.9}, {32.6, 68.9}, {32.8, 71.7}, {33.1, 70.4}, {33.2, 70.5}, {33.8, 70.2}, {34.2, 55.8}, {35.3, 70.5}, {35.4, 70.4}, {35.7, 55.6}, {36.3, 71.3}, {37.3, 62}, {37.9, 70.7}, {38, 57.3}, {38.4, 64.9}, {38.4, 67.8}, {38.5, 65}, {38.5, 67.8}, {38.6, 66.2}, {38.6, 66.5}}},
        },
        [562114] = { -- Mining Tools : https://wowhead.com/forever/object=562114/mining-tools
            [objectKeys.name] = "Mining Tools",
            [objectKeys.spawns] = {[12] = {{60.8, 52.7}, {60.9, 51.4}, {60.9, 51.5}, {61.3, 50.1}, {61.5, 51.4}, {61.5, 51.5}, {61.5, 53.2}, {61.6, 50.2}, {61.7, 53.5}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [562131] = { -- Applejack Still : https://wowhead.com/forever/object=562131/applejack-still
            [objectKeys.name] = "Applejack Still",
            [objectKeys.questStarts] = {91736},
            [objectKeys.questEnds] = {91736},
            [objectKeys.spawns] = {[12] = {{24.5, 58.2}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [563442] = { -- Kobold Tracks : https://wowhead.com/forever/object=563442/kobold-tracks
            [objectKeys.name] = "Kobold Tracks",
            [objectKeys.spawns] = {[12] = {{42.1, 62.5}, {45.4, 50.7}, {45.5, 51.3}, {46, 52.3}, {46.5, 54.4}, {47.8, 45.6}, {47.8, 51.9}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [565745] = { -- Portal to The Purple Parlor : https://wowhead.com/forever/object=565745/portal-to-the-purple-parlor
            [objectKeys.name] = "Portal to The Purple Parlor",
            [objectKeys.spawns] = {[36] = {{14.4, 57.5}, {14.5, 57.6}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [566037] = { -- Charred Remains : https://wowhead.com/forever/object=566037/charred-remains
            [objectKeys.name] = "Charred Remains",
            [objectKeys.spawns] = {[130] = {{65, 34.2}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [570207] = { -- Archmage Khadgar : https://wowhead.com/forever/object=570207/archmage-khadgar
            [objectKeys.name] = "Archmage Khadgar",
            [objectKeys.spawns] = {[36] = {{11.1, 63.4}, {11.2, 63.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [573811] = { -- Gravestone : https://wowhead.com/forever/object=573811/gravestone
            [objectKeys.name] = "Gravestone",
            [objectKeys.spawns] = {[616] = {{62.3, 60.9}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [576179] = { -- Supply Cache : https://wowhead.com/forever/object=576179/supply-cache
            [objectKeys.name] = "Supply Cache",
            [objectKeys.spawns] = {[16593] = {{48, 54.6}, {48.5, 55.8}, {49.1, 53.9}, {49.4, 57.1}, {49.5, 54.8}, {49.8, 57.3}, {49.9, 56}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578266] = { -- Wind Bridge : https://wowhead.com/forever/object=578266/wind-bridge
            [objectKeys.name] = "Wind Bridge",
            [objectKeys.spawns] = {[16593] = {{70.8, 50.1}, {70.8, 50.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578937] = { -- Ripe Stormapple : https://wowhead.com/forever/object=578937/ripe-stormapple
            [objectKeys.name] = "Ripe Stormapple",
            [objectKeys.spawns] = {[16593] = {{46.2, 78.4}, {46.3, 79.3}, {46.4, 80.2}, {46.5, 78.4}, {46.5, 78.5}, {46.6, 80.3}, {46.6, 80.7}, {47.4, 83.1}, {47.5, 83.1}, {48.3, 83.8}, {48.7, 83.6}, {49, 84.5}, {49.1, 83.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [578959] = { -- Flutterfly Dust : https://wowhead.com/forever/object=578959/flutterfly-dust
            [objectKeys.name] = "Flutterfly Dust",
            [objectKeys.spawns] = {[16593] = {{46.9, 76.9}, {47.8, 76.5}, {47.9, 76.4}, {48, 79.5}, {48.2, 78.4}, {48.2, 78.5}, {48.4, 73.7}, {48.7, 75.5}, {48.7, 79.1}, {48.9, 82}, {49.4, 74}, {49.5, 77.4}, {50, 75.2}, {50, 81.1}, {50.3, 73.5}, {50.3, 79.7}, {50.4, 77.6}, {50.4, 82.4}, {50.4, 82.5}, {50.5, 77.5}, {50.5, 79.6}, {50.5, 82.6}, {50.8, 80.9}, {51.1, 83.5}, {51.2, 81.8}, {51.4, 76}, {51.5, 77.1}, {51.8, 83.4}, {51.8, 83.5}, {51.9, 82.1}, {52.7, 79.4}, {52.8, 79.7}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [581777] = { -- Suspicious Crate : https://wowhead.com/forever/object=581777/suspicious-crate
            [objectKeys.name] = "Suspicious Crate",
            [objectKeys.spawns] = {[40] = {{41.8, 67.3}, {41.9, 67.6}, {42, 71}, {42.3, 69.6}, {42.4, 68.8}, {42.5, 68.7}, {43.4, 68.2}, {43.5, 67}, {44.4, 68.1}, {44.6, 70.8}, {45.4, 70.2}}},
        },
        [581792] = { -- Detonator : https://wowhead.com/forever/object=581792/detonator
            [objectKeys.name] = "Detonator",
            [objectKeys.spawns] = {[40] = {{38.7, 83.8}}},
            [objectKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [581820] = { -- Dusty Bedroll : https://wowhead.com/forever/object=581820/dusty-bedroll
            [objectKeys.name] = "Dusty Bedroll",
            [objectKeys.spawns] = {[16593] = {{52, 69.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [581822] = { -- Bloodstained Satchel : https://wowhead.com/forever/object=581822/bloodstained-satchel
            [objectKeys.name] = "Bloodstained Satchel",
            [objectKeys.questStarts] = {92849},
            [objectKeys.questEnds] = {92727},
            [objectKeys.spawns] = {[16593] = {{53.3, 72.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [586726] = { -- Portal To Rohashi Spires : https://wowhead.com/forever/object=586726/portal-to-rohashi-spires
            [objectKeys.name] = "Portal To Rohashi Spires",
            [objectKeys.spawns] = {[16593] = {{65.3, 50.6}, {65.4, 50.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [587338] = { -- Uthek's Staff : https://wowhead.com/forever/object=587338/utheks-staff
            [objectKeys.name] = "Uthek's Staff",
            [objectKeys.spawns] = {[405] = {{42.2, 82.1}}},
            [objectKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [602101] = { -- Centaur Supplies : https://wowhead.com/forever/object=602101/centaur-supplies
            [objectKeys.name] = "Centaur Supplies",
            [objectKeys.spawns] = {[16651] = {{29.4, 69.9}, {29.5, 72.1}, {29.6, 69.7}, {29.6, 73.7}, {29.9, 69.4}, {30, 73}, {30, 74.5}, {30.3, 70.8}, {30.7, 70.6}, {34.8, 77.8}}},
            [objectKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [602722] = { -- Mailbox : https://wowhead.com/forever/object=602722/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[616] = {{69.3, 47.2}, {69.3, 47.7}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [602735] = { -- Leyline : https://wowhead.com/forever/object=602735/leyline
            [objectKeys.name] = "Leyline",
            [objectKeys.spawns] = {[1] = {{45.9, 44.2}, {56.6, 45.6}, {63.8, 50.6}, {76.8, 51.8}}, [10] = {{4.3, 25.8}, {7.1, 47}, {10.9, 25.3}, {13, 22.4}, {18.5, 57.2}, {25.6, 33.6}, {34.1, 70.9}, {45.7, 14}, {55, 8.7}, {57.5, 10.2}, {60.9, 12.4}, {63, 73.4}, {72.4, 30.5}, {74.4, 46.8}, {78.3, 35.4}, {88, 11}}, [11] = {{14.7, 37.2}, {40.2, 38.5}, {53.8, 64.5}, {55, 29.7}, {56.2, 63.9}}, [12] = {{37.2, 56.1}, {64.9, 67.4}}, [17] = {{44.6, 90.4}, {48.9, 36.3}, {59.1, 39.6}}, [36] = {{12.6, 52.5}, {19.9, 86}}, [38] = {{28.4, 42.2}, {30.2, 21.8}, {35.9, 50.4}, {49.4, 25.5}, {57.6, 22.2}, {59, 36.4}, {66.9, 65.1}, {80.2, 64.2}, {82.8, 63.2}}, [40] = {{35, 73.2}, {42.3, 25.1}, {44.9, 36.1}, {45.9, 19.9}, {46.3, 59}, {51.1, 21.8}, {51.1, 67.5}, {59.7, 31.6}}, [130] = {{45, 67.9}, {49.3, 74.5}, {52.6, 70.5}, {56.2, 29.2}, {61.2, 79.3}, {62.5, 75.6}, {69.5, 6.7}, {75.6, 50.2}, {96.3, 85.7}}, [148] = {{42.3, 30.1}, {43, 59.5}, {44.5, 21.6}, {45.2, 50.3}, {46.3, 38.2}, {53.4, 20.4}, {57, 26.1}, {85.8, 7.8}}, [331] = {{7.5, 14.3}, {13.1, 24.8}, {13.6, 30.9}, {20.3, 42.6}, {22.1, 52.9}, {26.8, 49.2}, {29.1, 29.5}, {36, 54.6}, {50.4, 56.1}, {60.6, 55.6}, {66.8, 82.1}, {67.9, 79.1}, {75.5, 65.7}, {81.4, 48.9}, {89.4, 49.7}, {95.3, 48.2}}, [406] = {{34.9, 60.3}, {36.4, 12.4}, {37.8, 52.9}, {48.1, 33.6}, {48.5, 46.8}, {58.7, 65.9}, {69.7, 52}, {73.6, 86.6}, {75.3, 4.3}}, [493] = {{56.3, 32.4}}, [16593] = {{33.8, 55.5}, {35.4, 33.9}, {38.8, 47.6}, {41.7, 44.7}, {43.2, 43.5}, {45.7, 80.8}, {46.3, 17.9}, {48.3, 58.5}, {50.5, 33.4}, {52.5, 66.1}, {53.8, 66.3}, {55.1, 50.6}, {58.8, 33.6}, {62.2, 72.7}, {63.9, 74.2}, {64, 46.2}, {69.1, 62}}},
        },
        [610954] = { -- Bounty Available: Vulgara the Insatiable! : https://wowhead.com/forever/object=610954/bounty-available-vulgara-the-insatiable
            [objectKeys.name] = "Bounty Available: Vulgara the Insatiable!",
            [objectKeys.spawns] = {[16593] = {{43.4, 45.8}, {43.5, 45.8}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [612073] = { -- Cookie's Feast : https://wowhead.com/forever/object=612073/cookies-feast
            [objectKeys.name] = "Cookie's Feast",
            [objectKeys.spawns] = {[11] = {{48.7, 56.8}}, [12] = {{42.5, 65.9}}, [17] = {{42.6, 90.1}}, [130] = {{68.3, 45.5}}, [267] = {{62, 20.2}}},
        },
        [612088] = { -- Field Guide : https://wowhead.com/forever/object=612088/field-guide
            [objectKeys.name] = "Field Guide",
            [objectKeys.spawns] = {[10] = {{78.3, 45.3}}, [12] = {{33.5, 51.1}, {42.4, 65.9}}, [17] = {{47, 36.1}}, [33] = {{41, 62.6}}, [40] = {{42.4, 71.2}}, [148] = {{37.5, 43.7}}, [267] = {{50.5, 63.6}}, [331] = {{14.3, 15.2}, {35.4, 49.9}}},
        },
        [612090] = { -- Fishing Rack : https://wowhead.com/forever/object=612090/fishing-rack
            [objectKeys.name] = "Fishing Rack",
            [objectKeys.spawns] = {[17] = {{52, 30.5}}, [28] = {{41.3, 78.2}}},
        },
        [612091] = { -- Toxin Study : https://wowhead.com/forever/object=612091/toxin-study
            [objectKeys.name] = "Toxin Study",
            [objectKeys.spawns] = {[267] = {{62.2, 20.4}, {62.5, 20.4}}},
            [objectKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [613238] = { -- Zephyrseed Cone : https://wowhead.com/forever/object=613238/zephyrseed-cone
            [objectKeys.name] = "Zephyrseed Cone",
            [objectKeys.spawns] = {[16593] = {{55.7, 39.2}, {55.8, 40.5}, {56.1, 37.9}, {56.1, 39.9}, {56.9, 38.1}, {57, 37.4}, {57, 39.5}, {57.2, 39.2}, {57.5, 37.7}, {57.6, 40.6}, {57.9, 40}, {58.7, 39.9}, {58.8, 38.7}, {59.2, 41.4}, {59.3, 38.3}, {59.5, 39.3}, {59.5, 40.7}, {59.6, 39.5}, {60.1, 37.7}, {60.3, 37.3}, {60.6, 38.6}, {61, 37.7}, {61.2, 35.4}, {61.7, 39.3}, {61.8, 36.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [613286] = { -- Raw Windstone : https://wowhead.com/forever/object=613286/raw-windstone
            [objectKeys.name] = "Raw Windstone",
            [objectKeys.spawns] = {[16593] = {{38.3, 30}, {39.4, 27.7}, {40.4, 30.4}, {41.6, 26.9}, {42, 23.8}, {42.9, 22.3}, {42.9, 28.7}, {43.4, 23.8}, {43.5, 23.8}, {43.8, 25.4}, {43.8, 25.5}, {44.1, 22.3}, {44.3, 27.2}, {45, 19.8}, {45.3, 29.1}, {46.6, 17.9}, {46.6, 24.6}, {46.6, 31.1}, {46.7, 28}, {47, 20.9}, {47.2, 23.6}, {47.4, 26.4}, {47.4, 26.5}, {47.5, 26.5}, {48.1, 29.3}, {48.2, 25.7}, {48.3, 19.1}, {49.9, 24.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616466] = { -- Construct Parts : https://wowhead.com/forever/object=616466/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{49.4, 46}, {49.6, 45.9}, {50, 44.8}, {50.7, 44.4}, {50.7, 44.5}, {51.4, 46.6}, {51.6, 46.6}, {52.4, 45.8}, {52.6, 45.9}, {52.8, 49.4}, {52.8, 49.7}, {52.9, 51.7}, {53.1, 47.7}, {53.1, 51.4}, {53.5, 50.4}, {53.6, 50.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616467] = { -- Construct Parts : https://wowhead.com/forever/object=616467/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{43.3, 74.5}, {43.9, 75.4}, {43.9, 75.5}, {44.7, 73.4}, {44.8, 74.2}, {44.8, 76.7}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616468] = { -- Construct Parts : https://wowhead.com/forever/object=616468/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{51.4, 67.6}, {51.5, 67.6}, {51.9, 65.6}, {51.9, 67.1}, {52.8, 64.8}, {53.2, 65.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616860] = { -- Wind-Infused Bough : https://wowhead.com/forever/object=616860/wind-infused-bough
            [objectKeys.name] = "Wind-Infused Bough",
            [objectKeys.spawns] = {[16593] = {{48.4, 68.2}, {48.7, 67.4}, {48.7, 67.7}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616907] = { -- Windstone : https://wowhead.com/forever/object=616907/windstone
            [objectKeys.name] = "Windstone",
            [objectKeys.spawns] = {[16593] = {{35.8, 54.9}, {36.5, 44.9}, {39.8, 39.2}, {40.1, 34.4}, {40.4, 37.2}, {40.5, 37.2}, {40.5, 40.6}, {41.1, 34.6}, {41.7, 62.4}, {43.4, 35.3}, {43.5, 47.4}, {43.5, 47.5}, {45, 73.6}, {46.3, 37.9}, {46.4, 81.1}, {46.9, 38.6}, {47.4, 36}, {47.4, 40.3}, {47.5, 36}, {47.5, 40.2}, {48.4, 72.3}, {48.6, 69.4}, {48.8, 36.9}, {48.8, 81}, {49.1, 39.9}, {49.3, 66.8}, {50.4, 54.9}, {50.5, 54.8}, {50.8, 56.3}, {53.5, 66.4}, {53.5, 66.5}, {53.9, 44.3}, {54.7, 81}, {54.8, 44.6}, {55.5, 67.1}, {56, 37.1}, {56.2, 32.2}, {56.3, 59.2}, {56.8, 71.4}, {56.8, 71.5}, {57.7, 51.4}, {58.1, 44.3}, {58.4, 30.4}, {58.4, 30.5}, {58.5, 30.5}, {58.9, 25.3}, {58.9, 35.3}, {59.4, 33.8}, {59.5, 33.8}, {60.3, 49.2}, {61.1, 53.2}, {62.4, 35.4}, {62.6, 63.4}, {62.7, 63.6}, {63, 45.8}, {63.1, 72.1}, {63.9, 38.1}, {64.6, 39.8}, {64.7, 54.3}, {65.9, 36.1}, {69.2, 67.1}, {69.5, 67.7}, {70, 62.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [616992] = { -- Elemental Convergence : https://wowhead.com/forever/object=616992/elemental-convergence
            [objectKeys.name] = "Elemental Convergence",
            [objectKeys.spawns] = {[11] = {{45.4, 44.3}, {47.7, 48.7}, {49.5, 41.4}, {50.9, 26.4}, {52.5, 42}, {53.9, 64.4}, {54.1, 26.9}, {54.2, 67.3}, {58, 60.8}, {58.3, 6.8}, {60.2, 57}, {61.9, 68.4}}, [14] = {{45.1, 15.7}, {54.5, 50}}, [15] = {{19.5, 9.8}, {33, 30.8}, {35.6, 31.8}, {40.4, 30.7}, {41.8, 30.1}, {43.8, 26.3}}, [17] = {{39.9, 13.9}, {44.8, 55}, {45.7, 69.8}, {46.8, 74}, {48.1, 58.5}, {48.5, 46.3}, {49.1, 15.5}, {49.7, 34.6}, {49.8, 28.6}, {50.9, 14.6}, {53, 22.1}, {54, 26.6}, {54.6, 14.9}, {54.8, 34.7}, {56.3, 41.6}, {63.1, 41.1}}, [33] = {{13.3, 15}}, [36] = {{13.7, 84.9}, {19.5, 91.1}, {21.3, 87.1}, {24.5, 26.6}, {28.2, 80.9}, {38.5, 69.2}, {41, 63.5}, {46.8, 62.4}, {53, 30.6}, {55.2, 66.5}, {58.8, 71.1}, {59.6, 42.3}}, [45] = {{22.7, 23.9}, {25.5, 60.5}, {25.9, 29.5}, {28.2, 85}, {40, 66.6}, {48.4, 91.6}, {51.6, 50.4}, {53.7, 69.5}, {66.7, 30.4}, {68.5, 30.5}, {69.9, 31.7}, {73.5, 32.4}}, [85] = {{49.2, 63.8}, {60.9, 58.8}, {68.8, 64.6}, {75.5, 50.1}}, [130] = {{45, 67.9}, {45.4, 21}, {48.1, 75.4}, {49.4, 52.7}, {52.5, 70.4}, {54.8, 24.1}, {55, 66}, {55.9, 46.6}, {56.2, 10.1}}, [267] = {{14.7, 46.2}, {30, 27.3}, {30.9, 39.6}, {31.8, 30}, {34.8, 49.4}, {48.2, 31.4}, {48.2, 34.6}, {53.4, 13.3}, {56.7, 80.3}, {59.7, 43.1}, {60.8, 50.5}, {61.2, 19.3}, {61.2, 40.2}, {63.3, 46.4}, {64.1, 53.9}, {64.5, 61}, {66.1, 44.5}, {66.4, 22.8}, {67.8, 28.7}, {73, 63.4}, {74.4, 61}, {78.1, 54.2}, {78.3, 44.6}, {80.1, 48.3}, {80.1, 62.1}, {80.4, 45.4}, {81.8, 43.5}, {83.2, 35.3}, {85.4, 52.6}, {87.1, 50}}, [331] = {{9.9, 27.9}, {15.8, 19.6}, {20.7, 32.2}, {22.4, 30}, {25.9, 42.5}, {48.1, 69.5}, {60, 63.1}, {67.9, 79.1}, {76.3, 67.6}}, [400] = {{23.4, 30.4}, {27.2, 41.4}, {42.2, 49.4}, {54.8, 48.2}, {68.7, 52}}, [405] = {{22.9, 72.6}, {26.7, 77.9}, {36.1, 87.9}, {43, 37.6}, {56.3, 58}, {56.6, 29.9}, {58.5, 45.4}, {60.7, 52.9}, {61.5, 41.8}, {66.5, 21.3}, {71.8, 31.9}, {93.3, 58.4}}, [406] = {{33.4, 63.8}, {49.3, 36}, {72.6, 57.6}, {74.9, 94.5}, {80.8, 90.6}}, [1497] = {{33.7, 32.3}, {46.3, 75.8}, {52.9, 77.4}, {53.1, 65.5}, {65.9, 42.2}, {68.5, 64.9}, {70.9, 11.5}, {80.9, 30.7}}, [1637] = {{45.9, 53.5}, {46.8, 64.7}, {51.8, 36.2}, {52.1, 49.4}, {53.8, 69.4}, {68.4, 36.8}}, [1638] = {{24.4, 45.4}, {29.2, 20.2}, {35.2, 33}, {45.3, 53.4}, {50.1, 37.1}, {54.1, 83.8}, {60, 37.1}, {71.9, 29.5}}, [16591] = {{30.5, 66.7}, {33.6, 39.4}, {39.2, 42}, {46.3, 81.5}, {46.4, 50.6}, {53.9, 56.6}, {59.3, 53.6}, {67.4, 26.7}, {70.8, 58.5}, {72.3, 67.7}, {75.6, 35.2}, {84.1, 52.6}}, [16593] = {{34.1, 59.8}, {35.9, 33.6}, {41.7, 44.7}, {43.1, 43.5}, {46.6, 38.3}, {47.7, 69.5}, {48.4, 20.4}, {48.5, 55.8}, {48.5, 80.5}, {52.8, 57.6}, {59.3, 80}, {61.7, 51.6}, {62.2, 72.7}, {64.9, 38}, {68.3, 75}, {68.4, 66}, {70.1, 61.5}}},
        },
        [617084] = { -- Portal to Valanaar : https://wowhead.com/forever/object=617084/portal-to-valanaar
            [objectKeys.name] = "Portal to Valanaar",
            [objectKeys.spawns] = {[16593] = {{75.2, 53.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617085] = { -- Portal to Valanaar : https://wowhead.com/forever/object=617085/portal-to-valanaar
            [objectKeys.name] = "Portal to Valanaar",
            [objectKeys.spawns] = {[16593] = {{75.2, 53.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617674] = { -- Arvensus Shadowsong : https://wowhead.com/forever/object=617674/arvensus-shadowsong
            [objectKeys.name] = "Arvensus Shadowsong",
            [objectKeys.spawns] = {[16593] = {{41, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617675] = { -- Raani Windgazer : https://wowhead.com/forever/object=617675/raani-windgazer
            [objectKeys.name] = "Raani Windgazer",
            [objectKeys.spawns] = {[16593] = {{41.1, 64.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617704] = { -- Bloody Note : https://wowhead.com/forever/object=617704/bloody-note
            [objectKeys.name] = "Bloody Note",
            [objectKeys.spawns] = {[16593] = {{42.4, 62}, {42.5, 62.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [617839] = { -- Hippogryph Down : https://wowhead.com/forever/object=617839/hippogryph-down
            [objectKeys.name] = "Hippogryph Down",
            [objectKeys.spawns] = {[16593] = {{33.2, 54.4}, {33.2, 54.5}, {34, 55.2}, {34.2, 58}, {34.3, 51.4}, {34.3, 51.5}, {34.6, 52.7}, {35, 57}, {35.1, 54.1}, {35.2, 51.1}, {35.6, 53.1}, {35.7, 57.3}, {35.7, 57.5}, {35.8, 55.3}, {36, 51.9}, {36, 54.2}, {36.7, 59.1}, {36.8, 54.7}, {36.8, 56.8}, {36.9, 52.4}, {36.9, 53.3}, {37.2, 51.2}, {37.6, 58.2}, {37.7, 53}, {37.8, 51}, {38.3, 55.1}, {38.6, 51.8}, {38.6, 56.8}, {38.8, 53.2}, {39, 53.9}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [618329] = { -- Construct Parts : https://wowhead.com/forever/object=618329/construct-parts
            [objectKeys.name] = "Construct Parts",
            [objectKeys.spawns] = {[16593] = {{55.1, 69.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [618822] = { -- Ancient Sword : https://wowhead.com/forever/object=618822/ancient-sword
            [objectKeys.name] = "Ancient Sword",
            [objectKeys.spawns] = {[16593] = {{47.5, 72}, {48.9, 72.7}, {49, 72.4}, {50.5, 44.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [619450] = { -- Lady's Tear Moss : https://wowhead.com/forever/object=619450/ladys-tear-moss
            [objectKeys.name] = "Lady's Tear Moss",
            [objectKeys.spawns] = {[16593] = {{58.7, 40}, {59.1, 38.4}, {59.2, 38.5}, {59.9, 39.3}, {59.9, 40.5}, {60, 40.3}, {60.1, 37.5}, {60.3, 37.4}, {60.8, 38.7}, {60.9, 37.4}, {60.9, 37.5}, {61.2, 35.3}, {61.8, 38.9}, {62, 36.5}, {62.1, 36.4}, {62.7, 39.5}, {62.8, 39.4}, {64.3, 39.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [619896] = { -- Forgotten Shrine : https://wowhead.com/forever/object=619896/forgotten-shrine
            [objectKeys.name] = "Forgotten Shrine",
            [objectKeys.questStarts] = {94503},
            [objectKeys.questEnds] = {94502},
            [objectKeys.spawns] = {[40] = {{45.4, 60.1}, {45.6, 59.9}}},
        },
        [621813] = { -- Loose Soil : https://wowhead.com/forever/object=621813/loose-soil
            [objectKeys.name] = "Loose Soil",
            [objectKeys.spawns] = {[16591] = {{48.6, 43.8}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [623295] = { -- Abandonded Belongings : https://wowhead.com/forever/object=623295/abandoned-belongings
            [objectKeys.name] = "Abandonded Belongings",
            [objectKeys.spawns] = {[16593] = {{56.9, 29.4}, {56.9, 33.6}, {57, 33.4}, {57.6, 31}, {57.6, 32.1}, {57.9, 26.9}, {58.4, 32.7}, {58.8, 31.1}, {59.1, 32.3}, {59.1, 34.7}, {59.2, 33.8}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [625582] = { -- Fuzzle's Treasure : https://wowhead.com/forever/object=625582/fuzzles-treasure
            [objectKeys.name] = "Fuzzle's Treasure",
            [objectKeys.questEnds] = {94963},
        },
        [626718] = { -- Dented Chest : https://wowhead.com/forever/object=626718/dented-chest
            [objectKeys.name] = "Dented Chest",
            [objectKeys.spawns] = {[16593] = {{35.5, 22.5}, {35.8, 33.8}, {35.9, 24.7}, {36.2, 25.5}, {36.4, 33}, {36.5, 33}, {37.2, 26.2}, {37.7, 24.6}, {37.7, 34.6}, {46.9, 17.4}, {46.9, 17.5}, {47.3, 34.5}, {48.5, 20.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [626752] = { -- Dented Chest : https://wowhead.com/forever/object=626752/dented-chest
            [objectKeys.name] = "Dented Chest",
            [objectKeys.spawns] = {[16593] = {{35.1, 54.1}, {37.4, 53.7}, {41.9, 66.9}, {43.8, 75.4}, {43.8, 75.5}, {45, 64.5}, {49, 53.5}, {49.5, 56.2}, {49.9, 57.1}, {50, 35.1}, {50.2, 36}, {50.4, 33.1}, {50.6, 44.2}, {50.7, 34.4}, {50.7, 34.5}, {51.8, 72.8}, {55.1, 77.6}, {56, 58.7}, {66, 65.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [628948] = { -- WANTED! : https://wowhead.com/forever/object=628948/wanted
            [objectKeys.name] = "WANTED!",
            [objectKeys.questStarts] = {95254},
        },
        [629596] = { -- Snowdrift : https://wowhead.com/forever/object=629596/snowdrift
            [objectKeys.name] = "Snowdrift",
            [objectKeys.spawns] = {[1] = {{24.3, 44.1}, {24.5, 44.2}, {25, 39.6}, {25.3, 42.7}, {25.4, 40.5}, {25.7, 39.8}, {26.1, 42}, {26.2, 43.1}, {26.2, 43.8}, {26.3, 40.5}, {26.7, 36.2}, {26.8, 42.1}, {27.1, 41.1}, {27.5, 37.4}, {27.5, 37.5}, {27.6, 40.1}, {27.6, 42.8}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [630696] = { -- Dragonmaw Catapult : https://wowhead.com/forever/object=630696/dragonmaw-catapult
            [objectKeys.name] = "Dragonmaw Catapult",
            [objectKeys.questEnds] = {465},
        },
        [630871] = { -- Bottle : https://wowhead.com/forever/object=630871/bottle
            [objectKeys.name] = "Bottle",
            [objectKeys.spawns] = {[85] = {{8.6, 59.5}, {9.2, 59.1}, {9.3, 61.9}, {9.5, 62}, {9.6, 60.6}, {9.6, 63}, {9.8, 59.4}, {10.1, 70.1}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [630885] = { -- Bottle : https://wowhead.com/forever/object=630885/bottle
            [objectKeys.name] = "Bottle",
            [objectKeys.spawns] = {[85] = {{8.6, 65.6}, {8.7, 67}, {8.9, 64.8}, {9.3, 67.7}, {9.5, 68.1}, {10, 67.2}, {10.3, 65.2}, {10.5, 65.2}, {11.1, 65.7}, {11.2, 66.5}, {11.8, 66.4}, {11.8, 66.5}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [631197] = { -- Well : https://wowhead.com/forever/object=631197/well
            [objectKeys.name] = "Well",
            [objectKeys.spawns] = {[616] = {{14.2, 49.7}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [631299] = { -- Skyborne Portal to Stormwind : https://wowhead.com/forever/object=631299/skyborne-portal-to-stormwind
            [objectKeys.name] = "Skyborne Portal to Stormwind",
            [objectKeys.spawns] = {[36] = {{12.1, 56.4}, {12.1, 56.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [640104] = { -- Sprung Trap : https://wowhead.com/forever/object=640104/sprung-trap
            [objectKeys.name] = "Sprung Trap",
            [objectKeys.spawns] = {[17] = {{42.7, 13.9}, {42.7, 21.2}, {42.9, 15}, {43.1, 16.4}, {43.9, 14.4}, {43.9, 14.5}, {44.2, 13.1}, {44.8, 16.8}, {45.3, 14}, {45.4, 13.2}, {45.4, 15.3}, {45.5, 15.3}, {46.4, 13}, {47, 12.4}, {47, 13}, {47.6, 12.6}, {47.9, 11.1}, {50.2, 12.7}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [642320] = { -- Battered Trunk : https://wowhead.com/forever/object=642320/battered-trunk
            [objectKeys.name] = "Battered Trunk",
            [objectKeys.questEnds] = {94223},
            [objectKeys.spawns] = {[10] = {{26.2, 36.3}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [642744] = { -- Mailbox : https://wowhead.com/forever/object=642744/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [644436] = { -- Mailbox : https://wowhead.com/forever/object=644436/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{71, 60.4}, {71.2, 62.6}, {71.3, 63.7}, {71.4, 60.8}, {71.4, 62.4}, {71.7, 62.3}, {71.8, 61}, {71.8, 62.8}}},
        },
        [644437] = { -- Mailbox : https://wowhead.com/forever/object=644437/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{69, 51.8}, {69.4, 50}, {69.5, 50.4}, {69.7, 52.8}, {70, 51.1}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644438] = { -- Mailbox : https://wowhead.com/forever/object=644438/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{61.2, 51.6}, {62, 50.9}, {62.2, 52.4}, {62.3, 50.4}, {62.6, 52.5}, {62.7, 51.1}, {62.7, 52.4}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644439] = { -- Mailbox : https://wowhead.com/forever/object=644439/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{61.9, 37}, {62.3, 35.4}, {62.3, 37.5}, {62.4, 35.6}, {62.5, 35.8}, {62.8, 36.5}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644440] = { -- Mailbox : https://wowhead.com/forever/object=644440/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{69.3, 35.8}, {69.4, 36.9}, {69.7, 35.7}, {69.8, 37.8}, {70.1, 37.4}}},
        },
        [644441] = { -- Mailbox : https://wowhead.com/forever/object=644441/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{66.1, 49.8}, {66.2, 49.2}, {66.9, 49.9}, {67.2, 49.4}}},
        },
        [644442] = { -- Here Lies King Terenas Menethil II : https://wowhead.com/forever/object=644442/here-lies-king-terenas-menethil-ii
            [objectKeys.name] = "Here Lies King Terenas Menethil II",
            [objectKeys.spawns] = {[1497] = {{65.1, 44}, {65.4, 42.8}, {65.5, 42.9}, {66, 44.7}, {66.1, 43.5}, {66.5, 42.7}, {66.7, 44}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644469] = { -- Worm : https://wowhead.com/forever/object=644469/worm
            [objectKeys.name] = "Worm",
            [objectKeys.spawns] = {[1497] = {{44.7, 62.9}, {44.8, 63.7}, {45.1, 64.7}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [644488] = { -- Mailbox : https://wowhead.com/forever/object=644488/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1497] = {{67.2, 38.5}, {67.3, 38.4}, {67.5, 38.4}, {67.5, 38.5}}},
        },
        [645153] = { -- Offering Stone : https://wowhead.com/forever/object=645153/offering-stone
            [objectKeys.name] = "Offering Stone",
            [objectKeys.questStarts] = {95885},
            [objectKeys.questEnds] = {95884, 95885},
            [objectKeys.spawns] = {[130] = {{58.1, 69.8}}},
            [objectKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [645164] = { -- WANTED! : https://wowhead.com/forever/object=645164/wanted
            [objectKeys.name] = "WANTED!",
            [objectKeys.questStarts] = {95992},
        },
        [645166] = { -- WANTED! : https://wowhead.com/forever/object=645166/wanted
            [objectKeys.name] = "WANTED!",
            [objectKeys.questStarts] = {95991},
        },
        [649051] = { -- Wanted: Incinerator Gar'im : https://wowhead.com/forever/object=649051/wanted-incinerator-garim
            [objectKeys.name] = "Wanted: Incinerator Gar'im",
            [objectKeys.questStarts] = {95999},
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [649094] = { -- Rock Pile : https://wowhead.com/forever/object=649094/rock-pile
            [objectKeys.name] = "Rock Pile",
            [objectKeys.spawns] = {[16591] = {{65.2, 25}, {66.4, 25.5}, {67.1, 29}, {68.4, 29.2}, {68.5, 29.1}, {71.8, 34}, {73.2, 34.8}, {74.8, 39.6}, {77.2, 37.9}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [649125] = { -- Grave Marker : https://wowhead.com/forever/object=649125/grave-marker
            [objectKeys.name] = "Grave Marker",
            [objectKeys.spawns] = {[616] = {{22.3, 50.2}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [650428] = { -- Mailbox : https://wowhead.com/forever/object=650428/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{70.6, 72.7}}},
        },
        [650518] = { -- The Skull of Tyrannistrasz : https://wowhead.com/forever/object=650518/the-skull-of-tyrannistrasz
            [objectKeys.name] = "The Skull of Tyrannistrasz",
            [objectKeys.spawns] = {[1537] = {{77.3, 27.5}, {77.4, 27.1}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650519] = { -- Fossilized Egg : https://wowhead.com/forever/object=650519/fossilized-egg
            [objectKeys.name] = "Fossilized Egg",
            [objectKeys.spawns] = {[1537] = {{74.9, 24.1}, {76.2, 24.5}, {76.4, 24.2}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650520] = { -- Roc Talon : https://wowhead.com/forever/object=650520/roc-talon
            [objectKeys.name] = "Roc Talon",
            [objectKeys.spawns] = {[1537] = {{76.2, 24.3}, {76.5, 23.4}, {76.5, 24.3}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650521] = { -- Geru Strider : https://wowhead.com/forever/object=650521/geru-strider
            [objectKeys.name] = "Geru Strider",
            [objectKeys.spawns] = {[1537] = {{76.4, 22.3}, {76.6, 22.1}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650522] = { -- Toothgnasher's Skeleton : https://wowhead.com/forever/object=650522/toothgnashers-skeleton
            [objectKeys.name] = "Toothgnasher's Skeleton",
            [objectKeys.spawns] = {[1537] = {{73.8, 20.2}, {74.1, 21.4}, {74.1, 21.5}, {74.7, 21.7}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650523] = { -- Saurial Egg : https://wowhead.com/forever/object=650523/saurial-egg
            [objectKeys.name] = "Saurial Egg",
            [objectKeys.spawns] = {[1537] = {{77.8, 22.3}, {78.3, 22.8}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650524] = { -- Pteradon Skeleton : https://wowhead.com/forever/object=650524/pteradon-skeleton
            [objectKeys.name] = "Pteradon Skeleton",
            [objectKeys.spawns] = {[1537] = {{70.3, 18.4}, {70.9, 18.2}, {71.3, 16.9}, {71.5, 16.7}, {71.7, 17.5}, {72.4, 16.3}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650525] = { -- Highborne Astrolabe : https://wowhead.com/forever/object=650525/highborne-astrolabe
            [objectKeys.name] = "Highborne Astrolabe",
            [objectKeys.spawns] = {[1537] = {{69.4, 11.4}, {69.5, 9.5}, {69.6, 12}, {69.7, 10.5}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650526] = { -- Uldaman Relics : https://wowhead.com/forever/object=650526/uldaman-relics
            [objectKeys.name] = "Uldaman Relics",
            [objectKeys.spawns] = {[1537] = {{68.8, 5.5}, {69, 5.3}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650527] = { -- Horde Catapult : https://wowhead.com/forever/object=650527/horde-catapult
            [objectKeys.name] = "Horde Catapult",
            [objectKeys.spawns] = {[1537] = {{66, 6.8}, {66.7, 7}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650528] = { -- Uldaman Reliefs : https://wowhead.com/forever/object=650528/uldaman-reliefs
            [objectKeys.name] = "Uldaman Reliefs",
            [objectKeys.spawns] = {[1537] = {{64.1, 3.7}, {64.3, 3.4}, {64.5, 3.5}, {64.6, 2.9}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650529] = { -- Pteradon Skeleton : https://wowhead.com/forever/object=650529/pteradon-skeleton
            [objectKeys.name] = "Pteradon Skeleton",
            [objectKeys.spawns] = {[1537] = {{71.6, 13}, {72.9, 14}, {73, 13.2}, {73.5, 13.2}, {73.5, 13.6}, {73.7, 12.4}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650577] = { -- Mailbox : https://wowhead.com/forever/object=650577/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{20, 53}, {21.2, 51.3}, {21.2, 53.5}, {21.3, 53.4}, {21.6, 53.4}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [650593] = { -- Mailbox : https://wowhead.com/forever/object=650593/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{32.2, 64.5}, {32.4, 64.3}, {32.6, 65.2}, {32.7, 64}, {32.8, 65.6}, {33.5, 65.7}}},
        },
        [650666] = { -- Mailbox : https://wowhead.com/forever/object=650666/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1537] = {{71.4, 48.9}, {71.6, 49.5}, {71.7, 48.5}, {71.8, 48.4}, {72.6, 48.1}, {72.8, 49.8}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [651604] = { -- Mailbox : https://wowhead.com/forever/object=651604/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[36] = {{12.7, 52.4}, {12.8, 52.5}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [652323] = { -- Mailbox : https://wowhead.com/forever/object=652323/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16593] = {{43.3, 44}, {43.5, 44.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [652324] = { -- Mailbox : https://wowhead.com/forever/object=652324/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16593] = {{62.2, 73.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [654168] = { -- Skyborne Portal to Dalaran : https://wowhead.com/forever/object=654168/skyborne-portal-to-dalaran
            [objectKeys.name] = "Skyborne Portal to Dalaran",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [654846] = { -- Lost Journal : https://wowhead.com/forever/object=654846/lost-journal
            [objectKeys.name] = "Lost Journal",
            [objectKeys.spawns] = {[141] = {{59.1, 39.4}, {59.1, 39.5}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [654925] = { -- Lost Journal : https://wowhead.com/forever/object=654925/lost-journal
            [objectKeys.name] = "Lost Journal",
            [objectKeys.questStarts] = {96652},
            [objectKeys.spawns] = {[14] = {{42.8, 69.1}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [655669] = { -- Mailbox : https://wowhead.com/forever/object=655669/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[616] = {{70.8, 49.8}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [656157] = { -- Syndicate Footlocker : https://wowhead.com/forever/object=656157/syndicate-footlocker
            [objectKeys.name] = "Syndicate Footlocker",
            [objectKeys.questStarts] = {96784},
            [objectKeys.questEnds] = {96783},
            [objectKeys.spawns] = {[45] = {{32.3, 26.4}, {32.4, 26.7}, {32.5, 26.4}, {32.5, 26.7}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [656160] = { -- Wilted Peacebloom : https://wowhead.com/forever/object=656160/wilted-peacebloom
            [objectKeys.name] = "Wilted Peacebloom",
            [objectKeys.spawns] = {[1] = {{20.1, 74.8}, {20.6, 72.8}, {20.9, 77.6}, {21.5, 74.4}, {22.2, 72.8}, {22.3, 76.4}, {23, 77.1}, {23.2, 72}, {23.4, 69.4}, {23.4, 69.5}, {23.6, 75.7}, {24.1, 78.2}, {24.6, 70.8}, {25.3, 80.5}, {25.4, 76.7}, {25.5, 76.8}, {25.8, 77.5}, {25.9, 72.4}, {26, 78.9}, {26.3, 72.9}, {26.5, 72.3}, {26.7, 73.3}, {26.9, 78.1}, {26.9, 79.3}, {27.1, 71.3}, {27.7, 77.6}, {27.8, 72.3}, {28, 70.6}, {28.5, 71.7}, {28.5, 77.6}, {29, 70.9}, {29.4, 74.2}, {29.4, 76.9}, {29.5, 76.9}, {29.8, 73.3}, {29.8, 75.7}, {30.7, 75.7}, {31.1, 72.1}, {31.4, 73.1}, {31.5, 69.5}, {31.5, 73.2}, {31.6, 69.4}, {32.2, 72.4}, {32.5, 71.8}, {32.9, 72.7}, {33.6, 71.4}, {33.6, 71.5}}, [12] = {{44.2, 35.4}, {45.3, 31}, {45.4, 38.8}, {45.5, 45.5}, {45.6, 43.1}, {45.7, 45.3}, {45.8, 42.3}, {46.4, 39.8}, {46.7, 32.9}, {46.7, 42.7}, {46.8, 32.2}, {47.3, 46.1}, {48.9, 44.5}, {49.1, 48.3}, {49.4, 45.7}, {49.5, 45.7}, {49.9, 35.3}, {50, 36.9}, {50.4, 31.1}, {50.7, 50.7}, {51.1, 38.7}, {51.2, 41.7}, {51.2, 46.2}, {51.2, 48}, {51.3, 42.9}, {52.3, 46.2}, {52.4, 50.6}, {52.5, 47.7}, {52.6, 41.8}, {52.8, 34.8}, {53.1, 38.3}, {53.2, 52.2}, {53.9, 42.4}, {54.7, 38.5}, {54.8, 37}, {55.8, 39.1}, {55.8, 47.6}, {56, 41.2}, {56.1, 37.3}, {56.5, 48.5}, {56.6, 43.4}, {56.8, 50.4}, {57.5, 40}, {57.5, 46.9}, {57.7, 44.7}}, [14] = {{39, 62}, {39.8, 62.9}, {39.8, 67.1}, {40, 68.2}, {40.5, 69}, {40.6, 60.4}, {40.6, 62.3}, {40.8, 63.8}, {41.2, 58.8}, {41.2, 72.5}, {41.5, 73}, {41.6, 58.6}, {42, 63.2}, {42.5, 73.1}, {42.7, 57.6}, {42.7, 58.6}, {42.9, 56.2}, {43, 64.3}, {43.1, 57.3}, {43.4, 63}, {43.7, 62.7}, {43.8, 65.1}, {44, 67}, {44.2, 57.7}, {44.2, 69.5}, {44.6, 58.2}, {44.6, 64.8}, {44.7, 72.6}, {44.8, 67}, {44.9, 59.6}, {44.9, 61.7}, {45.4, 69}, {45.4, 71}, {45.5, 58.4}, {45.5, 58.5}, {45.5, 69}, {45.7, 64.5}, {45.7, 65.6}, {45.9, 67.6}, {46, 60.7}, {46.2, 63.3}, {46.5, 58.8}, {46.6, 69.7}, {46.9, 60.2}, {46.9, 66.2}, {47.1, 57.4}, {47.1, 57.6}, {47.2, 62.7}, {48, 69.6}}, [85] = {{29.1, 68.7}, {29.2, 62.8}, {29.3, 70.4}, {29.4, 58.9}, {29.9, 72}, {30, 60.9}, {30.3, 69.1}, {30.7, 68.3}, {31, 61.5}, {31.2, 62.6}, {32, 72.6}, {32.1, 70.5}, {32.3, 59.2}, {32.5, 69}, {32.9, 66.4}, {33, 69.6}, {33, 71.7}, {33.1, 56.1}, {33.1, 64.2}, {33.6, 69.1}, {33.7, 58.2}, {34, 63}, {34, 66.1}, {34.3, 61.6}, {34.4, 64.1}, {35, 56.2}, {35, 63.5}, {35.2, 59.4}, {35.4, 68.7}, {35.8, 65.2}, {35.9, 61.8}, {35.9, 62.8}, {35.9, 66.5}, {36.1, 70.2}, {36.4, 57.2}, {36.5, 57.2}, {37.3, 58.5}, {37.3, 67}, {37.5, 71.2}, {37.7, 60.7}, {38.2, 69.4}, {38.2, 69.5}, {38.4, 67.9}, {38.8, 66.8}}, [141] = {{53.3, 38.7}, {53.7, 38}, {53.9, 40.2}, {54.4, 43.5}, {54.4, 46.4}, {54.5, 33}, {54.5, 41.4}, {54.5, 41.5}, {54.6, 40}, {54.7, 43.1}, {54.8, 46.4}, {54.8, 46.5}, {55, 45.2}, {55.3, 37.4}, {55.3, 44.3}, {55.4, 36.3}, {55.5, 36.2}, {55.5, 41.6}, {55.5, 46.5}, {55.9, 32.3}, {56.5, 42.2}, {56.5, 44.1}, {56.8, 33.2}, {57, 37.2}, {57.1, 44.5}, {57.3, 33.5}, {57.4, 42.7}, {57.4, 46.4}, {57.5, 40.5}, {57.5, 43.7}, {58, 35.9}, {58, 38.4}, {58.1, 36.7}, {58.3, 46.3}, {58.9, 41.6}, {59, 46.9}, {59.3, 44.4}, {59.4, 46}, {60, 40.2}, {60.1, 46.1}, {60.3, 32.6}, {60.4, 36.3}, {60.5, 36.3}, {60.8, 30.3}, {60.9, 41.3}, {61, 47.4}, {61.1, 43.5}, {61.3, 38.2}, {61.4, 33.7}, {61.7, 34}, {62.3, 40}, {62.4, 40.7}, {62.5, 45.6}, {63, 36.6}, {63, 40.6}, {63.1, 38}, {63.2, 44.2}, {63.4, 35.4}, {63.8, 37.8}, {65.1, 42.8}}},
        },
        [656161] = { -- Stunted Silverleaf : https://wowhead.com/forever/object=656161/stunted-silverleaf
            [objectKeys.name] = "Stunted Silverleaf",
            [objectKeys.spawns] = {[1] = {{20.1, 74.8}, {20.6, 72.8}, {20.9, 77.7}, {21.4, 74.4}, {21.5, 74.4}, {22.2, 72.8}, {22.2, 76.4}, {22.2, 76.5}, {23, 77.1}, {23.2, 71.9}, {23.4, 69.6}, {23.6, 75.7}, {24.2, 78.1}, {24.6, 70.8}, {25.2, 80.5}, {25.4, 76.6}, {25.5, 76.7}, {25.8, 77.6}, {25.9, 72.2}, {26, 78.9}, {26.3, 72.9}, {26.6, 72.3}, {26.7, 73.3}, {26.8, 79.5}, {26.9, 78.1}, {26.9, 79.4}, {27.2, 71.2}, {27.7, 77.7}, {27.8, 72.3}, {28, 70.6}, {28.5, 71.6}, {28.5, 77.6}, {29, 70.9}, {29.4, 74.1}, {29.5, 74.2}, {29.8, 73.3}, {30.1, 76.4}, {30.1, 76.7}, {30.7, 75.7}, {31.1, 72.2}, {31.5, 69.5}, {32.2, 72.4}, {32.2, 72.5}, {32.5, 71.8}, {32.9, 72.7}, {34.1, 72}}, [12] = {{44.2, 35.3}, {45.3, 31}, {45.4, 38.8}, {45.5, 43.1}, {45.6, 45.4}, {45.9, 42.2}, {46.2, 46.7}, {46.3, 39.7}, {46.5, 39.7}, {46.7, 42.7}, {46.8, 32.1}, {46.8, 33}, {47.4, 46.2}, {48.9, 44.6}, {49.1, 48.3}, {49.4, 45.7}, {49.8, 35.4}, {50, 36.9}, {50.4, 31.1}, {50.8, 34.8}, {51, 38.7}, {51.1, 46.1}, {51.4, 43.1}, {51.9, 49.5}, {52.3, 46.3}, {52.4, 43.4}, {52.4, 43.6}, {52.4, 47.8}, {52.5, 46.3}, {52.5, 50.9}, {52.6, 41.9}, {52.8, 34.8}, {53, 38.2}, {54, 42.5}, {54.1, 42.3}, {55.3, 41}, {55.8, 47.8}, {56.1, 37.3}, {56.5, 48.6}, {56.7, 43.3}, {56.9, 50.3}, {57.5, 46.8}, {57.6, 40.1}, {57.7, 44.7}}, [14] = {{39, 62}, {39.8, 62.9}, {39.8, 67}, {40, 68.2}, {40.5, 69}, {40.6, 60.4}, {40.6, 62.4}, {40.6, 62.5}, {40.8, 63.8}, {41.2, 72.5}, {41.7, 58.6}, {42, 63.2}, {42.4, 73.1}, {42.5, 73.1}, {42.6, 57.8}, {42.7, 58.6}, {42.9, 56.2}, {43, 64.2}, {43.1, 57.3}, {43.4, 63.2}, {43.7, 62.7}, {43.7, 72.4}, {43.7, 72.6}, {43.8, 65.2}, {44, 66.8}, {44.1, 69.6}, {44.2, 57.8}, {44.6, 64.9}, {44.7, 58.3}, {44.7, 72.6}, {44.8, 61.7}, {44.8, 67}, {44.9, 59.6}, {45.4, 69.2}, {45.4, 71.1}, {45.5, 58.4}, {45.5, 58.5}, {45.5, 69}, {45.6, 64.5}, {45.6, 65.7}, {45.7, 63.5}, {45.9, 67.6}, {46, 60.7}, {46.2, 63.4}, {46.5, 58.9}, {46.6, 69.7}, {46.8, 66.3}, {46.9, 60.2}, {47.1, 57.4}, {47.1, 57.6}, {47.2, 62.7}, {47.9, 69.6}}, [85] = {{28.9, 69.2}, {29.3, 63}, {29.3, 70.5}, {29.4, 59.1}, {29.8, 71.9}, {30, 60.9}, {30.2, 68.9}, {30.8, 68.3}, {30.9, 61.5}, {31.2, 62.5}, {32, 70.6}, {32.1, 72.6}, {32.2, 59.2}, {32.8, 66.4}, {33, 69.5}, {33, 71.7}, {33.1, 56.2}, {33.1, 64.2}, {33.6, 58.3}, {33.6, 69}, {33.7, 61.6}, {33.9, 66.1}, {34, 62.9}, {34.3, 63.5}, {34.6, 68.1}, {34.8, 69.2}, {34.9, 56.1}, {35, 63.5}, {35.2, 59.4}, {35.3, 59.5}, {35.7, 65.1}, {35.8, 61.9}, {35.9, 62.7}, {35.9, 66.6}, {36, 70.2}, {36.4, 57.2}, {36.5, 57.2}, {37.1, 56}, {37.1, 60.2}, {37.1, 69.8}, {37.2, 58.5}, {37.4, 66.9}, {37.5, 67}, {37.5, 71.4}, {38.1, 61.4}, {38.2, 69.3}, {38.3, 69.5}, {38.8, 66.8}}, [141] = {{53.3, 38.6}, {53.7, 38}, {53.8, 40.1}, {54.3, 44.2}, {54.4, 45.2}, {54.4, 46.4}, {54.5, 33}, {54.7, 43.1}, {55, 45.2}, {55.2, 40.4}, {55.2, 40.5}, {55.2, 46}, {55.2, 47.3}, {55.3, 37.3}, {55.3, 44.3}, {55.4, 36.3}, {55.4, 41.5}, {55.5, 36.2}, {55.5, 41.6}, {55.5, 46.5}, {55.9, 32.3}, {56.4, 44}, {56.5, 42.2}, {56.5, 44.1}, {56.9, 33.4}, {57.1, 44.5}, {57.2, 37.2}, {57.3, 33.5}, {57.3, 40.5}, {57.4, 42.7}, {57.4, 46.4}, {57.5, 42.7}, {57.5, 43.7}, {58, 35.9}, {58, 38.4}, {58.1, 36.7}, {58.3, 46.3}, {58.6, 46.6}, {58.9, 41.6}, {59.1, 34.1}, {59.4, 44.4}, {59.4, 46.1}, {59.5, 45.9}, {59.7, 32.6}, {59.9, 40.1}, {60.2, 32.4}, {60.3, 45}, {60.4, 36.2}, {60.7, 30.3}, {60.8, 41.4}, {60.9, 43.6}, {61, 33.3}, {61, 47.4}, {61.3, 33.7}, {61.4, 38.2}, {61.7, 34.2}, {62.3, 40}, {62.4, 40.7}, {62.4, 43.6}, {62.5, 45.6}, {63, 36.6}, {63, 37.9}, {63.2, 44.2}, {63.3, 41.2}, {63.4, 35.3}, {63.5, 39.9}, {63.8, 37.8}, {65.2, 42.8}}},
        },
        [656177] = { -- Prickly Pear Fruit : https://wowhead.com/forever/object=656177/prickly-pear-fruit
            [objectKeys.name] = "Prickly Pear Fruit",
            [objectKeys.spawns] = {[14] = {{43.6, 50.5}, {43.8, 50.3}, {44.7, 49.6}, {44.8, 49.4}, {44.9, 50.5}, {46.8, 49}, {47.1, 49.9}, {47.6, 49.7}, {47.7, 48.2}, {47.8, 48.8}, {49, 49.2}, {49.3, 48.1}, {49.5, 47.7}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656180] = { -- Raider's Bow : https://wowhead.com/forever/object=656180/raiders-bow
            [objectKeys.name] = "Raider's Bow",
            [objectKeys.spawns] = {[14] = {{57.3, 57.9}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656181] = { -- Raider's Battleaxe : https://wowhead.com/forever/object=656181/raiders-battleaxe
            [objectKeys.name] = "Raider's Battleaxe",
            [objectKeys.spawns] = {[14] = {{57.4, 56.4}, {57.4, 56.5}, {57.5, 56.4}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656182] = { -- Raider's Shield : https://wowhead.com/forever/object=656182/raiders-shield
            [objectKeys.name] = "Raider's Shield",
            [objectKeys.spawns] = {[14] = {{56.6, 53}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [656332] = { -- Chunk of Amber : https://wowhead.com/forever/object=656332/chunk-of-amber
            [objectKeys.name] = "Chunk of Amber",
            [objectKeys.spawns] = {[141] = {{55.5, 28.1}, {55.7, 28.7}, {55.9, 26.4}, {56.2, 26.7}, {56.3, 24.6}, {56.3, 29.7}, {56.4, 30.5}, {56.4, 31.8}, {56.5, 26.4}, {56.5, 30.6}, {56.5, 31.8}, {56.8, 25.4}, {56.8, 27.8}, {57.2, 29.9}, {57.4, 27.3}, {57.4, 29}, {57.5, 29.9}, {57.8, 25.8}, {57.8, 26.5}, {57.9, 27.8}, {58.2, 28.5}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [656333] = { -- Large Chunk of Amber : https://wowhead.com/forever/object=656333/large-chunk-of-amber
            [objectKeys.name] = "Large Chunk of Amber",
            [objectKeys.spawns] = {[141] = {{37.2, 22.8}, {37.4, 23.9}, {37.6, 23.8}, {37.8, 82.7}, {37.9, 81.8}, {43, 61.6}, {43.1, 59.3}, {43.3, 60.7}, {43.5, 58.6}, {43.6, 61.9}, {43.6, 80.8}, {44, 57}, {44.2, 60.6}, {44.3, 58.4}, {44.3, 60.4}, {44.6, 62.6}, {44.7, 57.2}, {44.8, 58.9}, {45, 58.2}, {45.4, 60.2}, {45.5, 60.2}, {45.7, 57.7}, {46.3, 51.2}, {46.3, 51.8}, {51.1, 51}, {51.3, 50}, {51.4, 49.1}, {51.7, 51.8}, {51.8, 50.1}, {51.9, 51}, {52.3, 48.8}, {52.5, 50.2}, {52.8, 49.3}, {52.9, 79.6}, {53, 78.7}, {53.2, 51.9}, {53.2, 74.4}, {53.3, 50.6}, {53.4, 74.8}, {53.5, 48.4}, {53.5, 48.5}, {53.5, 50.1}, {53.7, 75.4}, {53.7, 75.5}, {54, 51.2}, {54.4, 51.9}, {54.5, 51.9}, {54.6, 52.6}, {54.7, 51.2}, {65.1, 72.3}, {70.6, 60}, {70.6, 63.9}, {71.1, 51.5}, {71.6, 51.8}, {71.7, 60.1}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [656366] = { -- Naxxramas Crystal Fragment : https://wowhead.com/forever/object=656366/naxxramas-crystal-fragment
            [objectKeys.name] = "Naxxramas Crystal Fragment",
            [objectKeys.spawns] = {[85] = {{66.4, 63.6}, {66.9, 64.4}, {66.9, 64.5}, {67.1, 62.4}, {67.3, 62.5}, {67.4, 65.6}, {67.5, 63.2}, {67.9, 66.8}, {68, 64.1}, {68.3, 65.7}, {68.4, 64.5}, {68.5, 64.6}, {68.6, 63}, {69.2, 66}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [656700] = { -- Mailbox : https://wowhead.com/forever/object=656700/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[33] = {{26.8, 76.5}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [656748] = { -- Mailbox : https://wowhead.com/forever/object=656748/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[33] = {{27.4, 77.5}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [656789] = { -- Lost Shipping Crate : https://wowhead.com/forever/object=656789/lost-shipping-crate
            [objectKeys.name] = "Lost Shipping Crate",
            [objectKeys.questStarts] = {94841},
        },
        [657380] = { -- Silverleaf : https://wowhead.com/forever/object=657380/silverleaf
            [objectKeys.name] = "Silverleaf",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [657382] = { -- Peacebloom : https://wowhead.com/forever/object=657382/peacebloom
            [objectKeys.name] = "Peacebloom",
            [objectKeys.spawns] = {[14] = {{36.4, 56.2}, {36.8, 31.8}, {37, 26.5}, {37, 50.1}, {40.6, 19.4}, {42.4, 31.2}, {51.5, 48}, {54.8, 15.4}, {64.1, 74.3}}, [16593] = {{39.6, 46.4}, {41.8, 45.5}, {41.9, 35.3}, {42.8, 40.9}, {43.8, 26.3}, {44.4, 42.9}, {44.9, 27.3}, {45.5, 21.9}, {46.8, 25.6}, {47.1, 73.8}, {47.3, 39.6}, {54.1, 75.7}, {54.2, 70.3}}},
        },
        [657383] = { -- Earthroot : https://wowhead.com/forever/object=657383/earthroot
            [objectKeys.name] = "Earthroot",
            [objectKeys.spawns] = {[14] = {{36.7, 54.6}, {37, 24.7}, {39.2, 25.4}, {41, 16.3}, {46.8, 45.9}, {53.7, 79.9}, {57, 72.1}}, [16593] = {{33.8, 53.3}, {37.2, 43.8}, {39.6, 34.8}, {41.6, 28.8}, {45.9, 29.8}, {48.4, 25.7}, {48.8, 55.3}, {62.8, 54.1}}},
        },
        [657385] = { -- Briarthorn : https://wowhead.com/forever/object=657385/briarthorn
            [objectKeys.name] = "Briarthorn",
            [objectKeys.spawns] = {[40] = {{39.5, 68.2}, {43.7, 70.4}}, [130] = {{50, 35.6}, {53.5, 46.6}}, [331] = {{22.4, 36.2}}, [406] = {{30, 63.7}}},
        },
        [657386] = { -- Bruiseweed : https://wowhead.com/forever/object=657386/bruiseweed
            [objectKeys.name] = "Bruiseweed",
            [objectKeys.spawns] = {[38] = {{73, 49}}, [40] = {{33.7, 73.9}}, [406] = {{76.6, 95.2}}},
        },
        [657387] = { -- Wild Steelbloom : https://wowhead.com/forever/object=657387/wild-steelbloom
            [objectKeys.name] = "Wild Steelbloom",
            [objectKeys.spawns] = {[17] = {{42.7, 83.2}}, [400] = {{65.1, 60.6}}, [406] = {{38.5, 67.3}, {73, 91.3}, {75.4, 83.2}}},
        },
        [657389] = { -- Grave Moss : https://wowhead.com/forever/object=657389/grave-moss
            [objectKeys.name] = "Grave Moss",
            [objectKeys.spawns] = {[17] = {{41.6, 78.9}, {43.3, 83.2}, {44.2, 83}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657390] = { -- Liferoot : https://wowhead.com/forever/object=657390/liferoot
            [objectKeys.name] = "Liferoot",
            [objectKeys.spawns] = {[45] = {{45.7, 81.3}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [657394] = { -- Stranglekelp : https://wowhead.com/forever/object=657394/stranglekelp
            [objectKeys.name] = "Stranglekelp",
            [objectKeys.spawns] = {[17] = {{63.3, 38.9}, {64.6, 42.8}, {65.1, 45.4}, {65.4, 37.3}}, [130] = {{38, 80.3}}},
        },
        [657454] = { -- Wilted Peacebloom : https://wowhead.com/forever/object=657454/wilted-peacebloom
            [objectKeys.name] = "Wilted Peacebloom",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [657455] = { -- Stunted Silverleaf : https://wowhead.com/forever/object=657455/stunted-silverleaf
            [objectKeys.name] = "Stunted Silverleaf",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [657456] = { -- Peacebloom : https://wowhead.com/forever/object=657456/peacebloom
            [objectKeys.name] = "Peacebloom",
            [objectKeys.spawns] = {[17] = {{49.4, 30.1}, {49.4, 36.4}, {57.9, 24.6}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657457] = { -- Silverleaf : https://wowhead.com/forever/object=657457/silverleaf
            [objectKeys.name] = "Silverleaf",
            [objectKeys.spawns] = {[17] = {{40.5, 17.2}, {48.1, 36.3}, {48.2, 40.1}, {49.5, 12.8}, {50.1, 33.9}, {52.6, 32.1}, {54.7, 22}, {55.5, 17}, {58.8, 20.5}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657458] = { -- Earthroot : https://wowhead.com/forever/object=657458/earthroot
            [objectKeys.name] = "Earthroot",
            [objectKeys.spawns] = {[17] = {{38.2, 27.2}, {39, 17.7}, {39.1, 30.7}, {39.2, 24.5}, {39.6, 28.7}, {39.8, 12.4}, {40.4, 21.5}, {40.8, 29.6}, {41.6, 29.8}, {41.6, 60.5}, {43.2, 78.2}, {44.8, 20.8}, {48, 23}, {50, 17.3}, {59.8, 19.3}, {61.6, 15.9}, {62, 9.6}, {62.3, 30.5}, {62.9, 43.9}, {63.2, 47.1}, {64.9, 44.1}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657459] = { -- Mageroyal : https://wowhead.com/forever/object=657459/mageroyal
            [objectKeys.name] = "Mageroyal",
            [objectKeys.spawns] = {[17] = {{39, 15.9}, {40.3, 29.6}, {41, 16}, {42.3, 48.1}, {42.5, 80.8}, {42.8, 25.6}, {42.8, 60.2}, {42.9, 28.5}, {42.9, 55.5}, {43.1, 20.1}, {43.8, 38.4}, {44.1, 63.6}, {44.2, 56.2}, {44.2, 61.1}, {44.4, 15.2}, {44.4, 34.5}, {44.5, 15.2}, {44.5, 19.2}, {45.1, 26.1}, {45.2, 64.1}, {45.9, 63.9}, {46.1, 54.2}, {46.3, 15.8}, {46.4, 24.3}, {47, 36.1}, {47.1, 42.9}, {47.5, 45.2}, {48.2, 74.3}, {48.5, 47.2}, {48.5, 63}, {49.2, 40.9}, {49.3, 23.5}, {51.6, 46.7}, {51.7, 54.2}, {53.3, 15.3}, {53.6, 51.3}, {54.3, 36.4}, {54.4, 39.4}, {54.8, 48.7}, {54.9, 16.8}, {55.7, 13.1}, {56, 5.9}, {56.9, 34.4}, {56.9, 34.5}, {57.5, 16}, {59.9, 22.8}, {59.9, 53.3}, {60.4, 11.1}, {62.1, 15.7}, {62.2, 13}, {63.4, 5.6}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657460] = { -- Briarthorn : https://wowhead.com/forever/object=657460/briarthorn
            [objectKeys.name] = "Briarthorn",
            [objectKeys.spawns] = {[17] = {{37.3, 26.8}, {38.2, 13.1}, {38.9, 30.2}, {39, 13.9}, {40.2, 16}, {40.2, 19.4}, {41.6, 24.6}, {42.7, 14.1}, {43.5, 62}, {43.8, 59.8}, {44.4, 21.3}, {44.6, 49.8}, {45.2, 46}, {45.4, 30.8}, {45.5, 36.3}, {52.9, 51.1}, {53.2, 24.4}, {53.3, 24.5}, {53.8, 9.9}, {54.2, 26.9}, {57.4, 52.9}, {57.5, 50.4}, {59.3, 33.6}, {59.4, 38.3}, {60.4, 10.2}, {61.4, 2.9}, {61.4, 41}, {61.4, 47.4}, {61.8, 44.8}, {62.7, 49.4}, {63.4, 46.3}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [657461] = { -- Bruiseweed : https://wowhead.com/forever/object=657461/bruiseweed
            [objectKeys.name] = "Bruiseweed",
            [objectKeys.spawns] = {[17] = {{43.4, 72.5}, {44.7, 83.5}, {45.1, 36}, {45.4, 86.3}, {45.5, 86.3}, {47.3, 69.3}, {61.9, 3.5}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [658115] = { -- Lost Shipping Crate : https://wowhead.com/forever/object=658115/lost-shipping-crate
            [objectKeys.name] = "Lost Shipping Crate",
            [objectKeys.questStarts] = {94895},
        },
        [658116] = { -- Lost Shipping Crate : https://wowhead.com/forever/object=658116/lost-shipping-crate
            [objectKeys.name] = "Lost Shipping Crate",
            [objectKeys.questStarts] = {93443},
        },
        [658827] = { -- Mailbox : https://wowhead.com/forever/object=658827/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [658836] = { -- On the Shal'nan : https://wowhead.com/forever/object=658836/on-the-shalnan
            [objectKeys.name] = "On the Shal'nan",
            [objectKeys.spawns] = {[16593] = {{41.9, 23.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658837] = { -- The Shal'nan's Abdication : https://wowhead.com/forever/object=658837/the-shalnans-abdication
            [objectKeys.name] = "The Shal'nan's Abdication",
            [objectKeys.spawns] = {[16593] = {{45.1, 44.8}, {65.3, 32.9}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658838] = { -- The Rebellion In Eldre'Thalas, Part 1 : https://wowhead.com/forever/object=658838/the-rebellion-in-eldrethalas-part-1
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 1",
            [objectKeys.spawns] = {[16593] = {{49.8, 56.4}, {49.8, 56.5}, {64.2, 34.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658839] = { -- The Rebellion In Eldre'Thalas, Part 2 : https://wowhead.com/forever/object=658839/the-rebellion-in-eldrethalas-part-2
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 2",
            [objectKeys.spawns] = {[16593] = {{46.6, 82.3}, {64.2, 34.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658840] = { -- The Rebellion In Eldre'Thalas, Part 3 : https://wowhead.com/forever/object=658840/the-rebellion-in-eldrethalas-part-3
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 3",
            [objectKeys.spawns] = {[16593] = {{62.1, 72.6}, {64.6, 35.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658841] = { -- The Rebellion In Eldre'Thalas, Part 4 : https://wowhead.com/forever/object=658841/the-rebellion-in-eldrethalas-part-4
            [objectKeys.name] = "The Rebellion In Eldre'Thalas, Part 4",
            [objectKeys.spawns] = {[16593] = {{64.7, 34.4}, {64.7, 34.5}, {65.8, 50.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [658919] = { -- Mailbox : https://wowhead.com/forever/object=658919/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{53.3, 65.5}, {53.4, 65.4}, {53.5, 65}, {53.5, 66}, {53.5, 66.5}}},
        },
        [658920] = { -- Mailbox : https://wowhead.com/forever/object=658920/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{37.8, 75.2}, {38.4, 74.3}, {38.5, 74.5}}},
        },
        [658921] = { -- Mailbox : https://wowhead.com/forever/object=658921/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{81.1, 21.2}, {81.2, 21.6}}},
        },
        [658922] = { -- Mailbox : https://wowhead.com/forever/object=658922/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{47.8, 38}, {48, 38.5}, {48.4, 36.6}, {48.5, 36.4}, {48.6, 37.3}, {48.9, 37.7}}},
        },
        [658923] = { -- Mailbox : https://wowhead.com/forever/object=658923/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{51.4, 59.1}, {51.4, 59.6}, {51.5, 59.7}, {52, 58.7}, {52.1, 58.4}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658924] = { -- Mailbox : https://wowhead.com/forever/object=658924/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{60.4, 54.4}, {60.4, 55.3}, {60.4, 55.6}, {60.5, 55}, {60.6, 55.5}, {60.8, 56.8}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658925] = { -- Mailbox : https://wowhead.com/forever/object=658925/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{45.2, 54.3}, {45.2, 54.5}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658926] = { -- Mailbox : https://wowhead.com/forever/object=658926/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{51.4, 47}, {51.9, 46.4}}},
        },
        [658927] = { -- Mailbox : https://wowhead.com/forever/object=658927/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{49.1, 71.4}, {49.1, 71.6}, {49.9, 70.2}, {49.9, 71.5}, {50.1, 71.4}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [658970] = { -- Mailbox : https://wowhead.com/forever/object=658970/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{62, 41}, {62.4, 39.7}, {62.5, 39.9}}},
        },
        [658980] = { -- The Armor of Mannoroth : https://wowhead.com/forever/object=658980/the-armor-of-mannoroth
            [objectKeys.name] = "The Armor of Mannoroth",
            [objectKeys.spawns] = {[1637] = {{45.4, 35}, {45.5, 35}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [659159] = { -- Mailbox : https://wowhead.com/forever/object=659159/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1637] = {{50.4, 70.8}, {50.5, 70.9}, {50.9, 69.9}}},
        },
        [659167] = { -- Horde Military Ranks : https://wowhead.com/forever/object=659167/horde-military-ranks
            [objectKeys.name] = "Horde Military Ranks",
            [objectKeys.spawns] = {[1637] = {{40, 68.1}, {40.6, 68.2}, {41.7, 68}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [659308] = { -- Brienne Stormhart : https://wowhead.com/forever/object=659308/brienne-stormhart
            [objectKeys.name] = "Brienne Stormhart",
            [objectKeys.spawns] = {[16591] = {{60, 84.9}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659309] = { -- Sir Howard Armstrong : https://wowhead.com/forever/object=659309/sir-howard-armstrong
            [objectKeys.name] = "Sir Howard Armstrong",
            [objectKeys.spawns] = {[16591] = {{59.9, 85.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659310] = { -- Roderick the Unbroken : https://wowhead.com/forever/object=659310/roderick-the-unbroken
            [objectKeys.name] = "Roderick the Unbroken",
            [objectKeys.spawns] = {[16591] = {{59.7, 84.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659311] = { -- Rosalind Ashwood : https://wowhead.com/forever/object=659311/rosalind-ashwood
            [objectKeys.name] = "Rosalind Ashwood",
            [objectKeys.spawns] = {[16591] = {{60.1, 85.2}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659313] = { -- Alden Amberhall : https://wowhead.com/forever/object=659313/alden-amberhall
            [objectKeys.name] = "Alden Amberhall",
            [objectKeys.spawns] = {[16591] = {{59.5, 85.2}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659816] = { -- Mailbox : https://wowhead.com/forever/object=659816/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16591] = {{78.6, 53.8}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659829] = { -- Mailbox : https://wowhead.com/forever/object=659829/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16591] = {{58.8, 45.3}, {58.8, 45.5}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [659837] = { -- Mailbox : https://wowhead.com/forever/object=659837/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16591] = {{64.4, 83.4}, {64.6, 83.4}, {64.7, 83.7}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [660331] = { -- Note : https://wowhead.com/forever/object=660331/note
            [objectKeys.name] = "Note",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660490] = { -- Bell : https://wowhead.com/forever/object=660490/bell
            [objectKeys.name] = "Bell",
            [objectKeys.spawns] = {[12] = {{49.3, 41.1}, {49.5, 41.4}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [660647] = { -- Forgotten Loa Idol : https://wowhead.com/forever/object=660647/forgotten-loa-idol
            [objectKeys.name] = "Forgotten Loa Idol",
            [objectKeys.spawns] = {[14] = {{64.6, 84}, {64.7, 83.3}, {64.9, 85.3}, {65, 85.8}, {65.1, 82.2}, {65.2, 87.9}, {65.5, 84.7}, {65.6, 83}, {65.6, 85.8}, {65.7, 87.2}, {66.2, 88.3}, {67, 87.8}, {67.1, 83.5}, {67.2, 86.5}, {67.4, 82.6}, {67.7, 82.1}, {67.8, 81.4}, {68.3, 83.7}, {68.4, 85.7}, {68.5, 84.3}, {68.5, 85.7}, {69, 83}, {69.1, 84.8}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [660729] = { -- The Forsaken Ally : https://wowhead.com/forever/object=660729/the-forsaken-ally
            [objectKeys.name] = "The Forsaken Ally",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660730] = { -- Trollbane Conquests : https://wowhead.com/forever/object=660730/trollbane-conquests
            [objectKeys.name] = "Trollbane Conquests",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660731] = { -- Field Accounts of Horde Razings : https://wowhead.com/forever/object=660731/field-accounts-of-horde-razings
            [objectKeys.name] = "Field Accounts of Horde Razings",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660732] = { -- Cycles of Morality : https://wowhead.com/forever/object=660732/cycles-of-morality
            [objectKeys.name] = "Cycles of Morality",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [660739] = { -- Ritual Fire : https://wowhead.com/forever/object=660739/ritual-fire
            [objectKeys.name] = "Ritual Fire",
            [objectKeys.questEnds] = {95805},
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [660848] = { -- Kuramaa's Stump : https://wowhead.com/forever/object=660848/kuramaas-stump
            [objectKeys.name] = "Kuramaa's Stump",
            [objectKeys.spawns] = {[16593] = {{42.5, 68.9}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [660930] = { -- Pile of Complicated Parts : https://wowhead.com/forever/object=660930/pile-of-complicated-parts
            [objectKeys.name] = "Pile of Complicated Parts",
            [objectKeys.spawns] = {[17] = {{61.4, 44.3}, {61.6, 48}, {61.6, 49.1}, {62, 45.2}, {62, 45.9}, {62.2, 44}, {62.2, 47.4}}},
            [objectKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [660964] = { -- Misplaced Packages : https://wowhead.com/forever/object=660964/misplaced-packages
            [objectKeys.name] = "Misplaced Packages",
            [objectKeys.questStarts] = {97263},
            [objectKeys.spawns] = {[1537] = {{71.9, 47.2}, {72.3, 48.4}, {72.4, 48.5}, {72.5, 48.3}, {72.5, 48.5}}},
            [objectKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [660984] = { -- Fel-Tainted Journal : https://wowhead.com/forever/object=660984/fel-tainted-journal
            [objectKeys.name] = "Fel-Tainted Journal",
            [objectKeys.spawns] = {[616] = {{42.8, 71.7}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [660999] = { -- Mysterious Letter : https://wowhead.com/forever/object=660999/mysterious-letter
            [objectKeys.name] = "Mysterious Letter",
            [objectKeys.spawns] = {[616] = {{51.4, 72.4}}},
            [objectKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [661092] = { -- Speargrass : https://wowhead.com/forever/object=661092/speargrass
            [objectKeys.name] = "Speargrass",
            [objectKeys.spawns] = {[1637] = {{65.4, 26.4}, {65.4, 26.6}, {65.5, 26.6}, {66, 28.4}, {66.2, 28.8}, {66.2, 29.6}, {67.7, 29.4}, {68, 29.6}, {69.3, 34.3}, {69.3, 34.6}, {69.5, 34.5}, {69.8, 28.6}, {70, 28.4}, {70.4, 29.5}, {70.4, 34.1}, {70.7, 33.9}, {70.8, 28.4}, {70.9, 28.5}, {70.9, 33.2}, {71.2, 32}, {71.4, 30.3}, {71.4, 30.8}, {71.5, 30.4}, {71.5, 30.6}, {71.6, 29.1}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661093] = { -- Cattail : https://wowhead.com/forever/object=661093/cattail
            [objectKeys.name] = "Cattail",
            [objectKeys.spawns] = {[1637] = {{66.1, 28.9}, {66.8, 28.3}, {67.3, 32.9}, {67.6, 32.4}, {67.6, 32.5}, {68.8, 29.8}, {68.8, 35.5}, {69, 35.2}, {69.4, 30.9}, {69.7, 31.2}, {70.4, 28.7}, {70.4, 29.9}, {71, 28.4}, {71.1, 32.4}, {71.1, 32.5}, {71.4, 29.5}, {71.4, 30.8}, {71.5, 29.4}, {71.5, 30.5}, {71.5, 31.7}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661446] = { -- Smooth Boulder : https://wowhead.com/forever/object=661446/smooth-boulder
            [objectKeys.name] = "Smooth Boulder",
            [objectKeys.spawns] = {[1637] = {{38.8, 26.7}, {39.6, 28.3}, {39.7, 29.3}, {39.9, 29.5}, {40.8, 34.4}, {40.8, 34.5}, {41.3, 29.3}, {41.4, 29.9}, {41.5, 29.3}, {41.8, 29.7}, {43.6, 34.6}, {43.9, 40.2}, {43.9, 40.8}, {44.3, 37.9}, {44.5, 38.2}, {44.7, 30.3}, {45, 30.5}, {45.3, 32.7}, {46.9, 32.8}, {47, 40.7}, {47.9, 37.9}, {47.9, 38.6}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661448] = { -- Smooth Boulder : https://wowhead.com/forever/object=661448/smooth-boulder
            [objectKeys.name] = "Smooth Boulder",
            [objectKeys.spawns] = {[1637] = {{39.2, 26.8}, {39.9, 29.3}, {40, 29.8}, {40.2, 27.3}, {40.2, 27.5}, {40.5, 27.9}, {41.3, 34.6}, {41.6, 34.4}, {41.8, 34.6}, {41.9, 31.8}, {42.1, 32.5}, {43.8, 34.6}, {43.9, 34.3}, {43.9, 40.4}, {43.9, 40.5}, {44.3, 37.8}, {44.4, 31.5}, {44.5, 31.8}, {44.5, 38.2}, {44.8, 31.3}, {45.4, 32.7}, {45.5, 32.7}, {46.9, 33}, {47.3, 33.5}, {47.8, 39.6}, {47.9, 38.6}, {48, 38.1}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661449] = { -- Smooth Boulder : https://wowhead.com/forever/object=661449/smooth-boulder
            [objectKeys.name] = "Smooth Boulder",
            [objectKeys.spawns] = {[1637] = {{38.4, 26.8}, {38.6, 26.7}, {39.2, 28.3}, {39.2, 28.5}, {39.6, 28.6}, {39.7, 28.3}, {40, 32.3}, {40.1, 32.5}, {41.1, 34.9}, {41.4, 32}, {41.5, 32.1}, {43.4, 32.3}, {43.4, 34.5}, {43.5, 34.4}, {43.7, 32.7}, {43.7, 40.2}, {43.8, 35}, {43.8, 40.9}, {44, 32.1}, {44.3, 38.6}, {44.4, 38}, {44.5, 38.3}, {45.3, 32.9}, {46.7, 33.1}, {46.9, 39.9}, {47.1, 40.6}, {47.8, 38.6}, {47.9, 37.9}}},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [661516] = { -- Thoroughly Scavenged Supplies : https://wowhead.com/forever/object=661516/thoroughly-scavenged-supplies
            [objectKeys.name] = "Thoroughly Scavenged Supplies",
            [objectKeys.questStarts] = {97328},
        },
        [661778] = { -- Statue of Malorne : https://wowhead.com/forever/object=661778/statue-of-malorne
            [objectKeys.name] = "Statue of Malorne",
            [objectKeys.questStarts] = {86611},
        },
        [664122] = { -- Gozwin's Mechanic's Log : https://wowhead.com/forever/object=664122/gozwins-mechanics-log
            [objectKeys.name] = "Gozwin's Mechanic's Log",
            [objectKeys.spawns] = {[1] = {{27.3, 62.8}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [665270] = { -- Purple Berry Bush : https://wowhead.com/forever/object=665270/purple-berry-bush
            [objectKeys.name] = "Purple Berry Bush",
            [objectKeys.spawns] = {[406] = {{43.7, 58.2}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [665282] = { -- Excavation Tools : https://wowhead.com/forever/object=665282/excavation-tools
            [objectKeys.name] = "Excavation Tools",
            [objectKeys.spawns] = {[38] = {{66.3, 66.7}, {67, 67.6}, {68.7, 59.6}, {69.4, 67.5}, {69.5, 67.6}, {69.6, 62.7}, {70.6, 65}, {71.1, 68.3}, {72.4, 61.7}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [665289] = { -- Discarded Fishing Toolbox : https://wowhead.com/forever/object=665289/discarded-fishing-toolbox
            [objectKeys.name] = "Discarded Fishing Toolbox",
            [objectKeys.questStarts] = {86614},
            [objectKeys.spawns] = {[38] = {{45.6, 43.3}, {45.6, 43.5}, {48.1, 39.4}, {48.1, 39.7}, {48.8, 54.5}, {48.9, 54.1}, {50.5, 53.5}, {50.6, 53.1}}},
            [objectKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [667362] = { -- Mirkweed : https://wowhead.com/forever/object=667362/mirkweed
            [objectKeys.name] = "Mirkweed",
            [objectKeys.spawns] = {[406] = {{46.9, 39.3}, {47.1, 40.9}, {47.1, 41.8}, {47.4, 38.3}, {47.4, 40.1}, {47.5, 38.4}, {47.5, 41}, {47.6, 40.3}, {47.8, 42.4}, {48.2, 42.5}, {48.8, 37.5}, {48.8, 42.3}, {49, 38.5}, {49, 42.7}, {49.6, 40.1}, {49.7, 41.1}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [667364] = { -- Dried Mirkweed Pile : https://wowhead.com/forever/object=667364/dried-mirkweed-pile
            [objectKeys.name] = "Dried Mirkweed Pile",
            [objectKeys.spawns] = {[406] = {{47.1, 40.2}, {48.8, 37.3}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [667573] = { -- Knights of the Brotherhood : https://wowhead.com/forever/object=667573/knights-of-the-brotherhood
            [objectKeys.name] = "Knights of the Brotherhood",
            [objectKeys.spawns] = {[16591] = {{63.5, 83.4}, {63.5, 83.5}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [667574] = { -- Fern Crimsonleaf : https://wowhead.com/forever/object=667574/fern-crimsonleaf
            [objectKeys.name] = "Fern Crimsonleaf",
            [objectKeys.spawns] = {[16591] = {{61.4, 85.2}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [668482] = { -- Gnarlpine Totem : https://wowhead.com/forever/object=668482/gnarlpine-totem
            [objectKeys.name] = "Gnarlpine Totem",
            [objectKeys.spawns] = {[141] = {{54.1, 39.6}, {54.2, 39.4}, {54.5, 44.1}, {55.1, 39.7}, {55.8, 44.3}, {56, 46.1}, {56.2, 39.4}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [668493] = { -- Gnarlpine Totem : https://wowhead.com/forever/object=668493/gnarlpine-totem
            [objectKeys.name] = "Gnarlpine Totem",
            [objectKeys.spawns] = {[141] = {{54, 38.3}, {54.3, 39.4}, {54.5, 43.7}, {55.5, 37.6}, {55.6, 37.4}, {55.6, 45.3}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [668544] = { -- A Wartorn Land and The Brotherhood : https://wowhead.com/forever/object=668544/a-wartorn-land-and-the-brotherhood
            [objectKeys.name] = "A Wartorn Land and The Brotherhood",
            [objectKeys.spawns] = {[16591] = {{62.1, 85.6}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [669176] = { -- Gleaming Crescent Pendant : https://wowhead.com/forever/object=669176/gleaming-crescent-pendant
            [objectKeys.name] = "Gleaming Crescent Pendant",
            [objectKeys.questStarts] = {98027},
        },
        [670771] = { -- Khaz Modan Timber : https://wowhead.com/forever/object=670771/khaz-modan-timber
            [objectKeys.name] = "Khaz Modan Timber",
            [objectKeys.spawns] = {[11] = {{3.9, 59.8}, {4, 55.2}, {4.7, 50.8}, {5.9, 61.7}, {6, 52.8}, {7.1, 65.6}, {7.9, 50.7}, {8.1, 50.3}, {8.3, 63.4}, {9.1, 64.9}, {10.9, 50.8}, {13.3, 52.3}, {13.6, 60.7}, {14.4, 56.6}, {14.6, 56.5}, {15.4, 53.8}, {15.7, 53.8}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [670773] = { -- Khaz Modan Timber : https://wowhead.com/forever/object=670773/khaz-modan-timber
            [objectKeys.name] = "Khaz Modan Timber",
            [objectKeys.spawns] = {[11] = {{3.4, 63.3}, {4.9, 67.5}, {5.1, 67.4}, {5.5, 55.6}, {5.7, 55.3}, {5.8, 58.3}, {5.9, 51.9}, {6.7, 48.3}, {6.7, 48.6}, {9.2, 48}, {12, 53.3}, {14, 53.6}, {16.8, 53.9}, {16.8, 58}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [670774] = { -- Khaz Modan Iron : https://wowhead.com/forever/object=670774/khaz-modan-iron
            [objectKeys.name] = "Khaz Modan Iron",
            [objectKeys.spawns] = {[11] = {{3.1, 62.3}, {3.5, 58.6}, {5, 52.3}, {5, 52.6}, {5.3, 56.1}, {6, 58}, {6.3, 47.6}, {6.4, 47.4}, {6.7, 51.5}, {6.8, 51.4}, {7.3, 62.8}, {7.9, 64.4}, {9.4, 46.8}, {9.5, 46.8}, {9.9, 50.9}, {11.4, 53}, {11.5, 53.2}, {14, 52.7}, {14.8, 56.1}, {15.3, 60.6}, {15.9, 52.4}, {15.9, 52.6}, {16.2, 54.2}, {17.4, 58.3}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [671154] = { -- Dry Branch : https://wowhead.com/forever/object=671154/dry-branch
            [objectKeys.name] = "Dry Branch",
            [objectKeys.spawns] = {[85] = {{53.8, 51.6}, {54.3, 53.3}, {54.4, 51.2}, {54.4, 53.5}, {54.5, 53.4}, {55.1, 55.4}, {55.1, 55.7}, {55.2, 53.7}, {55.4, 51}, {55.6, 50.9}, {55.9, 52}, {55.9, 57.8}, {56.1, 53.4}, {56.1, 53.5}, {56.2, 50.4}, {56.5, 50.6}, {57, 52.5}, {57.4, 52.3}, {57.4, 58.3}, {57.7, 51.2}, {58, 58.1}, {58.1, 59.2}, {58.8, 52.2}, {58.9, 52.8}, {59.8, 51.4}, {60.1, 51.6}, {60.3, 55}, {62, 53.9}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [671478] = { -- The Sky-Touched Mystery : https://wowhead.com/forever/object=671478/the-sky-touched-mystery
            [objectKeys.name] = "The Sky-Touched Mystery",
            [objectKeys.spawns] = {[16593] = {{59.4, 34.4}, {59.5, 34.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [671479] = { -- On The Windlord : https://wowhead.com/forever/object=671479/on-the-windlord
            [objectKeys.name] = "On The Windlord",
            [objectKeys.spawns] = {[16593] = {{56, 58.7}, {65.7, 34.2}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [671518] = { -- Tattered Spellbook : https://wowhead.com/forever/object=671518/tattered-spellbook
            [objectKeys.name] = "Tattered Spellbook",
            [objectKeys.questStarts] = {98223},
        },
        [672330] = { -- Dragonmaw Armaments : https://wowhead.com/forever/object=672330/dragonmaw-armaments
            [objectKeys.name] = "Dragonmaw Armaments",
            [objectKeys.questStarts] = {98293},
        },
        [672508] = { -- Flintfire's Shipment : https://wowhead.com/forever/object=672508/flintfires-shipment
            [objectKeys.name] = "Flintfire's Shipment",
            [objectKeys.spawns] = {[1] = {{39.1, 46.5}, {39.9, 47.1}, {40.3, 46.4}, {40.7, 45.3}, {40.8, 49.2}, {41, 50.8}, {41.1, 47.2}, {41.4, 45.5}, {41.5, 45.5}, {41.8, 45.3}, {41.8, 52.8}, {42, 46.5}, {42.1, 48.5}, {42.3, 47.5}, {42.6, 50.5}, {42.9, 51.7}, {43.5, 49.4}, {43.5, 49.5}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [672518] = { -- Damaged Blue Crystal : https://wowhead.com/forever/object=672518/damaged-blue-crystal
            [objectKeys.name] = "Damaged Blue Crystal",
            [objectKeys.spawns] = {[490] = {{66.3, 75.2}}},
            [objectKeys.zoneID] = zoneIDs.UN_GORO_CRATER,
        },
        [672821] = { -- Relic of the Fang : https://wowhead.com/forever/object=672821/relic-of-the-fang
            [objectKeys.name] = "Relic of the Fang",
            [objectKeys.spawns] = {[493] = {{72.4, 66}, {72.6, 66.1}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673085] = { -- Tarantula Egg : https://wowhead.com/forever/object=673085/tarantula-egg
            [objectKeys.name] = "Tarantula Egg",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673093] = { -- Relic of the Claw : https://wowhead.com/forever/object=673093/relic-of-the-claw
            [objectKeys.name] = "Relic of the Claw",
            [objectKeys.spawns] = {[493] = {{75.2, 67.2}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673094] = { -- Relic of the Silent Shadow : https://wowhead.com/forever/object=673094/relic-of-the-silent-shadow
            [objectKeys.name] = "Relic of the Silent Shadow",
            [objectKeys.spawns] = {[493] = {{74.4, 65.4}, {74.4, 65.5}, {74.5, 65.1}, {74.5, 65.5}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673101] = { -- Tarantula Egg : https://wowhead.com/forever/object=673101/tarantula-egg
            [objectKeys.name] = "Tarantula Egg",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673376] = { -- Meat Haunch : https://wowhead.com/forever/object=673376/meat-haunch
            [objectKeys.name] = "Meat Haunch",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673378] = { -- Oracle Tree Bark : https://wowhead.com/forever/object=673378/oracle-tree-bark
            [objectKeys.name] = "Oracle Tree Bark",
            [objectKeys.spawns] = {[141] = {{37, 34.1}}},
            [objectKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [673384] = { -- Water Barrel : https://wowhead.com/forever/object=673384/water-barrel
            [objectKeys.name] = "Water Barrel",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673385] = { -- Blackrock Supplies : https://wowhead.com/forever/object=673385/blackrock-supplies
            [objectKeys.name] = "Blackrock Supplies",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673390] = { -- Weapon Rack : https://wowhead.com/forever/object=673390/weapon-rack
            [objectKeys.name] = "Weapon Rack",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673394] = { -- Great Cat Spirit Statue : https://wowhead.com/forever/object=673394/great-cat-spirit-statue
            [objectKeys.name] = "Great Cat Spirit Statue",
            [objectKeys.spawns] = {[493] = {{71.7, 61.9}}},
            [objectKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [673399] = { -- Stolen Weapon : https://wowhead.com/forever/object=673399/stolen-weapon
            [objectKeys.name] = "Stolen Weapon",
            [objectKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [673431] = { -- Kurothel's Knapsack : https://wowhead.com/forever/object=673431/kurothels-knapsack
            [objectKeys.name] = "Kurothel's Knapsack",
            [objectKeys.spawns] = {[331] = {{80.6, 49}, {81.1, 50.6}, {81.3, 50.3}, {81.7, 49.2}}},
            [objectKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [673476] = { -- Abandoned Training Weapon : https://wowhead.com/forever/object=673476/abandoned-training-weapon
            [objectKeys.name] = "Abandoned Training Weapon",
            [objectKeys.spawns] = {[14] = {{40.6, 63.2}, {40.8, 71}, {40.9, 63.9}, {41.2, 62.4}, {41.5, 71.4}, {41.8, 72.3}, {42.2, 63.1}, {42.4, 64.4}, {42.4, 64.5}, {43, 72.6}, {43.2, 71.7}, {43.4, 62.4}, {43.4, 62.5}, {43.5, 72.5}, {43.6, 63.3}, {43.7, 72.4}, {43.8, 66.3}, {44, 67.2}, {44.1, 70.3}, {44.4, 64.6}, {44.4, 71.3}, {44.5, 62}, {44.6, 66.6}, {44.6, 72.6}, {44.9, 65.4}, {45, 63.4}, {45, 63.5}, {45.2, 66.2}, {45.3, 71.2}, {45.4, 59.3}, {45.6, 60.8}, {45.6, 62.8}, {45.7, 64.8}, {45.8, 61.6}, {47.1, 61.7}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [673494] = { -- Shredder Operation Instructions : https://wowhead.com/forever/object=673494/shredder-operation-instructions
            [objectKeys.name] = "Shredder Operation Instructions",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673496] = { -- Barrens Operations Best Practices : https://wowhead.com/forever/object=673496/barrens-operations-best-practices
            [objectKeys.name] = "Barrens Operations Best Practices",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673497] = { -- One "Gerenzo", of Stonetalon : https://wowhead.com/forever/object=673497/one-gerenzo-of-stonetalon
            [objectKeys.name] = "One \"Gerenzo\", of Stonetalon",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [673515] = { -- Memory of Valor : https://wowhead.com/forever/object=673515/memory-of-valor
            [objectKeys.name] = "Memory of Valor",
            [objectKeys.spawns] = {[10] = {{21.1, 55.6}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [673933] = { -- Blisterweed : https://wowhead.com/forever/object=673933/blisterweed
            [objectKeys.name] = "Blisterweed",
            [objectKeys.spawns] = {[1497] = {{54, 49.3}, {54.1, 49.5}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [674068] = { -- Burnt Page : https://wowhead.com/forever/object=674068/burnt-page
            [objectKeys.name] = "Burnt Page",
            [objectKeys.spawns] = {[45] = {{22.4, 24.2}, {22.6, 24.5}, {22.7, 24.1}}},
            [objectKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [674124] = { -- Traveler's Cache : https://wowhead.com/forever/object=674124/travelers-cache
            [objectKeys.name] = "Traveler's Cache",
            [objectKeys.spawns] = {[33] = {{14.4, 27.2}, {14.5, 27.2}}},
            [objectKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [674126] = { -- Hidden Stash : https://wowhead.com/forever/object=674126/hidden-stash
            [objectKeys.name] = "Hidden Stash",
            [objectKeys.spawns] = {[406] = {{40.7, 52.4}, {40.7, 52.7}}},
            [objectKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [676051] = { -- Ancient Heirloom : https://wowhead.com/forever/object=676051/ancient-heirloom
            [objectKeys.name] = "Ancient Heirloom",
            [objectKeys.spawns] = {[16593] = {{41.7, 23.4}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [676059] = { -- Ancient Hilt : https://wowhead.com/forever/object=676059/ancient-hilt
            [objectKeys.name] = "Ancient Hilt",
            [objectKeys.spawns] = {[16593] = {{58.2, 24.1}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [676349] = { -- Narassin's Strongbox : https://wowhead.com/forever/object=676349/narassins-strongbox
            [objectKeys.name] = "Narassin's Strongbox",
            [objectKeys.spawns] = {[148] = {{56.2, 26.5}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [678414] = { -- Torn Page : https://wowhead.com/forever/object=678414/torn-page
            [objectKeys.name] = "Torn Page",
            [objectKeys.spawns] = {[1497] = {{23, 36.3}, {23.2, 37}, {23.3, 38.5}, {23.5, 36}, {23.6, 35.3}, {24.2, 36.6}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [678602] = { -- Book : https://wowhead.com/forever/object=678602/book
            [objectKeys.name] = "Book",
            [objectKeys.spawns] = {[1497] = {{23, 36.4}, {23.1, 36.5}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [688047] = { -- Lady Isolde Brightlance : https://wowhead.com/forever/object=688047/lady-isolde-brightlance
            [objectKeys.name] = "Lady Isolde Brightlance",
            [objectKeys.spawns] = {[16591] = {{61.3, 84.4}, {61.4, 84.7}, {61.5, 84.5}, {61.6, 84.3}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [691558] = { -- Portal to The Violet Citadel : https://wowhead.com/forever/object=691558/portal-to-the-violet-citadel
            [objectKeys.name] = "Portal to The Violet Citadel",
            [objectKeys.spawns] = {[36] = {{15.1, 55.6}}},
            [objectKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [693669] = { -- Weapon Piece : https://wowhead.com/forever/object=693669/weapon-piece
            [objectKeys.name] = "Weapon Piece",
            [objectKeys.spawns] = {[14] = {{60.1, 44.8}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [693670] = { -- Strange Debris : https://wowhead.com/forever/object=693670/strange-debris
            [objectKeys.name] = "Strange Debris",
            [objectKeys.spawns] = {[14] = {{60.1, 42.4}, {60.1, 42.6}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [693674] = { -- Abandoned Dagger : https://wowhead.com/forever/object=693674/abandoned-dagger
            [objectKeys.name] = "Abandoned Dagger",
            [objectKeys.spawns] = {[14] = {{58.9, 44.4}, {58.9, 44.5}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [694054] = { -- Recipe: Raw Plated Armorfish : https://wowhead.com/forever/object=694054/recipe-raw-plated-armorfish
            [objectKeys.name] = "Recipe: Raw Plated Armorfish",
            [objectKeys.spawns] = {[41] = {{52.4, 34.5}, {52.5, 34.3}, {52.5, 34.5}}},
            [objectKeys.zoneID] = zoneIDs.DEADWIND_PASS,
        },
        [694732] = { -- Tomb Weed : https://wowhead.com/forever/object=694732/tomb-weed
            [objectKeys.name] = "Tomb Weed",
            [objectKeys.spawns] = {[85] = {{74.2, 60.2}, {74.4, 61.8}, {74.8, 62.7}, {74.9, 59.3}, {74.9, 61.3}, {75, 59.6}, {75, 62.1}, {75.9, 58.9}, {76, 62.3}, {76.3, 60.8}, {76.4, 59.7}, {76.4, 62.6}, {76.5, 59.7}, {76.6, 62}, {76.9, 60.9}, {77, 62.7}, {77.2, 58.8}, {77.7, 61.4}, {77.7, 61.5}, {77.9, 59.8}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [694772] = { -- Fishing Trap : https://wowhead.com/forever/object=694772/fishing-trap
            [objectKeys.name] = "Fishing Trap",
            [objectKeys.spawns] = {[12] = {{46.6, 64.7}, {46.9, 65.9}, {47.8, 64}, {47.8, 66.4}, {47.8, 66.5}, {48.3, 58.7}, {48.3, 60.9}, {48.4, 59.5}, {48.4, 63}, {48.4, 67.6}, {48.5, 59.5}, {48.5, 63}, {48.5, 63.5}, {48.6, 59.4}, {48.6, 67.4}, {48.8, 64.7}, {48.8, 66}, {49.4, 68.1}, {49.5, 65.3}, {49.5, 65.5}, {49.5, 67.9}, {49.8, 66.5}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [694785] = { -- Junk Pile : https://wowhead.com/forever/object=694785/junk-pile
            [objectKeys.name] = "Junk Pile",
            [objectKeys.spawns] = {[12] = {{54.3, 66.8}, {54.5, 66.8}, {54.8, 66}, {55.5, 66}, {55.6, 67}, {56, 67.6}, {56.6, 66.1}, {56.6, 67.3}, {57.4, 67.6}, {57.5, 67.4}, {57.5, 67.5}, {57.8, 66.3}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [694855] = { -- Overgrown Duskweed : https://wowhead.com/forever/object=694855/overgrown-duskweed
            [objectKeys.name] = "Overgrown Duskweed",
            [objectKeys.spawns] = {[12] = {{31.9, 84.4}, {32, 84.6}, {32, 85.6}, {32.6, 86.1}, {32.8, 84.1}, {33.1, 86.7}, {33.4, 85.4}, {33.5, 85.4}, {34.2, 85.7}, {40.1, 86.4}, {40.1, 86.5}, {40.7, 87}, {41.1, 87.7}, {41.2, 86.1}, {41.4, 84.4}, {41.5, 84.4}, {41.7, 85.4}, {41.7, 85.5}, {42.3, 89.4}, {42.4, 87.4}, {42.4, 87.5}, {42.5, 87.7}, {43.3, 87}}},
            [objectKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [694895] = { -- Glowing Crystal Fragment : https://wowhead.com/forever/object=694895/glowing-crystal-fragment
            [objectKeys.name] = "Glowing Crystal Fragment",
            [objectKeys.spawns] = {[85] = {{9.8, 69.3}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [694934] = { -- Fallen Log : https://wowhead.com/forever/object=694934/fallen-log
            [objectKeys.name] = "Fallen Log",
            [objectKeys.spawns] = {[1] = {{49.8, 51.6}, {50.8, 49.9}, {51.3, 52}, {52.4, 50.4}, {52.4, 50.5}, {52.5, 50.4}, {54, 46.8}, {54.2, 45.3}, {55.4, 45.8}, {55.5, 45.8}, {55.9, 48.6}, {55.9, 53.4}, {56, 52.2}, {56, 53.5}, {56.4, 55.4}, {56.4, 55.5}, {56.5, 55.6}, {56.6, 50.9}, {57, 53.4}, {57, 53.5}, {57.2, 54.9}, {57.4, 46.4}, {57.4, 46.5}, {57.5, 46.4}, {57.6, 48.6}, {58.2, 52}, {58.3, 54.4}, {58.3, 54.5}, {58.3, 56.2}, {58.4, 58.6}, {58.5, 58.6}, {58.6, 57.1}, {59.8, 58.6}, {60.1, 53}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [695222] = { -- Coalbeard's Rifle : https://wowhead.com/forever/object=695222/coalbeards-rifle
            [objectKeys.name] = "Coalbeard's Rifle",
            [objectKeys.spawns] = {[1] = {{52.1, 44.1}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [695223] = { -- Sunhammer's Rifle : https://wowhead.com/forever/object=695223/sunhammers-rifle
            [objectKeys.name] = "Sunhammer's Rifle",
            [objectKeys.spawns] = {[1] = {{59.9, 50.1}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [695277] = { -- Stoneanvil's Rifle : https://wowhead.com/forever/object=695277/stoneanvils-rifle
            [objectKeys.name] = "Stoneanvil's Rifle",
            [objectKeys.spawns] = {[1] = {{53.2, 58.7}}},
            [objectKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [696267] = { -- Mailbox : https://wowhead.com/forever/object=696267/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696268] = { -- Mailbox : https://wowhead.com/forever/object=696268/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696269] = { -- Mailbox : https://wowhead.com/forever/object=696269/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696270] = { -- Mailbox : https://wowhead.com/forever/object=696270/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696272] = { -- Mailbox : https://wowhead.com/forever/object=696272/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696273] = { -- Mailbox : https://wowhead.com/forever/object=696273/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696275] = { -- Mailbox : https://wowhead.com/forever/object=696275/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696276] = { -- Mailbox : https://wowhead.com/forever/object=696276/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696277] = { -- Mailbox : https://wowhead.com/forever/object=696277/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696278] = { -- Mailbox : https://wowhead.com/forever/object=696278/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696279] = { -- Mailbox : https://wowhead.com/forever/object=696279/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696280] = { -- Mailbox : https://wowhead.com/forever/object=696280/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696281] = { -- Mailbox : https://wowhead.com/forever/object=696281/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696295] = { -- Kurdran Wildhammer : https://wowhead.com/forever/object=696295/kurdran-wildhammer
            [objectKeys.name] = "Kurdran Wildhammer",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696296] = { -- General Turalyon : https://wowhead.com/forever/object=696296/general-turalyon
            [objectKeys.name] = "General Turalyon",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696297] = { -- Ranger Captain Alleria Windrunner : https://wowhead.com/forever/object=696297/ranger-captain-alleria-windrunner
            [objectKeys.name] = "Ranger Captain Alleria Windrunner",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696298] = { -- Danath Trollbane : https://wowhead.com/forever/object=696298/danath-trollbane
            [objectKeys.name] = "Danath Trollbane",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696299] = { -- Archmage Khadgar of the Kirin Tor : https://wowhead.com/forever/object=696299/archmage-khadgar-of-the-kirin-tor
            [objectKeys.name] = "Archmage Khadgar of the Kirin Tor",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696376] = { -- Alliance Military Ranks : https://wowhead.com/forever/object=696376/alliance-military-ranks
            [objectKeys.name] = "Alliance Military Ranks",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696392] = { -- Archbishop Alonsus Faol : https://wowhead.com/forever/object=696392/archbishop-alonsus-faol
            [objectKeys.name] = "Archbishop Alonsus Faol",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696434] = { -- Mailbox : https://wowhead.com/forever/object=696434/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696503] = { -- King Llane I of the House of Wrynn : https://wowhead.com/forever/object=696503/king-llane-i-of-the-house-of-wrynn
            [objectKeys.name] = "King Llane I of the House of Wrynn",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696504] = { -- Grand Admiral Daelin Proudmoore : https://wowhead.com/forever/object=696504/grand-admiral-daelin-proudmoore
            [objectKeys.name] = "Grand Admiral Daelin Proudmoore",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696505] = { -- Lady Mara Fordragon : https://wowhead.com/forever/object=696505/lady-mara-fordragon
            [objectKeys.name] = "Lady Mara Fordragon",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [696607] = { -- Mailbox : https://wowhead.com/forever/object=696607/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [697118] = { -- Windstone Formation : https://wowhead.com/forever/object=697118/windstone-formation
            [objectKeys.name] = "Windstone Formation",
            [objectKeys.spawns] = {[16593] = {{47, 69.2}, {47.3, 69.7}, {47.4, 68.3}, {47.7, 70}, {47.8, 67.5}, {48, 69.1}, {48.6, 68.5}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [701788] = { -- Knife : https://wowhead.com/forever/object=701788/knife
            [objectKeys.name] = "Knife",
            [objectKeys.spawns] = {[1497] = {{23, 36.4}, {23, 36.6}, {23.6, 35.2}, {23.7, 36}}},
            [objectKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [702301] = { -- A Small Pack : https://wowhead.com/forever/object=702301/a-small-pack
            [objectKeys.name] = "A Small Pack",
            [objectKeys.spawns] = {[46] = {{37.3, 26.6}, {37.4, 26.4}}},
            [objectKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [703257] = { -- Mailbox : https://wowhead.com/forever/object=703257/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[16593] = {{58.1, 76.5}, {58.3, 76.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [703896] = { -- Mailbox : https://wowhead.com/forever/object=703896/mailbox
            [objectKeys.name] = "Mailbox",
            [objectKeys.spawns] = {[1657] = {{58.3, 56.5}, {58.4, 56.3}, {58.6, 55.4}, {59, 57}, {59.4, 55.5}, {59.5, 55.5}, {59.5, 56.5}}},
            [objectKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [706178] = { -- Mausoleum Trigger : https://wowhead.com/forever/object=706178/mausoleum-trigger
            [objectKeys.name] = "Mausoleum Trigger",
            [objectKeys.spawns] = {[85] = {{59.2, 48.6}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [706187] = { -- Tear of Tilloa : https://wowhead.com/forever/object=706187/tear-of-tilloa
            [objectKeys.name] = "Tear of Tilloa",
            [objectKeys.spawns] = {[10] = {{78.4, 36.1}, {78.5, 36.1}}},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [707245] = { -- Wanted : https://wowhead.com/forever/object=707245/wanted
            [objectKeys.name] = "Wanted",
            [objectKeys.spawns] = {[16591] = {{65.9, 81.1}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [707249] = { -- Wanted : https://wowhead.com/forever/object=707249/wanted
            [objectKeys.name] = "Wanted",
            [objectKeys.questStarts] = {95882},
            [objectKeys.spawns] = {[16591] = {{59.6, 46.9}}},
            [objectKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [716301] = { -- Portal To Dalaran : https://wowhead.com/forever/object=716301/portal-to-dalaran
            [objectKeys.name] = "Portal To Dalaran",
            [objectKeys.spawns] = {[16593] = {{65.7, 83.3}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [716302] = { -- Portal to Thunder Bluff : https://wowhead.com/forever/object=716302/portal-to-thunder-bluff
            [objectKeys.name] = "Portal to Thunder Bluff",
            [objectKeys.spawns] = {[16593] = {{58, 80.4}, {58, 80.6}}},
            [objectKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [716304] = { -- Portal to Valanaar : https://wowhead.com/forever/object=716304/portal-to-valanaar
            [objectKeys.name] = "Portal to Valanaar",
            [objectKeys.zoneID] = zoneIDs.MULGORE,
        },
        [716522] = { -- Portal To Auberdine : https://wowhead.com/forever/object=716522/portal-to-auberdine
            [objectKeys.name] = "Portal To Auberdine",
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [716523] = { -- Portal To Stormwind : https://wowhead.com/forever/object=716523/portal-to-stormwind
            [objectKeys.name] = "Portal To Stormwind",
            [objectKeys.spawns] = {[148] = {{31, 41.1}}},
            [objectKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [716524] = { -- Portal To Southshore : https://wowhead.com/forever/object=716524/portal-to-southshore
            [objectKeys.name] = "Portal To Southshore",
            [objectKeys.spawns] = {[11] = {{5.3, 57}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [716525] = { -- Portal To Theramore : https://wowhead.com/forever/object=716525/portal-to-theramore
            [objectKeys.name] = "Portal To Theramore",
            [objectKeys.spawns] = {[11] = {{5.6, 63.2}}},
            [objectKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [716526] = { -- Portal To Menethil : https://wowhead.com/forever/object=716526/portal-to-menethil
            [objectKeys.name] = "Portal To Menethil",
            [objectKeys.spawns] = {[15] = {{71.5, 55.5}}},
            [objectKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [716527] = { -- Portal To Undercity : https://wowhead.com/forever/object=716527/portal-to-undercity
            [objectKeys.name] = "Portal To Undercity",
            [objectKeys.spawns] = {[14] = {{50.9, 13.5}, {51.1, 13.4}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [716528] = { -- Portal To Orgrimmar : https://wowhead.com/forever/object=716528/portal-to-orgrimmar
            [objectKeys.name] = "Portal To Orgrimmar",
            [objectKeys.spawns] = {[85] = {{60.9, 58.9}}},
            [objectKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [716529] = { -- Portal To Grom'gol : https://wowhead.com/forever/object=716529/portal-to-gromgol
            [objectKeys.name] = "Portal To Grom'gol",
            [objectKeys.spawns] = {[14] = {{50.4, 13.8}, {50.6, 13.3}, {50.7, 13.5}}},
            [objectKeys.zoneID] = zoneIDs.DUROTAR,
        },
    }
end
return ForeverBaseObject
