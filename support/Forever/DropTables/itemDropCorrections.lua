---@class QuestieItemDropCorrections
local QuestieItemDropCorrections = QuestieLoader:CreateModule("QuestieItemDropCorrections")
-------------------------
--Import modules.
-------------------------
---@type DropDB
local DropDB = QuestieLoader:ImportModule("DropDB")

local DropKeys = DropDB.correctionKeys

-- These tables contain manual drop corrections.
--
-- Use the following format:
-- [itemID] = { -- Item Name
--    [npcID] = 80.0,
-- }
--
-- This example would be an 80% drop rate.
--
-- Corrections propagate up to the current expansion. For instance, if you make a correction in Era, that
-- correction will be loaded in MoP unless an expansion after Era made a different correction for the same ID.
--
-- This is the same way our normal database corrections system behaves as well.
--
-- You can also use reference corrections. For instance:
--
-- [itemID] = { -- Item Name
--    [npcID] = DropDB.correctionKeys.WOWHEAD,
-- }
--
-- will point to the currently loaded Wowhead data for that item:NPC pair, if it exists.
-- Using a reference correction in an earlier expansion will propagate to later ones, pointing to their own DBs.
-- For instance, if you put the above example into Era corrections, but loaded up MoP, it would show MoP Wowhead data,
-- regardless of whatever data exists in the MoP pserver DB.

QuestieItemDropCorrections.Era = {
    [725] = { -- Gnoll Paw
        [98] = DropKeys.WOWHEAD,
        [117] = DropKeys.WOWHEAD,
        [123] = DropKeys.WOWHEAD,
        [124] = DropKeys.WOWHEAD,
        [125] = DropKeys.WOWHEAD,
        [452] = DropKeys.WOWHEAD,
        [453] = DropKeys.WOWHEAD,
        [500] = DropKeys.WOWHEAD,
        [501] = DropKeys.WOWHEAD,
        [506] = DropKeys.WOWHEAD,
        [1065] = DropKeys.WOWHEAD,
        [1426] = DropKeys.WOWHEAD,
    },
    [829] = { -- Red Leather Bandana
        [95] = DropKeys.WOWHEAD,
        [502] = DropKeys.WOWHEAD,
        [504] = DropKeys.WOWHEAD,
        [589] = DropKeys.WOWHEAD,
        [590] = DropKeys.WOWHEAD,
    },
    [884] = { -- Ghoul Rib
        [3] = DropKeys.WOWHEAD,
        [210] = DropKeys.WOWHEAD,
        [570] = DropKeys.WOWHEAD,
        [604] = DropKeys.WOWHEAD,
        [948] = DropKeys.WOWHEAD,
    },
    [1129] = { -- Ghoul Fang
        [3] = DropKeys.WOWHEAD,
        [210] = DropKeys.WOWHEAD,
        [570] = DropKeys.WOWHEAD,
        [604] = DropKeys.WOWHEAD,
        [948] = DropKeys.WOWHEAD,
        [1270] = DropKeys.WOWHEAD,
    },
    [1130] = { -- Vial of Spider Venom
        [217] = DropKeys.WOWHEAD,
        [539] = DropKeys.WOWHEAD,
        [569] = DropKeys.WOWHEAD,
        [574] = DropKeys.WOWHEAD,
        [930] = DropKeys.WOWHEAD,
        [949] = DropKeys.WOWHEAD,
    },
    [1468] = { -- Murloc Fin
        [422] = DropKeys.WOWHEAD,
        [544] = DropKeys.WOWHEAD,
        [545] = DropKeys.WOWHEAD,
        [548] = DropKeys.WOWHEAD,
        [578] = DropKeys.WOWHEAD,
        [1024] = DropKeys.WOWHEAD,
        [1025] = DropKeys.WOWHEAD,
        [1026] = DropKeys.WOWHEAD,
        [1027] = DropKeys.WOWHEAD,
        [1028] = DropKeys.WOWHEAD,
        [1029] = DropKeys.WOWHEAD,
        [1083] = DropKeys.WOWHEAD,
        [1259] = DropKeys.WOWHEAD,
        [1418] = DropKeys.WOWHEAD,
        [3654] = DropKeys.WOWHEAD,
        [3737] = DropKeys.WOWHEAD,
        [3739] = DropKeys.WOWHEAD,
        [3740] = DropKeys.WOWHEAD,
        [3742] = DropKeys.WOWHEAD,
        [4818] = DropKeys.WOWHEAD,
        [4819] = DropKeys.WOWHEAD,
        [4820] = DropKeys.WOWHEAD,
        [6243] = DropKeys.WOWHEAD,
        [10643] = DropKeys.WOWHEAD,
        [14270] = DropKeys.WOWHEAD,
    },
    [1519] = { -- Bloodscalp Ear
        [587] = DropKeys.WOWHEAD,
        [588] = DropKeys.WOWHEAD,
        [595] = DropKeys.WOWHEAD,
        [597] = DropKeys.WOWHEAD,
        [660] = DropKeys.WOWHEAD,
        [671] = DropKeys.WOWHEAD,
        [694] = DropKeys.WOWHEAD,
        [697] = DropKeys.WOWHEAD,
        [699] = DropKeys.WOWHEAD,
        [701] = DropKeys.WOWHEAD,
        [702] = DropKeys.WOWHEAD,
    },
    [1598] = { -- Rot Blossom
        [202] = DropKeys.WOWHEAD,
        [531] = DropKeys.WOWHEAD,
    },
    [1894] = { -- Miners' Union Card
        [623] = DropKeys.WOWHEAD,
        [624] = DropKeys.WOWHEAD,
        [625] = DropKeys.WOWHEAD,
    },
    [2378] = { -- Skeleton Finger
        [48] = DropKeys.WOWHEAD,
        [202] = DropKeys.WOWHEAD,
        [203] = DropKeys.WOWHEAD,
        [531] = DropKeys.WOWHEAD,
        [785] = DropKeys.WOWHEAD,
        [787] = DropKeys.WOWHEAD,
        [1110] = DropKeys.WOWHEAD,
    },
    [2633] = { -- Jungle Remedy
        [940] = DropKeys.WOWHEAD,
        [941] = DropKeys.WOWHEAD,
        [942] = DropKeys.WOWHEAD,
    },
    [2676] = { -- Shimmerweed
        [1397] = DropKeys.WOWHEAD,
    },
    [2843] = { -- Dirty Knucklebones
        [2252] = DropKeys.WOWHEAD,
        [2253] = DropKeys.WOWHEAD,
        [2254] = DropKeys.WOWHEAD,
        [2255] = DropKeys.WOWHEAD,
        [2256] = DropKeys.WOWHEAD,
        [2287] = DropKeys.WOWHEAD,
        [2416] = DropKeys.WOWHEAD,
    },
    [3297] = { -- Fel Moss
        [1988] = DropKeys.WOWHEAD,
    },
    [3348] = { -- Giant Crocolisk Skin
        [2089] = 100,
    },
    [3476] = { -- Gray Bear Tongue
        [2351] = DropKeys.WOWHEAD,
        [2354] = DropKeys.WOWHEAD,
        [2356] = DropKeys.WOWHEAD,
        [14280] = DropKeys.WOWHEAD,
    },
    [3477] = { -- Creeper Ichor
        [2348] = DropKeys.WOWHEAD,
        [2349] = DropKeys.WOWHEAD,
        [2350] = DropKeys.WOWHEAD,
        [14279] = DropKeys.WOWHEAD,
    },
    [3692] = { -- Hillsbrad Human Skull
        [232] = DropKeys.WOWHEAD,
        [2244] = DropKeys.WOWHEAD,
        [2260] = DropKeys.WOWHEAD,
        [2261] = DropKeys.WOWHEAD,
        [2264] = DropKeys.WOWHEAD,
        [2265] = DropKeys.WOWHEAD,
        [2266] = DropKeys.WOWHEAD,
        [2267] = DropKeys.WOWHEAD,
        [2268] = DropKeys.WOWHEAD,
        [2269] = DropKeys.WOWHEAD,
        [2270] = DropKeys.WOWHEAD,
        [2305] = DropKeys.WOWHEAD,
        [2335] = DropKeys.WOWHEAD,
        [2360] = DropKeys.WOWHEAD,
        [2387] = DropKeys.WOWHEAD,
        [2403] = DropKeys.WOWHEAD,
        [2404] = DropKeys.WOWHEAD,
        [2427] = DropKeys.WOWHEAD,
        [2428] = DropKeys.WOWHEAD,
        [2448] = DropKeys.WOWHEAD,
        [2449] = DropKeys.WOWHEAD,
        [2450] = DropKeys.WOWHEAD,
        [2451] = DropKeys.WOWHEAD,
        [2503] = DropKeys.WOWHEAD,
    },
    [3714] = { -- Worn Stone Token
        [2271] = DropKeys.WOWHEAD,
        [2272] = DropKeys.WOWHEAD,
        [2358] = DropKeys.WOWHEAD,
        [2415] = DropKeys.WOWHEAD,
        [2628] = DropKeys.WOWHEAD,
    },
    [3917] = { -- Singing Blue Crystal
        [674] = DropKeys.WOWHEAD,
        [675] = DropKeys.WOWHEAD,
        [676] = DropKeys.WOWHEAD,
        [677] = DropKeys.WOWHEAD,
        [4723] = DropKeys.WOWHEAD,
        [14492] = DropKeys.WOWHEAD,
    },
    [3918] = { -- Singing Crystal Shard
        [688] = DropKeys.WOWHEAD,
        [689] = DropKeys.WOWHEAD,
        [690] = DropKeys.WOWHEAD,
        [1550] = DropKeys.WOWHEAD,
        [1551] = DropKeys.WOWHEAD,
    },
    [4105] = { -- Elder Crocolisk Skin
        [2635] = 100.0,
    },
    [4627] = { -- Large Stone Slab
        [92] = 100,
    },
    [4628] = { -- Bracers of Rock Binding
        [2736] = 20,
    },
    [5026] = { -- Fire Tar
        [3267] = 75,
        [3268] = 75,
        [3269] = 75,
        [3271] = 75,
    },
    [5030] = { -- Centaur Bracers
        [3272] = DropKeys.WOWHEAD,
        [3273] = DropKeys.WOWHEAD,
        [3274] = DropKeys.WOWHEAD,
        [3275] = DropKeys.WOWHEAD,
        [3394] = DropKeys.WOWHEAD,
        [3395] = DropKeys.WOWHEAD,
        [3396] = DropKeys.WOWHEAD,
        [3397] = DropKeys.WOWHEAD,
        [5837] = DropKeys.WOWHEAD,
        [5838] = DropKeys.WOWHEAD,
        [5841] = DropKeys.WOWHEAD,
        [9456] = DropKeys.WOWHEAD,
        [9523] = DropKeys.WOWHEAD,
        [9524] = DropKeys.WOWHEAD,
    },
    [5055] = { -- Intact Raptor Horn
        [3256] = DropKeys.WOWHEAD,
        [3257] = DropKeys.WOWHEAD,
        [5842] = DropKeys.WOWHEAD,
    },
    [5062] = { -- Raptor Head
        [3254] = DropKeys.WOWHEAD,
        [3255] = DropKeys.WOWHEAD,
        [3256] = DropKeys.WOWHEAD,
        [3257] = DropKeys.WOWHEAD,
        [5842] = DropKeys.WOWHEAD,
    },
    [5078] = { -- Theramore Medal
        [3385] = 100,
        [3386] = 100,
        [3393] = 100,
        [3454] = 100,
        [3455] = 100,
    },
    [5085] = { -- Bristleback Quilboar Tusk
        [3258] = 100,
        [3260] = 100,
        [3261] = 100,
        [3263] = 100,
    },
    [5086] = { -- Zhevra Hooves
        [3242] = DropKeys.WOWHEAD,
        [3426] = DropKeys.WOWHEAD,
        [3466] = DropKeys.WOWHEAD,
        [5831] = DropKeys.WOWHEAD,
    },
    [5143] = { -- Thunder Lizard Blood
        [3238] = DropKeys.WOWHEAD,
        [3239] = DropKeys.WOWHEAD,
        [3240] = DropKeys.WOWHEAD,
    },
    [5170] = { -- Mossy Tumor
        [2027] = DropKeys.WOWHEAD,
        [2029] = DropKeys.WOWHEAD,
        [2030] = DropKeys.WOWHEAD,
    },
    [5233] = { -- Stone of Relu
        [1020] = 1.5,
        [1021] = 1.5,
        [1022] = 1.5,
        [1023] = 1.5,
    },
    [5366] = { -- Glowing Soul Gem
        [3725] = DropKeys.WOWHEAD,
        [3727] = DropKeys.WOWHEAD,
        [3728] = DropKeys.WOWHEAD,
        [3730] = DropKeys.WOWHEAD,
        [3879] = DropKeys.WOWHEAD,
    },
    [5669] = { -- Dust Devil Debris
        [832] = 50.0, -- not 100%, not 5%. Could be more than 50%
    },
    [5734] = { -- Super Reaper 6000 Blueprints
        [3988] = DropKeys.WOWHEAD,
    },
    [5801] = { -- Kraul Guano
        [4538] = 100,
        [4539] = 100,
    },
    [5867] = { -- Etched Phial
        -- Most comments on Wowhead are from players who didn't realize you have to be on the quest for it to drop.
        -- That being said, cmangos claims 100% and it's definitely not 100%. Didn't sit farming them all day, but farmed a few and seems around 20%. -ytt
        [4054] = 20,
    },
    [6250] = { -- Felhound Brain
        [4678] = 100,
        [4681] = 100,
        [4685] = 100,
    },
    [6251] = { -- Nether Wing
        [4679] = 100,
        [4682] = 100,
        [4684] = 100,
    },
    [6252] = { -- Doomwarder Blood
        [4680] = 100,
        [5760] = 100,
        [14226] = 100,
    },
    [6257] = { -- Roc Gizzard
        [5428] = DropKeys.WOWHEAD,
        [5429] = DropKeys.WOWHEAD,
        [5430] = DropKeys.WOWHEAD,
    },
    [6258] = { -- Ironfur Liver
        [5268] = DropKeys.WOWHEAD,
        [5272] = DropKeys.WOWHEAD,
        [5274] = DropKeys.WOWHEAD,
        [5352] = DropKeys.WOWHEAD,
    },
    [6259] = { -- Groddoc Liver
        [5260] = DropKeys.WOWHEAD,
        [5262] = DropKeys.WOWHEAD,
    },
    [6443] = { -- Deviate Hide
        [3630] = DropKeys.WOWHEAD,
        [3631] = DropKeys.WOWHEAD,
        [3632] = DropKeys.WOWHEAD,
        [3633] = DropKeys.WOWHEAD,
        [3634] = DropKeys.WOWHEAD,
        [3636] = DropKeys.WOWHEAD,
        [3637] = DropKeys.WOWHEAD,
        [3641] = DropKeys.WOWHEAD,
        [3653] = DropKeys.WOWHEAD,
        [3654] = DropKeys.WOWHEAD,
        [3674] = DropKeys.WOWHEAD,
        [5048] = DropKeys.WOWHEAD,
        [5053] = DropKeys.WOWHEAD,
        [5056] = DropKeys.WOWHEAD,
        [5755] = DropKeys.WOWHEAD,
        [5756] = DropKeys.WOWHEAD,
        [5761] = DropKeys.WOWHEAD,
        [5762] = DropKeys.WOWHEAD,
        [5775] = DropKeys.WOWHEAD,
        [5912] = DropKeys.WOWHEAD,
        [8886] = DropKeys.WOWHEAD,
    },
    [6652] = { -- Reagent Pouch
        [3199] = 75,
    },
    [6915] = { -- Large Soran'ruk Fragment
        [3855] = 20, -- empyrical value
    },
    [7267] = { -- Pristine Spider Silk
        [930] = 18,
        [949] = 100,
    },
    [7291] = { -- Infernal Orb
        [4668] = 100,
    },
    [9369] = { -- Iridescent Sprite Darter Wing
        -- this one is complicated; they drop 0-2, on average you get more than 1 per kill, but they occasionally don't drop any so 100% isn't accurate
        [5278] = 95,
        [7997] = 95,
    },
    [10458] = { -- Prayer to Elune
        [5860] = 20, -- empyrical value
        [5861] = 20, -- empyrical value
        [5862] = 20, -- empyrical value
        [8419] = 20, -- empyrical value
    },
    [10551] = { -- Thorium Plated Dagger
        [5839] = 50,
        [5840] = 50,
        [5843] = 50,
        [5844] = 50,
        [5846] = 50,
        [8337] = 50,
        [8504] = 50,
        [8566] = 50,
        [8637] = 50,
    },
    [10552] = { -- Symbol of Ragnaros
        [5860] = DropKeys.WOWHEAD,
        [5861] = DropKeys.WOWHEAD,
        [5862] = DropKeys.WOWHEAD,
        [8419] = DropKeys.WOWHEAD,
    },
    [10639] = { -- Hyacinth Mushroom
        [1988] = 80,
    },
    [11405] = { -- Giant Silver Vein
        [6146] = 100,
        [6147] = 100,
        [6148] = 100,
    },
    [11478] = { -- Un'Goro Gorilla Pelt
        [6514] = DropKeys.WOWHEAD,
    },
    [11479] = { -- Un'Goro Stomper Pelt
        [6513] = DropKeys.WOWHEAD,
    },
    [11480] = { -- Un'Goro Thunderer Pelt
        [6516] = DropKeys.WOWHEAD,
    },
    [11503] = { -- Blood Amber
        [7100] = 100,
        [7101] = 100,
        [7104] = 100,
    },
    [11725] = { -- Solid Crystal Leg Shaft
        [5856] = DropKeys.WOWHEAD,
    },
    [11829] = { -- Un'Goro Ash
        [6520] = 100.0,
        [6521] = 100.0,
        [9376] = 10.0,
        [14460] = 100.0,
        [14461] = 10.0,
    },
    [12335] = { -- Gemstone of Smolderthorn
        [9237] = 10,
    },
    [12336] = { -- Gemstone of Spirestone
        [9196] = 10,
    },
    [12337] = { -- Gemstone of Bloodaxe
        [9568] = 10,
    },
    [12524] = { -- Blue-feathered Amulet
        [7452] = 50,
        [7453] = 50,
        [7454] = 50,
    },
    [12733] = { -- Sacred Frostsaber Meat
        [7430] = 10,
        [7431] = 10,
        [7432] = 10,
        [7433] = 10,
        [7434] = 10,
    },
    [15849] = { -- Ghost-o-plasm
        [11560] = 100,
    },
    [15852] = { -- Kodo Horn
        [3234] = 100,
        [3236] = 100,
    },
    [15881] = { -- Rackmore's Golden Key
        [4711] = DropKeys.WOWHEAD,
        [4712] = DropKeys.WOWHEAD,
        [4713] = DropKeys.WOWHEAD,
        [4714] = DropKeys.WOWHEAD,
        [4715] = DropKeys.WOWHEAD,
        [4716] = DropKeys.WOWHEAD,
        [4718] = DropKeys.WOWHEAD,
        [4719] = DropKeys.WOWHEAD,
        [14229] = DropKeys.WOWHEAD,
    },
    [17309] = { -- Discordant Bracers
        [8519] = 100,
        [8520] = 100,
        [8521] = 100,
        [8522] = 100,
    },
    [17761] = { -- Gem of the First Khan
        [12240] = 100,
    },
    [17762] = { -- Gem of the Second Khan
        [12239] = 100,
    },
    [17763] = { -- Gem of the Third Khan
        [12241] = 100,
    },
    [17764] = { -- Gem of the Fourth Khan
        [12242] = 100,
    },
    [17765] = { -- Gem of the Fifth Khan
        [12243] = 100,
    },
    [18956] = { -- Miniaturization Residue
        [5357] = 100,
        [5358] = 100,
        [5359] = 100,
        [5360] = 100,
        [5361] = 100,
        [14603] = 100,
        [14604] = 100,
        [14638] = 100,
        [14639] = 100,
        [14640] = 100,
    },
    [20028] = { -- Glittering Dust
        [6198] = 25,
        [6199] = 25,
    },
    [20029] = { -- Enchanted Coral
        [6195] = 25,
    },
    [20373] = { -- Stonelash Scorpid Stinger
        [11735] = DropKeys.WOWHEAD,
    },
    [20374] = { -- Stonelash Pincer Stinger
        [11736] = DropKeys.WOWHEAD,
    },
    [20375] = { -- Stonelash Flayer Stinger
        [11737] = DropKeys.WOWHEAD,
    },
    [20376] = { -- Sand Skitterer Fang
        [11738] = DropKeys.WOWHEAD,
    },
    [20377] = { -- Rock Stalker Fang
        [11739] = DropKeys.WOWHEAD,
    },
    [21108] = { -- Draconic for Dummies (Chapter VI)
        [10184] = 100,
    },
    [21110] = { -- Draconic for Dummies (Chapter VIII)
        [11502] = 100,
    },
    [190232] = { -- Withered Scarf
        [3782] = 5, -- super bad drop rate, wowhead shows 3%. it's somewhere between 5-10%
        [3784] = 5, -- super bad drop rate, wowhead shows 3%. it's somewhere between 5-10%
    },
    [269715] = { -- Savannah Lion Hide
        [3241] = 31.42,
        [3416] = 4.08,
    },
}
