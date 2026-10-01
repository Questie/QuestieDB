-- Generated delta-base. Apply after inherited Static Corrections, before authored Forever Static Corrections.
-- Import provenance and refresh policy: docs/forever-delta-base.md.
local ForeverBaseNpc = QuestieLoader:CreateModule("ForeverBaseNpc")
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
function ForeverBaseNpc:Load()
    local npcKeys = QuestieDB.npcKeys
    local zoneIDs = ZoneDB.zoneIDs
    return {
        [89] = { -- Infernal : https://wowhead.com/forever/npc=89/infernal
            [npcKeys.minLevel] = 51,
        },
        [167] = { -- Morhan Coppertongue : https://wowhead.com/forever/npc=167/morhan-coppertongue
            [npcKeys.questStarts] = {86776},
            [npcKeys.questEnds] = {86776},
        },
        [197] = { -- Marshal McBride : https://wowhead.com/forever/npc=197/marshal-mcbride
            [npcKeys.questStarts_add] = {91758, 92479, 96627},
            [npcKeys.questEnds_add] = {91752},
        },
        [228] = { -- Avette Fellwood : https://wowhead.com/forever/npc=228/avette-fellwood
            [npcKeys.questEnds] = {95161},
        },
        [234] = { -- Gryan Stoutmantle : https://wowhead.com/forever/npc=234/gryan-stoutmantle
            [npcKeys.questEnds_add] = {98021},
        },
        [240] = { -- Marshal Dughan : https://wowhead.com/forever/npc=240/marshal-dughan
            [npcKeys.questStarts_add] = {91775, 91777},
            [npcKeys.questEnds_add] = {91772, 91775},
        },
        [241] = { -- Remy "Two Times" : https://wowhead.com/forever/npc=241/remy-two-times
            [npcKeys.questStarts_add] = {99130, 99131},
            [npcKeys.questEnds_add] = {99129, 99130},
        },
        [268] = { -- Sirra Von'Indi : https://wowhead.com/forever/npc=268/sirra-vonindi
            [npcKeys.questStarts_add] = {96139},
            [npcKeys.questEnds_add] = {96139},
        },
        [341] = { -- Foreman Oslow : https://wowhead.com/forever/npc=341/foreman-oslow
            [npcKeys.questStarts_add] = {98386},
            [npcKeys.questEnds_add] = {98386},
        },
        [344] = { -- Magistrate Solomon : https://wowhead.com/forever/npc=344/magistrate-solomon
            [npcKeys.questEnds_add] = {95999},
        },
        [376] = { -- High Priestess Laurena : https://wowhead.com/forever/npc=376/high-priestess-laurena
            [npcKeys.questStarts_add] = {94773},
            [npcKeys.questEnds_add] = {94773, 94774},
        },
        [377] = { -- Priestess Josetta : https://wowhead.com/forever/npc=377/priestess-josetta
            [npcKeys.questStarts_add] = {94774},
        },
        [382] = { -- Marshal Marris : https://wowhead.com/forever/npc=382/marshal-marris
            [npcKeys.questStarts_add] = {98387},
            [npcKeys.questEnds_add] = {98387},
        },
        [383] = { -- Jason Mathers : https://wowhead.com/forever/npc=383/jason-mathers
            [npcKeys.questStarts] = {99127, 99128, 99129},
            [npcKeys.questEnds] = {99127, 99128, 99131},
        },
        [466] = { -- General Marcus Jonathan : https://wowhead.com/forever/npc=466/general-marcus-jonathan
            [npcKeys.questEnds_add] = {95195},
        },
        [471] = { -- Mother Fang : https://wowhead.com/forever/npc=471/mother-fang
            [npcKeys.minLevel] = 7,
        },
        [483] = { -- Elaine Trias : https://wowhead.com/forever/npc=483/elaine-trias
            [npcKeys.questStarts] = {97222},
            [npcKeys.questEnds] = {97220, 97222},
        },
        [514] = { -- Smith Argus : https://wowhead.com/forever/npc=514/smith-argus
            [npcKeys.questEnds_add] = {97916},
        },
        [658] = { -- Sten Stoutarm : https://wowhead.com/forever/npc=658/sten-stoutarm
            [npcKeys.questStarts_add] = {98574, 98581},
        },
        [715] = { -- Hemet Nesingwary : https://wowhead.com/forever/npc=715/hemet-nesingwary
            [npcKeys.questEnds_add] = {93928},
        },
        [823] = { -- Deputy Willem : https://wowhead.com/forever/npc=823/deputy-willem
            [npcKeys.minLevel] = 1,
        },
        [837] = { -- Branstock Khalder : https://wowhead.com/forever/npc=837/branstock-khalder
            [npcKeys.questEnds_add] = {98574},
        },
        [951] = { -- Brother Paxton : https://wowhead.com/forever/npc=951/brother-paxton
            [npcKeys.questStarts_add] = {91743, 91745, 92124},
            [npcKeys.questEnds_add] = {91741, 91743, 91777},
        },
        [955] = { -- Sergeant De Vries : https://wowhead.com/forever/npc=955/sergeant-de-vries
            [npcKeys.questStarts] = {91738},
            [npcKeys.questEnds] = {91738},
        },
        [1070] = { -- Deputy Feldon : https://wowhead.com/forever/npc=1070/deputy-feldon
            [npcKeys.questStarts_add] = {98407},
            [npcKeys.questEnds_add] = {98407},
        },
        [1092] = { -- Captain Rugelfuss : https://wowhead.com/forever/npc=1092/captain-rugelfuss
            [npcKeys.questEnds_add] = {86585},
        },
        [1103] = { -- Eldrin : https://wowhead.com/forever/npc=1103/eldrin
            [npcKeys.questEnds] = {97925},
        },
        [1154] = { -- Marek Ironheart : https://wowhead.com/forever/npc=1154/marek-ironheart
            [npcKeys.questStarts_add] = {86758},
            [npcKeys.questEnds_add] = {86758},
        },
        [1215] = { -- Alchemist Mallory : https://wowhead.com/forever/npc=1215/alchemist-mallory
            [npcKeys.questEnds] = {97915},
        },
        [1218] = { -- Herbalist Pomeroy : https://wowhead.com/forever/npc=1218/herbalist-pomeroy
            [npcKeys.questEnds] = {97921},
        },
        [1226] = { -- Maxan Anvol : https://wowhead.com/forever/npc=1226/maxan-anvol
            [npcKeys.questStarts_add] = {94824, 99158},
        },
        [1241] = { -- Tognus Flintfire : https://wowhead.com/forever/npc=1241/tognus-flintfire
            [npcKeys.questStarts] = {98321},
            [npcKeys.questEnds] = {96044, 98321},
        },
        [1246] = { -- Vosur Brakthel : https://wowhead.com/forever/npc=1246/vosur-brakthel
            [npcKeys.questStarts] = {96045},
            [npcKeys.questEnds] = {96045},
        },
        [1252] = { -- Senir Whitebeard : https://wowhead.com/forever/npc=1252/senir-whitebeard
            [npcKeys.questStarts_add] = {98322},
            [npcKeys.questEnds_add] = {98323},
        },
        [1253] = { -- Father Gavin : https://wowhead.com/forever/npc=1253/father-gavin
            [npcKeys.questStarts] = {99159, 99160, 99161, 99162},
            [npcKeys.questEnds] = {99158, 99159, 99160, 99161, 99162},
        },
        [1256] = { -- Quarrymaster Thesten : https://wowhead.com/forever/npc=1256/quarrymaster-thesten
            [npcKeys.questStarts] = {95214},
            [npcKeys.questEnds] = {95213, 95214},
        },
        [1265] = { -- Rudra Amberstill : https://wowhead.com/forever/npc=1265/rudra-amberstill
            [npcKeys.questStarts_add] = {95212},
            [npcKeys.questEnds_add] = {95212},
        },
        [1325] = { -- Jasper Fel : https://wowhead.com/forever/npc=1325/jasper-fel
            [npcKeys.questStarts] = {92751},
            [npcKeys.questEnds] = {92750},
        },
        [1344] = { -- Prospector Ironband : https://wowhead.com/forever/npc=1344/prospector-ironband
            [npcKeys.questEnds_add] = {86613},
        },
        [1376] = { -- Beldin Steelgrill : https://wowhead.com/forever/npc=1376/beldin-steelgrill
            [npcKeys.questStarts] = {96408},
        },
        [1430] = { -- Tomas : https://wowhead.com/forever/npc=1430/tomas
            [npcKeys.questEnds] = {96626},
        },
        [1466] = { -- Gretta Finespindle : https://wowhead.com/forever/npc=1466/gretta-finespindle
            [npcKeys.questEnds] = {96031},
        },
        [1481] = { -- Bart Tidewater : https://wowhead.com/forever/npc=1481/bart-tidewater
            [npcKeys.questEnds] = {98459},
        },
        [1495] = { -- Deathguard Linnea : https://wowhead.com/forever/npc=1495/deathguard-linnea
            [npcKeys.questStarts_add] = {99156},
            [npcKeys.questEnds_add] = {99156},
        },
        [1515] = { -- Executor Zygand : https://wowhead.com/forever/npc=1515/executor-zygand
            [npcKeys.questStarts_add] = {99134, 99141},
            [npcKeys.questEnds_add] = {99134, 99141},
        },
        [1569] = { -- Shadow Priest Sarvis : https://wowhead.com/forever/npc=1569/shadow-priest-sarvis
            [npcKeys.questStarts_add] = {98601},
        },
        [1570] = { -- Executor Arren : https://wowhead.com/forever/npc=1570/executor-arren
            [npcKeys.questStarts_add] = {96656},
        },
        [1632] = { -- Adele Fielder : https://wowhead.com/forever/npc=1632/adele-fielder
            [npcKeys.questEnds] = {97922},
        },
        [1646] = { -- Baros Alexston : https://wowhead.com/forever/npc=1646/baros-alexston
            [npcKeys.questStarts_add] = {97926},
            [npcKeys.questEnds_add] = {97914},
        },
        [1651] = { -- Lee Brown : https://wowhead.com/forever/npc=1651/lee-brown
            [npcKeys.questStarts] = {99143},
            [npcKeys.questEnds] = {97920, 99143},
        },
        [1684] = { -- Khara Deepwater : https://wowhead.com/forever/npc=1684/khara-deepwater
            [npcKeys.questEnds] = {86614},
        },
        [1698] = { -- Frast Dokner : https://wowhead.com/forever/npc=1698/frast-dokner
            [npcKeys.questStarts] = {95217},
            [npcKeys.questEnds] = {95217},
        },
        [1699] = { -- Gremlock Pilsnor : https://wowhead.com/forever/npc=1699/gremlock-pilsnor
            [npcKeys.questEnds] = {96629},
        },
        [1700] = { -- Paxton Ganter : https://wowhead.com/forever/npc=1700/paxton-ganter
            [npcKeys.questEnds] = {96050},
        },
        [1702] = { -- Bronk Guzzlegear : https://wowhead.com/forever/npc=1702/bronk-guzzlegear
            [npcKeys.questEnds] = {96058},
        },
        [1703] = { -- Uthrar Threx : https://wowhead.com/forever/npc=1703/uthrar-threx
            [npcKeys.questEnds] = {96057},
        },
        [1725] = { -- Defias Watchman : https://wowhead.com/forever/npc=1725/defias-watchman
            [npcKeys.maxLevel] = 18,
        },
        [1738] = { -- Deathguard Terrence : https://wowhead.com/forever/npc=1738/deathguard-terrence
            [npcKeys.questStarts] = {96895},
        },
        [1742] = { -- Deathguard Bartholomew : https://wowhead.com/forever/npc=1742/deathguard-bartholomew
            [npcKeys.questStarts] = {86784},
        },
        [1748] = { -- Highlord Bolvar Fordragon : https://wowhead.com/forever/npc=1748/highlord-bolvar-fordragon
            [npcKeys.questStarts_add] = {93963, 98021},
            [npcKeys.questEnds_add] = {93963, 94947},
        },
        [1937] = { -- Apothecary Renferrel : https://wowhead.com/forever/npc=1937/apothecary-renferrel
            [npcKeys.questStarts_add] = {91921},
            [npcKeys.questEnds_add] = {91920},
        },
        [1938] = { -- Dalar Dawnweaver : https://wowhead.com/forever/npc=1938/dalar-dawnweaver
            [npcKeys.questStarts_add] = {98298, 98299},
            [npcKeys.questEnds_add] = {98298, 98299},
        },
        [1951] = { -- Quinn Yorick : https://wowhead.com/forever/npc=1951/quinn-yorick
            [npcKeys.questStarts] = {91920},
            [npcKeys.questEnds_add] = {91921},
        },
        [1965] = { -- Mountaineer Thalos : https://wowhead.com/forever/npc=1965/mountaineer-thalos
            [npcKeys.questStarts_add] = {96628},
        },
        [1992] = { -- Tarindrella : https://wowhead.com/forever/npc=1992/tarindrella
            [npcKeys.questStarts_add] = {97977},
            [npcKeys.questEnds_add] = {97977},
        },
        [2055] = { -- Master Apothecary Faranell : https://wowhead.com/forever/npc=2055/master-apothecary-faranell
            [npcKeys.questStarts_add] = {97289, 97291, 97292},
            [npcKeys.questEnds_add] = {97288, 97290, 97291, 97292},
        },
        [2081] = { -- Sentinel Kyra Starsong : https://wowhead.com/forever/npc=2081/sentinel-kyra-starsong
            [npcKeys.questEnds] = {99053},
            [npcKeys.questStarts_add] = {99046},
        },
        [2082] = { -- Gilshalan Windwalker : https://wowhead.com/forever/npc=2082/gilshalan-windwalker
            [npcKeys.questEnds_add] = {97236},
        },
        [2086] = { -- Valstag Ironjaw : https://wowhead.com/forever/npc=2086/valstag-ironjaw
            [npcKeys.questStarts_add] = {98197},
            [npcKeys.questEnds_add] = {98197},
        },
        [2096] = { -- Tarrel Rockweaver : https://wowhead.com/forever/npc=2096/tarrel-rockweaver
            [npcKeys.questEnds_add] = {98461},
        },
        [2114] = { -- Faruza : https://wowhead.com/forever/npc=2114/faruza
            [npcKeys.questEnds] = {97957},
        },
        [2121] = { -- Shadow Priest Allister : https://wowhead.com/forever/npc=2121/shadow-priest-allister
            [npcKeys.questStarts_add] = {95981},
            [npcKeys.questEnds_add] = {95981},
        },
        [2132] = { -- Carolai Anise : https://wowhead.com/forever/npc=2132/carolai-anise
            [npcKeys.questStarts] = {95314},
            [npcKeys.questEnds] = {95314, 97951},
        },
        [2326] = { -- Thamner Pol : https://wowhead.com/forever/npc=2326/thamner-pol
            [npcKeys.questEnds] = {96047},
        },
        [2329] = { -- Michelle Belle : https://wowhead.com/forever/npc=2329/michelle-belle
            [npcKeys.questEnds] = {97919},
        },
        [2504] = { -- Donyal Tovald : https://wowhead.com/forever/npc=2504/donyal-tovald
            [npcKeys.questStarts_add] = {97237},
            [npcKeys.questEnds_add] = {97234},
        },
        [2540] = { -- Dalaran Serpent : https://wowhead.com/forever/npc=2540/dalaran-serpent
            [npcKeys.maxLevel] = 17,
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [2543] = { -- Archmage Ansirem Runeweaver : https://wowhead.com/forever/npc=2543/archmage-ansirem-runeweaver
            [npcKeys.questStarts_add] = {94912},
        },
        [2756] = { -- UNUSED Grund Drokda : https://wowhead.com/forever/npc=2756/grund-drokda
            [npcKeys.questStarts] = {97277},
            [npcKeys.questEnds] = {97277},
        },
        [2784] = { -- King Magni Bronzebeard : https://wowhead.com/forever/npc=2784/king-magni-bronzebeard
            [npcKeys.questEnds_add] = {96393, 98423},
        },
        [2855] = { -- Snang : https://wowhead.com/forever/npc=2855/snang
            [npcKeys.questEnds] = {96102},
        },
        [2913] = { -- Archaeologist Hollee : https://wowhead.com/forever/npc=2913/archaeologist-hollee
            [npcKeys.questStarts_add] = {98461},
        },
        [2930] = { -- Sentinel Glynda Nal'Shea : https://wowhead.com/forever/npc=2930/sentinel-glynda-nalshea
            [npcKeys.questEnds_add] = {98025},
        },
        [2948] = { -- Mull Thunderhorn : https://wowhead.com/forever/npc=2948/mull-thunderhorn
            [npcKeys.questStarts_add] = {98435},
        },
        [2981] = { -- Chief Hawkwind : https://wowhead.com/forever/npc=2981/chief-hawkwind
            [npcKeys.questStarts_add] = {96659},
        },
        [2982] = { -- Seer Graytongue : https://wowhead.com/forever/npc=2982/seer-graytongue
            [npcKeys.questStarts_add] = {95805},
        },
        [2988] = { -- Morin Cloudstalker : https://wowhead.com/forever/npc=2988/morin-cloudstalker
            [npcKeys.questStarts_add] = {98427},
            [npcKeys.questEnds_add] = {98424, 98427},
        },
        [2993] = { -- Baine Bloodhoof : https://wowhead.com/forever/npc=2993/baine-bloodhoof
            [npcKeys.questStarts_add] = {99080, 99082},
            [npcKeys.questEnds_add] = {99080, 99101},
        },
        [3001] = { -- Brek Stonehoof : https://wowhead.com/forever/npc=3001/brek-stonehoof
            [npcKeys.questEnds] = {97935},
        },
        [3013] = { -- Komin Winterhoof : https://wowhead.com/forever/npc=3013/komin-winterhoof
            [npcKeys.questEnds] = {97933},
        },
        [3024] = { -- Tah Winterhoof : https://wowhead.com/forever/npc=3024/tah-winterhoof
            [npcKeys.questStarts] = {97538},
        },
        [3033] = { -- Turak Runetotem : https://wowhead.com/forever/npc=3033/turak-runetotem
            [npcKeys.questStarts_add] = {94913, 98340},
            [npcKeys.questEnds_add] = {94911, 98362},
        },
        [3057] = { -- Cairne Bloodhoof : https://wowhead.com/forever/npc=3057/cairne-bloodhoof
            [npcKeys.questEnds_add] = {98430, 99082},
        },
        [3063] = { -- Krang Stonehoof : https://wowhead.com/forever/npc=3063/krang-stonehoof
            [npcKeys.questEnds] = {99108},
            [npcKeys.questStarts_add] = {99108},
        },
        [3065] = { -- Yaw Sharpmane : https://wowhead.com/forever/npc=3065/yaw-sharpmane
            [npcKeys.questStarts_add] = {96130},
            [npcKeys.questEnds_add] = {96130},
        },
        [3067] = { -- Pyall Silentstride : https://wowhead.com/forever/npc=3067/pyall-silentstride
            [npcKeys.questEnds] = {96661},
        },
        [3069] = { -- Chaw Stronghide : https://wowhead.com/forever/npc=3069/chaw-stronghide
            [npcKeys.questEnds] = {97934},
        },
        [3134] = { -- Kzixx : https://wowhead.com/forever/npc=3134/kzixx
            [npcKeys.questEnds] = {94241},
        },
        [3139] = { -- Gar'Thok : https://wowhead.com/forever/npc=3139/garthok
            [npcKeys.questEnds_add] = {96821},
        },
        [3142] = { -- Orgnil Soulscar : https://wowhead.com/forever/npc=3142/orgnil-soulscar
            [npcKeys.questStarts_add] = {99048, 99051, 99052},
            [npcKeys.questEnds_add] = {99049, 99051, 99052},
        },
        [3143] = { -- Gornek : https://wowhead.com/forever/npc=3143/gornek
            [npcKeys.questStarts_add] = {97279, 98575, 98576},
        },
        [3156] = { -- Nartok : https://wowhead.com/forever/npc=3156/nartok
            [npcKeys.questEnds_add] = {98575},
        },
        [3159] = { -- Kzan Thornslash : https://wowhead.com/forever/npc=3159/kzan-thornslash
            [npcKeys.questEnds] = {97279},
        },
        [3174] = { -- Dwukk : https://wowhead.com/forever/npc=3174/dwukk
            [npcKeys.questEnds] = {97900},
        },
        [3175] = { -- Krunn : https://wowhead.com/forever/npc=3175/krunn
            [npcKeys.questEnds] = {97907},
        },
        [3188] = { -- Master Gadrin : https://wowhead.com/forever/npc=3188/master-gadrin
            [npcKeys.questEnds_add] = {97225},
        },
        [3191] = { -- Cook Torka : https://wowhead.com/forever/npc=3191/cook-torka
            [npcKeys.questStarts_add] = {96825},
            [npcKeys.questEnds_add] = {96655, 96825},
        },
        [3194] = { -- Vel'rin Fang : https://wowhead.com/forever/npc=3194/velrin-fang
            [npcKeys.questStarts_add] = {96821},
        },
        [3222] = { -- Brave Wildrunner : https://wowhead.com/forever/npc=3222/brave-wildrunner
            [npcKeys.questStarts] = {99079, 99101},
            [npcKeys.questEnds] = {99081},
        },
        [3293] = { -- Rezlak : https://wowhead.com/forever/npc=3293/rezlak
            [npcKeys.questStarts_add] = {97282},
            [npcKeys.questEnds_add] = {97281, 97282},
        },
        [3304] = { -- Master Vornal : https://wowhead.com/forever/npc=3304/master-vornal
            [npcKeys.questStarts_add] = {97225},
            [npcKeys.questEnds_add] = {99123},
        },
        [3347] = { -- Yelmak : https://wowhead.com/forever/npc=3347/yelmak
            [npcKeys.questStarts] = {97275},
        },
        [3348] = { -- Kor'geld : https://wowhead.com/forever/npc=3348/korgeld
            [npcKeys.questStarts] = {97242},
            [npcKeys.questEnds] = {97242},
        },
        [3365] = { -- Karolek : https://wowhead.com/forever/npc=3365/karolek
            [npcKeys.questEnds] = {97906},
        },
        [3368] = { -- Borstan : https://wowhead.com/forever/npc=3368/borstan
            [npcKeys.questStarts] = {97249},
            [npcKeys.questEnds] = {97246},
        },
        [3391] = { -- Gazlowe : https://wowhead.com/forever/npc=3391/gazlowe
            [npcKeys.questEnds_add] = {92706},
        },
        [3404] = { -- Jandi : https://wowhead.com/forever/npc=3404/jandi
            [npcKeys.questEnds] = {97905},
        },
        [3429] = { -- Thork : https://wowhead.com/forever/npc=3429/thork
            [npcKeys.questEnds_add] = {98024},
        },
        [3432] = { -- Mankrik : https://wowhead.com/forever/npc=3432/mankrik
            [npcKeys.questStarts_add] = {95774},
            [npcKeys.questEnds_add] = {95774},
        },
        [3516] = { -- Arch Druid Fandral Staghelm : https://wowhead.com/forever/npc=3516/arch-druid-fandral-staghelm
            [npcKeys.questStarts_add] = {98046},
        },
        [3519] = { -- Sentinel Arynia Cloudsbreak : https://wowhead.com/forever/npc=3519/sentinel-arynia-cloudsbreak
            [npcKeys.questStarts_add] = {98392, 98398},
            [npcKeys.questEnds_add] = {98392},
        },
        [3523] = { -- Bowen Brisboise : https://wowhead.com/forever/npc=3523/bowen-brisboise
            [npcKeys.questEnds] = {97961},
        },
        [3539] = { -- Ott : https://wowhead.com/forever/npc=3539/ott
            [npcKeys.questStarts] = {95125, 95126},
            [npcKeys.questEnds] = {95111, 95125},
        },
        [3549] = { -- Shelene Rhobart : https://wowhead.com/forever/npc=3549/shelene-rhobart
            [npcKeys.questStarts] = {97558},
            [npcKeys.questEnds] = {97558, 97958},
        },
        [3567] = { -- Tallonkai Swiftroot : https://wowhead.com/forever/npc=3567/tallonkai-swiftroot
            [npcKeys.questStarts_add] = {98403},
            [npcKeys.questEnds_add] = {98403},
        },
        [3595] = { -- Shanda : https://wowhead.com/forever/npc=3595/shanda
            [npcKeys.questStarts_add] = {97979},
            [npcKeys.questEnds_add] = {97979},
        },
        [3600] = { -- Laurna Morninglight : https://wowhead.com/forever/npc=3600/laurna-morninglight
            [npcKeys.questStarts_add] = {98391},
        },
        [3603] = { -- Cyndra Kindwhisper : https://wowhead.com/forever/npc=3603/cyndra-kindwhisper
            [npcKeys.questEnds] = {97938},
        },
        [3604] = { -- Malorne Bladeleaf : https://wowhead.com/forever/npc=3604/malorne-bladeleaf
            [npcKeys.questEnds] = {97944},
        },
        [3605] = { -- Nadyia Maneweaver : https://wowhead.com/forever/npc=3605/nadyia-maneweaver
            [npcKeys.questEnds] = {97946},
        },
        [3606] = { -- Alanna Raveneye : https://wowhead.com/forever/npc=3606/alanna-raveneye
            [npcKeys.questEnds] = {97940},
        },
        [3608] = { -- Aldia : https://wowhead.com/forever/npc=3608/aldia
            [npcKeys.questStarts] = {87288},
            [npcKeys.questEnds] = {87288},
        },
        [3616] = { -- Onu : https://wowhead.com/forever/npc=3616/onu
            [npcKeys.questEnds_add] = {98028},
        },
        [3649] = { -- Thundris Windweaver : https://wowhead.com/forever/npc=3649/thundris-windweaver
            [npcKeys.questStarts_add] = {97914},
            [npcKeys.questEnds_add] = {97926, 98042},
        },
        [3663] = { -- Delgren the Purifier : https://wowhead.com/forever/npc=3663/delgren-the-purifier
            [npcKeys.questEnds_add] = {78088},
        },
        [3682] = { -- Vrang Wildgore : https://wowhead.com/forever/npc=3682/vrang-wildgore
            [npcKeys.minLevel] = 35,
            [npcKeys.questStarts] = {95494, 95495, 95507},
            [npcKeys.questEnds] = {95494, 95507},
        },
        [4092] = { -- Lariia : https://wowhead.com/forever/npc=4092/lariia
            [npcKeys.questStarts] = {98065},
            [npcKeys.questEnds] = {98046},
        },
        [4156] = { -- Astaia : https://wowhead.com/forever/npc=4156/astaia
            [npcKeys.questEnds] = {97943},
        },
        [4201] = { -- Ziz Fizziks : https://wowhead.com/forever/npc=4201/ziz-fizziks
            [npcKeys.questEnds_add] = {94216},
        },
        [4217] = { -- Mathrengyl Bearwalker : https://wowhead.com/forever/npc=4217/mathrengyl-bearwalker
            [npcKeys.questStarts_add] = {98393},
            [npcKeys.questEnds_add] = {98397},
        },
        [4586] = { -- Graham Van Talen : https://wowhead.com/forever/npc=4586/graham-van-talen
            [npcKeys.questEnds] = {97954},
        },
        [4598] = { -- Brom Killian : https://wowhead.com/forever/npc=4598/brom-killian
            [npcKeys.questEnds] = {97959},
        },
        [4605] = { -- Basil Frye : https://wowhead.com/forever/npc=4605/basil-frye
            [npcKeys.questEnds] = {97952},
        },
        [4607] = { -- Father Lankester : https://wowhead.com/forever/npc=4607/father-lankester
            [npcKeys.questEnds] = {95328},
        },
        [4949] = { -- Thrall : https://wowhead.com/forever/npc=4949/thrall
            [npcKeys.questStarts_add] = {93739, 98024},
            [npcKeys.questEnds_add] = {95350},
        },
        [5137] = { -- Reyna Stonebranch : https://wowhead.com/forever/npc=5137/reyna-stonebranch
            [npcKeys.questEnds] = {96055},
        },
        [5392] = { -- Yarr Hammerstone : https://wowhead.com/forever/npc=5392/yarr-hammerstone
            [npcKeys.questEnds] = {96046},
        },
        [5504] = { -- Sheldras Moontree : https://wowhead.com/forever/npc=5504/sheldras-moontree
            [npcKeys.questStarts] = {94914},
            [npcKeys.questEnds] = {94912},
        },
        [5513] = { -- Gelman Stonehand : https://wowhead.com/forever/npc=5513/gelman-stonehand
            [npcKeys.questEnds] = {97923},
        },
        [5690] = { -- Clyde Kellen : https://wowhead.com/forever/npc=5690/clyde-kellen
            [npcKeys.questEnds] = {97956},
        },
        [5695] = { -- Vance Undergloom : https://wowhead.com/forever/npc=5695/vance-undergloom
            [npcKeys.questEnds] = {97953},
        },
        [5759] = { -- Nurse Neela : https://wowhead.com/forever/npc=5759/nurse-neela
            [npcKeys.questEnds] = {97955},
        },
        [5769] = { -- Arch Druid Hamuul Runetotem : https://wowhead.com/forever/npc=5769/arch-druid-hamuul-runetotem
            [npcKeys.questEnds_add] = {98435},
        },
        [5811] = { -- Kamari : https://wowhead.com/forever/npc=5811/kamari
            [npcKeys.questStarts] = {96875},
            [npcKeys.questEnds] = {96875, 96877},
        },
        [5884] = { -- Mai'ah : https://wowhead.com/forever/npc=5884/maiah
            [npcKeys.questEnds_add] = {98576},
        },
        [5891] = { -- Minor Manifestation of Earth : https://wowhead.com/forever/npc=5891/minor-manifestation-of-earth
            [npcKeys.questStarts_add] = {94375},
            [npcKeys.questEnds_add] = {94374},
        },
        [5895] = { -- Minor Manifestation of Water : https://wowhead.com/forever/npc=5895/minor-manifestation-of-water
            [npcKeys.questStarts_add] = {94505},
            [npcKeys.questEnds_add] = {94503},
        },
        [5911] = { -- Grunt Logmar : https://wowhead.com/forever/npc=5911/grunt-logmar
            [npcKeys.questStarts_add] = {97250},
            [npcKeys.questEnds_add] = {97250},
        },
        [5938] = { -- Uthan Stillwater : https://wowhead.com/forever/npc=5938/uthan-stillwater
            [npcKeys.questEnds] = {97932},
        },
        [5939] = { -- Vira Younghoof : https://wowhead.com/forever/npc=5939/vira-younghoof
            [npcKeys.questEnds] = {97931},
        },
        [5941] = { -- Lau'Tiki : https://wowhead.com/forever/npc=5941/lautiki
            [npcKeys.questEnds] = {97904},
        },
        [5943] = { -- Rawrk : https://wowhead.com/forever/npc=5943/rawrk
            [npcKeys.questEnds] = {97903},
        },
        [6094] = { -- Byancie : https://wowhead.com/forever/npc=6094/byancie
            [npcKeys.questStarts] = {99050, 99073},
            [npcKeys.questEnds] = {97942, 99047, 99050},
        },
        [6123] = { -- Dark Iron Spy : https://wowhead.com/forever/npc=6123/dark-iron-spy
            [npcKeys.maxLevel] = 11,
        },
        [6176] = { -- Bath'rah the Windwatcher : https://wowhead.com/forever/npc=6176/bathrah-the-windwatcher
            [npcKeys.questStarts_add] = {79362, 79363},
            [npcKeys.questEnds_add] = {79362, 79363},
        },
        [6271] = { -- Mouse : https://wowhead.com/forever/npc=6271/mouse
            [npcKeys.questStarts] = {93928},
        },
        [6286] = { -- Zarrin : https://wowhead.com/forever/npc=6286/zarrin
            [npcKeys.questEnds_add] = {96634},
        },
        [6287] = { -- Radnaal Maneweaver : https://wowhead.com/forever/npc=6287/radnaal-maneweaver
            [npcKeys.questEnds] = {97949},
        },
        [6289] = { -- Rand Rhobart : https://wowhead.com/forever/npc=6289/rand-rhobart
            [npcKeys.questEnds] = {97960},
        },
        [6290] = { -- Yonn Deepcut : https://wowhead.com/forever/npc=6290/yonn-deepcut
            [npcKeys.questEnds] = {97936},
        },
        [6291] = { -- Balthus Stoneflayer : https://wowhead.com/forever/npc=6291/balthus-stoneflayer
            [npcKeys.questEnds] = {96056},
        },
        [6297] = { -- Kurdram Stonehammer : https://wowhead.com/forever/npc=6297/kurdram-stonehammer
            [npcKeys.questEnds] = {97948},
        },
        [6301] = { -- Gorbold Steelhand : https://wowhead.com/forever/npc=6301/gorbold-steelhand
            [npcKeys.questEnds_add] = {97894},
        },
        [6306] = { -- Helene Peltskinner : https://wowhead.com/forever/npc=6306/helene-peltskinner
            [npcKeys.questStarts] = {91751},
            [npcKeys.questEnds] = {91746, 91751, 97924},
        },
        [6626] = { -- "Plucky" Johnson : https://wowhead.com/forever/npc=6626/plucky-johnson
            [npcKeys.questEnds] = {94227},
        },
        [6786] = { -- Ukor : https://wowhead.com/forever/npc=6786/ukor
            [npcKeys.questEnds] = {96876},
        },
        [7088] = { -- Thuwd : https://wowhead.com/forever/npc=7088/thuwd
            [npcKeys.questEnds] = {97908},
        },
        [7161] = { -- Wrenix the Wretched : https://wowhead.com/forever/npc=7161/wrenix-the-wretched
            [npcKeys.questStarts_add] = {97253},
            [npcKeys.questEnds_add] = {97253},
        },
        [7232] = { -- Borgus Steelhand : https://wowhead.com/forever/npc=7232/borgus-steelhand
            [npcKeys.questStarts] = {97894},
        },
        [7316] = { -- Sister Aquinne : https://wowhead.com/forever/npc=7316/sister-aquinne
            [npcKeys.questEnds] = {98391},
        },
        [7683] = { -- Alessandro Luca : https://wowhead.com/forever/npc=7683/alessandro-luca
            [npcKeys.questStarts_add] = {97891},
        },
        [7825] = { -- Oran Snakewrithe : https://wowhead.com/forever/npc=7825/oran-snakewrithe
            [npcKeys.questEnds_add] = {95204},
        },
        [7853] = { -- Scooty : https://wowhead.com/forever/npc=7853/scooty
            [npcKeys.questEnds_add] = {94235},
        },
        [7953] = { -- Xar'Ti : https://wowhead.com/forever/npc=7953/xarti
            [npcKeys.questStarts] = {97223},
            [npcKeys.questEnds] = {97223},
        },
        [7999] = { -- Tyrande Whisperwind : https://wowhead.com/forever/npc=7999/tyrande-whisperwind
            [npcKeys.questEnds_add] = {98065},
        },
        [8396] = { -- Sentinel Dalia Sunblade : https://wowhead.com/forever/npc=8396/sentinel-dalia-sunblade
            [npcKeys.questStarts] = {98067},
            [npcKeys.questEnds] = {98067},
        },
        [8508] = { -- Gretta Ganter : https://wowhead.com/forever/npc=8508/gretta-ganter
            [npcKeys.questStarts] = {98326},
            [npcKeys.questEnds] = {98326},
        },
        [10181] = { -- Lady Sylvanas Windrunner : https://wowhead.com/forever/npc=10181/lady-sylvanas-windrunner
            [npcKeys.questEnds] = {95803},
        },
        [10219] = { -- Gwennyth Bly'Leggonde : https://wowhead.com/forever/npc=10219/gwennyth-blyleggonde
            [npcKeys.questStarts_add] = {87760},
            [npcKeys.questEnds_add] = {87760},
        },
        [10266] = { -- Ug'thok : https://wowhead.com/forever/npc=10266/ugthok
            [npcKeys.questStarts] = {96874},
            [npcKeys.questEnds] = {96874},
        },
        [10278] = { -- Thrag Stonehoof : https://wowhead.com/forever/npc=10278/thrag-stonehoof
            [npcKeys.questEnds] = {97928},
        },
        [10665] = { -- Junior Apothecary Holland : https://wowhead.com/forever/npc=10665/junior-apothecary-holland
            [npcKeys.questStarts_add] = {99142},
            [npcKeys.questEnds_add] = {99142},
        },
        [11025] = { -- Mukdrak : https://wowhead.com/forever/npc=11025/mukdrak
            [npcKeys.questEnds] = {97902},
        },
        [11026] = { -- Sprite Jumpsprocket : https://wowhead.com/forever/npc=11026/sprite-jumpsprocket
            [npcKeys.questStarts] = {92749, 92750, 92752},
            [npcKeys.questEnds] = {92748, 92749, 92751, 97918},
        },
        [11028] = { -- Jemma Quikswitch : https://wowhead.com/forever/npc=11028/jemma-quikswitch
            [npcKeys.questStarts] = {95041},
            [npcKeys.questEnds] = {95041},
        },
        [11037] = { -- Jenna Lemkenilli : https://wowhead.com/forever/npc=11037/jenna-lemkenilli
            [npcKeys.questEnds] = {97941},
        },
        [11044] = { -- Doctor Martin Felben : https://wowhead.com/forever/npc=11044/doctor-martin-felben
            [npcKeys.questEnds] = {97891},
        },
        [11046] = { -- Whuut : https://wowhead.com/forever/npc=11046/whuut
            [npcKeys.questEnds] = {97275, 97899},
        },
        [11047] = { -- Kray : https://wowhead.com/forever/npc=11047/kray
            [npcKeys.questEnds] = {97927},
        },
        [11050] = { -- Trianna : https://wowhead.com/forever/npc=11050/trianna
            [npcKeys.questEnds] = {97950},
        },
        [11065] = { -- Thonys Pillarstone : https://wowhead.com/forever/npc=11065/thonys-pillarstone
            [npcKeys.questStarts] = {96059},
            [npcKeys.questEnds] = {96059},
        },
        [11066] = { -- Jhag : https://wowhead.com/forever/npc=11066/jhag
            [npcKeys.questEnds] = {97901},
        },
        [11068] = { -- Betty Quin : https://wowhead.com/forever/npc=11068/betty-quin
            [npcKeys.questEnds] = {97917},
        },
        [11072] = { -- Kitta Firewind : https://wowhead.com/forever/npc=11072/kitta-firewind
            [npcKeys.questStarts] = {91753},
            [npcKeys.questEnds] = {91753},
        },
        [11802] = { -- Dendrite Starblaze : https://wowhead.com/forever/npc=11802/dendrite-starblaze
            [npcKeys.questStarts_add] = {98341, 98362, 98394, 98397, 98405},
            [npcKeys.questEnds_add] = {94913, 94914, 98340, 98393, 98731, 98738, 98739},
        },
        [11835] = { -- Theodore Griffs : https://wowhead.com/forever/npc=11835/theodore-griffs
            [npcKeys.questStarts] = {95216},
            [npcKeys.questEnds] = {95216},
        },
        [11860] = { -- Maggran Earthbinder : https://wowhead.com/forever/npc=11860/maggran-earthbinder
            [npcKeys.questStarts_add] = {86576},
        },
        [11957] = { -- Great Cat Spirit : https://wowhead.com/forever/npc=11957/great-cat-spirit
            [npcKeys.questStarts] = {98342, 98396, 98731, 98739},
            [npcKeys.questEnds] = {98342, 98394, 98396, 98405},
        },
        [14450] = { -- Orphan Matron Nightingale : https://wowhead.com/forever/npc=14450/orphan-matron-nightingale
            [npcKeys.questStarts_add] = {95161},
            [npcKeys.questEnds_add] = {92415},
        },
        [14508] = { -- Short John Mithril : https://wowhead.com/forever/npc=14508/short-john-mithril
            [npcKeys.questEnds_add] = {94217},
        },
        [15906] = { -- Ironforge Reveler : https://wowhead.com/forever/npc=15906/ironforge-reveler
            [npcKeys.maxLevel] = 59,
        },
        [15991] = { -- Lady Dena Kennedy : https://wowhead.com/forever/npc=15991/lady-dena-kennedy
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.questEnds] = {95189},
        },
        [20735] = { -- Archmage Lan'dalock : https://wowhead.com/forever/npc=20735/archmage-landalock
            [npcKeys.name] = "Archmage Lan'dalock",
            [npcKeys.spawns] = {[36] = {{15.4, 74}, {15.6, 73.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [23909] = { -- Sinister Squashling : https://wowhead.com/forever/npc=23909/sinister-squashling
            [npcKeys.name] = "Sinister Squashling",
        },
        [28686] = { -- Caliel Brightwillow : https://wowhead.com/forever/npc=28686/caliel-brightwillow
            [npcKeys.name] = "Caliel Brightwillow",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{11.2, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [28687] = { -- Amisi Azuregaze : https://wowhead.com/forever/npc=28687/amisi-azuregaze
            [npcKeys.name] = "Amisi Azuregaze",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{18.2, 66.4}, {18.2, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [28694] = { -- Alard Schmied : https://wowhead.com/forever/npc=28694/alard-schmied
            [npcKeys.name] = "Alard Schmied",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{19.8, 63.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [28774] = { -- Andrew Matthews : https://wowhead.com/forever/npc=28774/andrew-matthews
            [npcKeys.name] = "Andrew Matthews",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[36] = {{15.8, 69}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [28776] = { -- Elizabeth Ross : https://wowhead.com/forever/npc=28776/elizabeth-ross
            [npcKeys.name] = "Elizabeth Ross",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{15.8, 69}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [28989] = { -- Aemara : https://wowhead.com/forever/npc=28989/aemara
            [npcKeys.name] = "Aemara",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{17.2, 71.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [28990] = { -- Anthony Durain : https://wowhead.com/forever/npc=28990/anthony-durain
            [npcKeys.name] = "Anthony Durain",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{20, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [29049] = { -- Arille Azuregaze : https://wowhead.com/forever/npc=29049/arille-azuregaze
            [npcKeys.name] = "Arille Azuregaze",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[36] = {{18.4, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [29491] = { -- Karandonna : https://wowhead.com/forever/npc=29491/karandonna
            [npcKeys.name] = "Karandonna",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{16, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [29512] = { -- Ainderu Summerleaf : https://wowhead.com/forever/npc=29512/ainderu-summerleaf
            [npcKeys.name] = "Ainderu Summerleaf",
            [npcKeys.spawns] = {[36] = {{17.4, 59.6}, {17.6, 59.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [29534] = { -- "Baroness" Llana : https://wowhead.com/forever/npc=29534/baroness-llana
            [npcKeys.name] = "\"Baroness\" Llana",
        },
        [29537] = { -- Darahir : https://wowhead.com/forever/npc=29537/darahir
            [npcKeys.name] = "Darahir",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{21.6, 69}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [29538] = { -- Hexil Garrot : https://wowhead.com/forever/npc=29538/hexil-garrot
            [npcKeys.name] = "Hexil Garrot",
            [npcKeys.spawns] = {[36] = {{14.8, 63.4}, {14.8, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [29547] = { -- Applebough : https://wowhead.com/forever/npc=29547/applebough
            [npcKeys.name] = "Applebough",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{14.4, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [29568] = { -- "Techs" Rickard Rustbolt : https://wowhead.com/forever/npc=29568/techs-rickard-rustbolt
            [npcKeys.name] = "\"Techs\" Rickard Rustbolt",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[36] = {{16.2, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [29660] = { -- Sai : https://wowhead.com/forever/npc=29660/sai
            [npcKeys.name] = "Sai",
            [npcKeys.spawns] = {[36] = {{17, 69.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [30104] = { -- Adamman the Trader : https://wowhead.com/forever/npc=30104/adamman-the-trader
            [npcKeys.name] = "Adamman the Trader",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{22, 68.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [30137] = { -- Shifty Vickers : https://wowhead.com/forever/npc=30137/shifty-vickers
            [npcKeys.name] = "Shifty Vickers",
            [npcKeys.spawns] = {[36] = {{14.4, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [30726] = { -- Archivist Betha : https://wowhead.com/forever/npc=30726/archivist-betha
            [npcKeys.name] = "Archivist Betha",
            [npcKeys.spawns] = {[36] = {{10, 63.4}, {10.4, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [30885] = { -- Blazik Fireclaw : https://wowhead.com/forever/npc=30885/blazik-fireclaw
            [npcKeys.name] = "Blazik Fireclaw",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{16, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [31439] = { -- Archmage Timear : https://wowhead.com/forever/npc=31439/archmage-timear
            [npcKeys.name] = "Archmage Timear",
            [npcKeys.spawns] = {[36] = {{15.4, 74}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32216] = { -- Mei Francis : https://wowhead.com/forever/npc=32216/mei-francis
            [npcKeys.name] = "Mei Francis",
        },
        [32287] = { -- Archmage Alvareaux : https://wowhead.com/forever/npc=32287/archmage-alvareaux
            [npcKeys.name] = "Archmage Alvareaux",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[36] = {{14, 63.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32330] = { -- Minzi the Minx : https://wowhead.com/forever/npc=32330/minzi-the-minx
            [npcKeys.name] = "Minzi the Minx",
            [npcKeys.spawns] = {[36] = {{17.6, 64.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32333] = { -- "Dapper" Danik Blackshaft : https://wowhead.com/forever/npc=32333/dapper-danik-blackshaft
            [npcKeys.name] = "\"Dapper\" Danik Blackshaft",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{16.2, 70.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32334] = { -- Nixi Fireclaw : https://wowhead.com/forever/npc=32334/nixi-fireclaw
            [npcKeys.name] = "Nixi Fireclaw",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{16.2, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32337] = { -- Christi Stockton : https://wowhead.com/forever/npc=32337/christi-stockton
            [npcKeys.name] = "Christi Stockton",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{19.8, 67.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32403] = { -- Sandra Bartan : https://wowhead.com/forever/npc=32403/sandra-bartan
            [npcKeys.name] = "Sandra Bartan",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{18, 65.2}, {18, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32411] = { -- Afsaneh Asrar : https://wowhead.com/forever/npc=32411/afsaneh-asrar
            [npcKeys.name] = "Afsaneh Asrar",
            [npcKeys.spawns] = {[36] = {{18, 66.6}, {18.4, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32413] = { -- Isirami Fairwind : https://wowhead.com/forever/npc=32413/isirami-fairwind
            [npcKeys.name] = "Isirami Fairwind",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{12.2, 66.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32424] = { -- Laire Brewgold : https://wowhead.com/forever/npc=32424/laire-brewgold
            [npcKeys.name] = "Laire Brewgold",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{10, 66.6}, {10.4, 66.4}, {10.8, 66.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32425] = { -- Galkara the Assassin : https://wowhead.com/forever/npc=32425/galkara-the-assassin
            [npcKeys.name] = "Galkara the Assassin",
        },
        [32426] = { -- Coira Longrifle : https://wowhead.com/forever/npc=32426/coira-longrifle
            [npcKeys.name] = "Coira Longrifle",
            [npcKeys.spawns] = {[36] = {{10.2, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32451] = { -- Dalaran Citizen : https://wowhead.com/forever/npc=32451/dalaran-citizen
            [npcKeys.name] = "Dalaran Citizen",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{15.6, 63.2}, {16.6, 63.6}, {18.4, 65.8}, {18.6, 65.8}, {20, 66.2}, {20.6, 61.8}, {22.2, 65}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32453] = { -- Dalaran Citizen : https://wowhead.com/forever/npc=32453/dalaran-citizen
            [npcKeys.name] = "Dalaran Citizen",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{15.6, 63.2}, {16.8, 63.6}, {17, 66.6}, {18.4, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32454] = { -- Dalaran Citizen : https://wowhead.com/forever/npc=32454/dalaran-citizen
            [npcKeys.name] = "Dalaran Citizen",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{10.4, 66.4}, {11, 68.6}, {13, 66.6}, {18.4, 65.4}, {20, 73.8}, {21.2, 65.2}, {22.6, 65}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32494] = { -- Dalaran Child : https://wowhead.com/forever/npc=32494/dalaran-child
            [npcKeys.name] = "Dalaran Child",
        },
        [32604] = { -- Seiren : https://wowhead.com/forever/npc=32604/seiren
            [npcKeys.name] = "Seiren",
        },
        [32631] = { -- Alfred Copperworth : https://wowhead.com/forever/npc=32631/alfred-copperworth
            [npcKeys.name] = "Alfred Copperworth",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{15, 57}, {15.2, 54.8}, {15.2, 56.4}, {15.8, 55.4}, {15.8, 56.4}, {15.8, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32668] = { -- Emi : https://wowhead.com/forever/npc=32668/emi
            [npcKeys.name] = "Emi",
        },
        [32669] = { -- Colin : https://wowhead.com/forever/npc=32669/colin
            [npcKeys.name] = "Colin",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32679] = { -- Darthalia Ebonscorch : https://wowhead.com/forever/npc=32679/darthalia-ebonscorch
            [npcKeys.name] = "Darthalia Ebonscorch",
            [npcKeys.spawns] = {[36] = {{18.6, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32685] = { -- Kitz Proudbreeze : https://wowhead.com/forever/npc=32685/kitz-proudbreeze
            [npcKeys.name] = "Kitz Proudbreeze",
            [npcKeys.spawns] = {[36] = {{17, 64}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32688] = { -- Archmage Tenaj : https://wowhead.com/forever/npc=32688/archmage-tenaj
            [npcKeys.name] = "Archmage Tenaj",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{17.6, 69.4}, {17.6, 69.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32708] = { -- Narestel Palestar : https://wowhead.com/forever/npc=32708/narestel-palestar
            [npcKeys.name] = "Narestel Palestar",
        },
        [32714] = { -- Moon Priestess Nici : https://wowhead.com/forever/npc=32714/moon-priestess-nici
            [npcKeys.name] = "Moon Priestess Nici",
        },
        [32716] = { -- Linzi Redgrin : https://wowhead.com/forever/npc=32716/linzi-redgrin
            [npcKeys.name] = "Linzi Redgrin",
        },
        [32728] = { -- Illusionist Karina : https://wowhead.com/forever/npc=32728/illusionist-karina
            [npcKeys.name] = "Illusionist Karina",
            [npcKeys.spawns] = {[36] = {{15, 59.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32735] = { -- Alchemist Burroughs : https://wowhead.com/forever/npc=32735/alchemist-burroughs
            [npcKeys.name] = "Alchemist Burroughs",
            [npcKeys.spawns] = {[36] = {{18, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32737] = { -- Archmage John Nicholas : https://wowhead.com/forever/npc=32737/archmage-john-nicholas
            [npcKeys.name] = "Archmage John Nicholas",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[36] = {{15.4, 55.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32738] = { -- Kat Sunflower : https://wowhead.com/forever/npc=32738/kat-sunflower
            [npcKeys.name] = "Kat Sunflower",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{15.2, 57.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32739] = { -- Baroness Zildjia : https://wowhead.com/forever/npc=32739/baroness-zildjia
            [npcKeys.name] = "Baroness Zildjia",
            [npcKeys.spawns] = {[36] = {{18.4, 65.4}, {18.4, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32740] = { -- Archmage Rheaume : https://wowhead.com/forever/npc=32740/archmage-rheaume
            [npcKeys.name] = "Archmage Rheaume",
            [npcKeys.spawns] = {[36] = {{18, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32741] = { -- Conjurer Weinhaus : https://wowhead.com/forever/npc=32741/conjurer-weinhaus
            [npcKeys.name] = "Conjurer Weinhaus",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{16, 56.2}, {16, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [32744] = { -- Bakor the Gangly : https://wowhead.com/forever/npc=32744/bakor-the-gangly
            [npcKeys.name] = "Bakor the Gangly",
            [npcKeys.spawns] = {[36] = {{17.2, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32745] = { -- Amera Sky : https://wowhead.com/forever/npc=32745/amera-sky
            [npcKeys.name] = "Amera Sky",
        },
        [32746] = { -- Geffon the Unruly : https://wowhead.com/forever/npc=32746/geffon-the-unruly
            [npcKeys.name] = "Geffon the Unruly",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{18.8, 67.2}, {20, 67.6}, {20.6, 68}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32747] = { -- Mendez Nightshadow : https://wowhead.com/forever/npc=32747/mendez-nightshadow
            [npcKeys.name] = "Mendez Nightshadow",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [32748] = { -- Bimble Sparkfingers : https://wowhead.com/forever/npc=32748/bimble-sparkfingers
            [npcKeys.name] = "Bimble Sparkfingers",
            [npcKeys.spawns] = {[36] = {{17.2, 67.6}, {17.6, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [34365] = { -- Orphan Matron Aria : https://wowhead.com/forever/npc=34365/orphan-matron-aria
            [npcKeys.name] = "Orphan Matron Aria",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[36] = {{21.6, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [35826] = { -- Kaye Toogie : https://wowhead.com/forever/npc=35826/kaye-toogie
            [npcKeys.name] = "Kaye Toogie",
            [npcKeys.spawns] = {[36] = {{14.4, 64.6}, {14.6, 64.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [36856] = { -- Shandy Glossgleam : https://wowhead.com/forever/npc=36856/shandy-glossgleam
            [npcKeys.name] = "Shandy Glossgleam",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [40833] = { -- Tiala Whitemane : https://wowhead.com/forever/npc=40833/tiala-whitemane
            [npcKeys.name] = "Tiala Whitemane",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{68.8, 50.4}, {68.8, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [41861] = { -- Fayran Elthas : https://wowhead.com/forever/npc=41861/fayran-elthas
            [npcKeys.name] = "Fayran Elthas",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{68.6, 44}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [41938] = { -- Tremor Totem : https://wowhead.com/forever/npc=41938/tremor-totem
            [npcKeys.name] = "Tremor Totem",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.friendlyToFaction] = "A",
        },
        [41940] = { -- Windfury Totem : https://wowhead.com/forever/npc=41940/windfury-totem
            [npcKeys.name] = "Windfury Totem",
        },
        [42604] = { -- Elemental Resistance Totem : https://wowhead.com/forever/npc=42604/elemental-resistance-totem
            [npcKeys.name] = "Elemental Resistance Totem",
        },
        [42605] = { -- Flametongue Totem : https://wowhead.com/forever/npc=42605/flametongue-totem
            [npcKeys.name] = "Flametongue Totem",
        },
        [43408] = { -- Aili Greenwillow : https://wowhead.com/forever/npc=43408/aili-greenwillow
            [npcKeys.name] = "Aili Greenwillow",
            [npcKeys.spawns] = {[616] = {{70.4, 49.8}, {70.6, 49.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [43411] = { -- Lenedil Moonwing : https://wowhead.com/forever/npc=43411/lenedil-moonwing
            [npcKeys.name] = "Lenedil Moonwing",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{70.8, 50.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [49808] = { -- Grenhild Darktalon : https://wowhead.com/forever/npc=49808/grenhild-darktalon
            [npcKeys.name] = "Grenhild Darktalon",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[38] = {{36.4, 48.2}, {36.6, 48.4}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [npcKeys.questStarts] = {86667},
            [npcKeys.friendlyToFaction] = "A",
        },
        [55571] = { -- Lunar Lantern : https://wowhead.com/forever/npc=55571/lunar-lantern
            [npcKeys.name] = "Lunar Lantern",
        },
        [55574] = { -- Festival Lantern : https://wowhead.com/forever/npc=55574/festival-lantern
            [npcKeys.name] = "Festival Lantern",
        },
        [165189] = { -- Generic Hunter Pet : https://wowhead.com/forever/npc=165189/generic-hunter-pet
            [npcKeys.name] = "Generic Hunter Pet",
        },
        [167875] = { -- RTC Player Dummy : https://wowhead.com/forever/npc=167875/rtc-player-dummy
            [npcKeys.name] = "RTC Player Dummy",
        },
        [184157] = { -- Apprentice Watcher : https://wowhead.com/forever/npc=184157/apprentice-watcher
            [npcKeys.name] = "Apprentice Watcher",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1537] = {{75.4, 9.4}, {75.4, 9.6}, {75.6, 9.6}, {75.8, 8.6}, {76, 8.4}, {76.6, 9.6}}, [1657] = {{37.4, 81.6}, {38, 80.4}, {38, 80.6}, {38.2, 79.4}, {38.4, 81.8}, {38.6, 80.4}, {38.6, 80.6}, {38.6, 81.6}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [202093] = { -- Polymorphed Apprentice : https://wowhead.com/forever/npc=202093/polymorphed-apprentice
            [npcKeys.name] = "Polymorphed Apprentice",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[12] = {{28.6, 83.2}, {29.4, 84}, {29.6, 84}, {30.8, 90.2}, {31, 68.4}, {31, 90.6}, {31.2, 68.8}, {34.4, 83.2}, {34.8, 82.2}, {34.8, 83}, {37.4, 77.2}, {37.8, 77.6}, {38, 77}, {40.4, 89.8}, {40.6, 89.4}, {40.8, 90}, {44.4, 56.4}, {44.4, 56.6}, {44.4, 57.6}, {44.6, 56.6}, {44.8, 56.2}, {46, 86.4}, {46, 87}, {46.2, 70.4}, {46.4, 71}, {46.6, 70.2}, {46.8, 70.6}, {48.8, 81}, {48.8, 81.8}, {49.2, 73.4}, {49.4, 73.6}, {49.8, 73.4}, {49.8, 73.6}, {56.2, 81}, {56.6, 80.4}, {56.6, 81}, {58.6, 60.2}, {61.4, 77}, {61.6, 77}, {61.6, 77.6}, {62.8, 63}, {62.8, 63.6}, {63.2, 62.2}, {66.8, 81.4}, {67, 82.2}, {70, 75.4}, {70, 76.2}, {70.4, 63.4}, {70.4, 63.8}, {77.4, 40}, {77.6, 39.8}, {79.4, 64.2}, {79.4, 78.8}, {79.6, 64.2}, {79.8, 64.6}, {80.4, 50.2}, {80.6, 50.4}, {80.6, 50.6}, {82.6, 86.2}, {82.8, 70.6}, {83, 70.4}, {84, 83.4}, {85.8, 65.2}, {86, 66.2}, {87, 82.2}, {90.2, 77.2}, {90.6, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [202116] = { -- Cut-throat Mugger : https://wowhead.com/forever/npc=202116/cut-throat-mugger
            [npcKeys.name] = "Cut-throat Mugger",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[1537] = {{44, 11}, {47.4, 12.6}, {49.2, 12.6}, {50.4, 11.6}, {51.2, 12.6}, {51.4, 10.6}, {51.4, 11.8}, {51.8, 12.4}, {51.8, 12.6}, {51.8, 13.6}, {52, 10.6}, {52.6, 9.6}, {52.8, 9}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [203079] = { -- Wandering Swordsman : https://wowhead.com/forever/npc=203079/wandering-swordsman
            [npcKeys.name] = "Wandering Swordsman",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[1] = {{53.4, 47.4}, {53.4, 47.8}, {53.6, 47.4}, {53.6, 47.6}}, [12] = {{22.2, 73.4}, {22.4, 73.6}, {22.6, 73.2}, {25.2, 70}, {25.6, 69.8}, {30, 73}, {36, 80.4}, {36, 80.6}, {38.4, 75.4}, {38.4, 75.6}, {38.6, 75.4}, {38.6, 75.6}, {40.8, 74.6}, {41, 74.4}}, [14] = {{36, 47.4}, {36, 48}, {41, 49.4}, {41, 49.6}, {55.8, 38.4}, {55.8, 38.6}, {56.4, 21.4}, {56.4, 27}, {56.6, 21.4}, {56.6, 21.6}}, [85] = {{78.2, 63.4}, {78.4, 65}, {79.4, 64.4}, {79.4, 64.8}, {79.6, 64.4}, {79.6, 65.2}}, [141] = {{39.6, 37.6}, {39.8, 37.4}, {39.8, 69.4}, {39.8, 69.6}, {43.8, 77}, {54.8, 66}, {62.4, 71.8}, {62.6, 71.8}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [203139] = { -- Son of Arugal : https://wowhead.com/forever/npc=203139/son-of-arugal
            [npcKeys.name] = "Son of Arugal",
            [npcKeys.minLevel] = 24,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[130] = {{32.6, 15.4}, {35, 16.8}, {35.2, 16.2}, {35.4, 18.4}, {35.4, 19.2}, {35.4, 19.8}, {35.6, 15.8}, {35.6, 18.8}, {36, 18}, {36.2, 19.8}, {36.2, 22.2}, {36.2, 23.6}, {36.2, 28.6}, {36.4, 15.2}, {36.4, 16.6}, {36.4, 20.6}, {36.4, 24.8}, {36.6, 20.2}, {36.8, 21.2}, {36.8, 25.8}, {36.8, 27.8}, {37, 14.8}, {37, 16}, {37, 16.8}, {37, 26.6}, {37.4, 24}, {37.4, 25.2}, {37.6, 15.8}, {37.6, 23.2}, {37.6, 24.6}, {37.8, 25.8}, {38, 14.2}, {38, 24}, {38, 28}, {38.2, 16.8}, {38.2, 21}, {38.4, 15.2}, {38.6, 17.8}, {38.8, 14.8}, {38.8, 27.2}, {38.8, 31.6}, {39, 15.6}, {39, 17.2}, {39, 28}, {39.2, 14.2}, {39.2, 26}, {39.4, 29.8}, {39.6, 25}, {39.6, 25.6}, {39.8, 15.4}, {39.8, 27}, {39.8, 30}, {40, 16.4}, {40, 18.4}, {40, 28.2}, {40.2, 30.8}, {40.4, 16.6}, {40.4, 29.2}, {40.6, 18.4}, {40.6, 30}, {40.8, 17.2}, {41, 19.4}, {41, 19.6}, {41.2, 29.4}, {41.2, 30.8}, {41.6, 17.2}, {41.6, 18.2}, {41.6, 21.6}, {41.8, 20}, {41.8, 29.8}, {42, 30.6}, {42.2, 20.8}, {42.4, 18.8}, {42.6, 21.4}, {43, 20.4}, {43, 22}, {43, 29.4}, {43.2, 28.2}, {43.4, 19}, {43.4, 30.4}, {43.6, 19}, {43.6, 21.4}, {43.6, 21.8}, {43.6, 28}, {43.6, 29.6}, {43.6, 79.6}, {44.2, 29.2}, {44.2, 77}, {44.2, 78.4}, {44.2, 79.4}, {44.4, 16}, {44.4, 18.2}, {44.4, 19.8}, {44.4, 31}, {44.4, 31.8}, {44.6, 29.2}, {44.6, 79.6}, {44.8, 17.8}, {44.8, 20.8}, {45, 29.8}, {45, 30.6}, {45, 68}, {45, 81.6}, {45.2, 17}, {45.2, 81.2}, {45.2, 83}, {45.4, 19}, {45.4, 27}, {45.4, 28.2}, {45.4, 33.2}, {45.4, 34.2}, {45.4, 76.2}, {45.4, 79.2}, {45.6, 16.8}, {45.6, 29.2}, {45.6, 41.6}, {45.6, 82}, {45.6, 83.4}, {45.6, 84.6}, {45.8, 21.4}, {45.8, 29.8}, {46, 17.6}, {46, 27.4}, {46, 28.2}, {46, 79}, {46, 83.6}, {46.2, 18.8}, {46.2, 33.4}, {46.4, 26.2}, {46.4, 32.2}, {46.4, 33.6}, {46.6, 18}, {46.6, 19.4}, {46.6, 25.2}, {46.6, 81.2}, {46.6, 83.6}, {46.8, 17.4}, {46.8, 25.6}, {46.8, 76}, {47, 26.8}, {47, 83.4}, {47.2, 19.8}, {47.2, 32.2}, {47.2, 82.4}, {47.2, 84.8}, {47.4, 20.8}, {47.4, 33}, {47.4, 33.8}, {47.4, 34.6}, {47.4, 77}, {47.6, 17}, {47.6, 33.2}, {47.6, 34}, {47.8, 19}, {47.8, 31.4}, {47.8, 34.6}, {47.8, 81.6}, {47.8, 83.4}, {48, 19.6}, {48, 21.8}, {48, 32.2}, {48, 83.8}, {48, 84.6}, {48.2, 26}, {48.2, 38.4}, {48.2, 77.2}, {48.4, 20.8}, {48.4, 25.4}, {48.4, 75.2}, {48.4, 79.4}, {48.6, 20}, {48.6, 33.8}, {48.6, 34.8}, {48.6, 37.8}, {48.6, 38.8}, {48.8, 26.6}, {48.8, 31}, {48.8, 32.8}, {48.8, 72.4}, {48.8, 75.6}, {48.8, 82.2}, {48.8, 82.6}, {48.8, 85.6}, {49, 18.8}, {49, 26.2}, {49, 32.2}, {49.2, 20.8}, {49.2, 22.6}, {49.2, 24.2}, {49.2, 25.4}, {49.2, 37.2}, {49.2, 75.2}, {49.2, 77.4}, {49.2, 80}, {49.4, 36.4}, {49.4, 84}, {49.6, 24.4}, {49.6, 26.4}, {49.6, 29.6}, {49.6, 33.4}, {49.6, 82.4}, {49.6, 83.6}, {49.8, 17.2}, {49.8, 33.6}, {49.8, 76.4}, {49.8, 83.2}, {50, 25}, {50.2, 22.6}, {50.2, 74.2}, {50.2, 74.8}, {50.2, 79}, {50.2, 81}, {50.4, 36.6}, {50.6, 34.8}, {50.6, 35.8}, {50.6, 74}, {50.8, 72}, {50.8, 75}, {50.8, 79.2}, {51, 78.4}, {51.4, 36.8}, {51.4, 72.8}, {51.6, 73}, {51.6, 77.6}, {52, 37.8}, {52, 72}, {52, 75.4}, {52.2, 74.2}, {52.2, 77.4}, {52.4, 76.2}, {52.6, 73.4}, {52.8, 74.2}, {52.8, 74.8}, {52.8, 76.4}, {53.4, 72.4}, {53.4, 76.6}, {53.6, 75.8}, {54, 74.6}, {58.8, 11.8}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [203475] = { -- Liv Bradford : https://wowhead.com/forever/npc=203475/liv-bradford
            [npcKeys.name] = "Liv Bradford",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [203478] = { -- Stuart : https://wowhead.com/forever/npc=203478/stuart
            [npcKeys.name] = "Stuart",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [204070] = { -- Soboz : https://wowhead.com/forever/npc=204070/soboz
            [npcKeys.name] = "Soboz",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{42.2, 35.4}, {42.2, 35.6}}, [14] = {{67.4, 87.8}, {67.6, 87.8}}, [1497] = {{22.2, 41.8}, {22.6, 43.2}, {23.2, 39.6}, {23.2, 42.2}, {23.4, 41.4}, {23.6, 40.4}, {23.8, 39.4}, {24, 41.4}, {24, 41.6}}},
        },
        [204827] = { -- Adventurer's Remains : https://wowhead.com/forever/npc=204827/adventurers-remains
            [npcKeys.name] = "Adventurer's Remains",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1] = {{43, 49.4}, {43, 49.6}}, [12] = {{52.2, 84.4}, {52.2, 84.6}}, [14] = {{48, 79.4}, {48, 79.6}}, [141] = {{33.4, 35.6}, {33.6, 35.4}, {33.6, 35.6}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [204937] = { -- Adventurer's Spirit : https://wowhead.com/forever/npc=204937/adventurers-spirit
            [npcKeys.name] = "Adventurer's Spirit",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1] = {{43, 49.4}, {43, 49.6}}, [12] = {{52.2, 84.4}, {52.2, 84.6}}, [14] = {{48, 79.4}, {48, 79.6}}, [141] = {{33.4, 35.6}, {33.6, 35.4}, {33.6, 35.6}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [205700] = { -- Venture Co. Poacher : https://wowhead.com/forever/npc=205700/venture-co-poacher
            [npcKeys.name] = "Venture Co. Poacher",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 7,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [205729] = { -- Boarton Shadetotem : https://wowhead.com/forever/npc=205729/boarton-shadetotem
            [npcKeys.name] = "Boarton Shadetotem",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1638] = {{39.4, 64.4}, {39.4, 65.4}, {39.4, 65.6}, {39.6, 64.4}, {39.6, 65.4}, {39.6, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [npcKeys.questStarts] = {76156, 76160, 76240},
            [npcKeys.questEnds] = {76156, 76160, 76240},
            [npcKeys.friendlyToFaction] = "H",
        },
        [208023] = { -- Gru'ark : https://wowhead.com/forever/npc=208023/gruark
            [npcKeys.name] = "Gru'ark",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[1637] = {{58.2, 51.2}, {58.4, 50.2}, {58.4, 52}, {58.6, 51.4}, {58.6, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [208124] = { -- Raluk : https://wowhead.com/forever/npc=208124/raluk
            [npcKeys.name] = "Raluk",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[14] = {{68.4, 71.4}, {68.4, 71.6}, {68.6, 71.4}, {68.6, 71.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [208180] = { -- Razormane Poacher : https://wowhead.com/forever/npc=208180/razormane-poacher
            [npcKeys.name] = "Razormane Poacher",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{28.8, 49.8}, {29, 49.4}}, [14] = {{40.4, 51.4}, {40.4, 52}, {40.6, 52}}},
        },
        [208196] = { -- Gillgar : https://wowhead.com/forever/npc=208196/gillgar
            [npcKeys.name] = "Gillgar",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[85] = {{25.2, 49}, {25.4, 47.4}, {25.4, 48.2}, {25.6, 48.2}, {25.6, 48.6}, {26.2, 47}, {26.6, 46.8}, {27.2, 46.4}, {28, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [208226] = { -- Darmak Bloodhowl : https://wowhead.com/forever/npc=208226/darmak-bloodhowl
            [npcKeys.name] = "Darmak Bloodhowl",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[14] = {{54.4, 41.4}, {54.6, 41.4}, {54.6, 41.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [208518] = { -- Gaeriyan : https://wowhead.com/forever/npc=208518/gaeriyan
            [npcKeys.name] = "Gaeriyan",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[440] = {{54, 23.2}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [208565] = { -- Altar of the Light : https://wowhead.com/forever/npc=208565/altar-of-the-light
            [npcKeys.name] = "Altar of the Light",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1] = {{28.8, 66.4}, {28.8, 66.6}}, [38] = {{37.4, 46.2}, {37.6, 46.2}}, [40] = {{52.6, 52.4}, {52.8, 52.8}}, [1537] = {{31.2, 21.4}, {31.4, 20.4}, {31.4, 21.6}, {31.8, 22}, {32, 20.4}, {32, 20.6}, {32.2, 19.4}, {32.6, 19.8}, {32.6, 21.4}, {32.6, 21.6}, {32.8, 19}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [208712] = { -- Odd Melon : https://wowhead.com/forever/npc=208712/odd-melon
            [npcKeys.name] = "Odd Melon",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{30.2, 47.2}, {33.4, 49.4}, {33.4, 49.6}, {33.6, 49.4}, {33.6, 49.6}, {34.8, 51.2}, {35.4, 49}, {35.6, 49}, {36.4, 50.8}, {36.8, 51}, {40.2, 42}, {44.2, 38.4}, {45.2, 33.4}, {47.2, 50.4}, {47.2, 50.8}, {47.4, 28.6}, {49.4, 46.4}, {49.6, 46.4}, {49.6, 46.6}, {49.8, 59.4}, {50, 59.6}, {50.2, 50.8}, {50.4, 61.8}, {50.6, 31}, {51.4, 57.2}, {51.6, 57.2}, {52.8, 57.6}, {53.8, 58.6}, {53.8, 59.8}, {54, 28}, {54, 56.4}, {54, 56.8}, {54, 58.2}, {57.4, 40.4}, {57.4, 40.6}, {58.2, 35.4}, {58.6, 35.2}, {58.8, 58.4}, {58.8, 58.6}, {59.8, 33}, {60, 37}, {65.4, 62.6}, {72, 50.8}, {72.2, 50.4}, {75, 61.4}, {75.2, 61.6}, {76, 59.4}, {76, 59.6}, {76.2, 51.4}, {76.2, 51.8}, {76.4, 61.4}, {76.4, 61.8}, {76.6, 61.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [208752] = { -- Frozen Trogg : https://wowhead.com/forever/npc=208752/frozen-trogg
            [npcKeys.name] = "Frozen Trogg",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[1] = {{69.2, 58.2}, {69.4, 58.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [208812] = { -- Jorul : https://wowhead.com/forever/npc=208812/jorul
            [npcKeys.name] = "Jorul",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{35.4, 43.6}, {37.2, 42.4}, {37.4, 42.6}, {37.8, 42.4}, {38.4, 43.4}, {38.4, 43.6}, {38.6, 43.4}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [208845] = { -- Par'kourc : https://wowhead.com/forever/npc=208845/parkourc
            [npcKeys.name] = "Par'kourc",
            [npcKeys.minLevel] = 62,
            [npcKeys.maxLevel] = 62,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [208919] = { -- Blueheart : https://wowhead.com/forever/npc=208919/blueheart
            [npcKeys.name] = "Blueheart",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{61.6, 51.4}, {61.6, 52.8}, {61.8, 51.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [209004] = { -- Bruart : https://wowhead.com/forever/npc=209004/bruart
            [npcKeys.name] = "Bruart",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[1537] = {{71.2, 73.2}, {71.2, 74.8}, {72, 73.4}, {72, 75.2}, {72.2, 74}, {72.6, 74}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [209608] = { -- Delwynna : https://wowhead.com/forever/npc=209608/delwynna
            [npcKeys.name] = "Delwynna",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[1657] = {{63.2, 22}, {63.6, 22}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [209797] = { -- Bruuz : https://wowhead.com/forever/npc=209797/bruuz
            [npcKeys.name] = "Bruuz",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[17] = {{63.4, 38.8}, {64.2, 38.4}, {64.4, 39}, {64.4, 39.6}, {64.8, 39.8}, {65.2, 39.4}, {65.6, 39.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [209908] = { -- Heretic Idol : https://wowhead.com/forever/npc=209908/heretic-idol
            [npcKeys.name] = "Heretic Idol",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[38] = {{71.8, 27}, {71.8, 27.6}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [npcKeys.friendlyToFaction] = "A",
        },
        [209928] = { -- Mowgh : https://wowhead.com/forever/npc=209928/mowgh
            [npcKeys.name] = "Mowgh",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[141] = {{46.4, 32.6}, {47.2, 32.6}, {47.4, 32.4}, {47.6, 32.6}, {48, 31.6}, {48.2, 31.4}, {48.6, 31.4}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [209948] = { -- Relaeron : https://wowhead.com/forever/npc=209948/relaeron
            [npcKeys.name] = "Relaeron",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1657] = {{39, 8.4}, {39.2, 9}, {39.4, 9.6}, {39.6, 9.8}, {39.8, 9}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [209949] = { -- Sickly Deer : https://wowhead.com/forever/npc=209949/sickly-deer
            [npcKeys.name] = "Sickly Deer",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1657] = {{39.2, 9}, {39.4, 9.8}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [209958] = { -- Graix : https://wowhead.com/forever/npc=209958/graix
            [npcKeys.name] = "Graix",
            [npcKeys.minLevel] = 18,
            [npcKeys.maxLevel] = 18,
            [npcKeys.spawns] = {[38] = {{72.4, 68.8}, {72.6, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [210451] = { -- Lady Sedorax : https://wowhead.com/forever/npc=210451/lady-sedorax
            [npcKeys.name] = "Lady Sedorax",
            [npcKeys.minLevel] = 18,
            [npcKeys.maxLevel] = 18,
            [npcKeys.spawns] = {[148] = {{55.2, 35.2}, {55.4, 36.2}, {55.4, 36.8}, {55.6, 35.2}, {55.6, 36.4}, {55.6, 36.6}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [210487] = { -- Horror of the Deep : https://wowhead.com/forever/npc=210487/horror-of-the-deep
            [npcKeys.name] = "Horror of the Deep",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[40] = {{26, 69.4}, {26, 69.6}, {26.4, 66}, {26.8, 69}, {26.8, 69.8}}},
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [210549] = { -- Defias Scout : https://wowhead.com/forever/npc=210549/defias-scout
            [npcKeys.name] = "Defias Scout",
            [npcKeys.minLevel] = 14,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[40] = {{50.2, 48.2}, {50.2, 48.6}, {50.4, 47.4}, {50.6, 47.6}, {51, 47.2}, {51, 54.8}, {51.4, 55.6}, {51.6, 55.4}, {51.6, 55.6}}},
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
        },
        [210845] = { -- Jixo Madrocket : https://wowhead.com/forever/npc=210845/jixo-madrocket
            [npcKeys.name] = "Jixo Madrocket",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[406] = {{59.2, 62.4}, {59.2, 62.6}, {60.4, 62.2}, {60.6, 62.2}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [210887] = { -- Unsuspecting Pridewing : https://wowhead.com/forever/npc=210887/unsuspecting-pridewing
            [npcKeys.name] = "Unsuspecting Pridewing",
            [npcKeys.minLevel] = 19,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[406] = {{60.4, 62.2}, {60.6, 62.2}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [210995] = { -- Alonso : https://wowhead.com/forever/npc=210995/alonso
            [npcKeys.name] = "Alonso",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[331] = {{42, 69.2}, {42.4, 70}, {43.4, 70.4}, {43.4, 70.6}, {43.6, 70.4}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.questStarts] = {78132, 78133, 78134},
            [npcKeys.questEnds] = {78132, 78133, 78134},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [211022] = { -- Owen Thadd : https://wowhead.com/forever/npc=211022/owen-thadd
            [npcKeys.name] = "Owen Thadd",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[1497] = {{73.4, 33}, {73.6, 33}, {74, 32.4}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.questStarts] = {79095},
            [npcKeys.questEnds] = {78148, 79092, 79095, 79536, 97286},
            [npcKeys.friendlyToFaction] = "H",
        },
        [211033] = { -- Garion Wendell : https://wowhead.com/forever/npc=211033/garion-wendell
            [npcKeys.name] = "Garion Wendell",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.questStarts] = {78148, 79092, 79536, 97286},
            [npcKeys.questEnds] = {78148, 79092, 79536, 97286},
            [npcKeys.friendlyToFaction] = "A",
        },
        [211146] = { -- Lost Adventurer : https://wowhead.com/forever/npc=211146/lost-adventurer
            [npcKeys.name] = "Lost Adventurer",
            [npcKeys.minLevel] = 16,
            [npcKeys.maxLevel] = 16,
            [npcKeys.spawns] = {[130] = {{35, 7.6}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [211229] = { -- Dietrich Praice : https://wowhead.com/forever/npc=211229/dietrich-praice
            [npcKeys.name] = "Dietrich Praice",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1637] = {{35.4, 88}, {35.6, 88}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [211951] = { -- Koartul : https://wowhead.com/forever/npc=211951/koartul
            [npcKeys.name] = "Koartul",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[267] = {{60.2, 33.8}, {61, 33.2}, {61, 33.6}, {61.6, 33.8}, {61.8, 33.4}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [211956] = { -- Scarimous the Wandering : https://wowhead.com/forever/npc=211956/scarimous-the-wandering
            [npcKeys.name] = "Scarimous the Wandering",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{91.8, 35.2}}, [357] = {{51.6, 8.6}}},
        },
        [211965] = { -- Carrodin : https://wowhead.com/forever/npc=211965/carrodin
            [npcKeys.name] = "Carrodin",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[11] = {{46.4, 64.4}, {46.4, 65}, {46.8, 63.4}, {47.2, 64.4}, {47.2, 64.8}, {47.2, 65.6}, {47.6, 64}, {47.6, 64.8}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [212694] = { -- Hirzek : https://wowhead.com/forever/npc=212694/hirzek
            [npcKeys.name] = "Hirzek",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[17] = {{43.2, 78.4}, {43.2, 78.6}, {45.8, 76.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [212699] = { -- Silverwing Archer : https://wowhead.com/forever/npc=212699/silverwing-archer
            [npcKeys.name] = "Silverwing Archer",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{28.2, 27.4}, {28.2, 28.8}, {28.4, 28.2}, {28.6, 28.2}, {28.6, 28.8}, {51.2, 55.8}, {51.2, 56.6}, {51.4, 54.4}, {51.4, 54.8}, {51.6, 54.8}, {51.6, 55.6}, {51.8, 54.4}, {59, 72.6}, {59.4, 72.2}, {59.8, 71.8}, {59.8, 72.6}, {60, 71.4}, {60.6, 71.4}, {72.6, 72.4}, {72.8, 73.2}, {73, 74.8}, {73.4, 73.6}, {73.6, 73.6}, {74, 73.2}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [212703] = { -- Silverwing Dryad : https://wowhead.com/forever/npc=212703/silverwing-dryad
            [npcKeys.name] = "Silverwing Dryad",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{28.4, 27}, {28.4, 28.2}, {28.4, 28.6}, {28.6, 28}, {28.8, 28.8}, {51.2, 54.4}, {51.2, 55.6}, {51.4, 55.4}, {51.6, 54.8}, {51.8, 55.6}, {59.4, 73}, {59.8, 72.4}, {60, 71.4}, {60, 72.6}, {60.6, 71.4}, {73, 73}, {73.4, 73.6}, {73.6, 73.8}, {74, 73.4}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [212706] = { -- Silverwing Druid : https://wowhead.com/forever/npc=212706/silverwing-druid
            [npcKeys.name] = "Silverwing Druid",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{28.2, 27}, {28.4, 28.4}, {28.4, 28.6}, {28.6, 28.2}, {28.6, 28.6}, {51.2, 55}, {51.2, 56}, {51.4, 54.4}, {51.6, 54.4}, {51.6, 54.6}, {59.4, 72}, {60, 70.4}, {60, 71.4}, {60, 71.6}, {60, 72.6}, {72.8, 72.4}, {73, 73.2}, {73.2, 73.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [212707] = { -- Larodar : https://wowhead.com/forever/npc=212707/larodar
            [npcKeys.name] = "Larodar",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{51.2, 54.4}, {51.2, 56.6}, {51.4, 55}, {51.4, 55.6}, {51.6, 54.4}, {51.6, 54.8}, {51.6, 55.6}, {52.6, 54.2}, {53.2, 54.6}, {53.6, 54.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [212727] = { -- Warsong Grunt : https://wowhead.com/forever/npc=212727/warsong-grunt
            [npcKeys.name] = "Warsong Grunt",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{21.2, 36.4}, {21.2, 37.4}, {21.2, 37.8}, {21.6, 36.4}, {21.6, 37.4}, {21.8, 37.6}, {38.2, 68}, {38.4, 67.4}, {38.8, 66.4}, {39, 67.8}, {39.4, 66.8}, {39.6, 66.4}, {39.6, 66.6}, {53.2, 54.6}, {53.4, 54.4}, {53.6, 54.6}, {54.2, 54.4}, {54.8, 55}, {55.6, 55.4}, {69.2, 63.6}, {69.4, 63}, {69.6, 63}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212728] = { -- Warsong Raider : https://wowhead.com/forever/npc=212728/warsong-raider
            [npcKeys.name] = "Warsong Raider",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{21.2, 37.4}, {21.2, 37.8}, {21.4, 36.4}, {21.6, 36.4}, {21.6, 37.4}, {21.8, 37.6}, {38.2, 67.8}, {38.4, 67.2}, {39, 67.6}, {39.4, 66.2}, {39.4, 66.8}, {39.6, 66.4}, {39.6, 66.6}, {53.2, 54.4}, {53.4, 54.6}, {54, 54.6}, {54.2, 54.4}, {54.6, 54.4}, {54.6, 55}, {68.6, 63.6}, {69.4, 63}, {69.6, 63}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212729] = { -- Warsong Shaman : https://wowhead.com/forever/npc=212729/warsong-shaman
            [npcKeys.name] = "Warsong Shaman",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{20.2, 37}, {21.2, 36.6}, {21.4, 37.6}, {21.6, 36.4}, {21.6, 37}, {21.8, 37.6}, {38.2, 68}, {38.4, 67.2}, {39, 67.8}, {39.2, 67}, {39.6, 66.2}, {39.6, 67.4}, {39.6, 67.6}, {53, 54.4}, {53, 54.6}, {54.2, 54.4}, {54.2, 54.6}, {54.8, 55}, {69.4, 62.8}, {69.8, 63.2}, {70.6, 63.2}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212730] = { -- Tojara : https://wowhead.com/forever/npc=212730/tojara
            [npcKeys.name] = "Tojara",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{51.4, 54.4}, {51.4, 54.6}, {51.6, 54.4}, {51.6, 54.6}, {53, 54.4}, {53.4, 54.6}, {54.2, 53.2}, {54.2, 54.4}, {54.2, 54.6}, {54.6, 54.4}, {54.8, 55}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212753] = { -- Tortured Soul : https://wowhead.com/forever/npc=212753/tortured-soul
            [npcKeys.name] = "Tortured Soul",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[130] = {{44.2, 40.2}, {44.4, 42}, {44.4, 44}, {44.8, 42.4}, {45, 40.6}, {46, 39.6}, {46.4, 83.8}, {47.4, 83.8}, {49, 38.2}, {52.6, 55}, {53.8, 71.6}, {54.8, 70}, {57.2, 71}, {57.6, 71.4}, {58, 69.8}, {58.4, 72}, {58.6, 72}, {59, 70.8}, {59.4, 70.2}, {59.6, 70}, {59.8, 71}, {59.8, 75.4}, {60, 72}, {60.2, 74}, {60.4, 73.4}, {60.6, 72.4}, {60.6, 72.6}, {61, 74.8}, {62, 72.6}, {62.6, 73.8}, {63.6, 75.2}, {65.8, 80}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [212763] = { -- Sadistic Fiend : https://wowhead.com/forever/npc=212763/sadistic-fiend
            [npcKeys.name] = "Sadistic Fiend",
            [npcKeys.minLevel] = 19,
            [npcKeys.maxLevel] = 19,
            [npcKeys.spawns] = {[130] = {{58.2, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [212801] = { -- Jubei : https://wowhead.com/forever/npc=212801/jubei
            [npcKeys.name] = "Jubei",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{21.2, 36.4}, {21.2, 37.4}, {21.2, 37.6}, {21.2, 38.6}, {21.6, 36.4}, {21.6, 37.4}, {21.6, 37.6}, {21.8, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212802] = { -- Moogul the Sly : https://wowhead.com/forever/npc=212802/moogul-the-sly
            [npcKeys.name] = "Moogul the Sly",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{68.4, 63.4}, {68.4, 63.8}, {69, 63.6}, {69.4, 63}, {69.6, 63.2}, {69.6, 63.6}, {69.8, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212803] = { -- Ceredwyn : https://wowhead.com/forever/npc=212803/ceredwyn
            [npcKeys.name] = "Ceredwyn",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{72.4, 72.2}, {72.4, 72.6}, {72.8, 72.4}, {73.2, 73.4}, {73.2, 73.6}, {73.6, 73.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [212969] = { -- Kazragore : https://wowhead.com/forever/npc=212969/kazragore
            [npcKeys.name] = "Kazragore",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{37.8, 66.4}, {38.4, 66.8}, {38.4, 67.6}, {38.8, 66.4}, {39, 67.4}, {39, 68.6}, {39.2, 67.8}, {39.6, 66.4}, {39.6, 66.6}, {39.6, 67.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [212970] = { -- Felore Moonray : https://wowhead.com/forever/npc=212970/felore-moonray
            [npcKeys.name] = "Felore Moonray",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{60, 70.4}, {60, 71.4}, {60, 71.8}, {60, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [213077] = { -- Elaine Compton : https://wowhead.com/forever/npc=213077/elaine-compton
            [npcKeys.name] = "Elaine Compton",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [213795] = { -- Gharrik : https://wowhead.com/forever/npc=213795/gharrik
            [npcKeys.name] = "Gharrik",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[3] = {{22.4, 67.4}, {22.4, 67.6}, {22.6, 67.4}, {22.6, 67.6}, {23.4, 66.2}, {23.6, 66.4}}},
            [npcKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [214070] = { -- Jornah : https://wowhead.com/forever/npc=214070/jornah
            [npcKeys.name] = "Jornah",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1637] = {{51.4, 63.8}, {51.4, 64.6}, {51.6, 63.8}, {51.6, 64.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [214098] = { -- Gishah : https://wowhead.com/forever/npc=214098/gishah
            [npcKeys.name] = "Gishah",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1497] = {{64.4, 38.4}, {64.4, 38.6}, {64.6, 38.6}, {64.8, 38.2}, {65.6, 38.4}, {65.6, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.friendlyToFaction] = "H",
        },
        [214101] = { -- Marcy Baker : https://wowhead.com/forever/npc=214101/marcy-baker
            [npcKeys.name] = "Marcy Baker",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1657] = {{59.2, 56.6}, {59.4, 56}, {59.8, 56.4}, {59.8, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [214129] = { -- Venture Co. Light Shredder : https://wowhead.com/forever/npc=214129/venture-co-light-shredder
            [npcKeys.name] = "Venture Co. Light Shredder",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 21,
            [npcKeys.spawns] = {[406] = {{59.8, 51}, {59.8, 51.6}, {60, 54.4}, {60, 55}, {62, 53}, {62, 53.6}, {62.2, 52.4}, {62.6, 52.8}, {66.4, 47.4}, {66.4, 47.6}, {66.6, 47.4}, {66.6, 47.6}, {67.4, 57.4}, {67.4, 57.6}, {67.6, 57.4}, {67.6, 57.6}, {68.4, 47.8}, {68.6, 47.8}, {70, 55.6}, {70.2, 55.2}, {70.6, 55.4}, {70.8, 42}, {70.8, 49.2}, {72.4, 53.2}, {72.6, 52.4}, {72.6, 53}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [214519] = { -- Incinerator Gar'im : https://wowhead.com/forever/npc=214519/incinerator-garim
            [npcKeys.name] = "Incinerator Gar'im",
            [npcKeys.minLevel] = 23,
            [npcKeys.maxLevel] = 23,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [214529] = { -- Brave Stonetorch : https://wowhead.com/forever/npc=214529/brave-stonetorch
            [npcKeys.name] = "Brave Stonetorch",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[267] = {{65.8, 19.6}, {66, 19.2}, {67.2, 14.4}, {67.4, 14.8}, {67.6, 14.4}, {67.6, 14.6}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [215072] = { -- Loa Altar : https://wowhead.com/forever/npc=215072/loa-altar
            [npcKeys.name] = "Loa Altar",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[36] = {{79.8, 67}}, [331] = {{11.8, 35.2}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [215974] = { -- Des'Altek : https://wowhead.com/forever/npc=215974/desaltek
            [npcKeys.name] = "Des'Altek",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[405] = {{51.2, 82.4}, {51.2, 82.6}, {51.6, 83}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [216659] = { -- Fallenroot Satyr : https://wowhead.com/forever/npc=216659/fallenroot-satyr
            [npcKeys.name] = "Fallenroot Satyr",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{13.4, 12.2}, {13.4, 13.2}, {13.6, 11.8}, {13.6, 13.4}, {13.8, 10}, {13.8, 11.2}, {14.4, 9.4}, {14.8, 10.4}, {15, 10.6}, {15.8, 11.4}, {16.2, 11.6}, {16.6, 11}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [216661] = { -- Blackfathom Tide Priestess : https://wowhead.com/forever/npc=216661/blackfathom-tide-priestess
            [npcKeys.name] = "Blackfathom Tide Priestess",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{12.8, 10}, {13.4, 9.4}, {13.4, 12.2}, {13.4, 13.2}, {13.6, 11.8}, {13.6, 13.4}, {13.8, 9.2}, {13.8, 10}, {13.8, 11.2}, {14.6, 10}, {15, 10.6}, {15.8, 11.4}, {16.4, 11.6}, {17, 11.2}, {17.6, 11}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [216662] = { -- Blackfathom Oracle : https://wowhead.com/forever/npc=216662/blackfathom-oracle
            [npcKeys.name] = "Blackfathom Oracle",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{13.4, 9.4}, {13.6, 9.6}, {14.4, 9.4}, {14.6, 10}, {15.2, 10.8}, {15.6, 11.2}, {16.4, 11.6}, {16.6, 11}, {16.6, 11.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [216665] = { -- Gnomeregan Evacuee : https://wowhead.com/forever/npc=216665/gnomeregan-evacuee
            [npcKeys.name] = "Gnomeregan Evacuee",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[1] = {{24.4, 39.8}, {24.6, 39.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [216902] = { -- Wulmort Jinglepocket : https://wowhead.com/forever/npc=216902/wulmort-jinglepocket
            [npcKeys.name] = "Wulmort Jinglepocket",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1537] = {{32.4, 67.4}, {33, 68.6}, {33.4, 65.4}, {33.4, 66.4}, {33.4, 67}, {33.4, 67.6}, {33.6, 66}, {33.6, 66.8}, {33.6, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [217049] = { -- Mirror Image : https://wowhead.com/forever/npc=217049/mirror-image
            [npcKeys.name] = "Mirror Image",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{21.2, 36.4}, {21.4, 36.8}, {21.4, 37.6}, {21.6, 36.4}, {21.6, 37.4}, {21.6, 37.6}, {21.6, 38.6}, {51.4, 54.2}, {51.4, 54.8}, {51.6, 53.2}, {51.6, 54}, {51.6, 54.6}, {53, 54.6}, {53.2, 54.4}, {53.8, 54.6}, {54.2, 54}, {54.4, 53.4}, {54.8, 54.4}, {54.8, 54.8}, {69.2, 63.6}, {69.4, 63}, {69.6, 63}, {69.6, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [217302] = { -- Tam'kar : https://wowhead.com/forever/npc=217302/tamkar
            [npcKeys.name] = "Tam'kar",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 37,
            [npcKeys.spawns] = {[45] = {{33.4, 44.4}, {33.4, 44.6}, {33.6, 44.4}, {33.6, 44.6}, {33.8, 47.2}}},
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [217305] = { -- Ancient Fire Elemental : https://wowhead.com/forever/npc=217305/ancient-fire-elemental
            [npcKeys.name] = "Ancient Fire Elemental",
            [npcKeys.minLevel] = 34,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[36] = {{59.4, 46.4}, {60, 45.4}, {60, 45.6}, {60, 46.6}, {61.4, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [217392] = { -- Flameseer Dubelen : https://wowhead.com/forever/npc=217392/flameseer-dubelen
            [npcKeys.name] = "Flameseer Dubelen",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[405] = {{56.4, 21.4}, {56.4, 21.8}, {56.6, 20.4}, {56.6, 21.4}, {56.6, 21.8}, {58, 22.6}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [217412] = { -- Amaryllis Webb : https://wowhead.com/forever/npc=217412/amaryllis-webb
            [npcKeys.name] = "Amaryllis Webb",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[8] = {{25, 53.4}, {25, 54.2}, {25.2, 54.6}}},
            [npcKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [217418] = { -- Zai'enki : https://wowhead.com/forever/npc=217418/zaienki
            [npcKeys.name] = "Zai'enki",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[400] = {{68.4, 55.4}, {68.6, 55.2}}},
            [npcKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [217580] = { -- Seductress Ceeyna : https://wowhead.com/forever/npc=217580/seductress-ceeyna
            [npcKeys.name] = "Seductress Ceeyna",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[405] = {{81.4, 80.2}, {81.4, 82}, {81.8, 80.4}, {81.8, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [217588] = { -- Arbor Tarantula : https://wowhead.com/forever/npc=217588/arbor-tarantula
            [npcKeys.name] = "Arbor Tarantula",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[33] = {{43.6, 18.4}, {43.8, 18.6}, {44.2, 22}, {45.2, 19.4}, {45.2, 19.6}, {45.4, 22.2}, {45.6, 22.2}, {45.6, 23}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [217589] = { -- Hay Weevil : https://wowhead.com/forever/npc=217589/hay-weevil
            [npcKeys.name] = "Hay Weevil",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[45] = {{30.6, 28.4}, {30.8, 28.6}, {31, 26.2}, {32.2, 31}, {54, 38.6}, {54.2, 38.4}, {57, 39.8}, {59.6, 57}, {61.2, 55.6}, {62.4, 56}, {62.6, 56}}},
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [217590] = { -- Flesh Picker : https://wowhead.com/forever/npc=217590/flesh-picker
            [npcKeys.name] = "Flesh Picker",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[405] = {{49, 58.4}, {50, 56}, {50, 59.2}, {51.2, 58}, {51.4, 59.8}, {51.6, 57.2}, {51.6, 59.8}, {52.2, 58.2}, {52.4, 58.6}, {52.6, 56.8}, {52.6, 58}, {52.8, 56.4}, {53, 59}, {54, 62}, {54, 62.6}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [217620] = { -- Reckless Warlock : https://wowhead.com/forever/npc=217620/reckless-warlock
            [npcKeys.name] = "Reckless Warlock",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[33] = {{30.8, 47}}, [36] = {{54.4, 49.6}, {54.6, 49.6}}, [400] = {{11, 40.6}}, [405] = {{74.8, 13.4}, {74.8, 13.6}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [217669] = { -- Scorched Screeching Roguefeather : https://wowhead.com/forever/npc=217669/scorched-screeching-roguefeather
            [npcKeys.name] = "Scorched Screeching Roguefeather",
            [npcKeys.minLevel] = 29,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[400] = {{26.2, 46.8}, {26.4, 46.4}, {26.6, 47.6}, {27, 46.4}, {27, 47.2}}},
            [npcKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [217711] = { -- Seared Needles Cougar : https://wowhead.com/forever/npc=217711/seared-needles-cougar
            [npcKeys.name] = "Seared Needles Cougar",
            [npcKeys.minLevel] = 27,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[400] = {{23.4, 23.2}, {23.4, 23.6}, {23.4, 25}, {23.6, 23.4}, {23.6, 24.4}, {23.6, 24.8}}},
            [npcKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [217980] = { -- Julien Faranister : https://wowhead.com/forever/npc=217980/julien-faranister
            [npcKeys.name] = "Julien Faranister",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [218029] = { -- Witherbark Champion : https://wowhead.com/forever/npc=218029/witherbark-champion
            [npcKeys.name] = "Witherbark Champion",
            [npcKeys.minLevel] = 34,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[45] = {{68, 79.4}, {68, 82.2}, {68.4, 80.6}, {69.4, 81.4}, {69.4, 81.6}, {69.6, 81.4}, {69.6, 81.6}}},
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [218032] = { -- Witherbark Goliath : https://wowhead.com/forever/npc=218032/witherbark-goliath
            [npcKeys.name] = "Witherbark Goliath",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[45] = {{67.8, 79.4}, {68.4, 80.4}, {68.4, 80.6}, {69.2, 81.4}, {69.2, 82.6}, {69.4, 81.6}, {69.6, 81.4}, {69.6, 81.6}}},
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [218115] = { -- Mai'zin : https://wowhead.com/forever/npc=218115/maizin
            [npcKeys.name] = "Mai'zin",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[33] = {{31.2, 48.4}, {31.2, 48.6}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [218236] = { -- Red Bag : https://wowhead.com/forever/npc=218236/red-bag
            [npcKeys.name] = "Red Bag",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[46] = {{53, 24.4}}},
            [npcKeys.zoneID] = zoneIDs.BURNING_STEPPES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [218246] = { -- Gurgthock : https://wowhead.com/forever/npc=218246/gurgthock
            [npcKeys.name] = "Gurgthock",
            [npcKeys.spawns] = {[12] = {{33.2, 50.2}}, [14] = {{45.4, 13.8}}, [1637] = {{51.8, 69.8}, {52, 69.4}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [218249] = { -- Slitherblade Tide Priestess : https://wowhead.com/forever/npc=218249/slitherblade-tide-priestess
            [npcKeys.name] = "Slitherblade Tide Priestess",
            [npcKeys.minLevel] = 33,
            [npcKeys.maxLevel] = 34,
            [npcKeys.spawns] = {[405] = {{29.4, 6}, {29.6, 6}, {33, 11.2}, {34.4, 20.2}, {34.4, 26.4}, {34.4, 26.8}, {34.4, 30}, {34.6, 20}, {34.6, 26.4}, {34.6, 26.8}, {34.6, 30}, {36.4, 27}, {36.6, 26.4}, {36.6, 26.8}, {38.4, 23.8}, {38.6, 24}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [218616] = { -- Balnazzar : https://wowhead.com/forever/npc=218616/balnazzar
            [npcKeys.name] = "Balnazzar",
        },
        [218631] = { -- Screeching Terror : https://wowhead.com/forever/npc=218631/screeching-terror
            [npcKeys.name] = "Screeching Terror",
        },
        [218673] = { -- Shade of Balnazzar : https://wowhead.com/forever/npc=218673/shade-of-balnazzar
            [npcKeys.name] = "Shade of Balnazzar",
        },
        [218690] = { -- Kha'damu : https://wowhead.com/forever/npc=218690/khadamu
            [npcKeys.name] = "Kha'damu",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[33] = {{31.2, 48.4}, {31.4, 48.6}, {32.2, 49.2}, {32.4, 49.6}, {33, 50.2}, {33.2, 15.2}, {33.2, 15.6}, {33.2, 16.6}, {33.4, 50.6}, {33.4, 51.8}, {33.4, 52.8}, {33.4, 55.6}, {33.6, 51.4}, {33.6, 51.6}, {33.8, 16.4}, {33.8, 52.6}, {34, 14.8}, {34.4, 18.6}, {34.8, 18.4}, {38.2, 56.8}, {38.4, 59}, {38.6, 58.4}, {38.8, 59.2}, {42.4, 36.4}, {42.4, 36.6}, {42.6, 36.4}, {42.6, 36.6}, {43.2, 35.2}, {43.6, 36}, {47.4, 16.8}, {47.6, 16.4}, {47.6, 16.8}, {48.2, 17.8}, {49.2, 18.4}, {49.2, 18.6}, {49.6, 18.6}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [218726] = { -- Scarlet Lightbearer : https://wowhead.com/forever/npc=218726/scarlet-lightbearer
            [npcKeys.name] = "Scarlet Lightbearer",
        },
        [218748] = { -- Infernal : https://wowhead.com/forever/npc=218748/infernal
            [npcKeys.name] = "Infernal",
        },
        [218871] = { -- Death's Head Cultist : https://wowhead.com/forever/npc=218871/deaths-head-cultist
            [npcKeys.name] = "Death's Head Cultist",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 37,
            [npcKeys.spawns] = {[400] = {{54.8, 40.8}}},
            [npcKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [218931] = { -- Dark Rider : https://wowhead.com/forever/npc=218931/dark-rider
            [npcKeys.name] = "Dark Rider",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[3] = {{56.4, 53.4}, {56.4, 53.8}, {56.4, 54.6}, {57, 55.6}, {57, 56.6}, {57.2, 52.4}, {57.4, 53.2}, {57.4, 53.6}, {57.4, 54.6}, {57.6, 53.4}, {57.6, 54.6}, {57.6, 55.6}, {57.6, 56.6}, {57.8, 54.2}, {58, 52.4}, {58.6, 54}, {58.6, 55}}, [8] = {{67, 29.6}, {67.2, 29.4}, {68.2, 27.4}, {68.4, 28}, {68.4, 28.6}, {68.6, 27.4}, {68.8, 27.8}, {68.8, 29.6}, {69, 28.8}, {69.2, 31}, {69.6, 25}, {69.6, 26.8}, {69.6, 28.6}, {70.4, 27.8}, {70.6, 28.4}, {70.6, 29.2}, {70.6, 29.6}}, [10] = {{19.6, 44}, {20, 50.6}, {20.8, 50.8}, {21.4, 46.4}, {22, 46.4}, {22, 47.6}, {22.2, 46.8}, {22.2, 51.4}, {22.6, 49.4}, {22.8, 46.8}, {22.8, 47.6}, {22.8, 49.6}, {23.2, 46.2}, {23.4, 45.2}, {23.6, 47.2}, {23.8, 48.4}, {24, 44.8}, {24, 48.8}, {24, 49.6}, {24.4, 46}, {25, 46.2}}, [17] = {{52, 36.6}, {52, 37.8}, {52.2, 36.4}, {52.6, 37}, {53.2, 37.8}}, [41] = {{42.4, 27.4}, {42.4, 27.8}, {42.6, 27.4}, {42.6, 27.6}, {42.8, 28.6}, {43.2, 26.2}, {44.4, 29.2}, {44.4, 30.6}, {44.6, 29.6}, {44.8, 29.4}}, [45] = {{60.2, 41.8}, {60.4, 39.4}, {60.4, 40.2}, {60.4, 40.6}, {60.6, 39.4}, {60.6, 39.8}, {60.8, 40.6}, {61.6, 39.4}, {61.6, 40.6}, {62.2, 40}}, [405] = {{64.4, 24.4}, {64.4, 24.8}, {65, 23.4}, {65.2, 25}, {65.2, 25.6}, {65.2, 27}, {65.4, 24.4}, {65.6, 24.4}, {65.6, 24.8}, {66, 22.6}, {66.2, 22.4}, {67, 22.6}}},
        },
        [219659] = { -- High Tinker Mekkatorque : https://wowhead.com/forever/npc=219659/high-tinker-mekkatorque
            [npcKeys.name] = "High Tinker Mekkatorque",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.spawns] = {[1537] = {{68.8, 49}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [219822] = { -- Chained Spirit : https://wowhead.com/forever/npc=219822/chained-spirit
            [npcKeys.name] = "Chained Spirit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[33] = {{30.2, 73.2}, {33.6, 62.4}, {33.8, 52.6}, {37.4, 64}, {38.4, 8.8}, {39, 45.8}, {39.4, 18}, {44.4, 25}, {44.6, 25}, {45.4, 13.4}, {47.6, 34.2}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [220930] = { -- Frix Xizzix : https://wowhead.com/forever/npc=220930/frix-xizzix
            [npcKeys.name] = "Frix Xizzix",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{81.4, 42.4}, {81.4, 42.6}, {81.6, 42.4}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [221168] = { -- Dire Wolf Alpha : https://wowhead.com/forever/npc=221168/dire-wolf-alpha
            [npcKeys.name] = "Dire Wolf Alpha",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{45, 58.4}, {45, 62.2}, {45.2, 62.6}, {45.4, 59.4}, {45.4, 59.6}, {45.6, 59.4}, {46, 57.6}, {46.4, 38.4}, {46.4, 39}, {46.4, 40}, {46.4, 40.8}, {46.4, 47.4}, {46.4, 47.8}, {46.4, 57.4}, {46.6, 38.4}, {46.6, 38.8}, {46.6, 39.8}, {46.6, 40.8}, {46.6, 41.6}, {46.6, 47.4}, {46.6, 47.6}, {46.6, 57.6}, {46.8, 57.2}, {47, 56.4}, {47.4, 62.8}, {48.8, 65}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221169] = { -- Black Widow Broodmother : https://wowhead.com/forever/npc=221169/black-widow-broodmother
            [npcKeys.name] = "Black Widow Broodmother",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{44.4, 62.8}, {46.2, 54.4}, {46.4, 55.2}, {46.4, 55.6}, {46.4, 59.4}, {46.4, 59.6}, {46.6, 55.4}, {46.6, 55.6}, {46.8, 59.4}, {47, 44.4}, {47, 44.6}, {47, 56.6}, {47.2, 45.6}, {47.2, 60.2}, {47.2, 60.6}, {47.4, 46.8}, {52, 72}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221170] = { -- Uprooted Gloomwood : https://wowhead.com/forever/npc=221170/uprooted-gloomwood
            [npcKeys.name] = "Uprooted Gloomwood",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 62,
            [npcKeys.spawns] = {[10] = {{44.8, 58.4}, {45, 58.8}, {45.6, 57.8}, {46.2, 54.4}, {46.4, 36.4}, {46.4, 37}, {46.4, 37.6}, {46.4, 38.6}, {46.4, 55}, {46.4, 55.6}, {46.4, 59.4}, {46.4, 59.6}, {46.6, 36.4}, {46.6, 37.4}, {46.6, 37.6}, {46.6, 38.6}, {46.6, 41.2}, {46.6, 42}, {46.6, 43}, {46.6, 55.4}, {46.6, 55.6}, {46.6, 59.4}, {46.6, 59.6}, {47.2, 63.6}, {47.4, 47}, {47.4, 47.8}, {47.4, 62.4}, {47.4, 63.2}, {47.6, 46.8}, {47.6, 47.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221171] = { -- Nightmare Runner : https://wowhead.com/forever/npc=221171/nightmare-runner
            [npcKeys.name] = "Nightmare Runner",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{55.4, 72.4}, {56, 72}, {56.2, 71.2}, {57.2, 71.4}, {58, 71}, {59.2, 71.8}, {59.6, 72.4}, {59.8, 72.8}, {60.4, 70}, {60.6, 70}, {60.6, 71}, {60.6, 73.6}, {61, 75.4}, {61, 75.6}, {61.2, 71.8}, {61.8, 75}, {62.4, 68.2}, {63, 76}, {63.2, 69.2}, {63.4, 69.8}, {63.6, 69.8}, {64, 67.4}, {64, 67.6}, {64, 73}, {64.2, 71.6}, {64.4, 68.8}, {65, 73}, {65.2, 68.4}, {65.2, 68.6}, {65.2, 69.6}, {65.2, 70.6}, {65.2, 72.2}, {65.4, 67.4}, {65.4, 74.4}, {65.4, 75}, {65.6, 69.4}, {65.6, 75.2}, {65.8, 68.4}, {65.8, 70}, {66, 73.6}, {66, 76.4}, {66.2, 72.2}, {66.2, 73.2}, {66.4, 66.8}, {66.8, 70.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221172] = { -- Nightmare Weaver : https://wowhead.com/forever/npc=221172/nightmare-weaver
            [npcKeys.name] = "Nightmare Weaver",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{61, 75.4}, {61, 75.6}, {62.6, 65.4}, {62.8, 71.4}, {62.8, 71.6}, {63.8, 67.4}, {63.8, 73}, {64, 67.6}, {64, 75.4}, {64, 75.6}, {64.2, 71.2}, {64.4, 65.8}, {64.6, 74}, {65, 70.6}, {65, 72.4}, {65, 73}, {65.2, 68.8}, {65.4, 67.4}, {65.4, 67.6}, {65.4, 69.6}, {65.6, 67.4}, {65.6, 67.6}, {65.6, 69.4}, {65.8, 75.4}, {66, 70.2}, {66, 70.8}, {66, 75.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221174] = { -- Deranged Ogre : https://wowhead.com/forever/npc=221174/deranged-ogre
            [npcKeys.name] = "Deranged Ogre",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{32.4, 69.4}, {32.6, 69.4}, {33.2, 69.6}, {33.6, 73.4}, {34, 73.6}, {34.2, 77.4}, {34.4, 71.4}, {34.4, 75.4}, {34.4, 75.6}, {34.4, 77.8}, {34.6, 71.4}, {34.6, 71.6}, {34.6, 75.4}, {34.6, 75.6}, {34.8, 78}, {35, 74.4}, {35.2, 78.8}, {35.6, 77.8}, {36.4, 81.4}, {36.4, 81.6}, {36.6, 77.4}, {36.6, 80.4}, {36.6, 81.4}, {36.8, 77.8}, {36.8, 78.8}, {37, 82.4}, {37, 82.8}, {37.2, 70.8}, {37.2, 71.8}, {37.2, 84.2}, {37.6, 70.6}, {37.6, 84.4}, {39.4, 70.2}, {40.4, 69.4}, {40.4, 69.8}, {40.6, 69.6}, {41, 69.2}, {41.6, 68.8}, {42.6, 68.2}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221175] = { -- Demented Fire Weaver : https://wowhead.com/forever/npc=221175/demented-fire-weaver
            [npcKeys.name] = "Demented Fire Weaver",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{32, 70.2}, {33.8, 70.2}, {33.8, 74.8}, {34, 76.6}, {34.2, 76}, {34.4, 71.4}, {34.4, 73.2}, {34.4, 77.8}, {34.6, 71.4}, {34.6, 71.6}, {34.6, 77.8}, {34.8, 73.4}, {34.8, 73.6}, {35.2, 79.2}, {35.4, 79.6}, {35.6, 78}, {35.6, 80.2}, {35.8, 81}, {36.2, 72.4}, {36.4, 72.6}, {36.4, 77.4}, {36.6, 72.4}, {36.6, 72.6}, {36.6, 77.4}, {36.6, 79.8}, {36.6, 84.2}, {36.8, 77.8}, {36.8, 78.8}, {36.8, 82}, {36.8, 84.6}, {37, 83}, {37.6, 79.4}, {37.6, 84.2}, {38.4, 74.2}, {38.6, 74.4}, {39.4, 70}, {39.6, 70}, {41, 73.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221176] = { -- Nightterror Whelp : https://wowhead.com/forever/npc=221176/nightterror-whelp
            [npcKeys.name] = "Nightterror Whelp",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{45.2, 71.4}, {45.4, 72.2}, {46, 72.2}, {46, 72.8}, {46.2, 71}, {46.6, 71.2}, {47, 72.2}, {47, 74.6}, {47.2, 68.8}, {47.2, 72.6}, {47.4, 67.4}, {47.4, 68.4}, {47.4, 70.4}, {47.4, 73.8}, {47.6, 68.4}, {47.6, 68.8}, {47.6, 70.6}, {48, 70.4}, {48.2, 76.6}, {48.4, 72.4}, {48.4, 73.2}, {48.4, 73.6}, {48.4, 75}, {48.4, 76.2}, {48.6, 70.4}, {48.6, 71}, {48.6, 72.4}, {48.6, 72.8}, {48.8, 74.4}, {49, 68.4}, {49, 68.6}, {49.2, 76.8}, {49.4, 75}, {49.4, 75.6}, {49.6, 70.8}, {49.6, 74.4}, {49.6, 75.2}, {49.8, 70.4}, {49.8, 77.6}, {50, 68.4}, {50.2, 69.4}, {50.2, 72.4}, {50.2, 72.6}, {50.2, 76.4}, {50.4, 76.6}, {50.6, 72}, {50.6, 72.8}, {50.6, 74.2}, {50.6, 75.8}, {50.6, 77}, {50.8, 70.4}, {50.8, 71.2}, {50.8, 75.4}, {50.8, 77.6}, {51.6, 73.4}, {51.6, 77.4}, {51.8, 74.6}, {52, 74.4}, {52.4, 75.6}, {52.6, 74.2}, {52.6, 75.4}, {52.6, 75.6}, {54, 75.8}, {54.2, 75.4}, {54.6, 75.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221200] = { -- Wyrmkin Terrorwalker : https://wowhead.com/forever/npc=221200/wyrmkin-terrorwalker
            [npcKeys.name] = "Wyrmkin Terrorwalker",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{47.4, 72.4}, {47.6, 72.6}, {47.8, 70.4}, {47.8, 72.4}, {48, 70.6}, {49.2, 76.4}, {49.2, 76.6}, {49.4, 75.4}, {49.6, 75.4}, {50.2, 70.2}, {50.4, 73.4}, {50.4, 73.8}, {50.4, 76.4}, {50.4, 76.6}, {50.4, 78.2}, {50.6, 73.4}, {50.6, 76.8}, {50.6, 78}, {54.4, 73}, {54.8, 72.8}, {55.4, 72.4}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221206] = { -- Vvarc' Zul : https://wowhead.com/forever/npc=221206/vvarc-zul
            [npcKeys.name] = "Vvarc' Zul",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[10] = {{37, 82.4}, {37, 83.4}, {37.4, 84.2}, {37.4, 84.6}, {37.6, 84.4}, {37.6, 84.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221207] = { -- Amokarok : https://wowhead.com/forever/npc=221207/amokarok
            [npcKeys.name] = "Amokarok",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[10] = {{65.4, 75}, {65.6, 75.2}, {66, 76.4}, {66.4, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221215] = { -- Alara Grovemender : https://wowhead.com/forever/npc=221215/alara-grovemender
            [npcKeys.name] = "Alara Grovemender",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[10] = {{49, 77.4}, {49, 77.6}, {65.6, 67.4}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221216] = { -- Elenora Marshwalker : https://wowhead.com/forever/npc=221216/elenora-marshwalker
            [npcKeys.name] = "Elenora Marshwalker",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[10] = {{32.4, 69.4}, {32.4, 69.6}, {32.6, 69.4}, {32.6, 69.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221222] = { -- Dreamwarden Thalinar : https://wowhead.com/forever/npc=221222/dreamwarden-thalinar
            [npcKeys.name] = "Dreamwarden Thalinar",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[10] = {{36.4, 83.8}, {36.6, 83.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221223] = { -- Duskblaze Shadowstalker : https://wowhead.com/forever/npc=221223/duskblaze-shadowstalker
            [npcKeys.name] = "Duskblaze Shadowstalker",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[10] = {{44.6, 40.8}, {45.4, 43.2}, {45.6, 51.2}, {46.4, 36.4}, {46.4, 36.6}, {46.4, 38.2}, {46.4, 38.6}, {46.4, 40.4}, {46.4, 40.6}, {46.4, 41.8}, {46.4, 42.6}, {46.6, 36.4}, {46.6, 36.6}, {46.6, 38}, {46.6, 39}, {46.6, 39.8}, {46.6, 41.2}, {46.6, 42.2}, {46.6, 42.8}, {46.8, 43.8}, {47.4, 46.8}, {47.8, 37.4}, {48.6, 40.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221227] = { -- Nightmare Hound : https://wowhead.com/forever/npc=221227/nightmare-hound
            [npcKeys.name] = "Nightmare Hound",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[10] = {{44.2, 40}, {44.4, 39.4}, {44.8, 40.8}, {45, 42.4}, {45, 42.6}, {45.2, 51.6}, {45.4, 39.4}, {45.4, 40}, {45.4, 51.2}, {45.6, 51.2}, {45.8, 43.2}, {46, 50.4}, {46.4, 36}, {46.4, 37.2}, {46.4, 38.2}, {46.4, 38.8}, {46.4, 40.2}, {46.4, 40.6}, {46.4, 42}, {46.4, 43.6}, {46.6, 36.4}, {46.6, 37.4}, {46.6, 38.2}, {46.6, 38.6}, {46.6, 40.2}, {46.6, 41.2}, {46.6, 41.6}, {46.6, 43}, {46.6, 50}, {47, 44.6}, {47.2, 44.2}, {47.2, 45.6}, {47.2, 46.8}, {47.4, 47.6}, {47.4, 49}, {47.6, 42.6}, {47.8, 38}, {47.8, 39}, {48, 40.4}, {48.2, 40.8}, {48.4, 41.8}, {48.6, 41.2}, {48.8, 41.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [221230] = { -- Nightmare Grizzly : https://wowhead.com/forever/npc=221230/nightmare-grizzly
            [npcKeys.name] = "Nightmare Grizzly",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{79.4, 46.4}, {79.4, 46.8}, {79.6, 46.4}, {79.6, 46.6}, {80.6, 48.8}, {82.8, 48.4}, {83, 48.6}, {83.2, 56.4}, {83.2, 56.6}, {83.6, 47.6}, {83.8, 46.8}, {83.8, 59.6}, {84, 46.4}, {85.2, 59.8}, {86, 46}, {86, 56.4}, {86, 56.8}, {86.6, 48.4}, {86.6, 48.6}, {87, 44.4}, {87, 44.6}, {87, 51.4}, {87.2, 52}, {87.4, 58}, {87.6, 58}, {87.6, 58.6}, {87.8, 41.2}, {88.6, 57.8}, {89, 42.2}, {89, 42.6}, {89.2, 44.4}, {89.2, 45.8}, {89.2, 47.2}, {89.2, 47.6}, {89.4, 40.4}, {89.4, 40.8}, {89.4, 44.8}, {89.6, 40}, {89.6, 40.6}, {89.6, 45}, {89.6, 47.2}, {91, 39.4}, {91.2, 39.6}, {91.6, 39.6}, {92.4, 39.2}, {92.8, 39}, {93.4, 38}, {93.8, 38.4}, {93.8, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221257] = { -- Deathhorn Stag : https://wowhead.com/forever/npc=221257/deathhorn-stag
            [npcKeys.name] = "Deathhorn Stag",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{84.4, 45.2}, {86.4, 46.4}, {86.4, 46.6}, {86.4, 54.2}, {86.4, 57.4}, {86.4, 57.6}, {86.6, 46.6}, {87, 44}, {88.2, 49.4}, {88.8, 41}, {89.8, 50.6}, {90, 48.4}, {90.2, 39.8}, {90.8, 39.8}, {91.4, 39.2}, {91.6, 39.2}, {92, 38}, {93.2, 37.8}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221258] = { -- Dreamthorn Stalker : https://wowhead.com/forever/npc=221258/dreamthorn-stalker
            [npcKeys.name] = "Dreamthorn Stalker",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{82.4, 53.4}, {82.4, 54}, {82.6, 54.2}, {82.6, 54.6}, {83, 52}, {83.4, 48}, {83.8, 46.4}, {84, 47.4}, {84, 47.6}, {84.2, 44.8}, {85.4, 45.4}, {85.4, 45.6}, {85.6, 45.4}, {86, 43.8}, {86, 46}, {86, 50.6}, {86.2, 50.4}, {87, 41.4}, {87, 41.6}, {87.4, 43.4}, {87.4, 43.6}, {87.6, 43.2}, {87.6, 43.6}, {88.4, 64.2}, {88.4, 67.6}, {88.6, 68}, {88.8, 43.6}, {89, 43}, {90.4, 39.2}, {90.4, 39.6}, {90.6, 39}, {93.8, 36.4}, {93.8, 36.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221259] = { -- Wyrmkin Nightstalker : https://wowhead.com/forever/npc=221259/wyrmkin-nightstalker
            [npcKeys.name] = "Wyrmkin Nightstalker",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{83.4, 48.2}, {83.6, 48}, {83.8, 45.4}, {84.8, 46}, {85.4, 44.4}, {85.4, 44.6}, {86, 46}, {86.2, 43}, {86.2, 44.8}, {86.4, 44.4}, {86.6, 44.6}, {86.8, 43}, {86.8, 46.4}, {87.4, 43.8}, {87.6, 43.4}, {87.6, 43.6}, {88.2, 41.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221260] = { -- Terror Whelp : https://wowhead.com/forever/npc=221260/terror-whelp
            [npcKeys.name] = "Terror Whelp",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{83.8, 47.2}, {84.8, 46.2}, {85.4, 45.2}, {85.6, 45}, {86.2, 44.4}, {86.4, 41.4}, {86.4, 41.6}, {86.4, 43}, {86.4, 48}, {86.6, 48}, {86.6, 49.2}, {86.8, 42}, {86.8, 43.4}, {86.8, 46.2}, {86.8, 46.6}, {87, 40.4}, {87, 40.6}, {87, 43.8}, {87, 44.6}, {87, 50.4}, {87, 50.6}, {88.2, 41.4}, {88.2, 41.6}, {88.2, 42.6}, {88.8, 43}, {89.2, 44.2}, {89.2, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221261] = { -- Dreamfire Betrayer : https://wowhead.com/forever/npc=221261/dreamfire-betrayer
            [npcKeys.name] = "Dreamfire Betrayer",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{78.2, 44.4}, {78.2, 44.6}, {78.4, 45.8}, {78.6, 45.8}, {79, 50.2}, {79.4, 51}, {79.8, 47.2}, {80, 47.8}, {80, 49.2}, {80.4, 50.4}, {80.4, 50.6}, {80.6, 48.8}, {80.8, 46.6}, {80.8, 49.8}, {80.8, 50.8}, {81.4, 48.4}, {81.4, 51.6}, {81.6, 48.4}, {81.6, 48.6}, {81.6, 51.8}, {82, 52.6}, {82.4, 50}, {82.4, 53.6}, {82.6, 50}, {82.6, 54.4}, {82.8, 55}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221262] = { -- Dreamfire Hellcaller : https://wowhead.com/forever/npc=221262/dreamfire-hellcaller
            [npcKeys.name] = "Dreamfire Hellcaller",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{78.2, 43.2}, {78.2, 45.4}, {78.2, 46.4}, {79, 46.2}, {80, 50.6}, {80.2, 47.2}, {80.2, 48.8}, {80.2, 49.8}, {80.4, 46.4}, {80.6, 46.6}, {81, 49.2}, {81, 49.8}, {81, 50.6}, {81.4, 48.4}, {81.6, 48.4}, {81.8, 50}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221263] = { -- Vengeful Ancient : https://wowhead.com/forever/npc=221263/vengeful-ancient
            [npcKeys.name] = "Vengeful Ancient",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{82, 52.4}, {82, 52.6}, {82.2, 54.6}, {82.4, 54.2}, {82.4, 61.4}, {82.4, 62.2}, {82.4, 62.6}, {82.6, 52.4}, {82.6, 52.6}, {82.6, 54.4}, {82.6, 54.6}, {82.6, 61}, {83, 55.8}, {83.4, 56.6}, {83.4, 58.4}, {83.4, 58.6}, {83.4, 60.2}, {83.6, 55.8}, {83.6, 56.6}, {83.6, 60.4}, {83.6, 60.6}, {83.8, 58.4}, {83.8, 58.8}, {84.4, 62.2}, {84.6, 61.4}, {84.6, 62.2}, {84.8, 56.4}, {85, 56.8}, {85.2, 50.4}, {85.2, 64.8}, {85.4, 50.6}, {85.4, 59.4}, {85.4, 64.4}, {85.4, 66}, {85.6, 50.4}, {85.6, 50.6}, {85.6, 56.2}, {85.6, 64}, {85.6, 65.6}, {85.8, 53.8}, {85.8, 59.4}, {85.8, 59.6}, {86.4, 57.4}, {86.4, 57.6}, {86.4, 60.8}, {86.4, 62.2}, {86.4, 62.6}, {86.6, 57.4}, {86.6, 57.8}, {86.6, 60}, {86.6, 60.6}, {86.6, 62.4}, {86.6, 62.6}, {86.8, 59.2}, {87, 52.6}, {87.2, 50.6}, {87.2, 52.2}, {87.4, 50.4}, {87.6, 50.4}, {87.6, 50.6}, {87.6, 53.6}, {87.8, 53.4}, {88, 58.8}, {88, 61.6}, {88.2, 58.4}, {88.2, 61.4}, {88.4, 55.4}, {88.4, 56.4}, {88.4, 56.6}, {88.6, 55.4}, {88.6, 56.6}, {88.8, 56.2}, {89.2, 49.6}, {89.4, 48.4}, {89.4, 49.2}, {89.4, 51.4}, {89.4, 51.6}, {89.4, 53.2}, {89.4, 53.6}, {89.6, 52.4}, {89.6, 52.6}, {90.2, 49.4}, {90.2, 49.6}, {90.4, 53.6}, {90.6, 50.2}, {91, 53.8}, {91.6, 53.8}, {92, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221264] = { -- Dreamharvester : https://wowhead.com/forever/npc=221264/dreamharvester
            [npcKeys.name] = "Dreamharvester",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{83.6, 58}, {84.2, 56}, {88.4, 55.4}, {88.4, 55.6}, {88.4, 57.8}, {88.6, 55.6}, {89.2, 54.4}, {89.2, 54.6}, {89.4, 53.4}, {89.4, 58}, {89.8, 58}, {90.6, 57.4}, {91, 57.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221265] = { -- Larsera : https://wowhead.com/forever/npc=221265/larsera
            [npcKeys.name] = "Larsera",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{84.4, 45.4}, {85.4, 45.4}, {85.4, 45.6}, {86, 46}, {86.2, 44.4}, {86.2, 44.8}, {86.6, 44.2}, {86.6, 44.6}, {89.4, 40.4}, {89.4, 40.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221267] = { -- Shredder 9000 : https://wowhead.com/forever/npc=221267/shredder-9000
            [npcKeys.name] = "Shredder 9000",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{86.4, 60.4}, {86.4, 61.2}, {86.4, 61.6}, {86.4, 62.8}, {86.6, 60.4}, {86.6, 61.2}, {86.8, 62.4}, {86.8, 62.6}, {87.6, 62.2}, {87.6, 62.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221269] = { -- Maseara Autumnmoon : https://wowhead.com/forever/npc=221269/maseara-autumnmoon
            [npcKeys.name] = "Maseara Autumnmoon",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[331] = {{81, 50.2}, {89.6, 40.4}, {89.6, 40.6}, {93.4, 38.8}, {93.8, 38.4}, {93.8, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221270] = { -- Alyssian Windcaller : https://wowhead.com/forever/npc=221270/alyssian-windcaller
            [npcKeys.name] = "Alyssian Windcaller",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[331] = {{89.6, 40.4}, {89.6, 40.6}, {92, 54.2}, {93.8, 38.4}, {93.8, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221282] = { -- Emberspark Dreamsworn : https://wowhead.com/forever/npc=221282/emberspark-dreamsworn
            [npcKeys.name] = "Emberspark Dreamsworn",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[331] = {{92, 39}, {92.4, 38.2}, {92.4, 40}, {92.8, 36.2}, {93.2, 40.4}, {93.2, 40.6}, {93.4, 37.2}, {93.4, 38.2}, {93.6, 38.2}, {94, 36.4}, {94, 37.2}, {94, 39.2}, {94, 39.8}, {94.4, 40.6}, {94.6, 39}, {94.8, 37}, {94.8, 38}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221283] = { -- Dreampyre Imp : https://wowhead.com/forever/npc=221283/dreampyre-imp
            [npcKeys.name] = "Dreampyre Imp",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[331] = {{89.8, 40.2}, {90.8, 39.6}, {91, 39}, {92, 39.4}, {92, 39.6}, {92.4, 36}, {92.6, 36.2}, {92.8, 36.8}, {92.8, 38.6}, {93, 38.4}, {93.4, 39.6}, {93.6, 39.8}, {93.8, 38.4}, {93.8, 38.6}, {94, 36.4}, {94.4, 36.6}, {94.6, 39.4}, {94.8, 37.4}, {94.8, 37.6}, {94.8, 39.8}, {95.6, 37.4}, {95.6, 37.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221292] = { -- Dreamhunter Hound : https://wowhead.com/forever/npc=221292/dreamhunter-hound
            [npcKeys.name] = "Dreamhunter Hound",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[331] = {{89.4, 40.4}, {89.4, 40.6}, {89.6, 40.6}, {90.4, 39.4}, {90.4, 39.8}, {90.6, 39.6}, {91.4, 38.8}, {91.6, 38.8}, {92.2, 37.8}, {92.4, 37.4}, {92.4, 39.8}, {92.6, 38.4}, {92.6, 39.6}, {93.4, 37}, {93.4, 38.8}, {93.6, 38.8}, {93.8, 37.6}, {93.8, 40.2}, {94, 36.4}, {94, 37.4}, {94.2, 35.2}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [221315] = { -- Unstable Wisp : https://wowhead.com/forever/npc=221315/unstable-wisp
            [npcKeys.name] = "Unstable Wisp",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{61.2, 35.4}, {61.2, 35.6}, {61.6, 34.4}, {61.6, 34.6}, {62.2, 32.4}, {62.4, 29.8}, {62.4, 31}, {62.8, 25.4}, {62.8, 25.6}, {63.2, 27}, {63.2, 27.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221324] = { -- Grief-Crazed Gryphon : https://wowhead.com/forever/npc=221324/grief-crazed-gryphon
            [npcKeys.name] = "Grief-Crazed Gryphon",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{53.4, 37.2}, {53.8, 37.4}, {54, 37.6}, {54.6, 37.8}, {59.4, 34.4}, {59.4, 35}, {59.6, 33.6}, {59.6, 35.4}, {59.8, 35.6}, {62.2, 23}, {62.2, 30.6}, {62.4, 28}, {62.4, 29.2}, {62.4, 30.2}, {62.6, 24.6}, {62.6, 30.8}, {62.8, 29.6}, {63, 26}, {63, 28.6}, {63.2, 27.4}, {63.2, 27.6}, {63.4, 46}, {63.6, 27.4}, {63.8, 28.2}, {63.8, 29.2}, {63.8, 31}, {64.2, 45}, {64.2, 45.6}, {64.2, 46.6}, {64.6, 45.4}, {64.8, 45.6}, {65.6, 47}, {66.2, 38.2}, {66.2, 38.6}, {66.4, 43.4}, {66.4, 43.6}, {66.4, 47.6}, {66.6, 43.4}, {67, 45.6}, {67.2, 43.8}, {67.2, 44.6}, {67.2, 48.2}, {67.8, 43.4}, {67.8, 44}, {68.2, 45.4}, {69.4, 45.4}, {69.4, 45.6}, {69.4, 49.4}, {69.4, 50.4}, {69.4, 51}, {69.6, 49.4}, {70, 45.8}, {70, 50.4}, {70.2, 50.6}, {70.4, 45.4}, {70.6, 45.4}, {70.6, 51.2}, {71.2, 47}, {71.6, 47.4}, {72, 47.6}, {72.2, 54}, {72.4, 50.2}, {72.4, 51.2}, {72.6, 50.4}, {72.8, 50.8}, {73, 51.6}, {73, 53.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221325] = { -- Wyrmkin Starhunter : https://wowhead.com/forever/npc=221325/wyrmkin-starhunter
            [npcKeys.name] = "Wyrmkin Starhunter",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{45, 42.6}, {45.4, 38.8}, {45.8, 39.4}, {46, 39.6}, {46, 42.6}, {46.2, 42.4}, {46.4, 40.6}, {46.6, 40.4}, {46.6, 44.4}, {47, 37.2}, {47, 37.6}, {47, 41.4}, {47, 41.6}, {47.8, 43.4}, {48, 41}, {48, 43.6}, {49.2, 41.4}, {49.2, 41.6}, {49.8, 39.4}, {49.8, 39.6}, {51.2, 40}, {52.4, 39.4}, {52.8, 38.8}, {53, 40}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221326] = { -- Wrath Whelp : https://wowhead.com/forever/npc=221326/wrath-whelp
            [npcKeys.name] = "Wrath Whelp",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{45, 41}, {45, 42.8}, {45.4, 38.8}, {45.4, 40.4}, {45.8, 39.4}, {46, 42.6}, {46.4, 40.4}, {46.4, 40.6}, {46.6, 40.4}, {46.6, 42.6}, {46.8, 34.4}, {46.8, 35}, {46.8, 35.6}, {46.8, 36.6}, {47, 41.4}, {47, 41.6}, {47.6, 41}, {48.4, 40.2}, {48.4, 41.6}, {48.6, 40.4}, {48.6, 40.6}, {48.8, 41.6}, {49.4, 38}, {49.6, 38.2}, {49.8, 39.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221328] = { -- Dreamwater Vicejaw : https://wowhead.com/forever/npc=221328/dreamwater-vicejaw
            [npcKeys.name] = "Dreamwater Vicejaw",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{57.4, 38.4}, {57.4, 38.8}, {58.4, 38.2}, {58.4, 38.6}, {58.6, 38.6}, {59, 38}, {59.2, 37.4}, {60, 38.2}, {60.4, 38.8}, {60.8, 38.8}, {61.2, 38.4}, {61.4, 39.6}, {61.6, 38.4}, {62.2, 40.8}, {62.4, 39.2}, {62.4, 39.6}, {62.6, 39.4}, {62.6, 39.6}, {63, 41.4}, {63.2, 42.6}, {63.4, 42.2}, {64.4, 40.4}, {64.4, 41.2}, {64.4, 42.2}, {64.4, 42.6}, {64.4, 43.8}, {64.6, 42}, {64.8, 43.4}, {65, 44.8}, {65, 47}, {65.2, 39.4}, {65.4, 40.4}, {65.4, 40.6}, {65.4, 44.4}, {65.4, 45.8}, {65.6, 44.4}, {65.6, 44.6}, {65.6, 46.2}, {65.8, 42.4}, {66, 46.6}, {66.2, 43.2}, {66.4, 40.4}, {66.4, 40.6}, {66.6, 40.4}, {66.6, 40.6}, {66.6, 43.4}, {66.6, 46.6}, {66.8, 45.4}, {66.8, 46}, {67.2, 39.4}, {67.2, 43.8}, {67.6, 40.4}, {67.8, 43.4}, {68, 40.6}, {68, 42.4}, {68, 44.2}, {68, 44.8}, {68, 45.8}, {68.2, 47.4}, {68.2, 47.6}, {68.6, 47.4}, {68.6, 47.6}, {68.8, 45.4}, {69, 45.6}, {69.4, 49.2}, {69.6, 45.4}, {69.6, 45.6}, {69.8, 49}, {70.2, 47.2}, {70.2, 48.4}, {70.4, 50}, {70.4, 51}, {70.4, 51.6}, {70.6, 48.4}, {70.6, 48.8}, {70.6, 51.4}, {70.6, 51.6}, {71.4, 47.4}, {71.4, 50.2}, {71.6, 47.4}, {71.6, 47.6}, {71.6, 50.4}, {71.6, 50.6}, {71.6, 51.8}, {71.8, 48.6}, {71.8, 52.8}, {72.2, 54}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [221329] = { -- Dreamhunter Hydra : https://wowhead.com/forever/npc=221329/dreamhunter-hydra
            [npcKeys.name] = "Dreamhunter Hydra",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{63.4, 40}, {63.6, 40.2}, {66.4, 40.6}, {70.4, 48.4}, {70.4, 48.6}, {70.6, 47.4}, {70.6, 48.6}, {70.8, 48.4}, {71.6, 52.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221330] = { -- Fallen Moonkin : https://wowhead.com/forever/npc=221330/fallen-moonkin
            [npcKeys.name] = "Fallen Moonkin",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[47] = {{50, 46.2}, {53.8, 40.8}, {54, 39}, {54, 39.6}, {54.8, 39.6}, {55.8, 41.2}, {55.8, 44}, {56.2, 40.2}, {56.2, 42.4}, {56.2, 42.6}, {56.4, 44.6}, {56.6, 42.2}, {56.6, 43.2}, {56.6, 44.6}, {57, 43.6}, {57.2, 46.2}, {57.4, 38.4}, {57.4, 38.8}, {57.4, 40.2}, {57.4, 41.2}, {57.6, 38.4}, {57.6, 39.4}, {57.6, 39.8}, {57.6, 44.8}, {57.8, 42.6}, {57.8, 43.6}, {58, 42.4}, {58, 46.4}, {58, 46.8}, {58.2, 41.2}, {58.6, 38.2}, {58.6, 38.8}, {58.6, 40.2}, {59, 46.8}, {59.2, 45.4}, {59.4, 46.2}, {59.8, 46.8}, {60, 45.4}, {60.2, 44.2}, {60.4, 43}, {60.6, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221331] = { -- Florius : https://wowhead.com/forever/npc=221331/florius
            [npcKeys.name] = "Florius",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[47] = {{45.4, 38.6}, {45.8, 39.4}, {46, 39.8}, {46.4, 36}, {46.4, 37.4}, {46.4, 38}, {46.4, 40.6}, {46.6, 40.2}, {46.6, 40.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221333] = { -- Doomkin : https://wowhead.com/forever/npc=221333/doomkin
            [npcKeys.name] = "Doomkin",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[47] = {{56.2, 44.6}, {56.4, 42.4}, {56.4, 43.2}, {56.4, 43.6}, {56.6, 42.2}, {56.6, 43.4}, {56.6, 43.6}, {56.6, 44.6}, {57.4, 39.2}, {57.6, 42.6}, {58, 40.8}, {58, 42.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221334] = { -- Ghamoo-Raja : https://wowhead.com/forever/npc=221334/ghamoo-raja
            [npcKeys.name] = "Ghamoo-Raja",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[47] = {{63, 26}, {63.2, 27.6}, {63.4, 27.4}, {71.2, 53.6}, {71.4, 53.4}, {71.8, 52.4}, {72, 53.4}, {72.4, 53.6}, {72.6, 53.6}, {72.8, 53.4}, {73, 51.4}, {73, 52}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221356] = { -- Doomspark Starsworn : https://wowhead.com/forever/npc=221356/doomspark-starsworn
            [npcKeys.name] = "Doomspark Starsworn",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[47] = {{60.4, 29.4}, {60.4, 29.6}, {60.6, 29.4}, {60.6, 29.6}, {60.8, 31.4}, {61, 31.6}, {61.4, 34.4}, {61.4, 34.6}, {61.6, 34.6}, {61.8, 33.4}, {61.8, 33.6}, {62.4, 23.4}, {62.4, 23.8}, {62.4, 24.6}, {62.6, 23.4}, {62.6, 24.2}, {62.8, 25.4}, {62.8, 25.8}, {62.8, 26.8}, {63.4, 27.6}, {63.6, 27}, {63.6, 27.6}, {63.8, 29.4}, {64, 25.6}, {64, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221357] = { -- Stardust Imp : https://wowhead.com/forever/npc=221357/stardust-imp
            [npcKeys.name] = "Stardust Imp",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[47] = {{60.8, 29.4}, {60.8, 29.8}, {61.4, 31.4}, {61.4, 31.8}, {61.6, 31.8}, {61.6, 33.4}, {61.6, 33.8}, {62.2, 23.2}, {62.2, 25.2}, {62.4, 23.6}, {62.4, 25.6}, {62.4, 30.4}, {62.4, 30.6}, {62.6, 23.8}, {62.6, 24.8}, {62.6, 30.4}, {62.6, 30.8}, {62.8, 26.2}, {63.8, 26.2}, {63.8, 26.6}, {63.8, 29.2}, {63.8, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221360] = { -- Starkiller Hound : https://wowhead.com/forever/npc=221360/starkiller-hound
            [npcKeys.name] = "Starkiller Hound",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[47] = {{60.8, 28.4}, {61, 25.2}, {61, 26.4}, {61, 26.6}, {61.4, 28.6}, {61.4, 31.4}, {61.4, 31.6}, {61.4, 33.2}, {61.4, 34.4}, {61.4, 34.6}, {61.6, 31.4}, {61.6, 31.6}, {61.6, 33.2}, {61.6, 33.6}, {61.6, 34.6}, {61.8, 29}, {62.2, 23}, {62.4, 24.2}, {62.4, 24.6}, {62.4, 25.6}, {62.4, 28.4}, {62.4, 29.6}, {62.6, 24.4}, {62.6, 24.6}, {62.8, 25.8}, {62.8, 29.4}, {62.8, 30.6}, {63, 27.2}, {63, 30.2}, {63.2, 27.8}, {63.6, 27.4}, {63.6, 27.8}, {64, 29.4}, {64, 29.8}, {64, 30.8}, {64.6, 27.2}, {64.6, 29}, {65.2, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [221361] = { -- Mad Sprite : https://wowhead.com/forever/npc=221361/mad-sprite
            [npcKeys.name] = "Mad Sprite",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{37.2, 12.4}, {37.2, 12.6}, {41.2, 9}, {43, 13}, {44.4, 11.8}, {44.8, 13.8}, {45.2, 19.4}, {45.2, 19.6}, {45.4, 21.4}, {45.4, 21.6}, {45.6, 21.4}, {45.6, 21.6}, {46.2, 14.2}, {46.2, 19.6}, {46.4, 18.4}, {46.4, 18.6}, {47.6, 13.4}, {47.6, 13.6}, {50.2, 12.4}, {50.4, 12.6}, {50.8, 10.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221365] = { -- Deathpetal Lasher : https://wowhead.com/forever/npc=221365/deathpetal-lasher
            [npcKeys.name] = "Deathpetal Lasher",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{43.2, 10.8}, {43.2, 13.6}, {43.4, 13.4}, {44.4, 10.8}, {44.6, 10.8}, {45, 19.8}, {45, 22.4}, {45.4, 19.2}, {45.6, 19.8}, {45.6, 22.2}, {45.6, 22.6}, {46, 13}, {46.2, 13.6}, {46.2, 17.4}, {46.2, 17.8}, {46.2, 19}, {46.2, 20.8}, {46.4, 15.2}, {46.6, 15.2}, {46.6, 15.6}, {46.6, 19}, {47, 21.6}, {47.4, 11.8}, {47.6, 11.4}, {47.6, 11.6}, {48, 15.8}, {49.2, 16}, {49.4, 15}, {50, 15.6}, {50.2, 15}, {50.4, 11}, {50.4, 11.8}, {50.4, 12.8}, {50.6, 12.6}, {50.8, 11.8}, {51, 11.4}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221367] = { -- Wyrmkin Berserker : https://wowhead.com/forever/npc=221367/wyrmkin-berserker
            [npcKeys.name] = "Wyrmkin Berserker",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{47.2, 16.8}, {48.4, 11.4}, {48.4, 11.6}, {48.6, 11.6}, {49.4, 15}, {49.6, 15.6}, {50, 14.4}, {50, 14.6}, {50.6, 5.6}, {50.6, 17.2}, {51, 15.4}, {51.2, 15.8}, {51.6, 14.8}, {51.8, 6}, {52.4, 16}, {52.8, 16.2}, {53.4, 12.2}, {53.6, 12.4}, {53.6, 13.4}, {53.6, 13.6}, {53.6, 15.2}, {53.6, 15.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221369] = { -- Frenzied Whelp : https://wowhead.com/forever/npc=221369/frenzied-whelp
            [npcKeys.name] = "Frenzied Whelp",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{45.8, 14.2}, {46.4, 12.8}, {47.2, 14.6}, {47.4, 14.4}, {48.2, 13.4}, {48.2, 13.6}, {48.8, 10.8}, {50.2, 16.2}, {50.4, 17}, {50.4, 22.4}, {50.4, 22.6}, {50.6, 17.2}, {50.6, 21}, {50.6, 22.2}, {50.6, 24.8}, {50.8, 19.6}, {51, 11.4}, {51, 11.6}, {51, 18.4}, {51, 18.8}, {51.4, 16.4}, {51.6, 16}, {51.6, 16.6}, {51.6, 19.6}, {51.8, 15.4}, {52.8, 16.2}, {53, 16.6}, {53.4, 14.4}, {53.4, 14.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221370] = { -- Dreamspring Roguefeather : https://wowhead.com/forever/npc=221370/dreamspring-roguefeather
            [npcKeys.name] = "Dreamspring Roguefeather",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{38, 14.6}, {38.2, 10.4}, {38.4, 11.4}, {38.4, 11.6}, {38.4, 13}, {38.4, 14.4}, {38.4, 15.8}, {38.4, 16.6}, {38.6, 11.4}, {38.6, 15.6}, {38.6, 16.6}, {39, 12}, {39, 13.4}, {39.2, 10}, {39.2, 14.8}, {39.4, 13.6}, {39.6, 13.8}, {39.6, 15.8}, {39.8, 10.2}, {39.8, 12.2}, {39.8, 12.6}, {39.8, 15.2}, {40, 9.2}, {40.4, 10.8}, {40.6, 8.2}, {40.6, 15}, {40.8, 9.8}, {41, 13.2}, {41.4, 8.6}, {41.4, 11.4}, {41.4, 12.4}, {41.4, 14.2}, {41.6, 8.4}, {41.6, 8.6}, {41.6, 11.4}, {41.6, 12.4}, {41.6, 12.6}, {41.6, 14}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221371] = { -- Dreamspring Stormcaller : https://wowhead.com/forever/npc=221371/dreamspring-stormcaller
            [npcKeys.name] = "Dreamspring Stormcaller",
            [npcKeys.minLevel] = 49,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{36.8, 13.8}, {37.2, 12.6}, {37.4, 12.4}, {37.6, 15.4}, {37.6, 15.6}, {37.8, 11.8}, {37.8, 12.6}, {38, 11.4}, {38, 14.4}, {38.6, 14}, {39, 10}, {39, 13.4}, {39.2, 16.4}, {39.4, 9.2}, {39.4, 10.8}, {39.6, 10.8}, {39.6, 12.8}, {39.8, 9.6}, {40, 9.2}, {40.2, 8}, {40.2, 12.4}, {40.2, 13.6}, {40.6, 9.6}, {40.8, 8.2}, {41, 10.8}, {41.2, 13}, {41.4, 9.4}, {42, 9}, {42.2, 11.2}, {42.8, 9.4}, {42.8, 9.6}, {43.2, 11}, {43.6, 11}, {43.8, 10}, {45, 9.4}, {45, 10.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221375] = { -- Lost Daughter : https://wowhead.com/forever/npc=221375/lost-daughter
            [npcKeys.name] = "Lost Daughter",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{41.4, 15}, {41.4, 15.6}, {41.6, 15.4}, {41.6, 18.4}, {42.2, 20.8}, {42.4, 19.8}, {43.2, 13.4}, {43.2, 13.6}, {44, 21.4}, {44.2, 21.6}, {44.2, 23}, {45, 12.4}, {45, 12.6}, {45, 22.4}, {45, 25}, {45.2, 21.4}, {45.4, 19.8}, {45.6, 19.8}, {45.6, 22.2}, {45.8, 16.6}, {46, 16.4}, {46, 24.4}, {46, 24.6}, {46.2, 18.8}, {46.4, 14.4}, {46.4, 14.8}, {46.4, 17.6}, {46.4, 21}, {49.6, 15}, {50.2, 16.2}, {50.4, 17}, {50.6, 17}, {50.8, 11.4}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221377] = { -- Vengeful Son : https://wowhead.com/forever/npc=221377/vengeful-son
            [npcKeys.name] = "Vengeful Son",
            [npcKeys.minLevel] = 51,
            [npcKeys.maxLevel] = 51,
            [npcKeys.spawns] = {[357] = {{41.4, 15.4}, {41.4, 15.6}, {41.6, 15.4}, {41.6, 15.8}, {41.8, 17.2}, {42.4, 19.8}, {42.6, 20}, {43, 13.2}, {43.4, 25}, {43.6, 25}, {44.4, 12.4}, {44.4, 12.6}, {44.4, 22.2}, {44.6, 12.4}, {44.6, 12.8}, {45, 19.8}, {45.2, 25.2}, {45.4, 19.2}, {45.4, 20.6}, {45.4, 22.2}, {45.4, 22.6}, {45.6, 18.8}, {45.6, 19.8}, {45.6, 20.8}, {45.8, 23.2}, {45.8, 23.6}, {46, 16.2}, {46, 16.6}, {46, 22}, {46, 25.4}, {46, 25.6}, {46.2, 15.4}, {46.2, 17.6}, {46.4, 14.4}, {46.6, 14.4}, {46.6, 14.6}, {46.6, 21.6}, {46.6, 24.8}, {47, 17.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221391] = { -- Slirena : https://wowhead.com/forever/npc=221391/slirena
            [npcKeys.name] = "Slirena",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[357] = {{38.4, 13}, {38.8, 14.6}, {39, 13.4}, {39.2, 13.6}, {39.6, 13.8}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221395] = { -- Mellias Earthtender : https://wowhead.com/forever/npc=221395/mellias-earthtender
            [npcKeys.name] = "Mellias Earthtender",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{49.6, 15.4}, {49.6, 15.6}, {50, 13.4}, {50, 13.6}, {50.6, 12.8}, {51, 11.4}, {51, 11.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221398] = { -- Nerene Brooksinger : https://wowhead.com/forever/npc=221398/nerene-brooksinger
            [npcKeys.name] = "Nerene Brooksinger",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{45.8, 16.4}, {45.8, 16.6}, {51, 11.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221399] = { -- Jamniss Treemender : https://wowhead.com/forever/npc=221399/jamniss-treemender
            [npcKeys.name] = "Jamniss Treemender",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{40.4, 8}, {40.6, 8}, {49.4, 12.2}, {49.8, 12.2}, {51, 11.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221407] = { -- Dreamshadow Imp : https://wowhead.com/forever/npc=221407/dreamshadow-imp
            [npcKeys.name] = "Dreamshadow Imp",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{48.6, 12.2}, {50.2, 10.4}, {50.2, 10.8}, {50.2, 12.4}, {50.2, 12.6}, {50.4, 7.4}, {50.4, 9.2}, {50.6, 7.4}, {50.6, 7.6}, {50.8, 10.4}, {50.8, 10.6}, {50.8, 11.6}, {51, 12.6}, {51.6, 8}, {51.6, 11.2}, {51.6, 11.8}, {52.6, 8.6}, {53.2, 10.2}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [221471] = { -- Field Captain Palandar : https://wowhead.com/forever/npc=221471/field-captain-palandar
            [npcKeys.name] = "Field Captain Palandar",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[10] = {{45.4, 51.2}, {45.6, 51.2}, {46.4, 47.6}, {46.6, 47.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [221575] = { -- Elrick : https://wowhead.com/forever/npc=221575/elrick
            [npcKeys.name] = "Elrick",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[15] = {{66.4, 45.4}, {66.6, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [221740] = { -- Calefactus the Unleashed : https://wowhead.com/forever/npc=221740/calefactus-the-unleashed
            [npcKeys.name] = "Calefactus the Unleashed",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[4] = {{44, 35.4}, {44, 38.2}, {44, 38.8}, {44.2, 30}, {44.2, 31.4}, {44.4, 36.2}, {44.4, 37.2}, {44.4, 43.8}, {44.6, 39}, {44.6, 46.8}, {44.8, 44.8}, {45, 37.2}, {45, 39.6}, {45, 41}, {45, 41.6}, {45, 49.2}, {45.2, 29.8}, {45.2, 31.8}, {45.2, 33.2}, {45.2, 43.4}, {45.2, 50.6}, {45.4, 28.2}, {45.4, 34.4}, {45.4, 35.4}, {45.4, 35.8}, {45.4, 38.4}, {45.4, 44.2}, {45.4, 48.2}, {45.4, 52}, {45.4, 52.8}, {45.4, 54.2}, {45.6, 37.6}, {45.6, 40.2}, {45.6, 42.2}, {45.6, 51.4}, {45.8, 32.2}, {45.8, 34}, {45.8, 48.2}, {46.2, 33.4}, {46.2, 37.2}, {46.2, 53}, {46.2, 54}, {46.4, 34.6}, {46.4, 35.6}, {46.4, 38.6}, {46.4, 47.2}, {46.4, 49.4}, {46.4, 52.4}, {46.6, 35.6}, {46.6, 36.8}, {46.6, 39}, {46.6, 52}, {46.6, 55}, {46.8, 34.2}, {46.8, 34.6}, {46.8, 38.2}, {47, 47.4}, {47, 52.6}, {47.2, 48.2}, {47.2, 50}, {47.4, 48.6}, {47.4, 51}, {47.4, 54}, {47.6, 47.4}, {47.6, 49.8}, {47.6, 51}, {47.8, 33.8}, {47.8, 48.6}, {47.8, 53.6}, {48, 33.4}, {48, 51.6}, {48.2, 34.6}, {48.2, 39}, {48.2, 48}, {48.2, 53.2}, {48.4, 36.8}, {48.4, 38.4}, {48.6, 49.2}, {48.6, 51.2}, {48.8, 35.2}, {48.8, 48.2}, {49, 37.2}, {49, 50.2}, {49.2, 38.4}, {49.2, 52.4}, {49.4, 38.8}, {49.8, 38.2}, {49.8, 52.2}, {49.8, 52.8}, {50, 36.6}, {50, 39}, {50.2, 36.4}, {50.4, 40.2}, {50.6, 36.8}, {50.6, 38.4}, {50.6, 38.8}, {50.6, 50.2}, {51.4, 36.4}, {51.8, 33.2}, {52.2, 36.6}, {53.2, 30.4}, {53.4, 28.2}, {53.6, 48.8}}},
            [npcKeys.zoneID] = zoneIDs.BLASTED_LANDS,
        },
        [221827] = { -- Magister Falath : https://wowhead.com/forever/npc=221827/magister-falath
            [npcKeys.name] = "Magister Falath",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[1537] = {{26.4, 9.4}, {26.4, 9.6}, {26.4, 10.6}, {26.6, 9.4}, {27, 8.4}, {27.2, 11.6}, {27.4, 10}, {27.4, 10.6}, {27.6, 10.4}, {27.6, 10.6}, {27.6, 11.8}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [221935] = { -- Treant Avatar : https://wowhead.com/forever/npc=221935/treant-avatar
            [npcKeys.name] = "Treant Avatar",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{58, 52.8}, {58.4, 52}, {58.6, 52.2}, {59, 52.8}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [222198] = { -- Nightmare Amalgamation : https://wowhead.com/forever/npc=222198/nightmare-amalgamation
            [npcKeys.name] = "Nightmare Amalgamation",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[331] = {{87.8, 68.4}, {88.2, 67.4}, {88.2, 68.6}, {88.4, 65}, {88.6, 66.2}, {88.6, 67}, {88.6, 68.2}, {88.6, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [222232] = { -- Corrupt Moderate Manifestation of Air : https://wowhead.com/forever/npc=222232/corrupt-moderate-manifestation-of-air
            [npcKeys.name] = "Corrupt Moderate Manifestation of Air",
            [npcKeys.minLevel] = 46,
            [npcKeys.maxLevel] = 47,
            [npcKeys.spawns] = {[47] = {{51, 46.4}, {51.2, 47}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [222286] = { -- Namida Grimtotem : https://wowhead.com/forever/npc=222286/namida-grimtotem
            [npcKeys.name] = "Namida Grimtotem",
            [npcKeys.minLevel] = 43,
            [npcKeys.maxLevel] = 43,
            [npcKeys.spawns] = {[357] = {{66.4, 38.4}, {66.4, 38.8}, {66.6, 38.2}, {66.8, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [222376] = { -- Groddoc Infant : https://wowhead.com/forever/npc=222376/groddoc-infant
            [npcKeys.name] = "Groddoc Infant",
            [npcKeys.spawns] = {[357] = {{59, 58.4}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222407] = { -- Enraged Leywalker : https://wowhead.com/forever/npc=222407/enraged-leywalker
            [npcKeys.name] = "Enraged Leywalker",
            [npcKeys.minLevel] = 47,
            [npcKeys.maxLevel] = 47,
            [npcKeys.spawns] = {[16] = {{18.2, 79.4}, {18.2, 79.6}, {18.6, 79.4}}, [47] = {{47.4, 59.2}, {47.4, 60}, {47.8, 59}, {48.6, 58.4}}, [51] = {{54.2, 65.2}, {54.4, 66.2}, {54.4, 66.6}, {54.8, 66}, {55, 66.6}, {55.4, 65.4}, {55.6, 65.8}}, [357] = {{57.2, 61.4}, {57.2, 61.6}}},
        },
        [222409] = { -- Boss "Gobb" Goldnick : https://wowhead.com/forever/npc=222409/boss-gobb-goldnick
            [npcKeys.name] = "Boss \"Gobb\" Goldnick",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[331] = {{88.4, 55.4}, {89.2, 57.8}, {90, 58}, {90.8, 57.2}, {90.8, 58.6}, {91, 58}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [222546] = { -- Iodax the Obliterator : https://wowhead.com/forever/npc=222546/iodax-the-obliterator
            [npcKeys.name] = "Iodax the Obliterator",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[51] = {{65.4, 45.4}, {65.4, 45.6}, {65.8, 44.4}, {65.8, 45.4}, {65.8, 45.6}, {66.6, 43.8}, {66.6, 45.4}, {66.8, 46.2}, {66.8, 46.6}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [222551] = { -- Grendag Brightbeard : https://wowhead.com/forever/npc=222551/grendag-brightbeard
            [npcKeys.name] = "Grendag Brightbeard",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[1537] = {{43.2, 10.8}, {44, 10}, {44.2, 10.6}, {44.4, 9.4}, {44.6, 11}, {45, 10.2}}, [1637] = {{49, 57.8}, {49.2, 57.4}, {49.2, 58.6}, {49.6, 58.2}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222620] = { -- Corrupt Moderate Manifestation of Fire : https://wowhead.com/forever/npc=222620/corrupt-moderate-manifestation-of-fire
            [npcKeys.name] = "Corrupt Moderate Manifestation of Fire",
            [npcKeys.minLevel] = 47,
            [npcKeys.maxLevel] = 48,
            [npcKeys.spawns] = {[51] = {{23.2, 73.6}, {23.4, 72.8}, {23.6, 72.6}, {24, 72.4}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [222625] = { -- Corrupt Moderate Manifestation of Earth : https://wowhead.com/forever/npc=222625/corrupt-moderate-manifestation-of-earth
            [npcKeys.name] = "Corrupt Moderate Manifestation of Earth",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 46,
            [npcKeys.spawns] = {[440] = {{62, 62.4}, {62, 62.6}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [222685] = { -- Quartermaster Kyleen : https://wowhead.com/forever/npc=222685/quartermaster-kyleen
            [npcKeys.name] = "Quartermaster Kyleen",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[331] = {{89.4, 40.4}, {89.4, 40.6}, {89.6, 40.4}, {89.6, 40.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222698] = { -- Fel Scar : https://wowhead.com/forever/npc=222698/fel-scar
            [npcKeys.name] = "Fel Scar",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[4] = {{35, 55.2}, {41.2, 33.4}, {41.2, 33.6}, {43.4, 25.6}, {43.6, 25.2}, {43.6, 25.6}, {46.4, 39.2}, {46.6, 39.2}, {48.4, 48}, {49, 48.2}, {56.2, 36.8}, {56.4, 36.4}, {60.2, 46}, {60.2, 46.6}, {62, 39.2}}, [16] = {{16.4, 51}, {16.6, 51}, {17.8, 58.6}, {21.2, 54}, {24.8, 47.8}, {25, 81.4}, {25, 81.6}, {30.2, 79.8}, {33, 81.4}, {33, 81.6}}, [357] = {{68.2, 58.8}, {70.6, 62.6}, {72.6, 63.8}, {73.2, 54.4}, {74.2, 50.8}, {74.2, 56.8}, {74.2, 60}, {76.2, 56.4}, {76.2, 56.6}, {76.6, 63.6}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222703] = { -- Whisperwing : https://wowhead.com/forever/npc=222703/whisperwing
            [npcKeys.name] = "Whisperwing",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[16] = {{34.4, 48.8}, {34.6, 48.8}}},
            [npcKeys.zoneID] = zoneIDs.AZSHARA,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222705] = { -- Blightbark : https://wowhead.com/forever/npc=222705/blightbark
            [npcKeys.name] = "Blightbark",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[357] = {{58.2, 53}, {58.4, 52}, {58.6, 52.2}, {58.8, 51}, {58.8, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222726] = { -- Tyrant of the Hive : https://wowhead.com/forever/npc=222726/tyrant-of-the-hive
            [npcKeys.name] = "Tyrant of the Hive",
            [npcKeys.minLevel] = 46,
            [npcKeys.maxLevel] = 46,
            [npcKeys.spawns] = {[357] = {{77.4, 62}, {77.8, 62.2}, {78, 62.6}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [222799] = { -- Simmering Elemental : https://wowhead.com/forever/npc=222799/simmering-elemental
            [npcKeys.name] = "Simmering Elemental",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 42,
            [npcKeys.spawns] = {[357] = {{79, 49.6}, {79.2, 49.4}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [222857] = { -- Odd Totem : https://wowhead.com/forever/npc=222857/odd-totem
            [npcKeys.name] = "Odd Totem",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[440] = {{45.6, 37.8}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [222968] = { -- Lethlas : https://wowhead.com/forever/npc=222968/lethlas
            [npcKeys.name] = "Lethlas",
            [npcKeys.minLevel] = 52,
            [npcKeys.maxLevel] = 52,
            [npcKeys.spawns] = {[357] = {{50.8, 18.2}, {51, 11.2}, {52.2, 15.2}, {52.4, 16.2}, {53, 16.4}, {53.2, 16.6}, {53.6, 17}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [222977] = { -- Phantim : https://wowhead.com/forever/npc=222977/phantim
            [npcKeys.name] = "Phantim",
            [npcKeys.minLevel] = 42,
            [npcKeys.maxLevel] = 42,
            [npcKeys.spawns] = {[331] = {{83.6, 47.6}, {83.8, 47}, {84, 45.2}, {84.2, 46}, {84.8, 45.4}, {84.8, 46}, {85.6, 44.4}, {86, 43.4}, {86, 46}, {86.2, 45}, {86.6, 43.2}, {86.6, 44.4}, {86.6, 44.6}, {86.8, 45.6}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [222978] = { -- Green Sludge : https://wowhead.com/forever/npc=222978/green-sludge
            [npcKeys.name] = "Green Sludge",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[47] = {{45.4, 40.4}, {45.8, 39.4}, {46, 39.6}, {46.2, 40.6}, {46.4, 37.2}, {46.4, 38.2}, {46.6, 40.2}, {46.6, 40.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [223287] = { -- Fire Elemental : https://wowhead.com/forever/npc=223287/fire-elemental
            [npcKeys.name] = "Fire Elemental",
            [npcKeys.minLevel] = 27,
            [npcKeys.maxLevel] = 27,
            [npcKeys.spawns] = {[10] = {{36.2, 81.2}, {37, 82.4}, {37, 83.4}, {37.4, 84.2}, {37.4, 84.6}, {37.6, 84.4}, {37.6, 84.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [223544] = { -- Fel Interloper : https://wowhead.com/forever/npc=223544/fel-interloper
            [npcKeys.name] = "Fel Interloper",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 48,
            [npcKeys.spawns] = {[4] = {{34.8, 56.2}, {35, 55}, {41.2, 33.4}, {41.2, 33.6}, {43.6, 25.2}, {46.2, 39.4}, {46.6, 39.2}, {48.8, 48.2}, {49.2, 48.6}, {56.2, 36.4}, {56.2, 36.6}, {56.6, 36.6}, {58.8, 41.2}, {59.2, 40.2}, {59.8, 42.4}, {60.2, 46.6}, {60.4, 46.4}, {60.6, 39}, {60.6, 44.8}, {61.8, 38.4}, {62.2, 39}}, [16] = {{16.4, 51}, {17.6, 58.8}, {21.2, 54}, {24.8, 47.4}, {24.8, 47.6}, {25, 81.4}, {25, 81.6}, {30.2, 79.8}, {33, 81.4}}, [357] = {{68.2, 58.8}, {70.6, 62.6}, {72.4, 63.6}, {72.6, 63.8}, {73.2, 54.2}, {74.2, 50.6}, {74.2, 56.8}, {74.2, 60}, {76.2, 56.4}, {76.2, 56.6}, {76.6, 63.8}}},
        },
        [223590] = { -- Shrine of the Watcher : https://wowhead.com/forever/npc=223590/shrine-of-the-watcher
            [npcKeys.name] = "Shrine of the Watcher",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16] = {{89.8, 33.4}, {89.8, 33.6}}},
            [npcKeys.zoneID] = zoneIDs.AZSHARA,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [223591] = { -- Echo of a Lost Soul : https://wowhead.com/forever/npc=223591/echo-of-a-lost-soul
            [npcKeys.name] = "Echo of a Lost Soul",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[8] = {{50.2, 62}}, [33] = {{40.8, 58.4}, {41, 58.6}}, [47] = {{72.4, 68.8}, {72.6, 68.4}, {72.6, 68.6}}, [440] = {{53.8, 29}}},
        },
        [224743] = { -- Emerald Warden : https://wowhead.com/forever/npc=224743/emerald-warden
            [npcKeys.name] = "Emerald Warden",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.spawns] = {[10] = {{45, 51.8}, {45.2, 51.2}, {45.4, 53}, {45.6, 51.2}, {45.6, 53.4}, {45.8, 53.6}, {46, 50.4}, {46.4, 47.4}, {46.4, 47.6}, {47, 47.8}}, [47] = {{60, 35}, {61.4, 34.4}, {61.4, 34.6}, {61.6, 34.6}, {61.8, 33.2}, {61.8, 33.6}}, [331] = {{89.2, 41.6}, {89.4, 40.4}, {89.4, 40.6}, {89.6, 40.4}, {89.6, 40.6}, {90.6, 39.6}}, [357] = {{48.4, 12.4}, {48.4, 12.6}, {48.6, 12.4}, {48.6, 12.6}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [226799] = { -- Pixi Pilfershard : https://wowhead.com/forever/npc=226799/pixi-pilfershard
            [npcKeys.name] = "Pixi Pilfershard",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[28] = {{43.2, 84}, {43.6, 84}}},
            [npcKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [226982] = { -- Frijidar : https://wowhead.com/forever/npc=226982/frijidar
            [npcKeys.name] = "Frijidar",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[618] = {{69.8, 38}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [227519] = { -- Fallen Knight : https://wowhead.com/forever/npc=227519/fallen-knight
            [npcKeys.name] = "Fallen Knight",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[28] = {{44.4, 46.6}, {44.6, 46.6}}},
            [npcKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [227533] = { -- Astral Wraith : https://wowhead.com/forever/npc=227533/astral-wraith
            [npcKeys.name] = "Astral Wraith",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[1377] = {{11.8, 95}}},
            [npcKeys.zoneID] = zoneIDs.SILITHUS,
        },
        [227985] = { -- Arkonos the Cursed : https://wowhead.com/forever/npc=227985/arkonos-the-cursed
            [npcKeys.name] = "Arkonos the Cursed",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [227996] = { -- Sebastian Jurgens : https://wowhead.com/forever/npc=227996/sebastian-jurgens
            [npcKeys.name] = "Sebastian Jurgens",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.spawns] = {[85] = {{53.6, 57.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [228142] = { -- Techbot : https://wowhead.com/forever/npc=228142/techbot
            [npcKeys.name] = "Techbot",
            [npcKeys.minLevel] = 62,
            [npcKeys.maxLevel] = 62,
            [npcKeys.spawns] = {[440] = {{51.2, 27}, {51.4, 28}, {51.4, 29}, {52, 29.4}, {52.2, 27.4}, {52.2, 27.8}, {52.4, 29.6}, {52.6, 29.4}, {53, 29.6}, {53.4, 30.6}, {53.6, 30.6}, {54, 31.6}, {54.4, 34}, {54.6, 34.6}, {54.6, 35.8}, {54.8, 36.8}, {54.8, 38.2}, {54.8, 39}, {54.8, 40.4}, {54.8, 42.8}, {55, 40.8}, {55, 41.6}, {55.2, 43.6}, {55.2, 44.8}, {55.4, 46}, {55.4, 47.4}, {55.4, 48.8}, {55.6, 49.4}, {56.2, 50}, {57.8, 52.4}, {58.2, 53}, {58.4, 54}, {58.6, 54.2}, {58.6, 89.8}, {58.8, 85.4}, {58.8, 87.2}, {58.8, 88.4}, {59.2, 55.2}, {59.2, 91.4}, {59.8, 81.4}, {60, 79.2}, {60, 80.2}, {60, 82.8}, {61, 77.2}, {61, 77.6}, {61.4, 76.4}, {61.6, 75.8}, {62.2, 75.2}, {62.6, 73.4}, {62.6, 75}, {62.8, 72.2}, {62.8, 74}, {63, 68}, {63, 69}, {63, 69.8}, {63, 71}, {63.2, 61.4}, {63.2, 66.6}, {63.4, 62}, {63.4, 66.4}, {63.8, 62.4}, {63.8, 62.8}, {63.8, 64}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [228173] = { -- Sam Otridge : https://wowhead.com/forever/npc=228173/sam-otridge
            [npcKeys.name] = "Sam Otridge",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [228176] = { -- Banteazo : https://wowhead.com/forever/npc=228176/banteazo
            [npcKeys.name] = "Banteazo",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[493] = {{56.2, 32.4}}},
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [228216] = { -- Nami : https://wowhead.com/forever/npc=228216/nami
            [npcKeys.name] = "Nami",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[618] = {{61.2, 37}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [228414] = { -- Heliath : https://wowhead.com/forever/npc=228414/heliath
            [npcKeys.name] = "Heliath",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 56,
            [npcKeys.spawns] = {[4] = {{68, 28.8}}},
            [npcKeys.zoneID] = zoneIDs.BLASTED_LANDS,
        },
        [228595] = { -- Vengeful Wisp : https://wowhead.com/forever/npc=228595/vengeful-wisp
            [npcKeys.name] = "Vengeful Wisp",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[361] = {{45.4, 18.6}, {45.6, 18.8}}},
            [npcKeys.zoneID] = zoneIDs.FELWOOD,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [228622] = { -- Orthas : https://wowhead.com/forever/npc=228622/orthas
            [npcKeys.name] = "Orthas",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 57,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [228718] = { -- Firelands Invader : https://wowhead.com/forever/npc=228718/firelands-invader
            [npcKeys.name] = "Firelands Invader",
            [npcKeys.minLevel] = 54,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[51] = {{26.6, 50}, {30.4, 33.4}, {30.4, 33.6}, {30.8, 33.4}, {30.8, 33.6}, {32.4, 32.4}, {32.4, 33.2}, {32.4, 33.6}, {32.6, 32.2}, {32.6, 33.2}, {32.6, 33.6}, {33, 31}, {33.4, 28.4}, {33.4, 29}, {33.4, 29.6}, {33.6, 28.8}, {33.6, 29.6}, {33.6, 32.2}, {33.8, 27.4}, {33.8, 27.6}, {34, 31.4}, {34.2, 26.4}, {34.4, 32.6}, {34.6, 32.4}, {34.6, 32.6}, {34.8, 30.6}, {35.4, 58}, {36, 57.8}, {36.8, 58}, {37.8, 59}, {38.2, 59.6}, {39, 38.8}, {39.2, 44.8}, {39.4, 44.4}, {39.6, 44.6}, {39.8, 44.4}, {41.4, 59.4}, {41.8, 58.8}, {42, 58.4}, {42.2, 57.2}, {42.6, 57.4}, {42.6, 57.6}, {45, 40.2}, {47.2, 35.6}, {47.4, 35.4}, {47.4, 48.8}, {47.4, 49.6}, {47.6, 48.8}, {47.8, 35.2}, {48, 39.6}, {48.4, 38.8}, {48.6, 38.6}, {48.8, 38.2}, {49.2, 37.4}, {49.8, 38.6}, {50, 48}, {50.4, 37.4}, {50.4, 37.6}, {50.4, 47.2}, {50.6, 37.2}, {50.6, 37.8}, {50.8, 36.4}, {52, 44.6}, {52.2, 44.4}, {54.8, 45}, {57.2, 36}, {63.2, 35.4}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228719] = { -- Firelands Drudge : https://wowhead.com/forever/npc=228719/firelands-drudge
            [npcKeys.name] = "Firelands Drudge",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[51] = {{43, 29.6}, {43.2, 28.6}, {43.4, 27.2}, {43.4, 28.4}, {43.6, 28.6}, {43.8, 27.4}, {43.8, 27.6}, {44, 25.4}, {44.4, 26.4}, {45.2, 26.4}, {45.4, 26.6}, {45.6, 26.8}, {45.8, 25.4}, {45.8, 26.4}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228720] = { -- Duke Searbrand : https://wowhead.com/forever/npc=228720/duke-searbrand
            [npcKeys.name] = "Duke Searbrand",
            [npcKeys.minLevel] = 59,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[51] = {{42.4, 29.4}, {42.4, 29.6}, {43, 29.4}, {43, 29.6}, {43.4, 28.4}, {43.6, 28.2}, {43.6, 28.6}, {43.8, 27.4}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228723] = { -- Obsidian Reaver : https://wowhead.com/forever/npc=228723/obsidian-reaver
            [npcKeys.name] = "Obsidian Reaver",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[51] = {{21.2, 76.6}, {22, 74.2}, {22.6, 77.4}, {23.8, 76.8}, {25, 76.2}, {25.8, 75.2}, {26, 75.6}, {26, 77.8}, {27.2, 71.4}, {27.2, 72}, {27.4, 69.8}, {27.4, 81}, {27.8, 70.6}, {27.8, 80.6}, {28, 77.2}, {28, 78.2}, {28, 78.8}, {28, 79.6}, {28.2, 65.8}, {28.4, 55.4}, {28.4, 55.6}, {28.4, 62.4}, {28.4, 76.4}, {28.4, 81.8}, {28.6, 55.4}, {28.6, 55.6}, {28.6, 61.6}, {28.6, 64.4}, {28.6, 66}, {28.6, 75.8}, {28.6, 81.4}, {28.6, 81.6}, {28.8, 65}, {28.8, 75.2}, {29, 77.2}, {29, 78.4}, {29, 79.8}, {29.2, 73.4}, {29.2, 78.8}, {29.6, 66.2}, {29.6, 79.2}, {30.6, 55.2}, {30.6, 55.6}, {30.8, 72.2}, {31, 62}, {31, 70.8}, {31.2, 63.6}, {31.4, 63.4}, {31.4, 67}, {31.4, 68.2}, {31.4, 69.4}, {31.4, 69.6}, {31.6, 63.6}, {31.6, 67.4}, {31.6, 69.2}, {31.6, 70}, {31.6, 76.4}, {31.8, 68}, {31.8, 77.6}, {32.4, 58.4}, {32.4, 74}, {32.4, 75}, {32.4, 77.2}, {32.8, 76.8}, {33, 72.2}, {33, 74.8}, {33, 76.4}, {33.2, 74}, {33.4, 61.2}, {33.4, 73.2}, {33.4, 77.6}, {33.4, 79.2}, {33.4, 80}, {33.6, 73.4}, {33.6, 73.6}, {33.6, 77.4}, {33.6, 77.8}, {33.6, 79.4}, {33.6, 79.6}, {34, 63.4}, {34, 64.4}, {34, 65.6}, {34, 71.6}, {34.2, 61.8}, {34.2, 64.8}, {34.2, 71.4}, {34.4, 60.6}, {34.6, 60.6}, {34.6, 71.2}, {34.6, 71.6}, {35.2, 73}, {35.4, 67.4}, {35.4, 67.8}, {35.8, 68.4}, {35.8, 68.6}, {35.8, 72}, {36, 70}, {36.2, 70.6}, {36.4, 73.2}, {36.4, 74}, {36.6, 62.8}, {36.6, 69}, {36.6, 70.6}, {36.6, 73.4}, {36.6, 74.2}, {41.2, 74.2}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228724] = { -- Obsidian Surger : https://wowhead.com/forever/npc=228724/obsidian-surger
            [npcKeys.name] = "Obsidian Surger",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[51] = {{29.2, 73}, {29.2, 73.6}, {29.4, 72.4}, {29.6, 72.8}, {29.6, 73.6}, {30.4, 72.4}, {30.8, 71.2}, {30.8, 72.4}, {31, 72.6}, {31.6, 72.4}, {32.4, 76}, {32.4, 76.8}, {33, 76.4}, {33, 76.8}, {33.4, 77.6}, {33.4, 79.4}, {33.4, 79.6}, {33.4, 80.6}, {33.6, 77.4}, {33.6, 78.4}, {33.6, 79.4}, {33.6, 79.6}, {33.6, 81.2}, {34, 73}, {34, 82.4}, {34.2, 82.8}, {34.4, 83.8}, {34.6, 83.4}, {34.6, 83.8}, {36.4, 69.2}, {36.4, 69.6}, {36.4, 71.2}, {36.4, 71.6}, {36.6, 69}, {36.6, 69.6}, {36.8, 71.4}, {36.8, 71.6}, {41.4, 66.8}, {41.6, 66.8}, {42.4, 74.6}, {42.6, 74.8}, {43.4, 66.8}, {43.6, 66.8}, {43.8, 66.4}, {45.4, 67.4}, {45.4, 67.6}, {45.6, 67.4}, {45.6, 67.6}, {45.8, 72}, {48.4, 66.2}, {48.8, 65.8}, {49.8, 70.6}, {50.4, 64.8}, {50.6, 64.8}, {53.2, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228726] = { -- Flamebringer Elementalist : https://wowhead.com/forever/npc=228726/flamebringer-elementalist
            [npcKeys.name] = "Flamebringer Elementalist",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 56,
            [npcKeys.spawns] = {[51] = {{15.4, 35}, {15.6, 35}, {16.2, 41.8}, {16.6, 41.6}, {19.4, 37.4}, {19.4, 37.8}, {19.6, 38.4}, {19.6, 38.6}, {21.2, 29}, {21.6, 29}, {22.2, 34.6}, {22.4, 34.2}, {22.6, 34.2}, {22.6, 34.6}, {23, 26.4}, {23.2, 26.8}, {24.4, 28}, {24.8, 28.4}, {25, 28.6}, {26, 36.4}, {26, 36.6}, {26.2, 29.4}, {26.2, 30}, {26.6, 30}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228727] = { -- Flamebringer Defender : https://wowhead.com/forever/npc=228727/flamebringer-defender
            [npcKeys.name] = "Flamebringer Defender",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 56,
            [npcKeys.spawns] = {[51] = {{13.4, 40.2}, {13.6, 38.4}, {13.6, 38.6}, {13.8, 37.4}, {14.2, 43.2}, {14.4, 43.6}, {14.6, 43.6}, {15, 43.2}, {15.2, 35}, {15.8, 34.6}, {16.2, 36}, {16.2, 41.8}, {16.4, 34}, {16.4, 36.6}, {16.6, 36.8}, {17.2, 34.6}, {17.4, 34.4}, {17.6, 34.4}, {17.8, 38}, {18, 35}, {18.4, 36}, {18.4, 37}, {18.6, 35.4}, {18.6, 36.6}, {18.8, 41.6}, {19, 35.6}, {19.4, 38.2}, {19.4, 40.4}, {19.4, 40.8}, {19.6, 35.6}, {19.6, 38.4}, {19.6, 38.8}, {19.6, 40.4}, {19.6, 40.6}, {21.4, 29.2}, {21.4, 29.6}, {21.4, 31.4}, {21.4, 31.6}, {21.6, 31}, {21.6, 31.6}, {21.8, 30.4}, {22.4, 25.4}, {22.4, 25.6}, {22.4, 27.4}, {22.4, 28.4}, {22.4, 28.6}, {22.4, 37}, {22.4, 38}, {22.6, 28.6}, {22.8, 25.4}, {22.8, 27.4}, {22.8, 27.6}, {22.8, 37.6}, {22.8, 38.6}, {23, 25.8}, {23, 36.2}, {23, 37.4}, {23.6, 25.8}, {23.6, 27.4}, {23.6, 27.6}, {23.6, 37}, {23.6, 37.6}, {23.6, 39.4}, {24, 40.2}, {24, 40.8}, {24, 42}, {24.4, 32.4}, {24.4, 32.8}, {24.4, 33.6}, {24.4, 35.6}, {24.6, 33.8}, {24.6, 40.8}, {24.8, 28.6}, {24.8, 32.4}, {24.8, 32.8}, {25.2, 27.6}, {25.2, 30.8}, {25.4, 25.8}, {25.4, 27.2}, {25.6, 27}, {25.6, 33}, {26, 26.2}, {26, 36.6}, {26.2, 30}, {26.2, 34.4}, {26.2, 35.6}, {26.4, 25.4}, {26.4, 34.6}, {26.6, 25.6}, {26.8, 34.6}, {27, 24.8}, {27.2, 24.4}, {27.4, 34.2}, {27.6, 34.4}, {27.6, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228747] = { -- Flamebringer Stalker : https://wowhead.com/forever/npc=228747/flamebringer-stalker
            [npcKeys.name] = "Flamebringer Stalker",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 56,
            [npcKeys.spawns] = {[51] = {{33.4, 28.4}, {33.4, 28.8}, {33.4, 29.6}, {33.6, 28.4}, {33.6, 28.6}, {33.6, 30}, {33.8, 27.4}, {33.8, 31.2}, {33.8, 32}, {35.4, 26.4}, {35.4, 27}, {35.4, 28.2}, {35.4, 28.6}, {35.6, 27}, {36.2, 25.4}, {36.4, 26}, {36.4, 28}, {36.6, 26.4}, {36.8, 26.8}, {37.2, 28.6}, {37.4, 27.6}, {37.6, 27.4}, {37.8, 28.2}, {37.8, 28.6}, {37.8, 29.6}, {38.4, 25.2}, {38.4, 25.6}, {38.6, 28}, {39, 25}, {39, 25.8}, {39.4, 27.4}, {39.6, 26.4}, {39.6, 26.8}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [228891] = { -- Enraged Shade : https://wowhead.com/forever/npc=228891/enraged-shade
            [npcKeys.name] = "Enraged Shade",
            [npcKeys.minLevel] = 53,
            [npcKeys.maxLevel] = 53,
            [npcKeys.spawns] = {[618] = {{29.8, 35.8}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [228934] = { -- Thane Korth'azz : https://wowhead.com/forever/npc=228934/thane-korthazz
            [npcKeys.name] = "Thane Korth'azz",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [228935] = { -- Enraged Spirit : https://wowhead.com/forever/npc=228935/enraged-spirit
            [npcKeys.name] = "Enraged Spirit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [229200] = { -- Astral Wraith : https://wowhead.com/forever/npc=229200/astral-wraith
            [npcKeys.name] = "Astral Wraith",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[1377] = {{11.8, 94.6}}},
            [npcKeys.zoneID] = zoneIDs.SILITHUS,
        },
        [230317] = { -- Mokvar : https://wowhead.com/forever/npc=230317/mokvar
            [npcKeys.name] = "Mokvar",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1637] = {{34.4, 37.4}, {34.4, 37.6}, {34.8, 38.6}, {35, 38}, {35.2, 37.4}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [230319] = { -- Deliana : https://wowhead.com/forever/npc=230319/deliana
            [npcKeys.name] = "Deliana",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1537] = {{42.4, 52.2}, {42.4, 52.6}, {43.2, 52.6}, {43.4, 51}, {43.4, 52.2}, {43.6, 50.8}, {43.6, 52}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [230565] = { -- Ironforge Guard : https://wowhead.com/forever/npc=230565/ironforge-guard
            [npcKeys.name] = "Ironforge Guard",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1537] = {{42.4, 53.8}, {43.2, 52.4}, {43.2, 52.6}, {43.4, 51.2}, {43.6, 51.2}, {43.6, 52.2}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [231499] = { -- Ada Darkhardt : https://wowhead.com/forever/npc=231499/ada-darkhardt
            [npcKeys.name] = "Ada Darkhardt",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [232399] = { -- Outcast Cryomancer : https://wowhead.com/forever/npc=232399/outcast-cryomancer
            [npcKeys.name] = "Outcast Cryomancer",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[618] = {{63.2, 68.2}, {63.2, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [232900] = { -- Cursed Mage : https://wowhead.com/forever/npc=232900/cursed-mage
            [npcKeys.name] = "Cursed Mage",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 56,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [232912] = { -- Ada Darkhardt : https://wowhead.com/forever/npc=232912/ada-darkhardt
            [npcKeys.name] = "Ada Darkhardt",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[28] = {{69.4, 79.4}, {69.4, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [232920] = { -- Uther : https://wowhead.com/forever/npc=232920/uther
            [npcKeys.name] = "Uther",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[28] = {{47, 69.8}}},
            [npcKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [232929] = { -- Gregory : https://wowhead.com/forever/npc=232929/gregory
            [npcKeys.name] = "Gregory",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[618] = {{53.4, 83.6}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
            [npcKeys.friendlyToFaction] = "A",
        },
        [232939] = { -- Felguard Elite : https://wowhead.com/forever/npc=232939/felguard-elite
            [npcKeys.name] = "Felguard Elite",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[618] = {{53.2, 83.8}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [232940] = { -- Felhound Spellseeker : https://wowhead.com/forever/npc=232940/felhound-spellseeker
            [npcKeys.name] = "Felhound Spellseeker",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[618] = {{53.2, 83.8}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [233335] = { -- Rune Broker : https://wowhead.com/forever/npc=233335/rune-broker
            [npcKeys.name] = "Rune Broker",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1] = {{29.4, 72}, {29.6, 72}}, [12] = {{48, 41.4}, {48.2, 41.6}}, [141] = {{58.8, 43.8}}, [1537] = {{53, 13.2}, {53.6, 12.2}, {53.8, 13.2}, {53.8, 13.6}}, [1657] = {{28.4, 39}, {28.6, 39}, {29, 38.4}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [233428] = { -- Rune Broker : https://wowhead.com/forever/npc=233428/rune-broker
            [npcKeys.name] = "Rune Broker",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[14] = {{42.8, 68}}, [85] = {{31.4, 66.4}, {31.4, 66.6}}, [1497] = {{79.2, 19.4}, {79.4, 19.8}, {79.6, 19.4}, {79.6, 20}, {79.8, 20.6}}, [1637] = {{49.2, 46.8}, {49.4, 46.2}, {49.6, 46.2}}, [1638] = {{22.6, 12.8}, {22.8, 13.8}}},
            [npcKeys.friendlyToFaction] = "H",
        },
        [235812] = { -- Horde Rogue : https://wowhead.com/forever/npc=235812/horde-rogue
            [npcKeys.name] = "Horde Rogue",
        },
        [235813] = { -- Horde Warlock : https://wowhead.com/forever/npc=235813/horde-warlock
            [npcKeys.name] = "Horde Warlock",
        },
        [235814] = { -- Horde Warrior : https://wowhead.com/forever/npc=235814/horde-warrior
            [npcKeys.name] = "Horde Warrior",
        },
        [235815] = { -- Horde Shaman : https://wowhead.com/forever/npc=235815/horde-shaman
            [npcKeys.name] = "Horde Shaman",
        },
        [235816] = { -- Alliance Warrior : https://wowhead.com/forever/npc=235816/alliance-warrior
            [npcKeys.name] = "Alliance Warrior",
        },
        [235817] = { -- Alliance Warlock : https://wowhead.com/forever/npc=235817/alliance-warlock
            [npcKeys.name] = "Alliance Warlock",
        },
        [235818] = { -- Alliance Rogue : https://wowhead.com/forever/npc=235818/alliance-rogue
            [npcKeys.name] = "Alliance Rogue",
        },
        [235819] = { -- Alliance Priest : https://wowhead.com/forever/npc=235819/alliance-priest
            [npcKeys.name] = "Alliance Priest",
        },
        [235820] = { -- Alliance Paladin : https://wowhead.com/forever/npc=235820/alliance-paladin
            [npcKeys.name] = "Alliance Paladin",
        },
        [235821] = { -- Alliance Mage : https://wowhead.com/forever/npc=235821/alliance-mage
            [npcKeys.name] = "Alliance Mage",
        },
        [235822] = { -- Alliance Hunter : https://wowhead.com/forever/npc=235822/alliance-hunter
            [npcKeys.name] = "Alliance Hunter",
        },
        [235824] = { -- Alliance Druid : https://wowhead.com/forever/npc=235824/alliance-druid
            [npcKeys.name] = "Alliance Druid",
        },
        [235825] = { -- Horde Druid : https://wowhead.com/forever/npc=235825/horde-druid
            [npcKeys.name] = "Horde Druid",
        },
        [235826] = { -- Horde Hunter : https://wowhead.com/forever/npc=235826/horde-hunter
            [npcKeys.name] = "Horde Hunter",
        },
        [235827] = { -- Horde Mage : https://wowhead.com/forever/npc=235827/horde-mage
            [npcKeys.name] = "Horde Mage",
        },
        [235828] = { -- Horde Priest : https://wowhead.com/forever/npc=235828/horde-priest
            [npcKeys.name] = "Horde Priest",
        },
        [235843] = { -- Balnazzar : https://wowhead.com/forever/npc=235843/balnazzar
            [npcKeys.name] = "Balnazzar",
        },
        [235844] = { -- Grand Crusader Dathrohan : https://wowhead.com/forever/npc=235844/grand-crusader-dathrohan
            [npcKeys.name] = "Grand Crusader Dathrohan",
        },
        [235892] = { -- Prince Halanox : https://wowhead.com/forever/npc=235892/prince-halanox
            [npcKeys.name] = "Prince Halanox",
        },
        [235903] = { -- Ekkal : https://wowhead.com/forever/npc=235903/ekkal
            [npcKeys.name] = "Ekkal",
        },
        [235906] = { -- Elder Bramblesnap : https://wowhead.com/forever/npc=235906/elder-bramblesnap
            [npcKeys.name] = "Elder Bramblesnap",
        },
        [235909] = { -- Furze : https://wowhead.com/forever/npc=235909/furze
            [npcKeys.name] = "Furze",
        },
        [235912] = { -- Ancient Irontree Walker : https://wowhead.com/forever/npc=235912/ancient-irontree-walker
            [npcKeys.name] = "Ancient Irontree Walker",
        },
        [236028] = { -- Honey Wasp : https://wowhead.com/forever/npc=236028/honey-wasp
            [npcKeys.name] = "Honey Wasp",
        },
        [236400] = { -- Demonic Essence : https://wowhead.com/forever/npc=236400/demonic-essence
            [npcKeys.name] = "Demonic Essence",
        },
        [236496] = { -- Master Feardred : https://wowhead.com/forever/npc=236496/master-feardred
            [npcKeys.name] = "Master Feardred",
        },
        [236573] = { -- Gatekeeper Rageroar : https://wowhead.com/forever/npc=236573/gatekeeper-rageroar
            [npcKeys.name] = "Gatekeeper Rageroar",
        },
        [236770] = { -- Korsa : https://wowhead.com/forever/npc=236770/korsa
            [npcKeys.name] = "Korsa",
        },
        [236818] = { -- Murloc : https://wowhead.com/forever/npc=236818/murloc
            [npcKeys.name] = "Murloc",
        },
        [236867] = { -- Legashi Soulstealer : https://wowhead.com/forever/npc=236867/legashi-soulstealer
            [npcKeys.name] = "Legashi Soulstealer",
        },
        [236874] = { -- Legashi Hellraiser : https://wowhead.com/forever/npc=236874/legashi-hellraiser
            [npcKeys.name] = "Legashi Hellraiser",
        },
        [236876] = { -- Legashi Blackguard : https://wowhead.com/forever/npc=236876/legashi-blackguard
            [npcKeys.name] = "Legashi Blackguard",
        },
        [236987] = { -- Satyrweed Quest Dummy : https://wowhead.com/forever/npc=236987/satyrweed-quest-dummy
            [npcKeys.name] = "Satyrweed Quest Dummy",
        },
        [236991] = { -- Timbermaw Ally : https://wowhead.com/forever/npc=236991/timbermaw-ally
            [npcKeys.name] = "Timbermaw Ally",
        },
        [237007] = { -- Graal : https://wowhead.com/forever/npc=237007/graal
            [npcKeys.name] = "Graal",
        },
        [237318] = { -- Firewater Cauldron : https://wowhead.com/forever/npc=237318/firewater-cauldron
            [npcKeys.name] = "Firewater Cauldron",
        },
        [237612] = { -- Legashi Cauldron : https://wowhead.com/forever/npc=237612/legashi-cauldron
            [npcKeys.name] = "Legashi Cauldron",
        },
        [237614] = { -- Cauldron Imp : https://wowhead.com/forever/npc=237614/cauldron-imp
            [npcKeys.name] = "Cauldron Imp",
        },
        [237615] = { -- Stalker : https://wowhead.com/forever/npc=237615/stalker
            [npcKeys.name] = "Stalker",
        },
        [237732] = { -- Blackmaw Warrior : https://wowhead.com/forever/npc=237732/blackmaw-warrior
            [npcKeys.name] = "Blackmaw Warrior",
        },
        [237733] = { -- Blackmaw Den Watcher : https://wowhead.com/forever/npc=237733/blackmaw-den-watcher
            [npcKeys.name] = "Blackmaw Den Watcher",
        },
        [237734] = { -- Blackmaw Totemic : https://wowhead.com/forever/npc=237734/blackmaw-totemic
            [npcKeys.name] = "Blackmaw Totemic",
        },
        [237735] = { -- Blackmaw Pathfinder : https://wowhead.com/forever/npc=237735/blackmaw-pathfinder
            [npcKeys.name] = "Blackmaw Pathfinder",
        },
        [237736] = { -- Blackmaw Shaman : https://wowhead.com/forever/npc=237736/blackmaw-shaman
            [npcKeys.name] = "Blackmaw Shaman",
        },
        [237738] = { -- Blackmaw Ursa : https://wowhead.com/forever/npc=237738/blackmaw-ursa
            [npcKeys.name] = "Blackmaw Ursa",
        },
        [237769] = { -- Gol'gere Deathmoon : https://wowhead.com/forever/npc=237769/golgere-deathmoon
            [npcKeys.name] = "Gol'gere Deathmoon",
        },
        [237810] = { -- Unknown Phantasm : https://wowhead.com/forever/npc=237810/unknown-phantasm
            [npcKeys.name] = "Unknown Phantasm",
        },
        [237818] = { -- Harrison Jones : https://wowhead.com/forever/npc=237818/harrison-jones
            [npcKeys.name] = "Harrison Jones",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[41] = {{52.2, 34.2}, {52.2, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.DEADWIND_PASS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [237962] = { -- Kinara Meadowheart : https://wowhead.com/forever/npc=237962/kinara-meadowheart
            [npcKeys.name] = "Kinara Meadowheart",
        },
        [238093] = { -- Unknown Phantasm : https://wowhead.com/forever/npc=238093/unknown-phantasm
            [npcKeys.name] = "Unknown Phantasm",
        },
        [238126] = { -- Ridolus : https://wowhead.com/forever/npc=238126/ridolus
            [npcKeys.name] = "Ridolus",
        },
        [238134] = { -- Timbermaw Ally : https://wowhead.com/forever/npc=238134/timbermaw-ally
            [npcKeys.name] = "Timbermaw Ally",
        },
        [238226] = { -- Trixx Boomfizz : https://wowhead.com/forever/npc=238226/trixx-boomfizz
            [npcKeys.name] = "Trixx Boomfizz",
        },
        [238272] = { -- Prankk Boomfizz : https://wowhead.com/forever/npc=238272/prankk-boomfizz
            [npcKeys.name] = "Prankk Boomfizz",
        },
        [238284] = { -- Ernix Boomfizz : https://wowhead.com/forever/npc=238284/ernix-boomfizz
            [npcKeys.name] = "Ernix Boomfizz",
        },
        [238321] = { -- Dream Icon 1 : https://wowhead.com/forever/npc=238321/dream-icon-1
            [npcKeys.name] = "Dream Icon 1",
        },
        [238322] = { -- Dream Icon 2 : https://wowhead.com/forever/npc=238322/dream-icon-2
            [npcKeys.name] = "Dream Icon 2",
        },
        [238323] = { -- Reuse Me : https://wowhead.com/forever/npc=238323/reuse-me
            [npcKeys.name] = "Reuse Me",
        },
        [238371] = { -- Reuse Me : https://wowhead.com/forever/npc=238371/reuse-me
            [npcKeys.name] = "Reuse Me",
        },
        [238374] = { -- Dockhand : https://wowhead.com/forever/npc=238374/dockhand
            [npcKeys.name] = "Dockhand",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [238376] = { -- Brother Luctus : https://wowhead.com/forever/npc=238376/brother-luctus
            [npcKeys.name] = "Brother Luctus",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [238377] = { -- Dream Icon 3 : https://wowhead.com/forever/npc=238377/dream-icon-3
            [npcKeys.name] = "Dream Icon 3",
        },
        [238383] = { -- Xavian Interloper : https://wowhead.com/forever/npc=238383/xavian-interloper
            [npcKeys.name] = "Xavian Interloper",
        },
        [238415] = { -- Grok'lo Mok'lo : https://wowhead.com/forever/npc=238415/groklo-moklo
            [npcKeys.name] = "Grok'lo Mok'lo",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[8] = {{34.4, 65.4}, {34.4, 65.8}, {34.4, 66.6}, {34.6, 65.4}, {34.6, 65.8}, {34.8, 63.2}}, [16] = {{32.2, 54.4}, {32.2, 54.6}}, [46] = {{65.4, 55.2}, {65.6, 55.2}}, [440] = {{54.4, 28.4}, {54.4, 28.6}, {54.6, 28.2}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [238431] = { -- Enthusiastic Wisp : https://wowhead.com/forever/npc=238431/enthusiastic-wisp
            [npcKeys.name] = "Enthusiastic Wisp",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[618] = {{51.4, 90.4}, {51.4, 90.6}, {52, 89.2}, {52, 90.8}, {52.2, 90.4}, {52.6, 90.4}, {52.6, 90.6}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [238633] = { -- Sylena Duskveil : https://wowhead.com/forever/npc=238633/sylena-duskveil
            [npcKeys.name] = "Sylena Duskveil",
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [238637] = { -- Makeshift Trap : https://wowhead.com/forever/npc=238637/makeshift-trap
            [npcKeys.name] = "Makeshift Trap",
        },
        [238715] = { -- New Avalon Refugee : https://wowhead.com/forever/npc=238715/new-avalon-refugee
            [npcKeys.name] = "New Avalon Refugee",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [238825] = { -- Ernix Boomfizz : https://wowhead.com/forever/npc=238825/ernix-boomfizz
            [npcKeys.name] = "Ernix Boomfizz",
        },
        [239031] = { -- Scarlet Inquisitor Caldoran : https://wowhead.com/forever/npc=239031/scarlet-inquisitor-caldoran
            [npcKeys.name] = "Scarlet Inquisitor Caldoran",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [239036] = { -- Scarlet Crusader : https://wowhead.com/forever/npc=239036/scarlet-crusader
            [npcKeys.name] = "Scarlet Crusader",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [239047] = { -- Scarlet Siege Commander : https://wowhead.com/forever/npc=239047/scarlet-siege-commander
            [npcKeys.name] = "Scarlet Siege Commander",
            [npcKeys.minLevel] = 59,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [239599] = { -- Captive Druid : https://wowhead.com/forever/npc=239599/captive-druid
            [npcKeys.name] = "Captive Druid",
        },
        [239817] = { -- Dummy Quest Kill Credit : https://wowhead.com/forever/npc=239817/dummy-quest-kill-credit
            [npcKeys.name] = "Dummy Quest Kill Credit",
        },
        [239820] = { -- Dummy Quest Kill Credit : https://wowhead.com/forever/npc=239820/dummy-quest-kill-credit
            [npcKeys.name] = "Dummy Quest Kill Credit",
        },
        [239822] = { -- Commander Truesong : https://wowhead.com/forever/npc=239822/commander-truesong
            [npcKeys.name] = "Commander Truesong",
            [npcKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [239831] = { -- Saria Fairmoon : https://wowhead.com/forever/npc=239831/saria-fairmoon
            [npcKeys.name] = "Saria Fairmoon",
            [npcKeys.spawns] = {[16] = {{50.4, 42.6}}},
            [npcKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [239855] = { -- Dummy Quest Kill Credit : https://wowhead.com/forever/npc=239855/dummy-quest-kill-credit
            [npcKeys.name] = "Dummy Quest Kill Credit",
        },
        [239939] = { -- Lord Sarthiss : https://wowhead.com/forever/npc=239939/lord-sarthiss
            [npcKeys.name] = "Lord Sarthiss",
        },
        [239942] = { -- Lady Sesspira : https://wowhead.com/forever/npc=239942/lady-sesspira
            [npcKeys.name] = "Lady Sesspira",
        },
        [239961] = { -- Xavian Nightmare Hellcaller : https://wowhead.com/forever/npc=239961/xavian-nightmare-hellcaller
            [npcKeys.name] = "Xavian Nightmare Hellcaller",
        },
        [239963] = { -- Xavian Nightmare Rogue : https://wowhead.com/forever/npc=239963/xavian-nightmare-rogue
            [npcKeys.name] = "Xavian Nightmare Rogue",
        },
        [239964] = { -- Xavian Nightmare Felsworn : https://wowhead.com/forever/npc=239964/xavian-nightmare-felsworn
            [npcKeys.name] = "Xavian Nightmare Felsworn",
        },
        [239965] = { -- Xavian Nightmare Betrayer : https://wowhead.com/forever/npc=239965/xavian-nightmare-betrayer
            [npcKeys.name] = "Xavian Nightmare Betrayer",
        },
        [239966] = { -- Storm Bay Tidecaller : https://wowhead.com/forever/npc=239966/storm-bay-tidecaller
            [npcKeys.name] = "Storm Bay Tidecaller",
        },
        [239971] = { -- Razorgill : https://wowhead.com/forever/npc=239971/razorgill
            [npcKeys.name] = "Razorgill",
        },
        [240247] = { -- Scarlet Bloodhound : https://wowhead.com/forever/npc=240247/scarlet-bloodhound
            [npcKeys.name] = "Scarlet Bloodhound",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 62,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [240352] = { -- Mana Elemental : https://wowhead.com/forever/npc=240352/mana-elemental
            [npcKeys.name] = "Mana Elemental",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.spawns] = {[41] = {{52, 36.4}, {52, 36.6}, {52.4, 34.4}, {52.4, 34.6}, {52.6, 34.4}, {52.6, 34.8}}},
            [npcKeys.zoneID] = zoneIDs.DEADWIND_PASS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [240482] = { -- Berdun Cliffbrew : https://wowhead.com/forever/npc=240482/berdun-cliffbrew
            [npcKeys.name] = "Berdun Cliffbrew",
            [npcKeys.spawns] = {[16] = {{12.4, 77.2}}},
            [npcKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [240527] = { -- Enraged Tempest : https://wowhead.com/forever/npc=240527/enraged-tempest
            [npcKeys.name] = "Enraged Tempest",
        },
        [240604] = { -- Carrie Hearthfire : https://wowhead.com/forever/npc=240604/carrie-hearthfire
            [npcKeys.name] = "Carrie Hearthfire",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [240607] = { -- Devon Woods : https://wowhead.com/forever/npc=240607/devon-woods
            [npcKeys.name] = "Devon Woods",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [240964] = { -- Corrupted Grell : https://wowhead.com/forever/npc=240964/corrupted-grell
            [npcKeys.name] = "Corrupted Grell",
        },
        [241120] = { -- Scarlet Footman : https://wowhead.com/forever/npc=241120/scarlet-footman
            [npcKeys.name] = "Scarlet Footman",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 62,
        },
        [241121] = { -- Scarlet Archer : https://wowhead.com/forever/npc=241121/scarlet-archer
            [npcKeys.name] = "Scarlet Archer",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 62,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [241122] = { -- Scarlet Confessor : https://wowhead.com/forever/npc=241122/scarlet-confessor
            [npcKeys.name] = "Scarlet Confessor",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 62,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [241123] = { -- Scarlet Priest : https://wowhead.com/forever/npc=241123/scarlet-priest
            [npcKeys.name] = "Scarlet Priest",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 62,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [241320] = { -- Fel-Warped Shade : https://wowhead.com/forever/npc=241320/fel-warped-shade
            [npcKeys.name] = "Fel-Warped Shade",
        },
        [241571] = { -- Bone Kodo : https://wowhead.com/forever/npc=241571/bone-kodo
            [npcKeys.name] = "Bone Kodo",
        },
        [241584] = { -- Skull : https://wowhead.com/forever/npc=241584/skull
            [npcKeys.name] = "Skull",
        },
        [241616] = { -- Scarlet Trainee : https://wowhead.com/forever/npc=241616/scarlet-trainee
            [npcKeys.name] = "Scarlet Trainee",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [241877] = { -- Mayor Quimby : https://wowhead.com/forever/npc=241877/mayor-quimby
            [npcKeys.name] = "Mayor Quimby",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 61,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [242059] = { -- Dark Strand Intercessor : https://wowhead.com/forever/npc=242059/dark-strand-intercessor
            [npcKeys.name] = "Dark Strand Intercessor",
        },
        [242115] = { -- Gol'gere Deathmoon : https://wowhead.com/forever/npc=242115/golgere-deathmoon
            [npcKeys.name] = "Gol'gere Deathmoon",
        },
        [242145] = { -- Unknown Phantasm : https://wowhead.com/forever/npc=242145/unknown-phantasm
            [npcKeys.name] = "Unknown Phantasm",
        },
        [242290] = { -- Twilight Bodyguard : https://wowhead.com/forever/npc=242290/twilight-bodyguard
            [npcKeys.name] = "Twilight Bodyguard",
        },
        [242367] = { -- New Avalon Citizen : https://wowhead.com/forever/npc=242367/new-avalon-citizen
            [npcKeys.name] = "New Avalon Citizen",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 61,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [242498] = { -- Reagent Bot : https://wowhead.com/forever/npc=242498/reagent-bot
            [npcKeys.name] = "Reagent Bot",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[1] = {{46.6, 53.8}}, [12] = {{26.4, 83.8}, {32, 49.2}, {32.4, 50.2}, {32.6, 52.2}, {33.2, 50.6}, {34.2, 50.8}, {34.2, 53}, {42.4, 65.4}, {42.4, 66}, {42.6, 65.6}, {44.8, 63.2}, {47, 69.4}, {60.8, 55.8}}, [14] = {{45.4, 12.6}, {45.6, 12.4}, {45.6, 12.8}, {45.8, 13.6}, {52, 32.6}, {52, 47.4}, {52.2, 42.6}, {52.4, 42.4}, {52.6, 43}, {54.4, 10.6}}, [17] = {{43.8, 14.4}, {46, 36.4}, {46, 36.6}, {46.8, 35.8}, {51, 29.2}, {51.8, 30.4}, {52, 30.6}, {53.4, 52.2}, {54.4, 22.8}, {61.2, 45.2}, {62, 39}, {63, 38.2}}, [38] = {{26, 17.2}, {26.2, 18.8}, {27.8, 51}, {28.2, 65.2}, {28.8, 66.6}, {29, 60.6}, {30, 58.8}, {31.2, 70.4}, {31.6, 55.2}, {32.4, 50}, {32.4, 50.6}, {32.8, 51.2}, {32.8, 51.6}, {33, 49.2}, {34, 50}, {34.4, 47.2}, {35.2, 46.8}, {35.6, 46.6}, {36.4, 46.2}, {40.8, 38.8}, {44, 12.8}, {49.6, 12.6}, {59, 15.4}, {63.6, 48.6}, {65.2, 65.2}}, [40] = {{33.2, 56}, {37.4, 77.6}, {37.4, 85.8}, {38.4, 82.8}, {40, 33.8}, {41.4, 72}, {42.4, 71.2}, {42.6, 71}, {43, 70.2}, {44.2, 28.4}, {44.4, 69.6}, {45, 69}, {51.4, 52.2}, {53.4, 52.6}, {53.6, 52.4}, {54.6, 51.6}, {55.4, 30.8}, {55.4, 48.2}, {55.6, 47.4}, {55.6, 47.6}, {56, 31.4}, {56, 52}, {56.2, 66.4}, {56.4, 53.2}, {57, 23.2}, {59.2, 19.6}}, [85] = {{59, 51.4}, {60.4, 52.2}, {60.8, 53}, {61.2, 53.6}, {61.8, 64.6}, {62, 63.8}}, [130] = {{43.6, 41.4}, {44.2, 41.6}, {45, 21}, {45, 67.8}, {45.2, 41.6}, {45.8, 39.4}, {45.8, 68.2}, {46.8, 40.8}, {47, 40.4}, {47.6, 39.6}}, [148] = {{32.4, 43.6}, {36, 47.6}, {36.8, 46.4}, {37.4, 43.6}, {37.6, 43.8}, {38.8, 43.6}, {41, 45.2}, {41, 50}, {42.2, 37.2}}, [16593] = {{41.8, 44.8}, {44.2, 45}, {51.8, 70}, {55.8, 61}, {58.8, 41}, {59.2, 79.8}, {61.8, 39}, {62.4, 73.8}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [242551] = { -- Leyara : https://wowhead.com/forever/npc=242551/leyara
            [npcKeys.name] = "Leyara",
        },
        [243046] = { -- Scarlet Captain : https://wowhead.com/forever/npc=243046/scarlet-captain
            [npcKeys.name] = "Scarlet Captain",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [243089] = { -- Alpine Chipmunk : https://wowhead.com/forever/npc=243089/alpine-chipmunk
            [npcKeys.name] = "Alpine Chipmunk",
        },
        [243090] = { -- Elfin Rabbit : https://wowhead.com/forever/npc=243090/elfin-rabbit
            [npcKeys.name] = "Elfin Rabbit",
            [npcKeys.spawns] = {[616] = {{59.2, 46.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [243254] = { -- Leonid Barthalomew : https://wowhead.com/forever/npc=243254/leonid-barthalomew
            [npcKeys.name] = "Leonid Barthalomew",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [243255] = { -- Scarlet Crusader : https://wowhead.com/forever/npc=243255/scarlet-crusader
            [npcKeys.name] = "Scarlet Crusader",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [243394] = { -- Percival Barthalomew : https://wowhead.com/forever/npc=243394/percival-barthalomew
            [npcKeys.name] = "Percival Barthalomew",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [243509] = { -- Noxious Slime : https://wowhead.com/forever/npc=243509/noxious-slime
            [npcKeys.name] = "Noxious Slime",
        },
        [243815] = { -- Sebelia : https://wowhead.com/forever/npc=243815/sebelia
            [npcKeys.name] = "Sebelia",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{70.8, 51.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [243855] = { -- Toron Rockhoof : https://wowhead.com/forever/npc=243855/toron-rockhoof
            [npcKeys.name] = "Toron Rockhoof",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{69, 47.2}, {69, 47.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [243923] = { -- Kel'rah the Shadowhunter : https://wowhead.com/forever/npc=243923/kelrah-the-shadowhunter
            [npcKeys.name] = "Kel'rah the Shadowhunter",
        },
        [243952] = { -- Thurandris Nightrage : https://wowhead.com/forever/npc=243952/thurandris-nightrage
            [npcKeys.name] = "Thurandris Nightrage",
        },
        [244129] = { -- Legashi Rogue : https://wowhead.com/forever/npc=244129/legashi-rogue
            [npcKeys.name] = "Legashi Rogue",
        },
        [244130] = { -- Legashi Satyr : https://wowhead.com/forever/npc=244130/legashi-satyr
            [npcKeys.name] = "Legashi Satyr",
        },
        [244188] = { -- Scalebeard : https://wowhead.com/forever/npc=244188/scalebeard
            [npcKeys.name] = "Scalebeard",
        },
        [244420] = { -- Remorseless Tormentor : https://wowhead.com/forever/npc=244420/remorseless-tormentor
            [npcKeys.name] = "Remorseless Tormentor",
        },
        [244425] = { -- Barkskin Matriarch : https://wowhead.com/forever/npc=244425/barkskin-matriarch
            [npcKeys.name] = "Barkskin Matriarch",
            [npcKeys.spawns] = {[616] = {{31.6, 58.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [244511] = { -- Zet'gan : https://wowhead.com/forever/npc=244511/zetgan
            [npcKeys.name] = "Zet'gan",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{14, 54.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [244512] = { -- Ortak Lomgok : https://wowhead.com/forever/npc=244512/ortak-lomgok
            [npcKeys.name] = "Ortak Lomgok",
            [npcKeys.spawns] = {[616] = {{12.8, 52.4}, {13, 52.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [244517] = { -- Sefira Everbright : https://wowhead.com/forever/npc=244517/sefira-everbright
            [npcKeys.name] = "Sefira Everbright",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{15.4, 54.2}, {15.4, 55}, {15.6, 54.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [244525] = { -- Hyjal Bear : https://wowhead.com/forever/npc=244525/hyjal-bear
            [npcKeys.name] = "Hyjal Bear",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 56,
            [npcKeys.spawns] = {[616] = {{44.6, 54}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [244530] = { -- Tainted Hyjal Bear : https://wowhead.com/forever/npc=244530/tainted-hyjal-bear
            [npcKeys.name] = "Tainted Hyjal Bear",
        },
        [244807] = { -- Tim's Test Creature : https://wowhead.com/forever/npc=244807/tims-test-creature
            [npcKeys.name] = "Tim's Test Creature",
        },
        [244808] = { -- Aramis Hammerhand : https://wowhead.com/forever/npc=244808/aramis-hammerhand
            [npcKeys.name] = "Aramis Hammerhand",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[85] = {{31, 66.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {90902, 91208, 91209, 98389},
            [npcKeys.questEnds] = {90902, 91208, 98389, 98601},
            [npcKeys.friendlyToFaction] = "H",
        },
        [244949] = { -- Chicken : https://wowhead.com/forever/npc=244949/chicken
            [npcKeys.name] = "Chicken",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[17] = {{61.4, 23.8}, {61.6, 23.8}}, [40] = {{56.2, 29.8}, {56.4, 31.4}, {56.6, 31.2}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [245263] = { -- (DNT) Vehicle Camera Test : https://wowhead.com/forever/npc=245263/dnt-vehicle-camera-test
            [npcKeys.name] = "(DNT) Vehicle Camera Test",
        },
        [245731] = { -- Mana Tide Totem IV : https://wowhead.com/forever/npc=245731/mana-tide-totem-iv
            [npcKeys.name] = "Mana Tide Totem IV",
        },
        [245999] = { -- Arcane Anomaly : https://wowhead.com/forever/npc=245999/arcane-anomaly
            [npcKeys.name] = "Arcane Anomaly",
        },
        [246003] = { -- Fel Ancient : https://wowhead.com/forever/npc=246003/fel-ancient
            [npcKeys.name] = "Fel Ancient",
        },
        [246008] = { -- Mana Devourer : https://wowhead.com/forever/npc=246008/mana-devourer
            [npcKeys.name] = "Mana Devourer",
        },
        [246016] = { -- Arcanic Enigma : https://wowhead.com/forever/npc=246016/arcanic-enigma
            [npcKeys.name] = "Arcanic Enigma",
        },
        [246017] = { -- Unstable Sentinel : https://wowhead.com/forever/npc=246017/unstable-sentinel
            [npcKeys.name] = "Unstable Sentinel",
        },
        [246020] = { -- Shade of the Archmage : https://wowhead.com/forever/npc=246020/shade-of-the-archmage
            [npcKeys.name] = "Shade of the Archmage",
        },
        [246133] = { -- Kill Credit Creature : https://wowhead.com/forever/npc=246133/kill-credit-creature
            [npcKeys.name] = "Kill Credit Creature",
        },
        [246143] = { -- Frightened Paladin : https://wowhead.com/forever/npc=246143/frightened-paladin
            [npcKeys.name] = "Frightened Paladin",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[85] = {{27.6, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [246152] = { -- Shari Stilwell : https://wowhead.com/forever/npc=246152/shari-stilwell
            [npcKeys.name] = "Shari Stilwell",
            [npcKeys.minLevel] = 16,
            [npcKeys.maxLevel] = 16,
            [npcKeys.spawns] = {[85] = {{60.2, 52.4}, {60.2, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {91282},
            [npcKeys.questEnds] = {91209, 99144},
            [npcKeys.friendlyToFaction] = "H",
        },
        [246249] = { -- Kobold Laborer : https://wowhead.com/forever/npc=246249/kobold-laborer
            [npcKeys.name] = "Kobold Laborer",
        },
        [246252] = { -- Kobold Vermin : https://wowhead.com/forever/npc=246252/kobold-vermin
            [npcKeys.name] = "Kobold Vermin",
        },
        [246258] = { -- Kobold Worker : https://wowhead.com/forever/npc=246258/kobold-worker
            [npcKeys.name] = "Kobold Worker",
        },
        [246263] = { -- Defias Thug : https://wowhead.com/forever/npc=246263/defias-thug
            [npcKeys.name] = "Defias Thug",
        },
        [246297] = { -- Violet Hold : https://wowhead.com/forever/npc=246297/violet-hold
            [npcKeys.name] = "Violet Hold",
        },
        [246310] = { -- Manamorph : https://wowhead.com/forever/npc=246310/manamorph
            [npcKeys.name] = "Manamorph",
        },
        [246324] = { -- Alchemy Trainer : https://wowhead.com/forever/npc=246324/alchemy-trainer
            [npcKeys.name] = "Alchemy Trainer",
        },
        [246344] = { -- Alodan the Hopeful : https://wowhead.com/forever/npc=246344/alodan-the-hopeful
            [npcKeys.name] = "Alodan the Hopeful",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1638] = {{25.4, 14.4}, {25.4, 14.6}, {25.6, 14.8}}},
            [npcKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [npcKeys.friendlyToFaction] = "H",
        },
        [246349] = { -- Breton Samuels : https://wowhead.com/forever/npc=246349/breton-samuels
            [npcKeys.name] = "Breton Samuels",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{21.8, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {91285, 91294},
            [npcKeys.questEnds] = {91282, 91285},
            [npcKeys.friendlyToFaction] = "H",
        },
        [246378] = { -- Danitha Morr : https://wowhead.com/forever/npc=246378/danitha-morr
            [npcKeys.name] = "Danitha Morr",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.spawns] = {[85] = {{22, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {91317, 91858, 94427, 94436, 95803},
            [npcKeys.questEnds] = {91294, 91317, 94435, 94441},
            [npcKeys.friendlyToFaction] = "H",
        },
        [246389] = { -- Hilda the Breaker : https://wowhead.com/forever/npc=246389/hilda-the-breaker
            [npcKeys.name] = "Hilda the Breaker",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{22, 47.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {99152},
            [npcKeys.questEnds] = {99152},
            [npcKeys.friendlyToFaction] = "H",
        },
        [246393] = { -- Jorin Croge : https://wowhead.com/forever/npc=246393/jorin-croge
            [npcKeys.name] = "Jorin Croge",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{22.4, 44.8}, {22.6, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {91316},
            [npcKeys.questEnds] = {91316},
            [npcKeys.friendlyToFaction] = "H",
        },
        [246394] = { -- Ander Solliden : https://wowhead.com/forever/npc=246394/ander-solliden
            [npcKeys.name] = "Ander Solliden",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[85] = {{22.2, 49.4}, {22.4, 49.6}, {22.6, 49.4}, {22.6, 49.6}, {23.6, 49.8}, {24.6, 50.6}, {25.4, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [246589] = { -- Skinning Bear : https://wowhead.com/forever/npc=246589/skinning-bear
            [npcKeys.name] = "Skinning Bear",
        },
        [246600] = { -- Mana Echo : https://wowhead.com/forever/npc=246600/mana-echo
            [npcKeys.name] = "Mana Echo",
        },
        [246602] = { -- Mana Fiend : https://wowhead.com/forever/npc=246602/mana-fiend
            [npcKeys.name] = "Mana Fiend",
        },
        [246611] = { -- Sevren Callahan : https://wowhead.com/forever/npc=246611/sevren-callahan
            [npcKeys.name] = "Sevren Callahan",
        },
        [246664] = { -- Fragmented Sentry : https://wowhead.com/forever/npc=246664/fragmented-sentry
            [npcKeys.name] = "Fragmented Sentry",
        },
        [246668] = { -- Kirin Tor Wizard : https://wowhead.com/forever/npc=246668/kirin-tor-wizard
            [npcKeys.name] = "Kirin Tor Wizard",
        },
        [246683] = { -- Mana Phantom : https://wowhead.com/forever/npc=246683/mana-phantom
            [npcKeys.name] = "Mana Phantom",
        },
        [246684] = { -- Mana Ray : https://wowhead.com/forever/npc=246684/mana-ray
            [npcKeys.name] = "Mana Ray",
        },
        [246690] = { -- Arcane Sentry : https://wowhead.com/forever/npc=246690/arcane-sentry
            [npcKeys.name] = "Arcane Sentry",
        },
        [246692] = { -- Adorean Lew : https://wowhead.com/forever/npc=246692/adorean-lew
            [npcKeys.name] = "Adorean Lew",
        },
        [246694] = { -- Bitty Frostflinger : https://wowhead.com/forever/npc=246694/bitty-frostflinger
            [npcKeys.name] = "Bitty Frostflinger",
        },
        [246695] = { -- Arcanist Alec : https://wowhead.com/forever/npc=246695/arcanist-alec
            [npcKeys.name] = "Arcanist Alec",
        },
        [246699] = { -- Linda Ann Kastinglow : https://wowhead.com/forever/npc=246699/linda-ann-kastinglow
            [npcKeys.name] = "Linda Ann Kastinglow",
        },
        [246700] = { -- Tomas Riogain : https://wowhead.com/forever/npc=246700/tomas-riogain
            [npcKeys.name] = "Tomas Riogain",
        },
        [246701] = { -- Grezla the Hag : https://wowhead.com/forever/npc=246701/grezla-the-hag
            [npcKeys.name] = "Grezla the Hag",
        },
        [246702] = { -- Fabioso the Fabulous : https://wowhead.com/forever/npc=246702/fabioso-the-fabulous
            [npcKeys.name] = "Fabioso the Fabulous",
        },
        [246704] = { -- Grindle Firespark : https://wowhead.com/forever/npc=246704/grindle-firespark
            [npcKeys.name] = "Grindle Firespark",
        },
        [246708] = { -- Magus Fansy Goodbringer : https://wowhead.com/forever/npc=246708/magus-fansy-goodbringer
            [npcKeys.name] = "Magus Fansy Goodbringer",
        },
        [246709] = { -- Babagahnoosh : https://wowhead.com/forever/npc=246709/babagahnoosh
            [npcKeys.name] = "Babagahnoosh",
            [npcKeys.spawns] = {[36] = {{15.6, 70.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [246732] = { -- Merleaux : https://wowhead.com/forever/npc=246732/merleaux
            [npcKeys.name] = "Merleaux",
        },
        [246734] = { -- Sabriana Sorrowgaze : https://wowhead.com/forever/npc=246734/sabriana-sorrowgaze
            [npcKeys.name] = "Sabriana Sorrowgaze",
        },
        [246736] = { -- Emeline Fizzlefry : https://wowhead.com/forever/npc=246736/emeline-fizzlefry
            [npcKeys.name] = "Emeline Fizzlefry",
        },
        [246737] = { -- Dorfus Alphamage : https://wowhead.com/forever/npc=246737/dorfus-alphamage
            [npcKeys.name] = "Dorfus Alphamage",
        },
        [246738] = { -- Illusionist Karina : https://wowhead.com/forever/npc=246738/illusionist-karina
            [npcKeys.name] = "Illusionist Karina",
        },
        [246739] = { -- Joboba Mezbreaker : https://wowhead.com/forever/npc=246739/joboba-mezbreaker
            [npcKeys.name] = "Joboba Mezbreaker",
        },
        [246740] = { -- Lofwyr Le'Fleur : https://wowhead.com/forever/npc=246740/lofwyr-lefleur
            [npcKeys.name] = "Lofwyr Le'Fleur",
        },
        [246741] = { -- Natalie Tootieblair : https://wowhead.com/forever/npc=246741/natalie-tootieblair
            [npcKeys.name] = "Natalie Tootieblair",
        },
        [246743] = { -- Minigob Manabonk : https://wowhead.com/forever/npc=246743/minigob-manabonk
            [npcKeys.name] = "Minigob Manabonk",
        },
        [246745] = { -- Archmage Celindra : https://wowhead.com/forever/npc=246745/archmage-celindra
            [npcKeys.name] = "Archmage Celindra",
        },
        [246747] = { -- Archmage Pentarus : https://wowhead.com/forever/npc=246747/archmage-pentarus
            [npcKeys.name] = "Archmage Pentarus",
        },
        [246748] = { -- Archmage Modera : https://wowhead.com/forever/npc=246748/archmage-modera
            [npcKeys.name] = "Archmage Modera",
        },
        [246751] = { -- Alchemist Burroughs : https://wowhead.com/forever/npc=246751/alchemist-burroughs
            [npcKeys.name] = "Alchemist Burroughs",
        },
        [246752] = { -- Arcanist Ginsberg : https://wowhead.com/forever/npc=246752/arcanist-ginsberg
            [npcKeys.name] = "Arcanist Ginsberg",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [246753] = { -- Conjurer Weinhaus : https://wowhead.com/forever/npc=246753/conjurer-weinhaus
            [npcKeys.name] = "Conjurer Weinhaus",
        },
        [246754] = { -- Rheaume : https://wowhead.com/forever/npc=246754/rheaume
            [npcKeys.name] = "Rheaume",
        },
        [246755] = { -- Scribe Whitman : https://wowhead.com/forever/npc=246755/scribe-whitman
            [npcKeys.name] = "Scribe Whitman",
        },
        [246756] = { -- Timothy Jones : https://wowhead.com/forever/npc=246756/timothy-jones
            [npcKeys.name] = "Timothy Jones",
        },
        [246757] = { -- Alturas : https://wowhead.com/forever/npc=246757/alturas
            [npcKeys.name] = "Alturas",
        },
        [246760] = { -- Alvareux : https://wowhead.com/forever/npc=246760/alvareux
            [npcKeys.name] = "Alvareux",
        },
        [246762] = { -- Barian Maryla : https://wowhead.com/forever/npc=246762/barian-maryla
            [npcKeys.name] = "Barian Maryla",
        },
        [246790] = { -- Breanni : https://wowhead.com/forever/npc=246790/breanni
            [npcKeys.name] = "Breanni",
        },
        [246792] = { -- Edward Egan : https://wowhead.com/forever/npc=246792/edward-egan
            [npcKeys.name] = "Edward Egan",
        },
        [246793] = { -- Patricia Egan : https://wowhead.com/forever/npc=246793/patricia-egan
            [npcKeys.name] = "Patricia Egan",
        },
        [246794] = { -- Dorothy Egan : https://wowhead.com/forever/npc=246794/dorothy-egan
            [npcKeys.name] = "Dorothy Egan",
        },
        [246795] = { -- Linzy Blackbolt : https://wowhead.com/forever/npc=246795/linzy-blackbolt
            [npcKeys.name] = "Linzy Blackbolt",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{18.4, 62.4}, {18.6, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [246797] = { -- Jessa Weaver : https://wowhead.com/forever/npc=246797/jessa-weaver
            [npcKeys.name] = "Jessa Weaver",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{17.6, 69.4}, {17.6, 69.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [246799] = { -- Arcane Sentry : https://wowhead.com/forever/npc=246799/arcane-sentry
            [npcKeys.name] = "Arcane Sentry",
        },
        [246800] = { -- Kirin Tor Wizard : https://wowhead.com/forever/npc=246800/kirin-tor-wizard
            [npcKeys.name] = "Kirin Tor Wizard",
        },
        [246805] = { -- Kirin Tor Wizard : https://wowhead.com/forever/npc=246805/kirin-tor-wizard
            [npcKeys.name] = "Kirin Tor Wizard",
        },
        [246848] = { -- Kirin Tor Guard : https://wowhead.com/forever/npc=246848/kirin-tor-guard
            [npcKeys.name] = "Kirin Tor Guard",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[36] = {{10.4, 68.4}, {10.4, 68.6}, {10.6, 68.6}, {11.8, 54.4}, {13.2, 60.8}, {13.4, 57.8}, {14, 52.8}, {14, 57.6}, {14, 59.4}, {14, 59.6}, {14.4, 57.4}, {14.4, 67.4}, {14.6, 65.8}, {14.6, 69.6}, {15.2, 73.4}, {15.2, 76.4}, {15.2, 76.6}, {15.6, 73.8}, {16, 71.8}, {16.4, 63.4}, {16.4, 69.4}, {16.4, 69.8}, {16.6, 63.8}, {16.6, 74}, {17.2, 65.4}, {17.2, 65.6}, {19, 65}, {19.2, 68.6}, {19.4, 68.4}, {19.6, 68.6}, {20.4, 81.2}, {20.6, 69}, {20.6, 80.4}, {20.8, 70}, {20.8, 80.8}, {21, 71}, {22, 68.2}, {22.8, 67.8}, {23.6, 57.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [246888] = { -- Arcane Elemental : https://wowhead.com/forever/npc=246888/arcane-elemental
            [npcKeys.name] = "Arcane Elemental",
        },
        [246890] = { -- Arcane Manaling : https://wowhead.com/forever/npc=246890/arcane-manaling
            [npcKeys.name] = "Arcane Manaling",
        },
        [246893] = { -- Arcane Manaling : https://wowhead.com/forever/npc=246893/arcane-manaling
            [npcKeys.name] = "Arcane Manaling",
        },
        [246900] = { -- Fragmented Sentry : https://wowhead.com/forever/npc=246900/fragmented-sentry
            [npcKeys.name] = "Fragmented Sentry",
        },
        [246920] = { -- Blood Elf Arcanist : https://wowhead.com/forever/npc=246920/blood-elf-arcanist
            [npcKeys.name] = "Blood Elf Arcanist",
        },
        [246931] = { -- Mana Wraith : https://wowhead.com/forever/npc=246931/mana-wraith
            [npcKeys.name] = "Mana Wraith",
        },
        [246990] = { -- Phantasm : https://wowhead.com/forever/npc=246990/phantasm
            [npcKeys.name] = "Phantasm",
        },
        [246991] = { -- Magister Hawkhelm : https://wowhead.com/forever/npc=246991/magister-hawkhelm
            [npcKeys.name] = "Magister Hawkhelm",
        },
        [246992] = { -- Arcane Echo : https://wowhead.com/forever/npc=246992/arcane-echo
            [npcKeys.name] = "Arcane Echo",
        },
        [246993] = { -- Mana Stalker : https://wowhead.com/forever/npc=246993/mana-stalker
            [npcKeys.name] = "Mana Stalker",
        },
        [247001] = { -- Saturated Remnant : https://wowhead.com/forever/npc=247001/saturated-remnant
            [npcKeys.name] = "Saturated Remnant",
        },
        [247003] = { -- Seeking Remnant : https://wowhead.com/forever/npc=247003/seeking-remnant
            [npcKeys.name] = "Seeking Remnant",
        },
        [247006] = { -- Lieutenant Suncrest : https://wowhead.com/forever/npc=247006/lieutenant-suncrest
            [npcKeys.name] = "Lieutenant Suncrest",
        },
        [247013] = { -- Ranger Lydrea : https://wowhead.com/forever/npc=247013/ranger-lydrea
            [npcKeys.name] = "Ranger Lydrea",
        },
        [247015] = { -- Vek'zol : https://wowhead.com/forever/npc=247015/vekzol
            [npcKeys.name] = "Vek'zol",
        },
        [247016] = { -- Suffused Treant : https://wowhead.com/forever/npc=247016/suffused-treant
            [npcKeys.name] = "Suffused Treant",
        },
        [247017] = { -- Suffused Treant : https://wowhead.com/forever/npc=247017/suffused-treant
            [npcKeys.name] = "Suffused Treant",
        },
        [247032] = { -- Lyn the Ignored : https://wowhead.com/forever/npc=247032/lyn-the-ignored
            [npcKeys.name] = "Lyn the Ignored",
        },
        [247033] = { -- Bloodshrike : https://wowhead.com/forever/npc=247033/bloodshrike
            [npcKeys.name] = "Bloodshrike",
        },
        [247047] = { -- Mindless Skeleton : https://wowhead.com/forever/npc=247047/mindless-skeleton
            [npcKeys.name] = "Mindless Skeleton",
        },
        [247126] = { -- Atrexis the Grave Knight : https://wowhead.com/forever/npc=247126/atrexis-the-grave-knight
            [npcKeys.name] = "Atrexis the Grave Knight",
        },
        [247215] = { -- Alfred the Alchemist : https://wowhead.com/forever/npc=247215/alfred-the-alchemist
            [npcKeys.name] = "Alfred the Alchemist",
        },
        [247216] = { -- Jason Stonepike : https://wowhead.com/forever/npc=247216/jason-stonepike
            [npcKeys.name] = "Jason Stonepike",
        },
        [247217] = { -- Sarah Fairwater : https://wowhead.com/forever/npc=247217/sarah-fairwater
            [npcKeys.name] = "Sarah Fairwater",
        },
        [247218] = { -- Merideth : https://wowhead.com/forever/npc=247218/merideth
            [npcKeys.name] = "Merideth",
        },
        [247219] = { -- Mittiny Cogwrench : https://wowhead.com/forever/npc=247219/mittiny-cogwrench
            [npcKeys.name] = "Mittiny Cogwrench",
        },
        [247221] = { -- Harold Justice : https://wowhead.com/forever/npc=247221/harold-justice
            [npcKeys.name] = "Harold Justice",
        },
        [247222] = { -- Ol' Fish Eye : https://wowhead.com/forever/npc=247222/ol-fish-eye
            [npcKeys.name] = "Ol' Fish Eye",
        },
        [247223] = { -- Nancy Songflower : https://wowhead.com/forever/npc=247223/nancy-songflower
            [npcKeys.name] = "Nancy Songflower",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[12] = {{52.2, 43.4}, {52.4, 43.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.friendlyToFaction] = "A",
        },
        [247224] = { -- Hannah Peltskinner : https://wowhead.com/forever/npc=247224/hannah-peltskinner
            [npcKeys.name] = "Hannah Peltskinner",
        },
        [247226] = { -- Kelsey Fargo : https://wowhead.com/forever/npc=247226/kelsey-fargo
            [npcKeys.name] = "Kelsey Fargo",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[12] = {{47.2, 32.2}, {47.2, 32.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {91752},
            [npcKeys.questEnds] = {91745},
            [npcKeys.friendlyToFaction] = "A",
        },
        [247227] = { -- Riley Peltskinner : https://wowhead.com/forever/npc=247227/riley-peltskinner
            [npcKeys.name] = "Riley Peltskinner",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[12] = {{47, 39.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.friendlyToFaction] = "A",
        },
        [247228] = { -- Rebecca Thimble : https://wowhead.com/forever/npc=247228/rebecca-thimble
            [npcKeys.name] = "Rebecca Thimble",
        },
        [247229] = { -- Daniel : https://wowhead.com/forever/npc=247229/daniel
            [npcKeys.name] = "Daniel",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[12] = {{49.4, 40.4}, {49.4, 40.6}, {49.6, 40.4}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questEnds] = {92124},
            [npcKeys.friendlyToFaction] = "A",
        },
        [247264] = { -- Emissary Jacques : https://wowhead.com/forever/npc=247264/emissary-jacques
            [npcKeys.name] = "Emissary Jacques",
            [npcKeys.spawns] = {[267] = {{48.2, 60}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [247442] = { -- Sealing Crystal : https://wowhead.com/forever/npc=247442/sealing-crystal
            [npcKeys.name] = "Sealing Crystal",
        },
        [247443] = { -- Focus Crystal : https://wowhead.com/forever/npc=247443/focus-crystal
            [npcKeys.name] = "Focus Crystal",
        },
        [247449] = { -- Sin'dorei Tome of Summoning : https://wowhead.com/forever/npc=247449/sindorei-tome-of-summoning
            [npcKeys.name] = "Sin'dorei Tome of Summoning",
        },
        [247470] = { -- Makrinni Burrower : https://wowhead.com/forever/npc=247470/makrinni-burrower
            [npcKeys.name] = "Makrinni Burrower",
        },
        [247473] = { -- Izvi Gildfizz : https://wowhead.com/forever/npc=247473/izvi-gildfizz
            [npcKeys.name] = "Izvi Gildfizz",
            [npcKeys.spawns] = {[16] = {{22.4, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.AZSHARA,
        },
        [247496] = { -- Barkskin Cub : https://wowhead.com/forever/npc=247496/barkskin-cub
            [npcKeys.name] = "Barkskin Cub",
        },
        [247497] = { -- Barkskin Patriarch : https://wowhead.com/forever/npc=247497/barkskin-patriarch
            [npcKeys.name] = "Barkskin Patriarch",
        },
        [247675] = { -- Tokra Rockheaver : https://wowhead.com/forever/npc=247675/tokra-rockheaver
            [npcKeys.name] = "Tokra Rockheaver",
        },
        [247690] = { -- Jason Quin : https://wowhead.com/forever/npc=247690/jason-quin
            [npcKeys.name] = "Jason Quin",
        },
        [247718] = { -- Cow Doll : https://wowhead.com/forever/npc=247718/cow-doll
            [npcKeys.name] = "Cow Doll",
        },
        [247751] = { -- Stalker : https://wowhead.com/forever/npc=247751/stalker
            [npcKeys.name] = "Stalker",
        },
        [247777] = { -- Weapon Vendor : https://wowhead.com/forever/npc=247777/weapon-vendor
            [npcKeys.name] = "Weapon Vendor",
        },
        [247809] = { -- Young Wolf : https://wowhead.com/forever/npc=247809/young-wolf
            [npcKeys.name] = "Young Wolf",
        },
        [247912] = { -- Cooking Bear : https://wowhead.com/forever/npc=247912/cooking-bear
            [npcKeys.name] = "Cooking Bear",
        },
        [247914] = { -- Cooking Wolf : https://wowhead.com/forever/npc=247914/cooking-wolf
            [npcKeys.name] = "Cooking Wolf",
        },
        [247972] = { -- Celegosa : https://wowhead.com/forever/npc=247972/celegosa
            [npcKeys.name] = "Celegosa",
        },
        [247984] = { -- Ley Line Rift : https://wowhead.com/forever/npc=247984/ley-line-rift
            [npcKeys.name] = "Ley Line Rift",
        },
        [248041] = { -- Hyjal Stag : https://wowhead.com/forever/npc=248041/hyjal-stag
            [npcKeys.name] = "Hyjal Stag",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[616] = {{42.8, 50}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [248042] = { -- Tainted Hyjal Stag : https://wowhead.com/forever/npc=248042/tainted-hyjal-stag
            [npcKeys.name] = "Tainted Hyjal Stag",
        },
        [248192] = { -- Large Noxious Slime : https://wowhead.com/forever/npc=248192/large-noxious-slime
            [npcKeys.name] = "Large Noxious Slime",
        },
        [248196] = { -- Apothecary Durelle : https://wowhead.com/forever/npc=248196/apothecary-durelle
            [npcKeys.name] = "Apothecary Durelle",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.8, 29.4}, {49.8, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248197] = { -- Gor'mak : https://wowhead.com/forever/npc=248197/gormak
            [npcKeys.name] = "Gor'mak",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.8, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248198] = { -- Aza'bek : https://wowhead.com/forever/npc=248198/azabek
            [npcKeys.name] = "Aza'bek",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.6, 29.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248199] = { -- Beneris : https://wowhead.com/forever/npc=248199/beneris
            [npcKeys.name] = "Beneris",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.6, 29.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248200] = { -- Fizzlefuse : https://wowhead.com/forever/npc=248200/fizzlefuse
            [npcKeys.name] = "Fizzlefuse",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.8, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248201] = { -- Pawani : https://wowhead.com/forever/npc=248201/pawani
            [npcKeys.name] = "Pawani",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.6, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248202] = { -- Jim'bek : https://wowhead.com/forever/npc=248202/jimbek
            [npcKeys.name] = "Jim'bek",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.6, 29.4}, {49.6, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248242] = { -- Hamish Bergwort : https://wowhead.com/forever/npc=248242/hamish-bergwort
            [npcKeys.name] = "Hamish Bergwort",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[12] = {{65, 69.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {91723, 91724},
            [npcKeys.questEnds] = {91723, 91724},
            [npcKeys.friendlyToFaction] = "A",
        },
        [248248] = { -- Blixie Fitzwink : https://wowhead.com/forever/npc=248248/blixie-fitzwink
            [npcKeys.name] = "Blixie Fitzwink",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[12] = {{63.2, 72.4}, {63.2, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {91725},
            [npcKeys.questEnds] = {91725},
            [npcKeys.friendlyToFaction] = "A",
        },
        [248265] = { -- Ormin Pelford : https://wowhead.com/forever/npc=248265/ormin-pelford
            [npcKeys.name] = "Ormin Pelford",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[12] = {{76.4, 72}, {76.6, 72}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {91733},
            [npcKeys.questEnds] = {91733},
            [npcKeys.friendlyToFaction] = "A",
        },
        [248266] = { -- Hagar Lowe : https://wowhead.com/forever/npc=248266/hagar-lowe
            [npcKeys.name] = "Hagar Lowe",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[12] = {{82.4, 63.8}, {82.6, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {91732},
            [npcKeys.questEnds] = {91732},
            [npcKeys.friendlyToFaction] = "A",
        },
        [248277] = { -- Merell Ross : https://wowhead.com/forever/npc=248277/merell-ross
            [npcKeys.name] = "Merell Ross",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[12] = {{84.4, 79.2}, {84.6, 79.2}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questEnds] = {91740},
            [npcKeys.friendlyToFaction] = "A",
        },
        [248278] = { -- Croaky : https://wowhead.com/forever/npc=248278/croaky
            [npcKeys.name] = "Croaky",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[12] = {{74.4, 86}, {74.8, 85}, {75, 86.6}, {75.2, 76.2}, {75.2, 80.6}, {75.4, 83}, {75.4, 86.2}, {76.2, 84.4}, {76.4, 83.2}, {76.4, 85.4}, {76.4, 85.8}, {76.4, 87.4}, {76.6, 85.2}, {76.6, 86}, {76.6, 86.8}, {76.8, 84.2}, {77.6, 84}, {77.6, 86}, {77.8, 82.6}, {78, 85}, {79.8, 86.4}}},
        },
        [248299] = { -- Elmpaw : https://wowhead.com/forever/npc=248299/elmpaw
            [npcKeys.name] = "Elmpaw",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[12] = {{73, 38.6}, {73.4, 40.2}, {73.6, 36}, {74.4, 41.8}, {74.6, 40}, {76.8, 37.6}, {76.8, 39}, {77.6, 37.8}, {78, 40}, {81.4, 85}, {81.4, 85.6}, {81.6, 85.4}, {81.8, 84.2}, {82, 82.4}, {82, 87.4}, {83.2, 87.4}, {83.8, 85.8}, {84, 81.8}, {86, 81}, {86.2, 80.2}, {87.6, 78.8}, {88, 80}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [248301] = { -- Minimus Tentaculus : https://wowhead.com/forever/npc=248301/minimus-tentaculus
            [npcKeys.name] = "Minimus Tentaculus",
        },
        [248333] = { -- Minimus Tentaculus : https://wowhead.com/forever/npc=248333/minimus-tentaculus
            [npcKeys.name] = "Minimus Tentaculus",
        },
        [248347] = { -- Tree Invis Stalker : https://wowhead.com/forever/npc=248347/tree-invis-stalker
            [npcKeys.name] = "Tree Invis Stalker",
        },
        [248362] = { -- Shinyfinder Narf : https://wowhead.com/forever/npc=248362/shinyfinder-narf
            [npcKeys.name] = "Shinyfinder Narf",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[12] = {{49, 28.8}, {49.2, 27.9}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [248366] = { -- Fraxinus : https://wowhead.com/forever/npc=248366/fraxinus
            [npcKeys.name] = "Fraxinus",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{53.6, 84.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [248367] = { -- Hyacinth : https://wowhead.com/forever/npc=248367/hyacinth
            [npcKeys.name] = "Hyacinth",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{54.2, 84}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [248395] = { -- Tainted Shrubbery : https://wowhead.com/forever/npc=248395/tainted-shrubbery
            [npcKeys.name] = "Tainted Shrubbery",
        },
        [248415] = { -- Tordrin Sternblade : https://wowhead.com/forever/npc=248415/tordrin-sternblade
            [npcKeys.name] = "Tordrin Sternblade",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[12] = {{51, 40.4}, {51.2, 40.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {91772},
            [npcKeys.questEnds] = {91758, 92479},
            [npcKeys.friendlyToFaction] = "A",
        },
        [248419] = { -- Mirt : https://wowhead.com/forever/npc=248419/mirt
            [npcKeys.name] = "Mirt",
            [npcKeys.spawns] = {[616] = {{15.6, 52.4}, {15.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [248463] = { -- Rumbler : https://wowhead.com/forever/npc=248463/rumbler
            [npcKeys.name] = "Rumbler",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[12] = {{37.6, 84.8}, {38.4, 84.4}, {38.6, 82}, {39, 83}, {39.2, 80.4}, {39.8, 84}, {40.4, 78.2}, {40.4, 80.2}, {40.8, 80.6}, {41, 80.4}, {41.4, 79.4}, {41.6, 80}, {60, 49.2}, {60.4, 50.2}, {60.4, 50.6}, {60.6, 49.6}, {60.6, 56.2}, {61, 51.2}, {61.2, 49}, {61.4, 48.4}, {61.4, 51.8}, {61.4, 53}, {61.8, 54.2}, {62, 47.8}, {62.2, 55.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [248464] = { -- Nimsy : https://wowhead.com/forever/npc=248464/nimsy
            [npcKeys.name] = "Nimsy",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[12] = {{40.4, 80.2}, {41, 77.6}, {41, 80.6}, {41.4, 79.2}, {41.4, 80.2}, {41.6, 80}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [248474] = { -- Geosculptor Yip : https://wowhead.com/forever/npc=248474/geosculptor-yip
            [npcKeys.name] = "Geosculptor Yip",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[12] = {{60, 49.4}, {60.4, 49.8}, {60.6, 49.8}, {61.2, 49}, {61.2, 51.4}, {61.2, 51.6}, {61.4, 48.2}, {61.8, 54.2}, {62, 55}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [248641] = { -- Fraxinus : https://wowhead.com/forever/npc=248641/fraxinus
            [npcKeys.name] = "Fraxinus",
        },
        [248709] = { -- Sunderbark : https://wowhead.com/forever/npc=248709/sunderbark
            [npcKeys.name] = "Sunderbark",
        },
        [248753] = { -- Steamwheedle Lost and Found : https://wowhead.com/forever/npc=248753/steamwheedle-lost-and-found
            [npcKeys.name] = "Steamwheedle Lost and Found",
        },
        [248755] = { -- Lumina Windsinger : https://wowhead.com/forever/npc=248755/lumina-windsinger
            [npcKeys.name] = "Lumina Windsinger",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[130] = {{64, 34}, {64.2, 33.4}, {65.2, 33}, {65.6, 23.2}, {65.6, 27.4}, {65.6, 29.6}, {65.6, 32.4}, {65.8, 25.4}, {65.8, 25.6}, {65.8, 27.6}, {65.8, 28.6}, {65.8, 30.8}, {66, 24.2}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.questStarts] = {91862, 96204},
            [npcKeys.questEnds] = {91861, 91862},
            [npcKeys.friendlyToFaction] = "H",
        },
        [248764] = { -- High Magistrate Vel : https://wowhead.com/forever/npc=248764/high-magistrate-vel
            [npcKeys.name] = "High Magistrate Vel",
        },
        [248779] = { -- Garreth Stills : https://wowhead.com/forever/npc=248779/garreth-stills
            [npcKeys.name] = "Garreth Stills",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[130] = {{60.2, 66.4}, {60.2, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.friendlyToFaction] = "H",
        },
        [248809] = { -- Jenna : https://wowhead.com/forever/npc=248809/jenna
            [npcKeys.name] = "Jenna",
            [npcKeys.spawns] = {[33] = {{27.8, 77.2}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [248813] = { -- Biggs Gearwedge : https://wowhead.com/forever/npc=248813/biggs-gearwedge
            [npcKeys.name] = "Biggs Gearwedge",
        },
        [248821] = { -- Trade Authority : https://wowhead.com/forever/npc=248821/trade-authority
            [npcKeys.name] = "Trade Authority",
        },
        [248822] = { -- Some Guy : https://wowhead.com/forever/npc=248822/some-guy
            [npcKeys.name] = "Some Guy",
        },
        [248840] = { -- Trevan Rol : https://wowhead.com/forever/npc=248840/trevan-rol
            [npcKeys.name] = "Trevan Rol",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[130] = {{43.4, 41}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.questStarts] = {91859, 95111},
            [npcKeys.questEnds] = {91858, 95036, 95126},
            [npcKeys.friendlyToFaction] = "H",
        },
        [248841] = { -- DNT KC 01 : https://wowhead.com/forever/npc=248841/dnt-kc-01
            [npcKeys.name] = "DNT KC 01",
        },
        [248876] = { -- Turn-In Vendor : https://wowhead.com/forever/npc=248876/turn-in-vendor
            [npcKeys.name] = "Turn-In Vendor",
        },
        [248946] = { -- Reagent Vendor : https://wowhead.com/forever/npc=248946/reagent-vendor
            [npcKeys.name] = "Reagent Vendor",
        },
        [248952] = { -- Fizlek : https://wowhead.com/forever/npc=248952/fizlek
            [npcKeys.name] = "Fizlek",
        },
        [248953] = { -- Trade Authority Turn-Ins (Alliance) : https://wowhead.com/forever/npc=248953/trade-authority-turn-ins-alliance
            [npcKeys.name] = "Trade Authority Turn-Ins (Alliance)",
        },
        [248973] = { -- Cloth Test : https://wowhead.com/forever/npc=248973/cloth-test
            [npcKeys.name] = "Cloth Test",
        },
        [248993] = { -- Leather Test : https://wowhead.com/forever/npc=248993/leather-test
            [npcKeys.name] = "Leather Test",
        },
        [249051] = { -- Celastrus the Bitter : https://wowhead.com/forever/npc=249051/celastrus-the-bitter
            [npcKeys.name] = "Celastrus the Bitter",
        },
        [249052] = { -- Witherbeard : https://wowhead.com/forever/npc=249052/witherbeard
            [npcKeys.name] = "Witherbeard",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{43.6, 32.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [249053] = { -- Hyjal Owl : https://wowhead.com/forever/npc=249053/hyjal-owl
            [npcKeys.name] = "Hyjal Owl",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[616] = {{24.4, 66.8}, {27.2, 76.8}, {34, 77}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249214] = { -- Glaive Thrower : https://wowhead.com/forever/npc=249214/glaive-thrower
            [npcKeys.name] = "Glaive Thrower",
        },
        [249215] = { -- Stormwind Dock Worker : https://wowhead.com/forever/npc=249215/stormwind-dock-worker
            [npcKeys.name] = "Stormwind Dock Worker",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [249216] = { -- Barkskin Warrior : https://wowhead.com/forever/npc=249216/barkskin-warrior
            [npcKeys.name] = "Barkskin Warrior",
        },
        [249217] = { -- Barkskin Shaman : https://wowhead.com/forever/npc=249217/barkskin-shaman
            [npcKeys.name] = "Barkskin Shaman",
        },
        [249218] = { -- Barkskin Totemic : https://wowhead.com/forever/npc=249218/barkskin-totemic
            [npcKeys.name] = "Barkskin Totemic",
        },
        [249219] = { -- Barkskin Den Watcher : https://wowhead.com/forever/npc=249219/barkskin-den-watcher
            [npcKeys.name] = "Barkskin Den Watcher",
        },
        [249220] = { -- Wormwing Harpy : https://wowhead.com/forever/npc=249220/wormwing-harpy
            [npcKeys.name] = "Wormwing Harpy",
        },
        [249221] = { -- Wormwing Windwitch : https://wowhead.com/forever/npc=249221/wormwing-windwitch
            [npcKeys.name] = "Wormwing Windwitch",
        },
        [249222] = { -- Wormwing Ambusher : https://wowhead.com/forever/npc=249222/wormwing-ambusher
            [npcKeys.name] = "Wormwing Ambusher",
        },
        [249223] = { -- Wormwing Fledgling : https://wowhead.com/forever/npc=249223/wormwing-fledgling
            [npcKeys.name] = "Wormwing Fledgling",
        },
        [249224] = { -- Child of Tortolla : https://wowhead.com/forever/npc=249224/child-of-tortolla
            [npcKeys.name] = "Child of Tortolla",
        },
        [249225] = { -- Ghostfang Alpha : https://wowhead.com/forever/npc=249225/ghostfang-alpha
            [npcKeys.name] = "Ghostfang Alpha",
        },
        [249226] = { -- Death Wailer : https://wowhead.com/forever/npc=249226/death-wailer
            [npcKeys.name] = "Death Wailer",
        },
        [249227] = { -- Forlorn Shade : https://wowhead.com/forever/npc=249227/forlorn-shade
            [npcKeys.name] = "Forlorn Shade",
        },
        [249228] = { -- Fleshflay Ravener : https://wowhead.com/forever/npc=249228/fleshflay-ravener
            [npcKeys.name] = "Fleshflay Ravener",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[616] = {{23.6, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249229] = { -- Felguard Sentinel : https://wowhead.com/forever/npc=249229/felguard-sentinel
            [npcKeys.name] = "Felguard Sentinel",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 59,
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249230] = { -- Defiling Hound : https://wowhead.com/forever/npc=249230/defiling-hound
            [npcKeys.name] = "Defiling Hound",
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249231] = { -- Varkharn the Vigilant : https://wowhead.com/forever/npc=249231/varkharn-the-vigilant
            [npcKeys.name] = "Varkharn the Vigilant",
        },
        [249232] = { -- Ganoloth the Tireless : https://wowhead.com/forever/npc=249232/ganoloth-the-tireless
            [npcKeys.name] = "Ganoloth the Tireless",
        },
        [249233] = { -- Unyielding Eye : https://wowhead.com/forever/npc=249233/unyielding-eye
            [npcKeys.name] = "Unyielding Eye",
        },
        [249234] = { -- Johun "Punchy" Dillas : https://wowhead.com/forever/npc=249234/johun-punchy-dillas
            [npcKeys.name] = "Johun \"Punchy\" Dillas",
            [npcKeys.spawns] = {[616] = {{43.8, 36.8}, {43.8, 37.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249235] = { -- Kaylaena Springwhisper : https://wowhead.com/forever/npc=249235/kaylaena-springwhisper
            [npcKeys.name] = "Kaylaena Springwhisper",
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249236] = { -- Doomguard : https://wowhead.com/forever/npc=249236/doomguard
            [npcKeys.name] = "Doomguard",
            [npcKeys.minLevel] = 59,
            [npcKeys.maxLevel] = 59,
        },
        [249237] = { -- Eternal Sentry : https://wowhead.com/forever/npc=249237/eternal-sentry
            [npcKeys.name] = "Eternal Sentry",
        },
        [249238] = { -- Legion Hulk : https://wowhead.com/forever/npc=249238/legion-hulk
            [npcKeys.name] = "Legion Hulk",
        },
        [249239] = { -- Rugged Traveler : https://wowhead.com/forever/npc=249239/rugged-traveler
            [npcKeys.name] = "Rugged Traveler",
        },
        [249240] = { -- Ragged Traveler : https://wowhead.com/forever/npc=249240/ragged-traveler
            [npcKeys.name] = "Ragged Traveler",
        },
        [249241] = { -- Paeonia : https://wowhead.com/forever/npc=249241/paeonia
            [npcKeys.name] = "Paeonia",
        },
        [249247] = { -- Forgotten Soldier : https://wowhead.com/forever/npc=249247/forgotten-soldier
            [npcKeys.name] = "Forgotten Soldier",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 57,
        },
        [249315] = { -- Enraged Galesprite : https://wowhead.com/forever/npc=249315/enraged-galesprite
            [npcKeys.name] = "Enraged Galesprite",
        },
        [249324] = { -- Cooking Fishing : https://wowhead.com/forever/npc=249324/cooking-fishing
            [npcKeys.name] = "Cooking Fishing",
        },
        [249363] = { -- Yala Windwatcher : https://wowhead.com/forever/npc=249363/yala-windwatcher
            [npcKeys.name] = "Yala Windwatcher",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{47.2, 21.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92465, 92469},
            [npcKeys.questEnds] = {92464, 92465},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [249399] = { -- Brave Bentzel : https://wowhead.com/forever/npc=249399/brave-bentzel
            [npcKeys.name] = "Brave Bentzel",
        },
        [249472] = { -- Highfeather Maverick : https://wowhead.com/forever/npc=249472/highfeather-maverick
            [npcKeys.name] = "Highfeather Maverick",
        },
        [249473] = { -- Sarinnia Wormwing : https://wowhead.com/forever/npc=249473/sarinnia-wormwing
            [npcKeys.name] = "Sarinnia Wormwing",
        },
        [249474] = { -- Rustleaf Fox : https://wowhead.com/forever/npc=249474/rustleaf-fox
            [npcKeys.name] = "Rustleaf Fox",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 56,
            [npcKeys.spawns] = {[616] = {{85, 73.4}, {85, 73.8}}, [618] = {{50.2, 83}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [249475] = { -- Inariel : https://wowhead.com/forever/npc=249475/inariel
            [npcKeys.name] = "Inariel",
        },
        [249476] = { -- Skunk : https://wowhead.com/forever/npc=249476/skunk
            [npcKeys.name] = "Skunk",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[616] = {{48.8, 85.8}, {53.4, 84.6}, {54.6, 83.4}, {63.6, 42.2}, {63.8, 42.8}, {66, 84.4}, {74.4, 80.6}, {81.8, 71.8}, {82.4, 35.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249477] = { -- Fel-Agitated Stag : https://wowhead.com/forever/npc=249477/fel-agitated-stag
            [npcKeys.name] = "Fel-Agitated Stag",
        },
        [249489] = { -- Nordrassil Grovewalker : https://wowhead.com/forever/npc=249489/nordrassil-grovewalker
            [npcKeys.name] = "Nordrassil Grovewalker",
        },
        [249490] = { -- Wildbreath Chimaerok : https://wowhead.com/forever/npc=249490/wildbreath-chimaerok
            [npcKeys.name] = "Wildbreath Chimaerok",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 59,
            [npcKeys.spawns] = {[616] = {{78.4, 37.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249491] = { -- Mountain Squallclimber : https://wowhead.com/forever/npc=249491/mountain-squallclimber
            [npcKeys.name] = "Mountain Squallclimber",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 59,
        },
        [249493] = { -- Nightsaber Guardian : https://wowhead.com/forever/npc=249493/nightsaber-guardian
            [npcKeys.name] = "Nightsaber Guardian",
            [npcKeys.spawns] = {[616] = {{72.2, 37.4}, {76, 34.8}, {77, 34.4}, {78, 41.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249494] = { -- Ghost : https://wowhead.com/forever/npc=249494/ghost
            [npcKeys.name] = "Ghost",
        },
        [249518] = { -- Morqhan Arkanev : https://wowhead.com/forever/npc=249518/morqhan-arkanev
            [npcKeys.name] = "Morqhan Arkanev",
            [npcKeys.spawns] = {[616] = {{86.2, 74}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249543] = { -- Poacher's Den Testing : https://wowhead.com/forever/npc=249543/poachers-den-testing
            [npcKeys.name] = "Poacher's Den Testing",
        },
        [249544] = { -- Stalker : https://wowhead.com/forever/npc=249544/stalker
            [npcKeys.name] = "Stalker",
        },
        [249545] = { -- Goldrinn : https://wowhead.com/forever/npc=249545/goldrinn
            [npcKeys.name] = "Goldrinn",
        },
        [249549] = { -- Fenwick Togglespring : https://wowhead.com/forever/npc=249549/fenwick-togglespring
            [npcKeys.name] = "Fenwick Togglespring",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[616] = {{25.2, 76}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [249550] = { -- Wennzut Togglespring : https://wowhead.com/forever/npc=249550/wennzut-togglespring
            [npcKeys.name] = "Wennzut Togglespring",
        },
        [249551] = { -- Blackthorne Cultist : https://wowhead.com/forever/npc=249551/blackthorne-cultist
            [npcKeys.name] = "Blackthorne Cultist",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{77.6, 40.2}, {79.8, 35}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249561] = { -- Riding Wolf : https://wowhead.com/forever/npc=249561/riding-wolf
            [npcKeys.name] = "Riding Wolf",
        },
        [249562] = { -- Duz'zt Ghuswerx : https://wowhead.com/forever/npc=249562/duzzt-ghuswerx
            [npcKeys.name] = "Duz'zt Ghuswerx",
        },
        [249661] = { -- Rift : https://wowhead.com/forever/npc=249661/rift
            [npcKeys.name] = "Rift",
        },
        [249662] = { -- REUSE ME : https://wowhead.com/forever/npc=249662/reuse-me
            [npcKeys.name] = "REUSE ME",
        },
        [249713] = { -- Odd Child : https://wowhead.com/forever/npc=249713/odd-child
            [npcKeys.name] = "Odd Child",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.questStarts] = {92109, 92110},
            [npcKeys.questEnds] = {92109, 92110},
            [npcKeys.friendlyToFaction] = "A",
        },
        [249719] = { -- Stalker : https://wowhead.com/forever/npc=249719/stalker
            [npcKeys.name] = "Stalker",
        },
        [249722] = { -- Barkskin Matriarch : https://wowhead.com/forever/npc=249722/barkskin-matriarch
            [npcKeys.name] = "Barkskin Matriarch",
        },
        [249746] = { -- Skunk : https://wowhead.com/forever/npc=249746/skunk
            [npcKeys.name] = "Skunk",
        },
        [249763] = { -- Loot Share Test : https://wowhead.com/forever/npc=249763/loot-share-test
            [npcKeys.name] = "Loot Share Test",
        },
        [249779] = { -- Barkskin Cub : https://wowhead.com/forever/npc=249779/barkskin-cub
            [npcKeys.name] = "Barkskin Cub",
        },
        [249845] = { -- Credit : https://wowhead.com/forever/npc=249845/credit
            [npcKeys.name] = "Credit",
        },
        [249853] = { -- Lorekeeper Nok : https://wowhead.com/forever/npc=249853/lorekeeper-nok
            [npcKeys.name] = "Lorekeeper Nok",
        },
        [249855] = { -- Unele : https://wowhead.com/forever/npc=249855/unele
            [npcKeys.name] = "Unele",
        },
        [249968] = { -- Hnaz Blunderflame : https://wowhead.com/forever/npc=249968/hnaz-blunderflame
            [npcKeys.name] = "Hnaz Blunderflame",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[616] = {{15.4, 50}, {15.6, 50.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [249974] = { -- Battlescarred Steelbeak : https://wowhead.com/forever/npc=249974/battlescarred-steelbeak
            [npcKeys.name] = "Battlescarred Steelbeak",
        },
        [250192] = { -- [DNT] Dummy Quest Kill Credit : https://wowhead.com/forever/npc=250192/dnt-dummy-quest-kill-credit
            [npcKeys.name] = "[DNT] Dummy Quest Kill Credit",
        },
        [250214] = { -- Item Preview Vendor : https://wowhead.com/forever/npc=250214/item-preview-vendor
            [npcKeys.name] = "Item Preview Vendor",
        },
        [250282] = { -- Vile Fin Seer : https://wowhead.com/forever/npc=250282/vile-fin-seer
            [npcKeys.name] = "Vile Fin Seer",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{12.8, 55.6}, {13.2, 58}, {13.4, 57.2}, {13.4, 59.2}, {13.8, 56.6}, {14, 53.2}, {14, 56.2}, {14, 58}, {14.2, 54.6}, {14.4, 52.4}, {14.4, 54.4}, {14.6, 52.4}, {14.6, 54.6}, {14.8, 52.8}, {14.8, 56.8}, {15.2, 54.2}, {15.4, 51.4}, {15.6, 51.2}, {15.8, 52.2}, {16, 52.8}, {16.6, 52.8}, {16.8, 52.2}, {17, 51}, {17.2, 55}, {17.2, 58.2}, {17.4, 55.6}, {17.4, 58.6}, {17.4, 60.2}, {17.6, 55.2}, {17.6, 55.6}, {17.6, 58.2}, {17.6, 61.6}, {17.8, 56.6}, {17.8, 59.4}, {18, 60.4}, {18, 60.6}, {18.8, 59.8}, {18.8, 60.6}, {18.8, 61.8}, {25.2, 44.4}, {25.4, 44.8}, {25.8, 45.4}, {26, 45.6}, {26.2, 43.4}, {26.2, 43.8}, {26.6, 43.8}, {26.8, 45.4}, {27.4, 45.6}, {27.8, 45.4}, {28.2, 45.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [250283] = { -- Vile Fin Attacker : https://wowhead.com/forever/npc=250283/vile-fin-attacker
            [npcKeys.name] = "Vile Fin Attacker",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[85] = {{12.4, 54.8}, {13.4, 55.2}, {13.4, 56.4}, {13.4, 56.6}, {13.4, 59.2}, {13.8, 53.4}, {13.8, 53.8}, {13.8, 54.8}, {13.8, 56.6}, {14, 56.2}, {14.4, 52.4}, {14.6, 52.2}, {14.8, 52.8}, {15.2, 54.2}, {15.2, 54.8}, {15.4, 56.4}, {15.4, 56.6}, {15.6, 56.4}, {15.8, 61.6}, {16, 55}, {16.2, 58}, {16.4, 57}, {16.4, 58.8}, {16.6, 57.2}, {17, 59}, {17.2, 54.4}, {17.2, 58.4}, {17.4, 56.2}, {17.4, 60.4}, {17.4, 60.6}, {17.8, 57.6}, {18, 57}, {18, 61.2}, {18.2, 59.4}, {18.2, 59.6}, {18.6, 57}, {18.6, 60}, {18.8, 61.2}, {18.8, 62}, {26, 47.4}, {26.2, 48}, {26.4, 45.2}, {26.6, 48.2}, {26.8, 44.2}, {27.2, 45.6}, {27.4, 45.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [250287] = { -- Tarnished Exemplar : https://wowhead.com/forever/npc=250287/tarnished-exemplar
            [npcKeys.name] = "Tarnished Exemplar",
        },
        [250352] = { -- Old Thornpaw : https://wowhead.com/forever/npc=250352/old-thornpaw
            [npcKeys.name] = "Old Thornpaw",
        },
        [250355] = { -- Defias Vintner : https://wowhead.com/forever/npc=250355/defias-vintner
            [npcKeys.name] = "Defias Vintner",
        },
        [250359] = { -- Brother Caelen : https://wowhead.com/forever/npc=250359/brother-caelen
            [npcKeys.name] = "Brother Caelen",
        },
        [250384] = { -- Goma Barkskin : https://wowhead.com/forever/npc=250384/goma-barkskin
            [npcKeys.name] = "Goma Barkskin",
        },
        [250416] = { -- Highfeather Maverick : https://wowhead.com/forever/npc=250416/highfeather-maverick
            [npcKeys.name] = "Highfeather Maverick",
        },
        [250448] = { -- Evin Schmidtt : https://wowhead.com/forever/npc=250448/evin-schmidtt
            [npcKeys.name] = "Evin Schmidtt",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[85] = {{22, 44.4}, {22, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [250483] = { -- Witherfang : https://wowhead.com/forever/npc=250483/witherfang
            [npcKeys.name] = "Witherfang",
        },
        [250484] = { -- Spider : https://wowhead.com/forever/npc=250484/spider
            [npcKeys.name] = "Spider",
        },
        [250488] = { -- Tarantula : https://wowhead.com/forever/npc=250488/tarantula
            [npcKeys.name] = "Tarantula",
        },
        [250539] = { -- Paladin Trainee : https://wowhead.com/forever/npc=250539/paladin-trainee
            [npcKeys.name] = "Paladin Trainee",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{22, 47.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [250541] = { -- Paladin Trainee : https://wowhead.com/forever/npc=250541/paladin-trainee
            [npcKeys.name] = "Paladin Trainee",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{22, 47}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [250617] = { -- Shrieking Banshee : https://wowhead.com/forever/npc=250617/shrieking-banshee
            [npcKeys.name] = "Shrieking Banshee",
        },
        [250618] = { -- Skeleton : https://wowhead.com/forever/npc=250618/skeleton
            [npcKeys.name] = "Skeleton",
        },
        [250619] = { -- Broodwidow : https://wowhead.com/forever/npc=250619/broodwidow
            [npcKeys.name] = "Broodwidow",
        },
        [250620] = { -- Shrieking Banshee : https://wowhead.com/forever/npc=250620/shrieking-banshee
            [npcKeys.name] = "Shrieking Banshee",
        },
        [250621] = { -- Cadaver : https://wowhead.com/forever/npc=250621/cadaver
            [npcKeys.name] = "Cadaver",
        },
        [250622] = { -- Ragged Ghoul : https://wowhead.com/forever/npc=250622/ragged-ghoul
            [npcKeys.name] = "Ragged Ghoul",
        },
        [250623] = { -- Mangled Cadaver : https://wowhead.com/forever/npc=250623/mangled-cadaver
            [npcKeys.name] = "Mangled Cadaver",
        },
        [250624] = { -- Skeletal Mage : https://wowhead.com/forever/npc=250624/skeletal-mage
            [npcKeys.name] = "Skeletal Mage",
        },
        [250625] = { -- Broodling : https://wowhead.com/forever/npc=250625/broodling
            [npcKeys.name] = "Broodling",
        },
        [250626] = { -- Skeletal Soldier : https://wowhead.com/forever/npc=250626/skeletal-soldier
            [npcKeys.name] = "Skeletal Soldier",
        },
        [250627] = { -- Ghoul : https://wowhead.com/forever/npc=250627/ghoul
            [npcKeys.name] = "Ghoul",
        },
        [250628] = { -- Dark Rider : https://wowhead.com/forever/npc=250628/dark-rider
            [npcKeys.name] = "Dark Rider",
        },
        [250629] = { -- Stone Watcher : https://wowhead.com/forever/npc=250629/stone-watcher
            [npcKeys.name] = "Stone Watcher",
        },
        [250630] = { -- Plague Ghoul : https://wowhead.com/forever/npc=250630/plague-ghoul
            [npcKeys.name] = "Plague Ghoul",
        },
        [250631] = { -- The Abandoned : https://wowhead.com/forever/npc=250631/the-abandoned
            [npcKeys.name] = "The Abandoned",
        },
        [250649] = { -- Mindless Undead : https://wowhead.com/forever/npc=250649/mindless-undead
            [npcKeys.name] = "Mindless Undead",
        },
        [250650] = { -- Wailing Banshee : https://wowhead.com/forever/npc=250650/wailing-banshee
            [npcKeys.name] = "Wailing Banshee",
        },
        [250651] = { -- Vengeful Citizen : https://wowhead.com/forever/npc=250651/vengeful-citizen
            [npcKeys.name] = "Vengeful Citizen",
        },
        [250652] = { -- Spiteful Phantom : https://wowhead.com/forever/npc=250652/spiteful-phantom
            [npcKeys.name] = "Spiteful Phantom",
        },
        [250653] = { -- Spectral Citizen : https://wowhead.com/forever/npc=250653/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [250654] = { -- Ghostly Citizen : https://wowhead.com/forever/npc=250654/ghostly-citizen
            [npcKeys.name] = "Ghostly Citizen",
        },
        [250656] = { -- Fallen Berserker : https://wowhead.com/forever/npc=250656/fallen-berserker
            [npcKeys.name] = "Fallen Berserker",
        },
        [250657] = { -- Rath'mael : https://wowhead.com/forever/npc=250657/rathmael
            [npcKeys.name] = "Rath'mael",
        },
        [250660] = { -- The Baron : https://wowhead.com/forever/npc=250660/the-baron
            [npcKeys.name] = "The Baron",
        },
        [250686] = { -- Tabitha Heartweaver : https://wowhead.com/forever/npc=250686/tabitha-heartweaver
            [npcKeys.name] = "Tabitha Heartweaver",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[130] = {{44.4, 43}, {44.6, 42.8}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.questStarts] = {92401},
            [npcKeys.questEnds] = {92401},
            [npcKeys.friendlyToFaction] = "H",
        },
        [250689] = { -- Living Monstrosity : https://wowhead.com/forever/npc=250689/living-monstrosity
            [npcKeys.name] = "Living Monstrosity",
        },
        [250735] = { -- Venom Lurker : https://wowhead.com/forever/npc=250735/venom-lurker
            [npcKeys.name] = "Venom Lurker",
        },
        [250741] = { -- Spider : https://wowhead.com/forever/npc=250741/spider
            [npcKeys.name] = "Spider",
        },
        [250783] = { -- Gear Adjustment : https://wowhead.com/forever/npc=250783/gear-adjustment
            [npcKeys.name] = "Gear Adjustment",
        },
        [250812] = { -- Battery : https://wowhead.com/forever/npc=250812/battery
            [npcKeys.name] = "Battery",
        },
        [250819] = { -- Gear Adjustment : https://wowhead.com/forever/npc=250819/gear-adjustment
            [npcKeys.name] = "Gear Adjustment",
        },
        [250831] = { -- Skeleton : https://wowhead.com/forever/npc=250831/skeleton
            [npcKeys.name] = "Skeleton",
        },
        [250842] = { -- Edward Heartweaver : https://wowhead.com/forever/npc=250842/edward-heartweaver
            [npcKeys.name] = "Edward Heartweaver",
        },
        [250856] = { -- Battery : https://wowhead.com/forever/npc=250856/battery
            [npcKeys.name] = "Battery",
        },
        [250861] = { -- Beholder : https://wowhead.com/forever/npc=250861/beholder
            [npcKeys.name] = "Beholder",
        },
        [250868] = { -- Vuldren : https://wowhead.com/forever/npc=250868/vuldren
            [npcKeys.name] = "Vuldren",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{36.4, 46.4}, {36.4, 46.8}, {37, 47}, {38.2, 43.8}, {38.4, 43}, {38.8, 44}, {40.2, 50.4}, {40.6, 56}, {40.8, 56.6}, {42, 35.8}, {42, 61.4}, {42, 61.6}, {42.4, 36.8}, {42.4, 41}, {42.4, 52.4}, {42.4, 52.6}, {42.6, 36.4}, {42.6, 52.6}, {42.8, 40.8}, {42.8, 51.8}, {43, 51.4}, {43.2, 47}, {43.4, 37.4}, {43.4, 39}, {43.8, 39.2}, {44, 39.6}, {44.4, 37.6}, {45, 37.6}, {45.4, 59.4}, {45.4, 59.6}, {45.6, 55.8}, {45.8, 54}, {46.2, 37}, {46.8, 36.6}, {46.8, 68.4}, {47, 39.4}, {47, 39.6}, {47.2, 40.6}, {47.2, 58.2}, {47.4, 52.6}, {47.6, 53}, {47.6, 58.2}, {52.4, 65.8}, {52.8, 65.8}, {56, 61.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250873] = { -- Juvenile Vuldren : https://wowhead.com/forever/npc=250873/juvenile-vuldren
            [npcKeys.name] = "Juvenile Vuldren",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{42, 28.2}, {43.2, 25.4}, {43.2, 25.6}, {43.2, 26.6}, {43.2, 28.2}, {43.4, 22}, {43.6, 22}, {43.8, 25.4}, {43.8, 28.6}, {44, 25.8}, {44.2, 26.6}, {44.2, 27.8}, {44.4, 22.6}, {44.6, 22}, {44.6, 25.6}, {44.6, 27}, {44.8, 21.2}, {44.8, 23.2}, {44.8, 27.6}, {45, 24.2}, {45.2, 25.2}, {45.2, 28.6}, {45.6, 22.6}, {45.6, 24.6}, {45.6, 26.6}, {45.6, 28.2}, {45.6, 28.8}, {45.8, 21.6}, {45.8, 26.4}, {46, 24.2}, {46.6, 22.2}, {46.8, 25.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [250874] = { -- Vuldren Alpha : https://wowhead.com/forever/npc=250874/vuldren-alpha
            [npcKeys.name] = "Vuldren Alpha",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{45.4, 81.2}, {45.6, 81.2}, {45.8, 80.4}, {46.6, 79.2}, {46.8, 81.8}, {47.2, 81}, {47.4, 83.6}, {47.6, 84.4}, {47.6, 84.6}, {48.4, 82.4}, {48.4, 85.8}, {48.6, 81}, {48.8, 82}, {48.8, 82.6}, {48.8, 85.8}, {49.6, 82.4}, {51, 84.6}, {51.2, 86}, {51.4, 84.2}, {51.6, 86.2}, {51.8, 79.4}, {51.8, 83}, {52, 80.4}, {52, 80.8}, {52.2, 77.8}, {52.4, 77}, {52.6, 77.8}, {52.6, 81}, {52.8, 71.4}, {52.8, 77.4}, {52.8, 79}, {53, 72.2}, {53.4, 69.8}, {53.6, 69.2}, {53.6, 70.6}, {53.8, 73}, {53.8, 75.8}, {53.8, 81.2}, {54, 73.8}, {54.2, 70.2}, {54.2, 75}, {54.6, 74.4}, {54.6, 75.4}, {55.2, 70}, {55.4, 75.6}, {56.2, 73.6}, {56.4, 68}, {57, 67.8}, {57, 68.6}, {57.4, 67.4}, {57.6, 69.6}, {57.8, 67.4}, {57.8, 69}, {57.8, 76.8}, {58, 72.4}, {58.2, 64.4}, {58.8, 62.6}, {58.8, 75}, {59, 64.2}, {59.2, 61.8}, {59.2, 66}, {59.4, 60.8}, {59.4, 65.2}, {59.4, 73.4}, {59.6, 61.4}, {59.6, 72.8}, {59.8, 61.8}, {59.8, 64.4}, {59.8, 72}, {60, 65.2}, {60, 67.2}, {60.2, 74.2}, {61, 73.4}, {61.2, 73.6}, {61.4, 68.4}, {61.4, 68.8}, {61.4, 70.4}, {61.4, 71.2}, {61.6, 68.4}, {61.8, 68.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250920] = { -- Vuldren Kit : https://wowhead.com/forever/npc=250920/vuldren-kit
            [npcKeys.name] = "Vuldren Kit",
        },
        [250921] = { -- Forest Sprite : https://wowhead.com/forever/npc=250921/forest-sprite
            [npcKeys.name] = "Forest Sprite",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{52.4, 42}, {52.4, 42.6}, {52.6, 41}, {53, 42.8}, {53.4, 40}, {53.6, 40}, {53.6, 43}, {53.6, 44.4}, {54.2, 41.4}, {54.4, 37.6}, {54.4, 39.2}, {54.6, 39.2}, {54.6, 43.8}, {54.8, 37.4}, {55, 38.4}, {55.4, 39.8}, {55.6, 39.4}, {55.6, 39.8}, {56.2, 42.4}, {56.8, 38.4}, {57.4, 40.6}, {57.6, 40.2}, {57.6, 40.6}, {59.2, 39.4}, {59.4, 39.6}, {59.6, 39.4}, {59.6, 39.6}, {60.8, 38.4}, {60.8, 38.6}, {61.6, 38.2}, {62, 39}, {62.4, 36.4}, {62.8, 39.4}, {63.2, 36.6}, {63.6, 39}, {63.8, 37.6}, {63.8, 40.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250922] = { -- Manticore : https://wowhead.com/forever/npc=250922/manticore
            [npcKeys.name] = "Manticore",
        },
        [250923] = { -- Manticore Hunter : https://wowhead.com/forever/npc=250923/manticore-hunter
            [npcKeys.name] = "Manticore Hunter",
        },
        [250924] = { -- Tamed Shriekling : https://wowhead.com/forever/npc=250924/tamed-shriekling
            [npcKeys.name] = "Tamed Shriekling",
        },
        [250925] = { -- Shriekling Ancient : https://wowhead.com/forever/npc=250925/shriekling-ancient
            [npcKeys.name] = "Shriekling Ancient",
        },
        [250926] = { -- Scrawny Ursera : https://wowhead.com/forever/npc=250926/scrawny-ursera
            [npcKeys.name] = "Scrawny Ursera",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 4,
            [npcKeys.spawns] = {[16593] = {{36.8, 24.4}, {37, 24.6}, {37, 29.8}, {37.2, 26.4}, {37.6, 25.2}, {37.8, 26.8}, {38, 26.4}, {38, 28.4}, {38, 28.6}, {38, 30.2}, {38.6, 27.6}, {39.2, 30.2}, {39.4, 26.6}, {39.4, 28.8}, {39.6, 27.6}, {40, 27.2}, {40, 29.4}, {40.4, 26.4}, {40.8, 26.8}, {41.2, 26.2}, {41.4, 25.2}, {41.4, 27.6}, {41.6, 25.4}, {41.6, 25.8}, {41.6, 27}, {41.8, 27.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250927] = { -- Shadowgale Ursera : https://wowhead.com/forever/npc=250927/shadowgale-ursera
            [npcKeys.name] = "Shadowgale Ursera",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{54.2, 43.6}, {54.4, 43.4}, {54.6, 43.4}, {54.8, 36}, {55, 36.6}, {56.2, 31.6}, {56.6, 32}, {57.8, 43.2}, {58.2, 43.8}, {59.6, 33.2}, {60, 33.8}, {61.8, 37.3}, {62, 38.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250928] = { -- Highlands Ursera : https://wowhead.com/forever/npc=250928/highlands-ursera
            [npcKeys.name] = "Highlands Ursera",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{49.8, 58.6}, {50, 58.3}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [250929] = { -- Malfunctioning Cyclone Construct : https://wowhead.com/forever/npc=250929/malfunctioning-cyclone-construct
            [npcKeys.name] = "Malfunctioning Cyclone Construct",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[16593] = {{48.4, 78.2}, {48.4, 78.6}, {48.8, 78.4}, {48.8, 78.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92698},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [250930] = { -- Blood Flies : https://wowhead.com/forever/npc=250930/blood-flies
            [npcKeys.name] = "Blood Flies",
        },
        [250931] = { -- Vuldren Stalker : https://wowhead.com/forever/npc=250931/vuldren-stalker
            [npcKeys.name] = "Vuldren Stalker",
        },
        [250932] = { -- Skyshrike Fury : https://wowhead.com/forever/npc=250932/skyshrike-fury
            [npcKeys.name] = "Skyshrike Fury",
        },
        [250933] = { -- Skyshrike : https://wowhead.com/forever/npc=250933/skyshrike
            [npcKeys.name] = "Skyshrike",
        },
        [250934] = { -- Skyshrike Channeler : https://wowhead.com/forever/npc=250934/skyshrike-channeler
            [npcKeys.name] = "Skyshrike Channeler",
        },
        [250935] = { -- Ursera Defender : https://wowhead.com/forever/npc=250935/ursera-defender
            [npcKeys.name] = "Ursera Defender",
        },
        [250936] = { -- Den'dralass : https://wowhead.com/forever/npc=250936/dendralass
            [npcKeys.name] = "Den'dralass",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{61.2, 37.2}, {61.6, 38.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250937] = { -- Ursera Scavenger : https://wowhead.com/forever/npc=250937/ursera-scavenger
            [npcKeys.name] = "Ursera Scavenger",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 4,
            [npcKeys.spawns] = {[16593] = {{35.4, 24.2}, {35.4, 25}, {35.6, 24.2}, {35.6, 25.2}, {35.6, 25.6}, {35.8, 23.2}, {37, 24.2}, {37.4, 24.8}, {37.4, 25.8}, {37.4, 26.8}, {37.6, 25.4}, {37.6, 26}, {37.8, 26.8}, {38.2, 27.6}, {38.6, 27.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [250938] = { -- Aggressive Manticore : https://wowhead.com/forever/npc=250938/aggressive-manticore
            [npcKeys.name] = "Aggressive Manticore",
        },
        [250942] = { -- Toumani Dabati : https://wowhead.com/forever/npc=250942/toumani-dabati
            [npcKeys.name] = "Toumani Dabati",
        },
        [250943] = { -- Lift : https://wowhead.com/forever/npc=250943/lift
            [npcKeys.name] = "Lift",
        },
        [250966] = { -- Lift : https://wowhead.com/forever/npc=250966/lift
            [npcKeys.name] = "Lift",
        },
        [250967] = { -- Lift : https://wowhead.com/forever/npc=250967/lift
            [npcKeys.name] = "Lift",
        },
        [250969] = { -- Rat : https://wowhead.com/forever/npc=250969/rat
            [npcKeys.name] = "Rat",
        },
        [251001] = { -- Deathguard Kristof : https://wowhead.com/forever/npc=251001/deathguard-kristof
            [npcKeys.name] = "Deathguard Kristof",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{65.2, 60.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {92422},
            [npcKeys.questEnds] = {92422},
            [npcKeys.friendlyToFaction] = "H",
        },
        [251065] = { -- Stalker : https://wowhead.com/forever/npc=251065/stalker
            [npcKeys.name] = "Stalker",
        },
        [251067] = { -- Lift : https://wowhead.com/forever/npc=251067/lift
            [npcKeys.name] = "Lift",
        },
        [251096] = { -- Bitter Spirit : https://wowhead.com/forever/npc=251096/bitter-spirit
            [npcKeys.name] = "Bitter Spirit",
        },
        [251103] = { -- The Horror : https://wowhead.com/forever/npc=251103/the-horror
            [npcKeys.name] = "The Horror",
        },
        [251104] = { -- Revildesh : https://wowhead.com/forever/npc=251104/revildesh
            [npcKeys.name] = "Revildesh",
        },
        [251105] = { -- Metamorphic Fury : https://wowhead.com/forever/npc=251105/metamorphic-fury
            [npcKeys.name] = "Metamorphic Fury",
        },
        [251115] = { -- Urs'anah : https://wowhead.com/forever/npc=251115/ursanah
            [npcKeys.name] = "Urs'anah",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{35.3, 24.2}, {35.4, 25.4}, {35.4, 25.6}, {35.6, 25.2}, {35.6, 26}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251143] = { -- Roiling Winds : https://wowhead.com/forever/npc=251143/roiling-winds
            [npcKeys.name] = "Roiling Winds",
            [npcKeys.minLevel] = 2,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[16593] = {{46.6, 20}, {47.1, 19.1}, {47.4, 20.9}, {47.6, 20}, {47.7, 19.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251145] = { -- Al'Aketh Brute : https://wowhead.com/forever/npc=251145/alaketh-brute
            [npcKeys.name] = "Al'Aketh Brute",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 4,
            [npcKeys.spawns] = {[16593] = {{35.4, 32.4}, {35.4, 33.2}, {35.4, 33.8}, {35.6, 32.8}, {35.8, 34.4}, {35.8, 34.6}, {36.4, 31.4}, {36.4, 32}, {36.6, 31.4}, {36.6, 34.6}, {37.2, 33.8}, {37.4, 32.2}, {37.4, 33}, {37.6, 31.4}, {37.6, 32}, {37.6, 32.6}, {37.6, 33.6}, {37.8, 35}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251160] = { -- Al'Aketh Convert : https://wowhead.com/forever/npc=251160/alaketh-convert
            [npcKeys.name] = "Al'Aketh Convert",
            [npcKeys.minLevel] = 2,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[16593] = {{46.7, 20.4}, {47, 18.9}, {47.3, 20.7}, {47.8, 20.1}, {47.9, 19.3}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251166] = { -- Minor Manifestation of Earth : https://wowhead.com/forever/npc=251166/minor-manifestation-of-earth
            [npcKeys.name] = "Minor Manifestation of Earth",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[16593] = {{49.6, 24}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92468},
            [npcKeys.questEnds] = {92467},
            [npcKeys.friendlyToFaction] = "H",
        },
        [251169] = { -- Pesky Cirrusfly : https://wowhead.com/forever/npc=251169/pesky-cirrusfly
            [npcKeys.name] = "Pesky Cirrusfly",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{42.8, 26.6}, {43.2, 28.6}, {43.4, 28.4}, {44.2, 28.6}, {44.4, 25.2}, {44.4, 26}, {44.4, 27.2}, {44.4, 28.4}, {44.6, 27.4}, {45, 25.6}, {45, 28.2}, {45.2, 24.2}, {45.2, 25.2}, {45.4, 28.6}, {45.8, 25}, {45.8, 29}, {46.2, 29.8}, {46.4, 26.4}, {46.4, 26.8}, {46.4, 28}, {46.6, 25.2}, {46.6, 26.6}, {46.6, 28.2}, {46.6, 28.6}, {46.8, 26.2}, {47.6, 26.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251199] = { -- Head Scratcher : https://wowhead.com/forever/npc=251199/head-scratcher
            [npcKeys.name] = "Head Scratcher",
        },
        [251245] = { -- Prideclaw : https://wowhead.com/forever/npc=251245/prideclaw
            [npcKeys.name] = "Prideclaw",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{35.4, 46.8}, {35.8, 47.6}, {36.2, 45.4}, {36.2, 46.8}, {36.4, 45.8}, {36.6, 45.6}, {36.6, 46.6}, {36.8, 45.2}, {37.4, 43.2}, {37.4, 44.2}, {37.6, 45.8}, {38, 44}, {38, 57.6}, {38.2, 44.6}, {38.2, 55.4}, {38.2, 55.6}, {38.2, 58.6}, {38.4, 42.8}, {38.4, 57.4}, {38.6, 56.2}, {38.6, 57.4}, {38.6, 57.8}, {39, 42}, {39.2, 41.4}, {39.2, 42.8}, {39.4, 43.8}, {39.4, 44.8}, {39.4, 54.4}, {39.4, 55.2}, {39.6, 43}, {39.6, 44.8}, {39.6, 54.6}, {39.6, 56.6}, {39.8, 40.4}, {39.8, 40.8}, {39.8, 42.4}, {39.8, 54.2}, {40, 39}, {40, 44}, {40, 48.8}, {40, 55.6}, {40.2, 63.6}, {40.4, 37}, {40.4, 37.8}, {40.4, 45.6}, {40.4, 46.6}, {40.4, 49.6}, {40.6, 37.6}, {40.6, 39.6}, {40.6, 43.8}, {40.6, 45.2}, {40.6, 46.6}, {40.6, 49.2}, {40.6, 49.6}, {40.6, 54}, {40.8, 56.4}, {41, 53}, {41.2, 37}, {41.2, 42.6}, {41.2, 45.6}, {41.4, 36.4}, {41.4, 42.4}, {41.4, 50.6}, {41.4, 52.2}, {41.4, 63.4}, {41.4, 63.8}, {41.6, 41.8}, {41.6, 45.6}, {41.6, 46.6}, {41.6, 52.2}, {41.6, 53}, {41.6, 63.2}, {41.6, 63.8}, {41.8, 45}, {42, 41.4}, {42, 42.6}, {42, 51.4}, {42.2, 39.8}, {42.2, 48.4}, {42.2, 48.8}, {42.2, 49.6}, {42.4, 35.2}, {42.4, 36.8}, {42.4, 38.4}, {42.4, 39.2}, {42.6, 39.6}, {43, 35}, {43, 35.8}, {43, 38.6}, {43, 49}, {43, 50.6}, {43, 51.6}, {43.2, 37.2}, {43.2, 37.8}, {43.2, 40.8}, {43.2, 48.4}, {43.2, 62.4}, {43.2, 62.8}, {43.4, 50.4}, {43.6, 36.2}, {43.6, 36.6}, {43.6, 40.6}, {43.8, 40}, {43.8, 47}, {43.8, 50.6}, {43.8, 64.8}, {44.2, 49.8}, {44.4, 37.6}, {44.4, 39.4}, {44.4, 69.6}, {44.6, 44.2}, {44.6, 61.8}, {44.8, 40.2}, {44.8, 40.8}, {45, 36.4}, {45, 61.4}, {45.2, 36.8}, {45.2, 41.6}, {45.4, 37.8}, {45.4, 39.2}, {45.4, 68.4}, {45.6, 36.4}, {45.6, 53.6}, {45.6, 68.2}, {45.8, 37.2}, {45.8, 39.2}, {45.8, 40.4}, {45.8, 41}, {45.8, 41.8}, {45.8, 52.8}, {46, 38.4}, {46.4, 70.2}, {46.4, 70.6}, {46.6, 40.6}, {46.6, 69.2}, {46.6, 70}, {46.8, 41.8}, {47, 65.2}, {47.2, 52.6}, {47.2, 53.8}, {47.4, 39.2}, {47.4, 40}, {47.4, 50.4}, {47.4, 50.6}, {47.4, 51.6}, {47.6, 39.2}, {47.6, 40}, {47.6, 51}, {47.6, 51.6}, {50.4, 65.2}, {50.4, 66.2}, {50.6, 65.2}, {50.8, 62}, {51, 65.6}, {51.2, 51.8}, {51.6, 62}, {51.6, 65.8}, {52.2, 64.2}, {52.4, 64.6}, {52.6, 62.4}, {52.6, 64.8}, {53.4, 59.6}, {54, 61}, {54.4, 60.2}, {55.2, 62.6}, {55.4, 62.4}, {55.8, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251247] = { -- Shadowgale Manticore : https://wowhead.com/forever/npc=251247/shadowgale-manticore
            [npcKeys.name] = "Shadowgale Manticore",
        },
        [251261] = { -- Hippogryph Matriarch : https://wowhead.com/forever/npc=251261/hippogryph-matriarch
            [npcKeys.name] = "Hippogryph Matriarch",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{33.2, 54.4}, {33.4, 54.6}, {33.6, 54.4}, {33.6, 54.6}, {33.8, 56}, {34.2, 51.4}, {34.2, 53}, {34.4, 52.2}, {34.6, 51}, {35, 50.4}, {35, 51.8}, {35, 53.8}, {35, 54.6}, {35.2, 53.4}, {35.6, 53.4}, {35.6, 54.2}, {35.8, 51}, {36, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251284] = { -- Hippogryph Protector : https://wowhead.com/forever/npc=251284/hippogryph-protector
            [npcKeys.name] = "Hippogryph Protector",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{33.4, 54.2}, {33.4, 54.6}, {33.8, 55.6}, {34, 53.2}, {34, 55.2}, {34.2, 57.8}, {34.4, 51.4}, {34.4, 51.6}, {34.4, 54.2}, {34.6, 57.2}, {34.8, 51.2}, {34.8, 52}, {35, 53.6}, {35, 55.4}, {35.4, 53.4}, {35.4, 55.6}, {35.6, 53}, {35.8, 55.2}, {36, 52}, {36.2, 50.8}, {36.2, 55.6}, {36.4, 50.4}, {36.4, 53.8}, {36.6, 55.8}, {36.6, 56.6}, {36.8, 52.4}, {36.8, 53.2}, {36.8, 55.4}, {37, 53.6}, {37.2, 50.2}, {37.2, 51}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251290] = { -- Feast of the Unicorn : https://wowhead.com/forever/npc=251290/feast-of-the-unicorn
            [npcKeys.name] = "Feast of the Unicorn",
        },
        [251291] = { -- Hippogryph Youth : https://wowhead.com/forever/npc=251291/hippogryph-youth
            [npcKeys.name] = "Hippogryph Youth",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{35, 56}, {35, 57}, {35.4, 58}, {35.6, 56.4}, {36, 57.2}, {36.2, 50.4}, {36.2, 58}, {36.4, 50.6}, {36.8, 57.6}, {36.8, 58.6}, {37, 51}, {37.2, 50.2}, {37.4, 51.6}, {37.4, 54.2}, {37.4, 55}, {37.4, 55.6}, {37.4, 57.2}, {37.6, 49.4}, {37.6, 49.8}, {37.6, 58.2}, {37.8, 51}, {37.8, 53.2}, {37.8, 57.4}, {38, 53.6}, {38.2, 55}, {38.4, 52}, {38.4, 55.6}, {38.6, 51.8}, {38.6, 56.8}, {38.8, 51.4}, {38.8, 53.4}, {38.8, 54.6}, {39, 53.8}, {39.2, 50.2}, {39.2, 58}, {39.4, 55.6}, {39.6, 52.8}, {39.8, 51.4}, {39.8, 51.6}, {39.8, 53.6}, {39.8, 55.4}, {39.8, 56.4}, {39.8, 57.4}, {39.8, 58.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251306] = { -- Hoarder : https://wowhead.com/forever/npc=251306/hoarder
            [npcKeys.name] = "Hoarder",
        },
        [251314] = { -- Skyhopper : https://wowhead.com/forever/npc=251314/skyhopper
            [npcKeys.name] = "Skyhopper",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{57.6, 74.2}, {57.8, 72.8}, {57.8, 76.8}, {58.2, 75.2}, {58.2, 76.4}, {58.8, 76.8}, {59, 73.2}, {59.2, 75}, {59.2, 76}, {59.4, 74.4}, {59.6, 73.2}, {59.8, 75.4}, {59.8, 75.6}, {60.6, 75.2}, {60.8, 73.2}, {60.8, 74.2}, {61, 76.4}, {62.2, 73.4}, {62.2, 73.6}, {62.2, 75.2}, {62.4, 76}, {62.8, 77.6}, {63, 74.4}, {63, 74.6}, {63, 77.2}, {63.2, 75.8}, {63.2, 78.8}, {63.8, 75.6}, {64.2, 78.2}, {64.2, 80.6}, {65.4, 76.4}, {65.4, 76.6}, {65.6, 79.2}, {66, 76.4}, {66.2, 79.6}, {66.4, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251317] = { -- Slimecontrolled Creature : https://wowhead.com/forever/npc=251317/slimecontrolled-creature
            [npcKeys.name] = "Slimecontrolled Creature",
        },
        [251320] = { -- Peasant : https://wowhead.com/forever/npc=251320/peasant
            [npcKeys.name] = "Peasant",
            [npcKeys.spawns] = {[616] = {{14.8, 51.2}, {15.2, 52.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251321] = { -- Peon : https://wowhead.com/forever/npc=251321/peon
            [npcKeys.name] = "Peon",
            [npcKeys.spawns] = {[616] = {{12.8, 51.2}, {13, 52.6}, {13.6, 53.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [251340] = { -- Stalker : https://wowhead.com/forever/npc=251340/stalker
            [npcKeys.name] = "Stalker",
        },
        [251343] = { -- Shen'dralar Citizen : https://wowhead.com/forever/npc=251343/shendralar-citizen
            [npcKeys.name] = "Shen'dralar Citizen",
            [npcKeys.spawns] = {[16651] = {{42.6, 60}, {51, 74.6}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [251354] = { -- Skeleton : https://wowhead.com/forever/npc=251354/skeleton
            [npcKeys.name] = "Skeleton",
        },
        [251361] = { -- Rorian the Dayseeker : https://wowhead.com/forever/npc=251361/rorian-the-dayseeker
            [npcKeys.name] = "Rorian the Dayseeker",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{42, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92461, 92464, 92471, 92481, 92482, 92483, 92484, 92485, 92532},
            [npcKeys.questEnds] = {92460, 92461, 92469, 92474},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251362] = { -- Ailee Farheart : https://wowhead.com/forever/npc=251362/ailee-farheart
            [npcKeys.name] = "Ailee Farheart",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{42.8, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92460},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251363] = { -- Dalia the Collector : https://wowhead.com/forever/npc=251363/dalia-the-collector
            [npcKeys.name] = "Dalia the Collector",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{43.2, 24}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93552},
            [npcKeys.questEnds] = {93552},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251364] = { -- Destin Thriceforged : https://wowhead.com/forever/npc=251364/destin-thriceforged
            [npcKeys.name] = "Destin Thriceforged",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{43.4, 23.4}, {43.4, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251365] = { -- Jolee Brightmeadows : https://wowhead.com/forever/npc=251365/jolee-brightmeadows
            [npcKeys.name] = "Jolee Brightmeadows",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{43.4, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251366] = { -- Aetheen of the Gales : https://wowhead.com/forever/npc=251366/aetheen-of-the-gales
            [npcKeys.name] = "Aetheen of the Gales",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{42.6, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92470, 92472, 96638},
            [npcKeys.questEnds] = {92470, 92471},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251368] = { -- Elatrell Featherlight : https://wowhead.com/forever/npc=251368/elatrell-featherlight
            [npcKeys.name] = "Elatrell Featherlight",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{43.4, 24.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92462, 92463},
            [npcKeys.questEnds] = {92462, 92463},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251371] = { -- Falorne Fallwind : https://wowhead.com/forever/npc=251371/falorne-fallwind
            [npcKeys.name] = "Falorne Fallwind",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{43.2, 24.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92597},
            [npcKeys.questEnds] = {92597},
            [npcKeys.friendlyToFaction] = "A",
        },
        [251373] = { -- Xyton Silverwind : https://wowhead.com/forever/npc=251373/xyton-silverwind
            [npcKeys.name] = "Xyton Silverwind",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{41.6, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {92485},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251374] = { -- Windshaper Boro : https://wowhead.com/forever/npc=251374/windshaper-boro
            [npcKeys.name] = "Windshaper Boro",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{42.8, 23.4}, {42.8, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92466, 92467},
            [npcKeys.questEnds] = {92466, 92468, 92484},
            [npcKeys.friendlyToFaction] = "H",
        },
        [251376] = { -- Tai'ree Farsight : https://wowhead.com/forever/npc=251376/tairee-farsight
            [npcKeys.name] = "Tai'ree Farsight",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{42.4, 23.4}, {42.4, 23.6}, {42.6, 23.4}, {42.6, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {92482},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251379] = { -- Dorii Brightwhisper : https://wowhead.com/forever/npc=251379/dorii-brightwhisper
            [npcKeys.name] = "Dorii Brightwhisper",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{41.4, 23.4}, {41.4, 23.6}, {41.6, 23.4}, {41.6, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {92481},
            [npcKeys.friendlyToFaction] = "A",
        },
        [251389] = { -- Akeri Duskblade : https://wowhead.com/forever/npc=251389/akeri-duskblade
            [npcKeys.name] = "Akeri Duskblade",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{43.6, 24.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {92483},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251402] = { -- Cirrusfly Soldier : https://wowhead.com/forever/npc=251402/cirrusfly-soldier
            [npcKeys.name] = "Cirrusfly Soldier",
            [npcKeys.minLevel] = 2,
            [npcKeys.maxLevel] = 2,
            [npcKeys.spawns] = {[16593] = {{47, 27.6}, {47.4, 26.4}, {47.4, 27.2}, {47.4, 29}, {47.6, 26.8}, {47.6, 28}, {47.8, 28.6}, {47.8, 29.6}, {48.6, 28.4}, {48.6, 28.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251404] = { -- Cirrusfly Queen : https://wowhead.com/forever/npc=251404/cirrusfly-queen
            [npcKeys.name] = "Cirrusfly Queen",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[16593] = {{47.6, 28.9}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251407] = { -- Cirrusfly Hive : https://wowhead.com/forever/npc=251407/cirrusfly-hive
            [npcKeys.name] = "Cirrusfly Hive",
        },
        [251428] = { -- Hoarder : https://wowhead.com/forever/npc=251428/hoarder
            [npcKeys.name] = "Hoarder",
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251437] = { -- Fireflies : https://wowhead.com/forever/npc=251437/fireflies
            [npcKeys.name] = "Fireflies",
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251448] = { -- Al'Aketh Neophyte : https://wowhead.com/forever/npc=251448/alaketh-neophyte
            [npcKeys.name] = "Al'Aketh Neophyte",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 4,
            [npcKeys.spawns] = {[16593] = {{35, 33.6}, {35.4, 31.8}, {35.4, 33.2}, {36.4, 31.4}, {36.4, 31.6}, {36.4, 33.2}, {36.8, 33}, {37, 31.4}, {37, 34.8}, {37.4, 32.4}, {37.4, 33.8}, {37.6, 32.6}, {37.6, 33.6}, {37.6, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251451] = { -- Al'Aketh Ambusher : https://wowhead.com/forever/npc=251451/alaketh-ambusher
            [npcKeys.name] = "Al'Aketh Ambusher",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{38.2, 34}, {38.8, 34}, {39, 33.4}, {39.6, 34.4}, {39.8, 34.6}, {40.6, 36.8}, {41, 35.2}, {41, 36.4}, {41.6, 38}, {42, 37.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251469] = { -- Cirrusfly Hive : https://wowhead.com/forever/npc=251469/cirrusfly-hive
            [npcKeys.name] = "Cirrusfly Hive",
        },
        [251478] = { -- Stalker : https://wowhead.com/forever/npc=251478/stalker
            [npcKeys.name] = "Stalker",
        },
        [251486] = { -- Viaara Shadowsong : https://wowhead.com/forever/npc=251486/viaara-shadowsong
            [npcKeys.name] = "Viaara Shadowsong",
        },
        [251487] = { -- Ventaari Brightwish : https://wowhead.com/forever/npc=251487/ventaari-brightwish
            [npcKeys.name] = "Ventaari Brightwish",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{42.6, 24.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92598},
            [npcKeys.questEnds] = {92598},
            [npcKeys.friendlyToFaction] = "H",
        },
        [251488] = { -- Ghansurok : https://wowhead.com/forever/npc=251488/ghansurok
            [npcKeys.name] = "Ghansurok",
        },
        [251489] = { -- Placeholder : https://wowhead.com/forever/npc=251489/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251490] = { -- Placeholder : https://wowhead.com/forever/npc=251490/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251491] = { -- Placeholder : https://wowhead.com/forever/npc=251491/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251492] = { -- Placeholder : https://wowhead.com/forever/npc=251492/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251493] = { -- Captain McManus : https://wowhead.com/forever/npc=251493/captain-mcmanus
            [npcKeys.name] = "Captain McManus",
        },
        [251494] = { -- Boulupulo : https://wowhead.com/forever/npc=251494/boulupulo
            [npcKeys.name] = "Boulupulo",
        },
        [251495] = { -- Placeholder : https://wowhead.com/forever/npc=251495/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251496] = { -- Placeholder : https://wowhead.com/forever/npc=251496/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251497] = { -- Placeholder : https://wowhead.com/forever/npc=251497/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251498] = { -- Placeholder : https://wowhead.com/forever/npc=251498/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251499] = { -- Placeholder : https://wowhead.com/forever/npc=251499/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251500] = { -- Placeholder : https://wowhead.com/forever/npc=251500/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251501] = { -- Placeholder : https://wowhead.com/forever/npc=251501/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251502] = { -- Placeholder : https://wowhead.com/forever/npc=251502/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251503] = { -- Placeholder : https://wowhead.com/forever/npc=251503/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251504] = { -- Placeholder : https://wowhead.com/forever/npc=251504/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251505] = { -- Placeholder : https://wowhead.com/forever/npc=251505/placeholder
            [npcKeys.name] = "Placeholder",
        },
        [251506] = { -- Stalker : https://wowhead.com/forever/npc=251506/stalker
            [npcKeys.name] = "Stalker",
        },
        [251507] = { -- Josephine Carson : https://wowhead.com/forever/npc=251507/josephine-carson
            [npcKeys.name] = "Josephine Carson",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[12] = {{41.2, 66.2}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {94792, 94793, 94863, 94864},
            [npcKeys.questEnds] = {94792, 94863, 94864},
            [npcKeys.friendlyToFaction] = "A",
        },
        [251523] = { -- Constable Aonda : https://wowhead.com/forever/npc=251523/constable-aonda
            [npcKeys.name] = "Constable Aonda",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{45.4, 45.4}, {45.6, 45.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92514, 92517, 92550, 92579, 92701, 93036, 93461, 93926, 93948},
            [npcKeys.questEnds] = {92472, 92514, 92517, 92528, 92550, 93461, 93927},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251537] = { -- Uualia Suncrest : https://wowhead.com/forever/npc=251537/uualia-suncrest
            [npcKeys.name] = "Uualia Suncrest",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{42.8, 24.4}, {42.8, 24.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251553] = { -- Ghansurok : https://wowhead.com/forever/npc=251553/ghansurok
            [npcKeys.name] = "Ghansurok",
        },
        [251554] = { -- Yngwe Windstream : https://wowhead.com/forever/npc=251554/yngwe-windstream
            [npcKeys.name] = "Yngwe Windstream",
        },
        [251559] = { -- Hoarder : https://wowhead.com/forever/npc=251559/hoarder
            [npcKeys.name] = "Hoarder",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{38, 51.2}, {40, 40.4}, {40.4, 53}, {40.6, 52.6}, {41, 45}, {42, 25.6}, {42.2, 44}, {42.8, 28}, {42.8, 44.8}, {42.8, 47.8}, {43, 44.4}, {43.8, 59.6}, {44.6, 42}, {44.6, 43}, {44.8, 48}, {45, 57.2}, {46.2, 78.4}, {47.4, 75.6}, {48.2, 78.8}, {51.8, 69.4}, {52, 69.8}, {56.2, 77.4}, {57.4, 75.2}, {58.8, 66.4}, {58.8, 77.2}, {58.8, 77.6}, {59.2, 72.2}, {59.6, 77.8}, {60, 77.4}, {60.8, 74.4}, {61, 74.8}, {61.4, 63.4}, {61.4, 63.6}, {63, 67.8}, {63, 79}, {65, 78}, {65.2, 46.4}, {66.2, 75}, {69.2, 61.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251565] = { -- Glaive Thrower : https://wowhead.com/forever/npc=251565/glaive-thrower
            [npcKeys.name] = "Glaive Thrower",
        },
        [251566] = { -- Glaive : https://wowhead.com/forever/npc=251566/glaive
            [npcKeys.name] = "Glaive",
        },
        [251615] = { -- Deathulus : https://wowhead.com/forever/npc=251615/deathulus
            [npcKeys.name] = "Deathulus",
        },
        [251617] = { -- Peeps : https://wowhead.com/forever/npc=251617/peeps
            [npcKeys.name] = "Peeps",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{43.8, 24}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251618] = { -- Crushfist Bloodbreaker : https://wowhead.com/forever/npc=251618/crushfist-bloodbreaker
            [npcKeys.name] = "Crushfist Bloodbreaker",
        },
        [251620] = { -- Monocuglare : https://wowhead.com/forever/npc=251620/monocuglare
            [npcKeys.name] = "Monocuglare",
        },
        [251622] = { -- Flutterfly : https://wowhead.com/forever/npc=251622/flutterfly
            [npcKeys.name] = "Flutterfly",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{46, 71.8}, {46.2, 72.8}, {47, 76.8}, {47.8, 76.4}, {47.8, 76.6}, {48, 79.6}, {48.2, 73.4}, {48.2, 73.6}, {48.2, 78.4}, {48.2, 78.6}, {48.6, 75.6}, {48.6, 79.2}, {49, 81.8}, {49.2, 74}, {49.4, 77.4}, {49.4, 77.6}, {49.6, 77.4}, {49.8, 81}, {50, 73.2}, {50, 75.2}, {50.2, 73.6}, {50.2, 79.4}, {50.2, 79.6}, {50.4, 72.2}, {50.4, 77.8}, {50.4, 82.4}, {50.4, 82.8}, {50.8, 80.8}, {51, 81.8}, {51, 83.4}, {51, 83.6}, {51.2, 75.8}, {51.4, 75.4}, {51.4, 77.2}, {51.6, 77}, {51.8, 82}, {51.8, 83.4}, {52.6, 79.2}, {52.8, 80}, {53, 82.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251635] = { -- Windblessed Faedragon : https://wowhead.com/forever/npc=251635/windblessed-faedragon
            [npcKeys.name] = "Windblessed Faedragon",
        },
        [251637] = { -- Initiastrasz : https://wowhead.com/forever/npc=251637/initiastrasz
            [npcKeys.name] = "Initiastrasz",
        },
        [251661] = { -- Galestrider : https://wowhead.com/forever/npc=251661/galestrider
            [npcKeys.name] = "Galestrider",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{35.8, 47.6}, {36.2, 46.8}, {36.4, 55.8}, {36.4, 57.2}, {36.4, 57.8}, {36.6, 57.6}, {36.8, 47.8}, {36.8, 56.8}, {37, 47.2}, {37, 58.6}, {37.2, 46.4}, {37.2, 56.4}, {37.4, 43.4}, {37.4, 44.2}, {37.4, 44.6}, {37.4, 55.4}, {37.6, 43.8}, {37.6, 44.8}, {37.6, 46.2}, {37.6, 46.6}, {37.6, 58.2}, {38, 42.4}, {38.4, 43}, {38.4, 55.4}, {38.4, 55.6}, {38.8, 42.2}, {39, 55.8}, {39.2, 41.4}, {39.4, 43.4}, {39.4, 43.8}, {39.4, 45}, {39.4, 46.2}, {39.4, 47}, {39.4, 51.8}, {39.4, 52.6}, {39.6, 41.2}, {39.6, 41.8}, {39.6, 43.4}, {39.8, 46.8}, {39.8, 58.8}, {40, 39.4}, {40, 40.4}, {40, 47.6}, {40.2, 44}, {40.2, 52}, {40.4, 38.4}, {40.4, 45.4}, {40.4, 45.6}, {40.4, 52.8}, {40.6, 39.2}, {40.6, 39.6}, {40.6, 44.4}, {40.6, 60.2}, {40.8, 38.4}, {41, 62.2}, {41.2, 41.2}, {41.2, 42}, {41.2, 42.6}, {41.2, 62.6}, {41.4, 45.2}, {41.4, 45.6}, {41.6, 39}, {41.6, 41.6}, {41.6, 45.2}, {41.6, 45.6}, {41.8, 41.4}, {41.8, 56.2}, {42, 39.6}, {42, 56.8}, {42.2, 35.4}, {42.2, 38.2}, {42.2, 49.4}, {42.4, 35.6}, {42.4, 36.8}, {42.4, 49.8}, {42.4, 60.6}, {42.6, 35.4}, {42.6, 39.2}, {42.6, 39.8}, {42.6, 49.4}, {42.6, 49.8}, {42.6, 62.8}, {42.8, 36.4}, {42.8, 37.8}, {43, 37.4}, {43, 58.2}, {43.6, 57.8}, {43.8, 38.2}, {43.8, 56.8}, {44.4, 37.4}, {44.4, 38.6}, {44.4, 42.2}, {44.4, 43}, {44.6, 37.8}, {44.6, 38.6}, {44.6, 42.4}, {44.6, 42.6}, {44.8, 66.4}, {44.8, 66.6}, {45, 36.4}, {45.2, 41}, {45.2, 58.6}, {45.4, 36.8}, {45.4, 40.4}, {45.4, 53.4}, {45.4, 56.2}, {45.6, 37.6}, {45.6, 40.4}, {45.6, 53.4}, {45.6, 53.6}, {45.6, 56.4}, {45.8, 58.2}, {45.8, 65.6}, {46, 36.8}, {46.2, 36.2}, {46.2, 40.8}, {46.2, 42.4}, {46.2, 42.6}, {46.4, 43.8}, {46.4, 68.4}, {46.6, 40.2}, {46.6, 43.4}, {46.6, 44.2}, {46.6, 57.2}, {46.6, 57.8}, {46.6, 65.4}, {46.8, 40.8}, {47.2, 66}, {47.4, 36.2}, {47.4, 37.4}, {47.4, 37.8}, {47.4, 38.8}, {47.4, 51.8}, {47.6, 36.2}, {47.6, 36.8}, {47.8, 38.2}, {47.8, 38.8}, {52, 65.4}, {52, 65.6}, {52.6, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251662] = { -- Living Lightning : https://wowhead.com/forever/npc=251662/living-lightning
            [npcKeys.name] = "Living Lightning",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{47.2, 56}, {47.4, 54}, {47.4, 55.4}, {47.6, 53.2}, {47.6, 56}, {48, 54.2}, {48, 57}, {48.2, 55}, {48.4, 57.8}, {48.6, 56.8}, {48.6, 57.8}, {49, 53.8}, {49, 58.6}, {49.4, 55.4}, {49.4, 56}, {49.6, 55}, {49.6, 56}, {49.6, 57.6}, {50, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251672] = { -- Gutknuckle : https://wowhead.com/forever/npc=251672/gutknuckle
            [npcKeys.name] = "Gutknuckle",
        },
        [251673] = { -- Lord Bloodfiend : https://wowhead.com/forever/npc=251673/lord-bloodfiend
            [npcKeys.name] = "Lord Bloodfiend",
        },
        [251676] = { -- Wind Hollow : https://wowhead.com/forever/npc=251676/wind-hollow
            [npcKeys.name] = "Wind Hollow",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{57, 29.4}, {57.2, 29.6}, {57.2, 33.4}, {57.2, 33.6}, {57.4, 32}, {57.6, 31}, {57.6, 32.2}, {57.6, 33.8}, {57.8, 30.4}, {58.4, 32.6}, {58.6, 32.2}, {58.8, 31.2}, {58.8, 32.6}, {59.2, 34.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251683] = { -- Captain Plunderspine : https://wowhead.com/forever/npc=251683/captain-plunderspine
            [npcKeys.name] = "Captain Plunderspine",
        },
        [251684] = { -- Strange Hermit : https://wowhead.com/forever/npc=251684/strange-hermit
            [npcKeys.name] = "Strange Hermit",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{54, 39}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93159, 93160, 93172, 98285},
            [npcKeys.questEnds] = {93159, 93160, 93172, 98285},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251707] = { -- Ornery Galestrider : https://wowhead.com/forever/npc=251707/ornery-galestrider
            [npcKeys.name] = "Ornery Galestrider",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{45.4, 81.2}, {45.6, 81.2}, {48.4, 74.4}, {48.4, 74.6}, {48.4, 77.4}, {48.4, 79.2}, {48.4, 84.2}, {48.4, 85.6}, {48.6, 84.2}, {48.8, 74.4}, {49, 77.4}, {49, 85}, {49.2, 79}, {49.2, 79.6}, {49.4, 75.2}, {49.4, 75.6}, {49.4, 78.4}, {49.4, 80.8}, {49.4, 82.2}, {49.4, 83}, {49.6, 73.4}, {49.6, 76}, {49.6, 81.4}, {49.6, 84.6}, {49.8, 74}, {49.8, 80}, {49.8, 82.6}, {50, 78.4}, {50, 83.6}, {50.4, 75}, {50.4, 79}, {50.4, 81.8}, {50.6, 75.2}, {50.6, 75.6}, {50.6, 78.4}, {50.6, 78.8}, {50.6, 83.2}, {51, 76.6}, {51, 80}, {51.2, 82.2}, {51.4, 81.4}, {51.6, 74.8}, {51.6, 77.4}, {51.6, 78.6}, {51.6, 81.2}, {51.6, 82}, {52, 77.8}, {52.4, 71.4}, {52.4, 71.6}, {52.6, 77.8}, {52.8, 71.4}, {53.2, 69.6}, {53.2, 72.2}, {53.4, 69.4}, {53.4, 72.6}, {53.4, 74}, {53.4, 74.8}, {53.6, 69.2}, {53.6, 70.2}, {53.6, 72.4}, {53.6, 72.8}, {53.8, 71.4}, {53.8, 74.4}, {53.8, 75}, {54, 76.2}, {54.6, 69.6}, {54.6, 75.2}, {54.6, 76}, {54.8, 71.6}, {55.2, 73.8}, {55.4, 71}, {55.6, 74.4}, {55.6, 75.4}, {55.6, 76}, {55.8, 70.8}, {56.2, 69.2}, {56.2, 70.2}, {56.2, 72.8}, {56.6, 75}, {57, 70.4}, {57, 70.6}, {57.2, 68.4}, {57.2, 68.8}, {57.8, 62.4}, {57.8, 63}, {58, 68.4}, {58.2, 63.6}, {58.4, 65.2}, {58.4, 68.6}, {58.4, 69.8}, {58.6, 67.2}, {58.6, 68.8}, {58.6, 69.6}, {59, 65.4}, {59, 65.6}, {59, 67.8}, {59.2, 62.4}, {59.4, 62.6}, {59.4, 73.4}, {59.6, 62}, {59.6, 67.4}, {59.8, 69.8}, {60, 68}, {60, 69.2}, {60.6, 68.2}, {61.4, 69.4}, {61.4, 69.8}, {61.6, 69.4}, {61.6, 70.2}, {61.8, 67.8}, {62.8, 69}, {62.8, 70.6}, {63.4, 67.4}, {63.4, 67.8}, {63.4, 69.6}, {63.6, 69.2}, {64.4, 67.6}, {64.6, 66.4}, {64.8, 67.4}, {64.8, 67.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251727] = { -- Skyhopper : https://wowhead.com/forever/npc=251727/skyhopper
            [npcKeys.name] = "Skyhopper",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{57.4, 74.2}, {57.6, 74.2}, {57.8, 72.8}, {57.8, 76.8}, {58, 75.2}, {58.2, 76.4}, {58.8, 73}, {58.8, 75.2}, {58.8, 76.8}, {59.4, 74.2}, {59.4, 75.8}, {59.6, 72.8}, {59.8, 75.4}, {59.8, 75.6}, {60.4, 73.6}, {60.6, 75}, {60.8, 73.2}, {60.8, 74.2}, {61, 76.4}, {62.2, 73.2}, {62.2, 73.6}, {62.4, 75.4}, {62.4, 76}, {62.6, 73.2}, {62.6, 74.8}, {62.8, 77.6}, {63, 74.4}, {63, 77}, {63.2, 75.8}, {63.4, 79}, {63.6, 77.6}, {63.8, 76.2}, {64, 80}, {64.2, 80.6}, {65.2, 80.2}, {65.4, 76.4}, {65.4, 76.6}, {65.6, 79.2}, {66, 76.4}, {66.4, 76.6}, {66.4, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251730] = { -- Dustbrain : https://wowhead.com/forever/npc=251730/dustbrain
            [npcKeys.name] = "Dustbrain",
        },
        [251734] = { -- Gear Adjustment : https://wowhead.com/forever/npc=251734/gear-adjustment
            [npcKeys.name] = "Gear Adjustment",
        },
        [251735] = { -- Battery : https://wowhead.com/forever/npc=251735/battery
            [npcKeys.name] = "Battery",
        },
        [251736] = { -- Gear Adjustment : https://wowhead.com/forever/npc=251736/gear-adjustment
            [npcKeys.name] = "Gear Adjustment",
        },
        [251737] = { -- Battery : https://wowhead.com/forever/npc=251737/battery
            [npcKeys.name] = "Battery",
        },
        [251782] = { -- Brock : https://wowhead.com/forever/npc=251782/brock
            [npcKeys.name] = "Brock",
            [npcKeys.spawns] = {[36] = {{21.2, 73.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251783] = { -- Korben : https://wowhead.com/forever/npc=251783/korben
            [npcKeys.name] = "Korben",
            [npcKeys.spawns] = {[36] = {{22, 75}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251784] = { -- Dallas : https://wowhead.com/forever/npc=251784/dallas
            [npcKeys.name] = "Dallas",
            [npcKeys.spawns] = {[36] = {{21.8, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251785] = { -- Josie : https://wowhead.com/forever/npc=251785/josie
            [npcKeys.name] = "Josie",
            [npcKeys.spawns] = {[36] = {{21.8, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251787] = { -- Lilly : https://wowhead.com/forever/npc=251787/lilly
            [npcKeys.name] = "Lilly",
            [npcKeys.spawns] = {[36] = {{21.8, 73.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251816] = { -- Stalker : https://wowhead.com/forever/npc=251816/stalker
            [npcKeys.name] = "Stalker",
        },
        [251829] = { -- (DNT) Dice Manager Stalker : https://wowhead.com/forever/npc=251829/dnt-dice-manager-stalker
            [npcKeys.name] = "(DNT) Dice Manager Stalker",
        },
        [251862] = { -- Stalker : https://wowhead.com/forever/npc=251862/stalker
            [npcKeys.name] = "Stalker",
        },
        [251881] = { -- Coin Pile : https://wowhead.com/forever/npc=251881/coin-pile
            [npcKeys.name] = "Coin Pile",
        },
        [251890] = { -- Tyrus Blackhorn : https://wowhead.com/forever/npc=251890/tyrus-blackhorn
            [npcKeys.name] = "Tyrus Blackhorn",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{27, 59.6}, {27.2, 59.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [251894] = { -- Sazzbakk : https://wowhead.com/forever/npc=251894/sazzbakk
            [npcKeys.name] = "Sazzbakk",
        },
        [251902] = { -- Illaya Amberwind : https://wowhead.com/forever/npc=251902/illaya-amberwind
            [npcKeys.name] = "Illaya Amberwind",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{43.4, 44.8}, {43.6, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92595, 94411},
            [npcKeys.questEnds] = {92595, 94411},
            [npcKeys.friendlyToFaction] = "H",
        },
        [251903] = { -- Rathiril Sunlance : https://wowhead.com/forever/npc=251903/rathiril-sunlance
            [npcKeys.name] = "Rathiril Sunlance",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{45, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92596, 94413},
            [npcKeys.questEnds] = {92596, 94413},
            [npcKeys.friendlyToFaction] = "A",
        },
        [251904] = { -- Sania Silverstream : https://wowhead.com/forever/npc=251904/sania-silverstream
            [npcKeys.name] = "Sania Silverstream",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{44.8, 45.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92529},
            [npcKeys.questEnds] = {93036},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251905] = { -- Zerril Softbreeze : https://wowhead.com/forever/npc=251905/zerril-softbreeze
            [npcKeys.name] = "Zerril Softbreeze",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{43.8, 43.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92553},
            [npcKeys.questEnds] = {92553, 96646},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251906] = { -- Teeri Wellwind : https://wowhead.com/forever/npc=251906/teeri-wellwind
            [npcKeys.name] = "Teeri Wellwind",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{44.4, 45}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92516, 93319},
            [npcKeys.questEnds] = {92516, 93319},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251907] = { -- (DNT) Dread Bite Stalker : https://wowhead.com/forever/npc=251907/dnt-dread-bite-stalker
            [npcKeys.name] = "(DNT) Dread Bite Stalker",
        },
        [251913] = { -- Aedi Thriceforged : https://wowhead.com/forever/npc=251913/aedi-thriceforged
            [npcKeys.name] = "Aedi Thriceforged",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{44.8, 44.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97964},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251918] = { -- Highlands Bandit : https://wowhead.com/forever/npc=251918/highlands-bandit
            [npcKeys.name] = "Highlands Bandit",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{47.4, 36}, {47.4, 37.2}, {47.4, 38.2}, {47.4, 38.8}, {47.6, 36.4}, {47.8, 37}, {47.8, 38.4}, {47.8, 38.6}, {48.8, 37.2}, {49.2, 35.4}, {49.2, 35.8}, {49.2, 38.4}, {49.2, 40}, {49.4, 34.4}, {49.4, 38.6}, {49.6, 38.8}, {49.8, 33.8}, {49.8, 35}, {50, 35.8}, {50.4, 33.4}, {50.6, 33.4}, {50.6, 33.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [251922] = { -- Wild Bomb : https://wowhead.com/forever/npc=251922/wild-bomb
            [npcKeys.name] = "Wild Bomb",
        },
        [251925] = { -- Faladiel : https://wowhead.com/forever/npc=251925/faladiel
            [npcKeys.name] = "Faladiel",
        },
        [251926] = { -- Sania : https://wowhead.com/forever/npc=251926/sania
            [npcKeys.name] = "Sania",
        },
        [251952] = { -- Pirate : https://wowhead.com/forever/npc=251952/pirate
            [npcKeys.name] = "Pirate",
        },
        [251953] = { -- Talia Softglen : https://wowhead.com/forever/npc=251953/talia-softglen
            [npcKeys.name] = "Talia Softglen",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 27,
            [npcKeys.spawns] = {[36] = {{19.8, 70.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251955] = { -- Lucian Trias : https://wowhead.com/forever/npc=251955/lucian-trias
            [npcKeys.name] = "Lucian Trias",
            [npcKeys.spawns] = {[36] = {{20.2, 67.4}, {20.2, 67.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251956] = { -- Lizi Silverstone : https://wowhead.com/forever/npc=251956/lizi-silverstone
            [npcKeys.name] = "Lizi Silverstone",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{20, 66.4}, {20, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251960] = { -- Glaive Thrower : https://wowhead.com/forever/npc=251960/glaive-thrower
            [npcKeys.name] = "Glaive Thrower",
        },
        [251961] = { -- Lift : https://wowhead.com/forever/npc=251961/lift
            [npcKeys.name] = "Lift",
        },
        [251964] = { -- Blademaster Ren : https://wowhead.com/forever/npc=251964/blademaster-ren
            [npcKeys.name] = "Blademaster Ren",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{43.4, 24.2}, {43.6, 24.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {92532},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251965] = { -- Fevrath Skyhammer : https://wowhead.com/forever/npc=251965/fevrath-skyhammer
            [npcKeys.name] = "Fevrath Skyhammer",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{43.2, 23.4}, {43.4, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251966] = { -- Commander Cyclas : https://wowhead.com/forever/npc=251966/commander-cyclas
            [npcKeys.name] = "Commander Cyclas",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{49.8, 56.4}, {50, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251968] = { -- Ayessa Dawnsinger : https://wowhead.com/forever/npc=251968/ayessa-dawnsinger
            [npcKeys.name] = "Ayessa Dawnsinger",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{59, 79.4}, {59, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92708, 92871, 93735, 93740, 93746, 93836, 95349},
            [npcKeys.questEnds] = {92646, 92700, 92708, 93090, 93738, 93740, 93746},
            [npcKeys.friendlyToFaction] = "H",
        },
        [251969] = { -- Lift : https://wowhead.com/forever/npc=251969/lift
            [npcKeys.name] = "Lift",
        },
        [251970] = { -- Glaive Thrower : https://wowhead.com/forever/npc=251970/glaive-thrower
            [npcKeys.name] = "Glaive Thrower",
        },
        [251971] = { -- Smoldering Burn : https://wowhead.com/forever/npc=251971/smoldering-burn
            [npcKeys.name] = "Smoldering Burn",
        },
        [251972] = { -- Charles Worth : https://wowhead.com/forever/npc=251972/charles-worth
            [npcKeys.name] = "Charles Worth",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{17.6, 60.2}, {17.8, 60.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251973] = { -- Dominique Stefano : https://wowhead.com/forever/npc=251973/dominique-stefano
            [npcKeys.name] = "Dominique Stefano",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{17.6, 60.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251974] = { -- Linna Bruder : https://wowhead.com/forever/npc=251974/linna-bruder
            [npcKeys.name] = "Linna Bruder",
            [npcKeys.spawns] = {[36] = {{17.4, 59.6}, {17.6, 59.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251975] = { -- Harold Winston : https://wowhead.com/forever/npc=251975/harold-winston
            [npcKeys.name] = "Harold Winston",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[36] = {{18, 62}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251976] = { -- Tiffany Cartier : https://wowhead.com/forever/npc=251976/tiffany-cartier
            [npcKeys.name] = "Tiffany Cartier",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{18, 62}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251977] = { -- Angelique Butler : https://wowhead.com/forever/npc=251977/angelique-butler
            [npcKeys.name] = "Angelique Butler",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{17.2, 61}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251978] = { -- Vanessa Sellers : https://wowhead.com/forever/npc=251978/vanessa-sellers
            [npcKeys.name] = "Vanessa Sellers",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{16.6, 62.6}, {16.8, 62.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251979] = { -- Jepetto Joybuzz : https://wowhead.com/forever/npc=251979/jepetto-joybuzz
            [npcKeys.name] = "Jepetto Joybuzz",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{16.4, 65}, {16.6, 65}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251980] = { -- Rueben Lauren : https://wowhead.com/forever/npc=251980/rueben-lauren
            [npcKeys.name] = "Rueben Lauren",
            [npcKeys.spawns] = {[36] = {{15.8, 65.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251981] = { -- Sheddle Glossgleam : https://wowhead.com/forever/npc=251981/sheddle-glossgleam
            [npcKeys.name] = "Sheddle Glossgleam",
            [npcKeys.spawns] = {[36] = {{16.4, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [251991] = { -- Taleen Shimmerthread : https://wowhead.com/forever/npc=251991/taleen-shimmerthread
            [npcKeys.name] = "Taleen Shimmerthread",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{44.8, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93951},
            [npcKeys.questEnds] = {93951, 97972, 97973},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251992] = { -- Fenn Fairweather : https://wowhead.com/forever/npc=251992/fenn-fairweather
            [npcKeys.name] = "Fenn Fairweather",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{45, 48.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97967},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251993] = { -- Indari Sunseam : https://wowhead.com/forever/npc=251993/indari-sunseam
            [npcKeys.name] = "Indari Sunseam",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{44.6, 44.4}, {44.6, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92515},
            [npcKeys.questEnds] = {92515, 97969},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [251996] = { -- Tenn Fairweather : https://wowhead.com/forever/npc=251996/tenn-fairweather
            [npcKeys.name] = "Tenn Fairweather",
        },
        [251997] = { -- Norvin Alderman : https://wowhead.com/forever/npc=251997/norvin-alderman
            [npcKeys.name] = "Norvin Alderman",
            [npcKeys.spawns] = {[36] = {{16, 65.4}, {16, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [251999] = { -- Debbi Moore : https://wowhead.com/forever/npc=251999/debbi-moore
            [npcKeys.name] = "Debbi Moore",
            [npcKeys.spawns] = {[36] = {{15.4, 68.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252000] = { -- Brammold Deepmine : https://wowhead.com/forever/npc=252000/brammold-deepmine
            [npcKeys.name] = "Brammold Deepmine",
            [npcKeys.spawns] = {[36] = {{15.8, 68.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252001] = { -- Orton Bennet : https://wowhead.com/forever/npc=252001/orton-bennet
            [npcKeys.name] = "Orton Bennet",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252003] = { -- Fairweather Caravan : https://wowhead.com/forever/npc=252003/fairweather-caravan
            [npcKeys.name] = "Fairweather Caravan",
        },
        [252004] = { -- Ninsianna : https://wowhead.com/forever/npc=252004/ninsianna
            [npcKeys.name] = "Ninsianna",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252019] = { -- Abra Cadabra : https://wowhead.com/forever/npc=252019/abra-cadabra
            [npcKeys.name] = "Abra Cadabra",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{12, 70.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252020] = { -- Jack Findle : https://wowhead.com/forever/npc=252020/jack-findle
            [npcKeys.name] = "Jack Findle",
            [npcKeys.minLevel] = 27,
            [npcKeys.maxLevel] = 27,
            [npcKeys.spawns] = {[36] = {{13.2, 71.2}, {13.2, 71.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252022] = { -- Susana Averoy : https://wowhead.com/forever/npc=252022/susana-averoy
            [npcKeys.name] = "Susana Averoy",
            [npcKeys.spawns] = {[36] = {{13.2, 71.2}, {13.2, 71.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252040] = { -- Hagatha Moorehead : https://wowhead.com/forever/npc=252040/hagatha-moorehead
            [npcKeys.name] = "Hagatha Moorehead",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 27,
            [npcKeys.spawns] = {[36] = {{14, 63.4}, {14.2, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252063] = { -- Deadwood Den Guardian : https://wowhead.com/forever/npc=252063/deadwood-den-guardian
            [npcKeys.name] = "Deadwood Den Guardian",
            [npcKeys.spawns] = {[616] = {{24, 66.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [252068] = { -- Al'Aketh Stormcaller : https://wowhead.com/forever/npc=252068/alaketh-stormcaller
            [npcKeys.name] = "Al'Aketh Stormcaller",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{47.2, 56}, {47.2, 57.8}, {47.4, 53.4}, {47.4, 53.6}, {47.4, 55}, {47.6, 52.4}, {47.6, 54.2}, {47.6, 55.4}, {47.6, 55.6}, {48, 53.2}, {48, 56.8}, {48, 57.6}, {48.8, 54.6}, {48.8, 57}, {49, 53.8}, {49.2, 58}, {49.4, 56}, {49.6, 54.2}, {49.6, 55}, {49.6, 57.8}, {49.8, 56.4}, {49.8, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252076] = { -- High Priestess Lorthuna : https://wowhead.com/forever/npc=252076/high-priestess-lorthuna
            [npcKeys.name] = "High Priestess Lorthuna",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{48.8, 54}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252077] = { -- Skypriest Aanders : https://wowhead.com/forever/npc=252077/skypriest-aanders
            [npcKeys.name] = "Skypriest Aanders",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{48.8, 54}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252078] = { -- KC Creature : https://wowhead.com/forever/npc=252078/kc-creature
            [npcKeys.name] = "KC Creature",
        },
        [252079] = { -- KC Creature : https://wowhead.com/forever/npc=252079/kc-creature
            [npcKeys.name] = "KC Creature",
        },
        [252080] = { -- Stefan Cotter : https://wowhead.com/forever/npc=252080/stefan-cotter
            [npcKeys.name] = "Stefan Cotter",
            [npcKeys.minLevel] = 27,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{12.8, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252081] = { -- Sebastian Bower : https://wowhead.com/forever/npc=252081/sebastian-bower
            [npcKeys.name] = "Sebastian Bower",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[36] = {{12.4, 65}, {12.6, 64.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252082] = { -- Marcella Bloom : https://wowhead.com/forever/npc=252082/marcella-bloom
            [npcKeys.name] = "Marcella Bloom",
        },
        [252083] = { -- Derek Odds : https://wowhead.com/forever/npc=252083/derek-odds
            [npcKeys.name] = "Derek Odds",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{12.4, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252084] = { -- Katherine Lee : https://wowhead.com/forever/npc=252084/katherine-lee
            [npcKeys.name] = "Katherine Lee",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{12.4, 65.8}, {12.6, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252085] = { -- Archmage Celindra : https://wowhead.com/forever/npc=252085/archmage-celindra
            [npcKeys.name] = "Archmage Celindra",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[36] = {{14.2, 60}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252086] = { -- Mei Francis : https://wowhead.com/forever/npc=252086/mei-francis
            [npcKeys.name] = "Mei Francis",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{18.8, 70}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [252087] = { -- Horse : https://wowhead.com/forever/npc=252087/horse
            [npcKeys.name] = "Horse",
            [npcKeys.spawns] = {[36] = {{18.8, 69.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252088] = { -- Ice Claw Bear : https://wowhead.com/forever/npc=252088/ice-claw-bear
            [npcKeys.name] = "Ice Claw Bear",
            [npcKeys.spawns] = {[36] = {{19.8, 70.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252089] = { -- Diemetradon : https://wowhead.com/forever/npc=252089/diemetradon
            [npcKeys.name] = "Diemetradon",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252090] = { -- White Lion : https://wowhead.com/forever/npc=252090/white-lion
            [npcKeys.name] = "White Lion",
            [npcKeys.spawns] = {[36] = {{19.8, 70.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252091] = { -- Gryphon : https://wowhead.com/forever/npc=252091/gryphon
            [npcKeys.name] = "Gryphon",
        },
        [252092] = { -- Frostwolf : https://wowhead.com/forever/npc=252092/frostwolf
            [npcKeys.name] = "Frostwolf",
            [npcKeys.spawns] = {[36] = {{19.8, 69.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252093] = { -- School of Fish : https://wowhead.com/forever/npc=252093/school-of-fish
            [npcKeys.name] = "School of Fish",
        },
        [252094] = { -- Trophy Fish : https://wowhead.com/forever/npc=252094/trophy-fish
            [npcKeys.name] = "Trophy Fish",
        },
        [252095] = { -- Hanaa Nightwind : https://wowhead.com/forever/npc=252095/hanaa-nightwind
            [npcKeys.name] = "Hanaa Nightwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{38.2, 30.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92544},
            [npcKeys.questEnds] = {92544},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252096] = { -- Deadwood Fel-Tender : https://wowhead.com/forever/npc=252096/deadwood-fel-tender
            [npcKeys.name] = "Deadwood Fel-Tender",
        },
        [252111] = { -- Fuzz : https://wowhead.com/forever/npc=252111/fuzz
            [npcKeys.name] = "Fuzz",
            [npcKeys.spawns] = {[36] = {{19.6, 70.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252113] = { -- Dart Frog : https://wowhead.com/forever/npc=252113/dart-frog
            [npcKeys.name] = "Dart Frog",
            [npcKeys.spawns] = {[36] = {{19.4, 70.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252116] = { -- Deadwood Totemic : https://wowhead.com/forever/npc=252116/deadwood-totemic
            [npcKeys.name] = "Deadwood Totemic",
            [npcKeys.spawns] = {[616] = {{22.8, 64.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [252117] = { -- Reuse Me : https://wowhead.com/forever/npc=252117/reuse-me
            [npcKeys.name] = "Reuse Me",
        },
        [252137] = { -- Snake : https://wowhead.com/forever/npc=252137/snake
            [npcKeys.name] = "Snake",
            [npcKeys.spawns] = {[36] = {{19.2, 70.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252155] = { -- Peacekeeper Vaaniel : https://wowhead.com/forever/npc=252155/peacekeeper-vaaniel
            [npcKeys.name] = "Peacekeeper Vaaniel",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{42.4, 62}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93927},
            [npcKeys.questEnds] = {93926},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252157] = { -- Al'Aketh Cutthroat : https://wowhead.com/forever/npc=252157/alaketh-cutthroat
            [npcKeys.name] = "Al'Aketh Cutthroat",
        },
        [252166] = { -- Thimble : https://wowhead.com/forever/npc=252166/thimble
            [npcKeys.name] = "Thimble",
        },
        [252168] = { -- Frankie : https://wowhead.com/forever/npc=252168/frankie
            [npcKeys.name] = "Frankie",
            [npcKeys.spawns] = {[36] = {{16.4, 65}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252169] = { -- Boulder Bully : https://wowhead.com/forever/npc=252169/boulder-bully
            [npcKeys.name] = "Boulder Bully",
        },
        [252172] = { -- Danarii Bellowveil : https://wowhead.com/forever/npc=252172/danarii-bellowveil
            [npcKeys.name] = "Danarii Bellowveil",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{45.2, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92551},
            [npcKeys.questEnds] = {92551, 93318},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252206] = { -- Patrick Ginnis : https://wowhead.com/forever/npc=252206/patrick-ginnis
            [npcKeys.name] = "Patrick Ginnis",
        },
        [252207] = { -- Sally : https://wowhead.com/forever/npc=252207/sally
            [npcKeys.name] = "Sally",
        },
        [252319] = { -- Cirrusfly Hive : https://wowhead.com/forever/npc=252319/cirrusfly-hive
            [npcKeys.name] = "Cirrusfly Hive",
        },
        [252346] = { -- Hnaz Blunderflame : https://wowhead.com/forever/npc=252346/hnaz-blunderflame
            [npcKeys.name] = "Hnaz Blunderflame",
        },
        [252355] = { -- Lily : https://wowhead.com/forever/npc=252355/lily
            [npcKeys.name] = "Lily",
        },
        [252356] = { -- Roger : https://wowhead.com/forever/npc=252356/roger
            [npcKeys.name] = "Roger",
            [npcKeys.spawns] = {[36] = {{21.8, 74.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252357] = { -- Chicken : https://wowhead.com/forever/npc=252357/chicken
            [npcKeys.name] = "Chicken",
            [npcKeys.spawns] = {[36] = {{19.4, 70.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252359] = { -- Lotheluum Starbreeze : https://wowhead.com/forever/npc=252359/lotheluum-starbreeze
            [npcKeys.name] = "Lotheluum Starbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64, 75}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94006, 94484},
            [npcKeys.questEnds] = {94491},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252360] = { -- Alley : https://wowhead.com/forever/npc=252360/alley
            [npcKeys.name] = "Alley",
        },
        [252362] = { -- Toby : https://wowhead.com/forever/npc=252362/toby
            [npcKeys.name] = "Toby",
            [npcKeys.spawns] = {[36] = {{14.2, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252363] = { -- Merry : https://wowhead.com/forever/npc=252363/merry
            [npcKeys.name] = "Merry",
        },
        [252364] = { -- Pancakes : https://wowhead.com/forever/npc=252364/pancakes
            [npcKeys.name] = "Pancakes",
            [npcKeys.spawns] = {[36] = {{23, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252373] = { -- Anathamaas Aetherwind : https://wowhead.com/forever/npc=252373/anathamaas-aetherwind
            [npcKeys.name] = "Anathamaas Aetherwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.8, 80.4}, {65.8, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93791},
            [npcKeys.friendlyToFaction] = "A",
        },
        [252374] = { -- Lalaa Lunarbreeze : https://wowhead.com/forever/npc=252374/lalaa-lunarbreeze
            [npcKeys.name] = "Lalaa Lunarbreeze",
        },
        [252375] = { -- Neyaa Songspring : https://wowhead.com/forever/npc=252375/neyaa-songspring
            [npcKeys.name] = "Neyaa Songspring",
        },
        [252376] = { -- Emerii Tallgust : https://wowhead.com/forever/npc=252376/emerii-tallgust
            [npcKeys.name] = "Emerii Tallgust",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{63.8, 80.4}, {63.8, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252377] = { -- Seena Skybreaker : https://wowhead.com/forever/npc=252377/seena-skybreaker
            [npcKeys.name] = "Seena Skybreaker",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.8, 72.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94003},
            [npcKeys.questEnds] = {94003},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252378] = { -- Yorana Windyreed : https://wowhead.com/forever/npc=252378/yorana-windyreed
            [npcKeys.name] = "Yorana Windyreed",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{69.6, 67}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92642, 92645, 92880},
            [npcKeys.questEnds] = {92642, 92645, 93320},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252379] = { -- Eltheen Nightbreeze : https://wowhead.com/forever/npc=252379/eltheen-nightbreeze
            [npcKeys.name] = "Eltheen Nightbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.8, 72.4}, {59.8, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252380] = { -- Othesia Evengale : https://wowhead.com/forever/npc=252380/othesia-evengale
            [npcKeys.name] = "Othesia Evengale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.4, 81}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252381] = { -- Orelnaa Evengale : https://wowhead.com/forever/npc=252381/orelnaa-evengale
            [npcKeys.name] = "Orelnaa Evengale",
        },
        [252382] = { -- Sessaria Skystride : https://wowhead.com/forever/npc=252382/sessaria-skystride
            [npcKeys.name] = "Sessaria Skystride",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58.2, 78.4}, {58.2, 78.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {97243},
            [npcKeys.questEnds] = {97257},
            [npcKeys.friendlyToFaction] = "H",
        },
        [252383] = { -- Valennia Stormfist : https://wowhead.com/forever/npc=252383/valennia-stormfist
            [npcKeys.name] = "Valennia Stormfist",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{66.2, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92699, 92700, 92881, 93065, 93320, 93949},
            [npcKeys.questEnds] = {92579, 92640, 92701, 92860, 92871, 92880, 93949},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252384] = { -- Railei Rumblebreeze : https://wowhead.com/forever/npc=252384/railei-rumblebreeze
            [npcKeys.name] = "Railei Rumblebreeze",
        },
        [252385] = { -- Sazzbakk : https://wowhead.com/forever/npc=252385/sazzbakk
            [npcKeys.name] = "Sazzbakk",
        },
        [252387] = { -- Whislee Wondergust : https://wowhead.com/forever/npc=252387/whislee-wondergust
            [npcKeys.name] = "Whislee Wondergust",
        },
        [252388] = { -- Halavuul Cragwind : https://wowhead.com/forever/npc=252388/halavuul-cragwind
            [npcKeys.name] = "Halavuul Cragwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.4, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252389] = { -- Quel'ana Quickgale : https://wowhead.com/forever/npc=252389/quelana-quickgale
            [npcKeys.name] = "Quel'ana Quickgale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.6, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94013, 94050, 94978, 94979},
            [npcKeys.questEnds] = {94007, 94013, 94978, 94979},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252390] = { -- Antelariaa Cloudgaze : https://wowhead.com/forever/npc=252390/antelariaa-cloudgaze
            [npcKeys.name] = "Antelariaa Cloudgaze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63, 77.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252391] = { -- Haalee Windstalker : https://wowhead.com/forever/npc=252391/haalee-windstalker
            [npcKeys.name] = "Haalee Windstalker",
        },
        [252392] = { -- Orsaan Dalewind : https://wowhead.com/forever/npc=252392/orsaan-dalewind
            [npcKeys.name] = "Orsaan Dalewind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.2, 75.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252408] = { -- Uugorol : https://wowhead.com/forever/npc=252408/uugorol
            [npcKeys.name] = "Uugorol",
        },
        [252409] = { -- Myrkiss : https://wowhead.com/forever/npc=252409/myrkiss
            [npcKeys.name] = "Myrkiss",
        },
        [252417] = { -- As The Crow Flies : https://wowhead.com/forever/npc=252417/as-the-crow-flies
            [npcKeys.name] = "As The Crow Flies",
        },
        [252424] = { -- Tara : https://wowhead.com/forever/npc=252424/tara
            [npcKeys.name] = "Tara",
        },
        [252425] = { -- Buddy : https://wowhead.com/forever/npc=252425/buddy
            [npcKeys.name] = "Buddy",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252428] = { -- Munchies : https://wowhead.com/forever/npc=252428/munchies
            [npcKeys.name] = "Munchies",
            [npcKeys.spawns] = {[36] = {{16, 63.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252429] = { -- Prairie Dog : https://wowhead.com/forever/npc=252429/prairie-dog
            [npcKeys.name] = "Prairie Dog",
            [npcKeys.spawns] = {[36] = {{15.8, 63}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252432] = { -- Sprout : https://wowhead.com/forever/npc=252432/sprout
            [npcKeys.name] = "Sprout",
            [npcKeys.spawns] = {[36] = {{16.8, 62.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252435] = { -- Nori : https://wowhead.com/forever/npc=252435/nori
            [npcKeys.name] = "Nori",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252437] = { -- Momo : https://wowhead.com/forever/npc=252437/momo
            [npcKeys.name] = "Momo",
        },
        [252438] = { -- Mister Tibbs : https://wowhead.com/forever/npc=252438/mister-tibbs
            [npcKeys.name] = "Mister Tibbs",
            [npcKeys.spawns] = {[36] = {{18, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252439] = { -- Beepo : https://wowhead.com/forever/npc=252439/beepo
            [npcKeys.name] = "Beepo",
            [npcKeys.spawns] = {[36] = {{20, 66.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252440] = { -- Niko : https://wowhead.com/forever/npc=252440/niko
            [npcKeys.name] = "Niko",
            [npcKeys.spawns] = {[36] = {{20, 66.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252448] = { -- Alvarion Windfield : https://wowhead.com/forever/npc=252448/alvarion-windfield
            [npcKeys.name] = "Alvarion Windfield",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{62, 73.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92679},
            [npcKeys.questEnds] = {92703},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252449] = { -- Iallion Featherfall : https://wowhead.com/forever/npc=252449/iallion-featherfall
            [npcKeys.name] = "Iallion Featherfall",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58.8, 75.4}, {58.8, 75.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252457] = { -- Mazzogore : https://wowhead.com/forever/npc=252457/mazzogore
            [npcKeys.name] = "Mazzogore",
        },
        [252464] = { -- Aleister : https://wowhead.com/forever/npc=252464/aleister
            [npcKeys.name] = "Aleister",
        },
        [252467] = { -- Miss Mojo : https://wowhead.com/forever/npc=252467/miss-mojo
            [npcKeys.name] = "Miss Mojo",
            [npcKeys.spawns] = {[36] = {{13, 66.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252468] = { -- Potato : https://wowhead.com/forever/npc=252468/potato
            [npcKeys.name] = "Potato",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252469] = { -- Twiggy : https://wowhead.com/forever/npc=252469/twiggy
            [npcKeys.name] = "Twiggy",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252472] = { -- Turaal Trueblade : https://wowhead.com/forever/npc=252472/turaal-trueblade
            [npcKeys.name] = "Turaal Trueblade",
        },
        [252473] = { -- Denaris Zephyrgaze : https://wowhead.com/forever/npc=252473/denaris-zephyrgaze
            [npcKeys.name] = "Denaris Zephyrgaze",
        },
        [252475] = { -- Elaadrin Evengale : https://wowhead.com/forever/npc=252475/elaadrin-evengale
            [npcKeys.name] = "Elaadrin Evengale",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{66.4, 79.8}, {66.6, 79.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92709, 92834, 92840, 92860, 94369, 94946},
            [npcKeys.questEnds] = {92699, 92709, 92834, 92840, 93089, 93835},
            [npcKeys.friendlyToFaction] = "A",
        },
        [252476] = { -- Talaanis Shadowsong : https://wowhead.com/forever/npc=252476/talaanis-shadowsong
            [npcKeys.name] = "Talaanis Shadowsong",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{66.2, 76.4}, {66.2, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92640, 92643, 93089, 93090, 94568},
            [npcKeys.questEnds] = {92644, 92881, 93836, 93948, 94369, 94568},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252477] = { -- Peacekeeper Elite : https://wowhead.com/forever/npc=252477/peacekeeper-elite
            [npcKeys.name] = "Peacekeeper Elite",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{64.2, 76.2}, {64.4, 63.6}, {65.4, 76.2}, {65.6, 76}, {66.2, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252478] = { -- Xy'aaria Streamrunner : https://wowhead.com/forever/npc=252478/xyaaria-streamrunner
            [npcKeys.name] = "Xy'aaria Streamrunner",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.2, 77.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252479] = { -- Daeann Steelwind : https://wowhead.com/forever/npc=252479/daeann-steelwind
            [npcKeys.name] = "Daeann Steelwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.4, 80.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252481] = { -- Wind Sprite : https://wowhead.com/forever/npc=252481/wind-sprite
            [npcKeys.name] = "Wind Sprite",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{46, 37.4}, {46.4, 38}, {46.4, 38.8}, {46.6, 38.4}, {46.8, 39.2}, {47, 37.4}, {47.2, 69.4}, {47.4, 69.6}, {48, 69}, {48.4, 68.4}, {48.4, 69.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252482] = { -- Malevolent Zephyr : https://wowhead.com/forever/npc=252482/malevolent-zephyr
            [npcKeys.name] = "Malevolent Zephyr",
        },
        [252489] = { -- Tiger : https://wowhead.com/forever/npc=252489/tiger
            [npcKeys.name] = "Tiger",
            [npcKeys.spawns] = {[36] = {{13.2, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252492] = { -- Chloe : https://wowhead.com/forever/npc=252492/chloe
            [npcKeys.name] = "Chloe",
        },
        [252501] = { -- Sunny : https://wowhead.com/forever/npc=252501/sunny
            [npcKeys.name] = "Sunny",
            [npcKeys.spawns] = {[36] = {{13.6, 70.6}, {18.2, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252502] = { -- Butterscotch : https://wowhead.com/forever/npc=252502/butterscotch
            [npcKeys.name] = "Butterscotch",
            [npcKeys.spawns] = {[36] = {{13.8, 70.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252503] = { -- Solus : https://wowhead.com/forever/npc=252503/solus
            [npcKeys.name] = "Solus",
        },
        [252504] = { -- Pippin : https://wowhead.com/forever/npc=252504/pippin
            [npcKeys.name] = "Pippin",
        },
        [252505] = { -- Syrah : https://wowhead.com/forever/npc=252505/syrah
            [npcKeys.name] = "Syrah",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252506] = { -- Honey : https://wowhead.com/forever/npc=252506/honey
            [npcKeys.name] = "Honey",
        },
        [252530] = { -- Haido : https://wowhead.com/forever/npc=252530/haido
            [npcKeys.name] = "Haido",
            [npcKeys.spawns] = {[36] = {{12.8, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252532] = { -- Princess Nana : https://wowhead.com/forever/npc=252532/princess-nana
            [npcKeys.name] = "Princess Nana",
        },
        [252533] = { -- Kocha : https://wowhead.com/forever/npc=252533/kocha
            [npcKeys.name] = "Kocha",
            [npcKeys.spawns] = {[36] = {{12.2, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252534] = { -- Arya : https://wowhead.com/forever/npc=252534/arya
            [npcKeys.name] = "Arya",
        },
        [252535] = { -- Zara : https://wowhead.com/forever/npc=252535/zara
            [npcKeys.name] = "Zara",
        },
        [252536] = { -- Lulu : https://wowhead.com/forever/npc=252536/lulu
            [npcKeys.name] = "Lulu",
            [npcKeys.spawns] = {[36] = {{23, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [252537] = { -- Misifus : https://wowhead.com/forever/npc=252537/misifus
            [npcKeys.name] = "Misifus",
        },
        [252542] = { -- Survivor Village Guard : https://wowhead.com/forever/npc=252542/survivor-village-guard
            [npcKeys.name] = "Survivor Village Guard",
        },
        [252588] = { -- Zeez : https://wowhead.com/forever/npc=252588/zeez
            [npcKeys.name] = "Zeez",
        },
        [252592] = { -- Lake Crawler : https://wowhead.com/forever/npc=252592/lake-crawler
            [npcKeys.name] = "Lake Crawler",
        },
        [252593] = { -- Arcane Manifestation : https://wowhead.com/forever/npc=252593/arcane-manifestation
            [npcKeys.name] = "Arcane Manifestation",
        },
        [252594] = { -- Wimdy the Wagon Driver : https://wowhead.com/forever/npc=252594/wimdy-the-wagon-driver
            [npcKeys.name] = "Wimdy the Wagon Driver",
        },
        [252629] = { -- Boulder : https://wowhead.com/forever/npc=252629/boulder
            [npcKeys.name] = "Boulder",
        },
        [252630] = { -- Boulder : https://wowhead.com/forever/npc=252630/boulder
            [npcKeys.name] = "Boulder",
        },
        [252632] = { -- Tenn Fairweather : https://wowhead.com/forever/npc=252632/tenn-fairweather
            [npcKeys.name] = "Tenn Fairweather",
        },
        [252655] = { -- Boulder : https://wowhead.com/forever/npc=252655/boulder
            [npcKeys.name] = "Boulder",
        },
        [252664] = { -- Al'Aketh Stormchaser : https://wowhead.com/forever/npc=252664/alaketh-stormchaser
            [npcKeys.name] = "Al'Aketh Stormchaser",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{62, 35.8}, {62.2, 37.6}, {62.4, 37.2}, {62.6, 36.2}, {62.6, 37.2}, {63, 38.6}, {63.4, 37.8}, {63.6, 36.2}, {63.6, 38}, {63.8, 36.8}, {63.8, 39}, {64.6, 38.4}, {64.6, 38.6}, {65, 36.4}, {65.4, 37}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252665] = { -- Al'Aketh Footsoldier : https://wowhead.com/forever/npc=252665/alaketh-footsoldier
            [npcKeys.name] = "Al'Aketh Footsoldier",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{62.2, 38.4}, {62.2, 38.6}, {62.6, 38.6}, {63, 36.4}, {63.4, 37.2}, {63.4, 37.8}, {63.6, 36.4}, {63.6, 37.6}, {64.4, 36.8}, {64.6, 37.8}, {64.8, 37}, {65.4, 36}, {65.6, 35.4}, {65.6, 35.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252666] = { -- Commander Belguilos : https://wowhead.com/forever/npc=252666/commander-belguilos
            [npcKeys.name] = "Commander Belguilos",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.6, 65.4}, {65.6, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252691] = { -- Adarien : https://wowhead.com/forever/npc=252691/adarien
            [npcKeys.name] = "Adarien",
            [npcKeys.spawns] = {[16651] = {{42.6, 70}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [252695] = { -- Pylon Protector : https://wowhead.com/forever/npc=252695/pylon-protector
            [npcKeys.name] = "Pylon Protector",
            [npcKeys.spawns] = {[16651] = {{47.4, 79.2}, {48.4, 77.4}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [252696] = { -- Shard Guard : https://wowhead.com/forever/npc=252696/shard-guard
            [npcKeys.name] = "Shard Guard",
            [npcKeys.spawns] = {[16651] = {{47.6, 76.8}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [252703] = { -- Shen'dralar Pylon : https://wowhead.com/forever/npc=252703/shendralar-pylon
            [npcKeys.name] = "Shen'dralar Pylon",
        },
        [252711] = { -- Decrepit Pylon Protector : https://wowhead.com/forever/npc=252711/decrepit-pylon-protector
            [npcKeys.name] = "Decrepit Pylon Protector",
        },
        [252754] = { -- Vincent : https://wowhead.com/forever/npc=252754/vincent
            [npcKeys.name] = "Vincent",
        },
        [252758] = { -- Al'Akir the Windlord : https://wowhead.com/forever/npc=252758/alakir-the-windlord
            [npcKeys.name] = "Al'Akir the Windlord",
        },
        [252762] = { -- Al'Aketh Guardian : https://wowhead.com/forever/npc=252762/alaketh-guardian
            [npcKeys.name] = "Al'Aketh Guardian",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{58.2, 50.6}, {59, 53}, {59.2, 49.4}, {59.4, 50.4}, {59.4, 50.6}, {59.4, 52}, {59.6, 52.2}, {59.8, 52.8}, {60.4, 49.4}, {60.4, 50.4}, {60.4, 51.2}, {60.6, 49.6}, {60.6, 51}, {60.6, 51.8}, {60.8, 48.4}, {60.8, 49}, {61.2, 52.6}, {61.6, 50.4}, {61.6, 50.6}, {61.8, 48.6}, {62, 53.2}, {62.2, 46.2}, {62.2, 51.6}, {62.4, 47}, {62.4, 48.4}, {62.4, 53.6}, {62.6, 46.8}, {62.6, 50}, {62.6, 51.4}, {62.8, 53.4}, {63, 48.8}, {63, 53.6}, {63.2, 48}, {63.4, 46.2}, {63.4, 52.2}, {63.6, 52}, {63.6, 53.4}, {63.6, 54.4}, {63.8, 46.4}, {63.8, 46.6}, {63.8, 50.4}, {64, 45.4}, {64.2, 55}, {64.6, 52.8}, {64.6, 53.8}, {64.8, 47.2}, {64.8, 56.2}, {65, 45}, {65, 46.2}, {65.2, 47.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252763] = { -- Al'Aketh Spiritcaller : https://wowhead.com/forever/npc=252763/alaketh-spiritcaller
            [npcKeys.name] = "Al'Aketh Spiritcaller",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.6, 52.2}, {60, 49.8}, {60.2, 51.4}, {60.4, 49.2}, {60.8, 50}, {61, 51}, {61, 51.8}, {61.2, 52.8}, {61.4, 49.4}, {61.8, 48.6}, {61.8, 51.4}, {62, 47.4}, {62, 49.6}, {62, 53.2}, {62.2, 51.6}, {62.2, 53.6}, {62.4, 48.4}, {62.6, 48.4}, {62.8, 53.4}, {63, 49}, {63.4, 46.8}, {63.4, 52.2}, {63.4, 54.2}, {63.4, 54.6}, {63.6, 52.2}, {63.6, 54.4}, {63.8, 45.4}, {63.8, 46.6}, {64, 46.4}, {64.2, 55.4}, {64.6, 45.8}, {64.6, 54.4}, {64.8, 47.2}, {65, 44.6}, {65, 56.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252764] = { -- Al'Aketh Skypriest : https://wowhead.com/forever/npc=252764/alaketh-skypriest
            [npcKeys.name] = "Al'Aketh Skypriest",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{64.8, 51.6}, {65.2, 50.4}, {65.2, 50.6}, {65.6, 50}, {65.8, 47.4}, {66.2, 51.4}, {66.2, 51.6}, {66.4, 49.2}, {66.6, 49.4}, {66.8, 50}, {66.8, 50.6}, {66.8, 52.4}, {69, 49.4}, {69, 49.6}, {69, 50.6}, {69.8, 48.8}, {69.8, 51.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252765] = { -- Al'Aketh Blademaster : https://wowhead.com/forever/npc=252765/alaketh-blademaster
            [npcKeys.name] = "Al'Aketh Blademaster",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.4, 50}, {59.4, 51.4}, {59.4, 52}, {59.6, 52.2}, {59.8, 52.8}, {60.2, 49.4}, {60.2, 50}, {60.2, 51.4}, {60.6, 49.2}, {60.8, 50}, {61, 51.8}, {61.2, 51.2}, {61.2, 52.6}, {61.4, 48.2}, {62, 47.4}, {62, 47.6}, {62, 48.8}, {62, 49.8}, {62, 53.2}, {62.4, 46.4}, {62.4, 51.2}, {62.4, 51.6}, {62.4, 53.8}, {62.6, 48.4}, {62.6, 51}, {62.8, 49.8}, {63, 48.6}, {63, 52.4}, {63, 52.6}, {63.2, 46.8}, {63.4, 45.2}, {63.4, 46.4}, {63.4, 54.2}, {63.6, 52}, {63.8, 45.4}, {63.8, 46.4}, {63.8, 46.6}, {64, 55.4}, {64.2, 48.6}, {64.2, 56}, {64.4, 54.4}, {64.6, 45.6}, {64.6, 46.6}, {64.6, 53.8}, {64.6, 54.6}, {64.8, 45.2}, {65, 56.4}, {65.4, 48.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252767] = { -- Al'Aketh Honor Guard : https://wowhead.com/forever/npc=252767/alaketh-honor-guard
            [npcKeys.name] = "Al'Aketh Honor Guard",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{65.2, 50.2}, {65.2, 50.6}, {65.6, 50.2}, {66.2, 51.4}, {66.4, 49.2}, {66.6, 49.4}, {66.6, 51.2}, {66.8, 50}, {68.6, 50.4}, {69, 50.8}, {69.4, 49}, {69.8, 48.8}, {69.8, 51.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252800] = { -- Aamelia Windfield : https://wowhead.com/forever/npc=252800/aamelia-windfield
            [npcKeys.name] = "Aamelia Windfield",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{46.6, 81.8}, {47, 81.2}, {47.2, 80}, {47.4, 78.4}, {47.4, 78.6}, {47.6, 78.4}, {47.6, 78.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92682, 92683, 92684, 92685, 92693, 92703},
            [npcKeys.questEnds] = {92679, 92682, 92683, 92684, 92685, 92693, 92698},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252802] = { -- Hungry Bandit : https://wowhead.com/forever/npc=252802/hungry-bandit
            [npcKeys.name] = "Hungry Bandit",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{46, 78.8}, {46.2, 80.4}, {46.4, 77.2}, {46.4, 78.4}, {46.4, 80.8}, {46.6, 77.4}, {46.6, 80.4}, {46.6, 80.6}, {46.8, 78.6}, {46.8, 81.8}, {47.2, 77.8}, {47.4, 76.2}, {47.4, 82.6}, {47.4, 83.6}, {47.6, 78.2}, {47.6, 79.4}, {47.6, 80.2}, {47.6, 81.6}, {48, 84}, {48.2, 83.2}, {48.4, 80.6}, {48.4, 84.6}, {48.6, 80.8}, {48.8, 83.4}, {49, 81.6}, {49.2, 84}, {49.2, 84.6}, {50, 82.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252806] = { -- Territorial Fox : https://wowhead.com/forever/npc=252806/territorial-fox
            [npcKeys.name] = "Territorial Fox",
        },
        [252813] = { -- Prideclaw Raptor : https://wowhead.com/forever/npc=252813/prideclaw-raptor
            [npcKeys.name] = "Prideclaw Raptor",
        },
        [252820] = { -- Bandit Highwayman : https://wowhead.com/forever/npc=252820/bandit-highwayman
            [npcKeys.name] = "Bandit Highwayman",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{43.4, 74.4}, {43.4, 74.8}, {43.8, 74.6}, {44, 74.2}, {44.8, 73.4}, {44.8, 73.6}, {44.8, 74.6}, {45, 72.4}, {45, 76.4}, {45.2, 76.8}, {45.4, 78}, {45.4, 78.8}, {45.6, 72.4}, {45.6, 77.6}, {45.6, 79}, {45.8, 73.2}, {45.8, 77.4}, {47.2, 74.4}, {47.4, 75}, {47.4, 75.6}, {47.6, 75.4}, {47.6, 75.6}, {48.2, 73.6}, {48.8, 73.6}, {49, 73.4}, {50, 76.4}, {50.2, 76.8}, {50.4, 71.4}, {50.4, 72.2}, {50.4, 72.6}, {50.6, 72}, {50.8, 71}, {50.8, 72.8}, {51, 74.4}, {51, 74.6}, {51.4, 75.8}, {51.6, 75.4}, {51.8, 75.6}, {51.8, 76.6}, {52.2, 73.8}, {52.4, 73.2}, {52.6, 73.4}, {52.6, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252863] = { -- Ferauu the Bludgeon : https://wowhead.com/forever/npc=252863/ferauu-the-bludgeon
            [npcKeys.name] = "Ferauu the Bludgeon",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{47.6, 78}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252864] = { -- Rustleaf Fox : https://wowhead.com/forever/npc=252864/rustleaf-fox
            [npcKeys.name] = "Rustleaf Fox",
        },
        [252865] = { -- Skyborne Test : https://wowhead.com/forever/npc=252865/skyborne-test
            [npcKeys.name] = "Skyborne Test",
        },
        [252869] = { -- Remi : https://wowhead.com/forever/npc=252869/remi
            [npcKeys.name] = "Remi",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{46.6, 82.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [252875] = { -- Bandit Henchman : https://wowhead.com/forever/npc=252875/bandit-henchman
            [npcKeys.name] = "Bandit Henchman",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{47.8, 77.4}, {47.8, 78}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [252878] = { -- Vivien Hathrow : https://wowhead.com/forever/npc=252878/vivien-hathrow
            [npcKeys.name] = "Vivien Hathrow",
        },
        [252957] = { -- High Priestess Lorthuna : https://wowhead.com/forever/npc=252957/high-priestess-lorthuna
            [npcKeys.name] = "High Priestess Lorthuna",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{75, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253002] = { -- Fillion Flamebreeze : https://wowhead.com/forever/npc=253002/fillion-flamebreeze
            [npcKeys.name] = "Fillion Flamebreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{50.4, 65.4}, {50.6, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [253004] = { -- Iaadaria Bitterwind : https://wowhead.com/forever/npc=253004/iaadaria-bitterwind
            [npcKeys.name] = "Iaadaria Bitterwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{66.2, 79.4}, {66.2, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92741},
            [npcKeys.questEnds] = {92741},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253066] = { -- Umarak : https://wowhead.com/forever/npc=253066/umarak
            [npcKeys.name] = "Umarak",
            [npcKeys.spawns] = {[405] = {{43.4, 78.6}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [253092] = { -- Alba Fairmoon : https://wowhead.com/forever/npc=253092/alba-fairmoon
            [npcKeys.name] = "Alba Fairmoon",
            [npcKeys.minLevel] = 24,
            [npcKeys.maxLevel] = 24,
            [npcKeys.spawns] = {[40] = {{52.4, 53}, {52.6, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
            [npcKeys.questStarts] = {92742, 92744, 92745, 92747, 92748, 92753},
            [npcKeys.questEnds] = {92742, 92744, 92745, 92747, 92752},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253096] = { -- Halea : https://wowhead.com/forever/npc=253096/halea
            [npcKeys.name] = "Halea",
        },
        [253097] = { -- Mirda : https://wowhead.com/forever/npc=253097/mirda
            [npcKeys.name] = "Mirda",
        },
        [253136] = { -- Orgrul : https://wowhead.com/forever/npc=253136/orgrul
            [npcKeys.name] = "Orgrul",
            [npcKeys.spawns] = {[16651] = {{35.6, 12}, {35.8, 13}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [253139] = { -- Gorhak : https://wowhead.com/forever/npc=253139/gorhak
            [npcKeys.name] = "Gorhak",
            [npcKeys.spawns] = {[405] = {{66.2, 79.4}}},
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [253140] = { -- Molkar : https://wowhead.com/forever/npc=253140/molkar
            [npcKeys.name] = "Molkar",
            [npcKeys.zoneID] = zoneIDs.DESOLACE,
        },
        [253153] = { -- (DNT) Invisible Stalker : https://wowhead.com/forever/npc=253153/dnt-invisible-stalker
            [npcKeys.name] = "(DNT) Invisible Stalker",
        },
        [253163] = { -- Grolkar : https://wowhead.com/forever/npc=253163/grolkar
            [npcKeys.name] = "Grolkar",
        },
        [253166] = { -- Talra : https://wowhead.com/forever/npc=253166/talra
            [npcKeys.name] = "Talra",
        },
        [253177] = { -- Nerlokh : https://wowhead.com/forever/npc=253177/nerlokh
            [npcKeys.name] = "Nerlokh",
            [npcKeys.spawns] = {[16651] = {{21.2, 23.2}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [253195] = { -- Al'Aketh Preacher : https://wowhead.com/forever/npc=253195/alaketh-preacher
            [npcKeys.name] = "Al'Aketh Preacher",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{59.2, 68.4}, {60.4, 65.4}, {60.4, 65.6}, {60.4, 68.4}, {60.8, 68.6}, {61.2, 64.2}, {61.2, 65.2}, {61.2, 65.8}, {61.2, 68.4}, {61.4, 62.2}, {61.4, 66.8}, {61.8, 66.8}, {62, 60.8}, {62, 63.2}, {62, 64.6}, {62.2, 60.4}, {62.2, 66.4}, {62.2, 68}, {62.4, 61.8}, {62.4, 63.8}, {62.6, 61.4}, {62.6, 63.4}, {62.6, 65.4}, {63, 60.4}, {63, 63.8}, {63, 65.8}, {63.2, 67.2}, {63.4, 62}, {63.6, 60.4}, {63.6, 60.8}, {63.8, 64.6}, {64, 62.8}, {64.2, 62.4}, {64.2, 64.4}, {64.2, 66}, {64.4, 58}, {64.6, 66}, {65.2, 58}, {65.2, 63}, {65.4, 62.4}, {65.4, 64.4}, {65.4, 64.6}, {65.6, 58}, {65.6, 64.6}, {66, 62.6}, {66, 64.4}, {66.2, 57.2}, {66.4, 62.4}, {66.6, 62.4}, {66.6, 63.8}, {66.8, 63.4}, {67.8, 62.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253204] = { -- Dondallion Whisperwind : https://wowhead.com/forever/npc=253204/dondallion-whisperwind
            [npcKeys.name] = "Dondallion Whisperwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{66.2, 79.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92727},
            [npcKeys.questEnds] = {92850},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253226] = { -- DNT : https://wowhead.com/forever/npc=253226/dnt
            [npcKeys.name] = "DNT",
        },
        [253272] = { -- Magram Necromancer : https://wowhead.com/forever/npc=253272/magram-necromancer
            [npcKeys.name] = "Magram Necromancer",
            [npcKeys.minLevel] = 43,
            [npcKeys.maxLevel] = 43,
            [npcKeys.spawns] = {[405] = {{63.8, 80.6}}, [16651] = {{35.6, 17.8}, {35.6, 18.8}, {35.8, 25.2}, {38.4, 28.6}, {39, 29.2}, {41.2, 31.2}, {46.4, 42}, {46.6, 41.2}}},
        },
        [253274] = { -- Magram Necrokhan : https://wowhead.com/forever/npc=253274/magram-necrokhan
            [npcKeys.name] = "Magram Necrokhan",
            [npcKeys.spawns] = {[16651] = {{39, 30.2}, {45, 32.8}, {45.2, 32}, {50.8, 41.6}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [253275] = { -- Outcast Necrokhan : https://wowhead.com/forever/npc=253275/outcast-necrokhan
            [npcKeys.name] = "Outcast Necrokhan",
        },
        [253277] = { -- Griswold : https://wowhead.com/forever/npc=253277/griswold
            [npcKeys.name] = "Griswold",
        },
        [253279] = { -- Alba Fairmoon : https://wowhead.com/forever/npc=253279/alba-fairmoon
            [npcKeys.name] = "Alba Fairmoon",
            [npcKeys.minLevel] = 24,
            [npcKeys.maxLevel] = 24,
            [npcKeys.spawns] = {[40] = {{38.4, 83.6}, {38.6, 83.2}, {38.6, 83.6}}},
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
            [npcKeys.questStarts] = {92819},
            [npcKeys.questEnds] = {92753, 92819},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253280] = { -- Jasper Fel : https://wowhead.com/forever/npc=253280/jasper-fel
            [npcKeys.name] = "Jasper Fel",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[40] = {{38.4, 83.6}, {38.6, 83.6}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253281] = { -- Fillion Flamebreeze : https://wowhead.com/forever/npc=253281/fillion-flamebreeze
            [npcKeys.name] = "Fillion Flamebreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{49.8, 66.8}, {50.4, 65.6}, {50.6, 65.4}, {51.2, 66.2}, {51.2, 66.8}, {51.2, 68}, {51.4, 69}, {51.6, 66.4}, {52, 66.6}, {52, 69.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [253282] = { -- Shriekling Fledgling : https://wowhead.com/forever/npc=253282/shriekling-fledgling
            [npcKeys.name] = "Shriekling Fledgling",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{49.8, 66.8}, {50.2, 66.4}, {50.4, 65.4}, {50.6, 65.4}, {51.2, 66.2}, {51.4, 67.2}, {51.4, 68}, {51.4, 68.6}, {51.6, 67.6}, {52.2, 66.6}, {52.4, 64.8}, {52.4, 66.4}, {52.8, 64.8}, {52.8, 66.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [253283] = { -- Shriekling Matriarch : https://wowhead.com/forever/npc=253283/shriekling-matriarch
            [npcKeys.name] = "Shriekling Matriarch",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{52, 65.4}, {52, 65.8}, {52.2, 66.6}, {52.6, 66.2}, {52.6, 66.6}, {52.8, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [253284] = { -- Fillion Flamebreeze : https://wowhead.com/forever/npc=253284/fillion-flamebreeze
            [npcKeys.name] = "Fillion Flamebreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{52, 69.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92850},
            [npcKeys.questEnds] = {92849},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253285] = { -- Fillion Flamebreeze : https://wowhead.com/forever/npc=253285/fillion-flamebreeze
            [npcKeys.name] = "Fillion Flamebreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{66.2, 79.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [253286] = { -- Standing Stone Vortex : https://wowhead.com/forever/npc=253286/standing-stone-vortex
            [npcKeys.name] = "Standing Stone Vortex",
        },
        [253306] = { -- Index Esoteria : https://wowhead.com/forever/npc=253306/index-esoteria
            [npcKeys.name] = "Index Esoteria",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{48, 69}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [253310] = { -- Windshaper Shaman : https://wowhead.com/forever/npc=253310/windshaper-shaman
            [npcKeys.name] = "Windshaper Shaman",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{48, 69}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [253318] = { -- Brother Aesiil : https://wowhead.com/forever/npc=253318/brother-aesiil
            [npcKeys.name] = "Brother Aesiil",
        },
        [253335] = { -- Marny Welbrade : https://wowhead.com/forever/npc=253335/marny-welbrade
            [npcKeys.name] = "Marny Welbrade",
        },
        [253336] = { -- Gale Hardt : https://wowhead.com/forever/npc=253336/gale-hardt
            [npcKeys.name] = "Gale Hardt",
        },
        [253347] = { -- (DNT) Invisible Stalker : https://wowhead.com/forever/npc=253347/dnt-invisible-stalker
            [npcKeys.name] = "(DNT) Invisible Stalker",
        },
        [253351] = { -- [DNT] Invisible Stalker : https://wowhead.com/forever/npc=253351/dnt-invisible-stalker
            [npcKeys.name] = "[DNT] Invisible Stalker",
        },
        [253353] = { -- [DNT] Invisible Stalker : https://wowhead.com/forever/npc=253353/dnt-invisible-stalker
            [npcKeys.name] = "[DNT] Invisible Stalker",
        },
        [253357] = { -- Tower Watchman : https://wowhead.com/forever/npc=253357/tower-watchman
            [npcKeys.name] = "Tower Watchman",
        },
        [253360] = { -- Nascent Undead Ravager : https://wowhead.com/forever/npc=253360/nascent-undead-ravager
            [npcKeys.name] = "Nascent Undead Ravager",
        },
        [253370] = { -- [DNT] Kill Credit: Place Explosives : https://wowhead.com/forever/npc=253370/dnt-kill-credit-place-explosives
            [npcKeys.name] = "[DNT] Kill Credit: Place Explosives",
        },
        [253372] = { -- Dead Cultist : https://wowhead.com/forever/npc=253372/dead-cultist
            [npcKeys.name] = "Dead Cultist",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{56, 58.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92644},
            [npcKeys.questEnds] = {92643},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253394] = { -- Corpsefeeder : https://wowhead.com/forever/npc=253394/corpsefeeder
            [npcKeys.name] = "Corpsefeeder",
        },
        [253395] = { -- Ozwin Ironsprocket : https://wowhead.com/forever/npc=253395/ozwin-ironsprocket
            [npcKeys.name] = "Ozwin Ironsprocket",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[40] = {{51.4, 32.2}, {51.6, 32.2}}},
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
            [npcKeys.questStarts] = {92909, 92911},
            [npcKeys.questEnds] = {92909, 92910, 92911},
            [npcKeys.friendlyToFaction] = "A",
        },
        [253431] = { -- Gelkis Captive : https://wowhead.com/forever/npc=253431/gelkis-captive
            [npcKeys.name] = "Gelkis Captive",
            [npcKeys.spawns] = {[16651] = {{60.8, 26.8}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [253446] = { -- Haggard Bones : https://wowhead.com/forever/npc=253446/haggard-bones
            [npcKeys.name] = "Haggard Bones",
        },
        [253471] = { -- Mordent Evenshade : https://wowhead.com/forever/npc=253471/mordent-evenshade
            [npcKeys.name] = "Mordent Evenshade",
            [npcKeys.spawns] = {[16651] = {{35, 46}, {35, 46.6}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [253474] = { -- Peacekeeper : https://wowhead.com/forever/npc=253474/peacekeeper
            [npcKeys.name] = "Peacekeeper",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.2, 46.4}, {57.4, 74.2}, {58, 72.4}, {58, 73.2}, {62, 73.6}, {62.2, 75}, {64.8, 80.4}, {65, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253479] = { -- Nyliaris : https://wowhead.com/forever/npc=253479/nyliaris
            [npcKeys.name] = "Nyliaris",
        },
        [253511] = { -- Al'Aketh Pillager : https://wowhead.com/forever/npc=253511/alaketh-pillager
            [npcKeys.name] = "Al'Aketh Pillager",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{60.2, 66.6}, {60.4, 65.4}, {60.4, 66}, {60.4, 68}, {60.6, 68.2}, {60.8, 65.6}, {61, 62.4}, {61, 68.6}, {61.2, 64.2}, {61.2, 65}, {61.4, 61}, {61.4, 62.8}, {61.4, 66.6}, {61.6, 61.6}, {61.8, 60.4}, {62, 61.4}, {62, 63.4}, {62, 65}, {62, 66.6}, {62.4, 63.6}, {62.4, 66}, {62.6, 60.6}, {62.6, 63.8}, {63, 60.2}, {63, 66.6}, {63.2, 62.8}, {63.2, 65.6}, {63.4, 58.8}, {63.4, 62}, {63.4, 64.6}, {63.6, 60.4}, {63.6, 61}, {63.6, 62.2}, {63.6, 64.6}, {63.6, 66.6}, {63.8, 58.2}, {63.8, 63}, {64.2, 58.6}, {64.2, 64.4}, {64.2, 66}, {64.6, 65.8}, {64.6, 66.8}, {64.8, 62.4}, {65, 58.4}, {65, 58.6}, {65.2, 63.2}, {65.4, 61.4}, {65.4, 64.4}, {65.4, 64.6}, {65.6, 62.6}, {65.8, 64.4}, {65.8, 64.6}, {66, 57.8}, {66.2, 57}, {66.2, 61.4}, {66.2, 62.4}, {66.6, 62.2}, {66.6, 64}, {66.8, 63.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253524] = { -- Bristleback Nomad : https://wowhead.com/forever/npc=253524/bristleback-nomad
            [npcKeys.name] = "Bristleback Nomad",
        },
        [253525] = { -- Bristleback Thornweaver : https://wowhead.com/forever/npc=253525/bristleback-thornweaver
            [npcKeys.name] = "Bristleback Thornweaver",
        },
        [253526] = { -- Bristleback Skullcrusher : https://wowhead.com/forever/npc=253526/bristleback-skullcrusher
            [npcKeys.name] = "Bristleback Skullcrusher",
        },
        [253527] = { -- Kog'thug the Brave : https://wowhead.com/forever/npc=253527/kogthug-the-brave
            [npcKeys.name] = "Kog'thug the Brave",
        },
        [253529] = { -- Bristleback Snortsnout : https://wowhead.com/forever/npc=253529/bristleback-snortsnout
            [npcKeys.name] = "Bristleback Snortsnout",
        },
        [253533] = { -- Frightened Bristleback Child : https://wowhead.com/forever/npc=253533/frightened-bristleback-child
            [npcKeys.name] = "Frightened Bristleback Child",
        },
        [253535] = { -- Chicken Jockey : https://wowhead.com/forever/npc=253535/chicken-jockey
            [npcKeys.name] = "Chicken Jockey",
        },
        [253574] = { -- Al'Akir the Windlord : https://wowhead.com/forever/npc=253574/alakir-the-windlord
            [npcKeys.name] = "Al'Akir the Windlord",
        },
        [253576] = { -- Hyusaa Quickbreeze : https://wowhead.com/forever/npc=253576/hyusaa-quickbreeze
            [npcKeys.name] = "Hyusaa Quickbreeze",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{63.8, 50.4}, {63.8, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93958},
            [npcKeys.questEnds] = {92947},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253590] = { -- Valennia Stormfist : https://wowhead.com/forever/npc=253590/valennia-stormfist
            [npcKeys.name] = "Valennia Stormfist",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{65.2, 50.4}, {65.2, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92646, 93835},
            [npcKeys.questEnds] = {93958},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253622] = { -- Commander Haalien : https://wowhead.com/forever/npc=253622/commander-haalien
            [npcKeys.name] = "Commander Haalien",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.4, 36.4}, {65.4, 36.6}, {65.6, 36.2}, {65.6, 36.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253623] = { -- [DNT] Kill Credit: Speak with Mordent Evenshade : https://wowhead.com/forever/npc=253623/dnt-kill-credit-speak-with-mordent-evenshade
            [npcKeys.name] = "[DNT] Kill Credit: Speak with Mordent Evenshade",
        },
        [253642] = { -- Jorvhan Vail : https://wowhead.com/forever/npc=253642/jorvhan-vail
            [npcKeys.name] = "Jorvhan Vail",
        },
        [253664] = { -- Centaur : https://wowhead.com/forever/npc=253664/centaur
            [npcKeys.name] = "Centaur",
        },
        [253713] = { -- Mulara : https://wowhead.com/forever/npc=253713/mulara
            [npcKeys.name] = "Mulara",
        },
        [253754] = { -- [DNT] Kill Credit: Dispel the Accursed Skull : https://wowhead.com/forever/npc=253754/dnt-kill-credit-dispel-the-accursed-skull
            [npcKeys.name] = "[DNT] Kill Credit: Dispel the Accursed Skull",
        },
        [253781] = { -- Peacekeeper : https://wowhead.com/forever/npc=253781/peacekeeper
            [npcKeys.name] = "Peacekeeper",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{68.4, 67.4}, {68.4, 67.8}, {69.4, 67.2}, {69.6, 67}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253782] = { -- Al'Aketh Attacker : https://wowhead.com/forever/npc=253782/alaketh-attacker
            [npcKeys.name] = "Al'Aketh Attacker",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.2, 63.8}, {64.4, 68.2}, {65, 66.8}, {65.4, 65.8}, {66.2, 68}, {67.2, 67.2}, {67.2, 68.2}, {67.2, 68.8}, {67.8, 68.6}, {68.2, 67}, {68.2, 67.8}, {68.6, 67.4}, {68.6, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253787] = { -- Al'Aketh Attacker : https://wowhead.com/forever/npc=253787/alaketh-attacker
            [npcKeys.name] = "Al'Aketh Attacker",
        },
        [253812] = { -- Elaadrin Evengale : https://wowhead.com/forever/npc=253812/elaadrin-evengale
            [npcKeys.name] = "Elaadrin Evengale",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{61.2, 70.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [253813] = { -- Ayessa Dawnsinger : https://wowhead.com/forever/npc=253813/ayessa-dawnsinger
            [npcKeys.name] = "Ayessa Dawnsinger",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{61.2, 70.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [253844] = { -- Valennia Stormfist : https://wowhead.com/forever/npc=253844/valennia-stormfist
            [npcKeys.name] = "Valennia Stormfist",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{61.2, 71}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92947},
            [npcKeys.questEnds] = {93065},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [253847] = { -- Elaadrin Evengale : https://wowhead.com/forever/npc=253847/elaadrin-evengale
            [npcKeys.name] = "Elaadrin Evengale",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{74, 52.4}, {74, 52.6}, {75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [253849] = { -- Ayessa Dawnsinger : https://wowhead.com/forever/npc=253849/ayessa-dawnsinger
            [npcKeys.name] = "Ayessa Dawnsinger",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{74, 52.4}, {74, 52.6}, {75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [253851] = { -- Hagiak : https://wowhead.com/forever/npc=253851/hagiak
            [npcKeys.name] = "Hagiak",
            [npcKeys.spawns] = {[16651] = {{58.8, 53.8}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [253852] = { -- Bristleback Quilboar : https://wowhead.com/forever/npc=253852/bristleback-quilboar
            [npcKeys.name] = "Bristleback Quilboar",
        },
        [253860] = { -- Stick Stalker : https://wowhead.com/forever/npc=253860/stick-stalker
            [npcKeys.name] = "Stick Stalker",
        },
        [253871] = { -- Hyjal Druid : https://wowhead.com/forever/npc=253871/hyjal-druid
            [npcKeys.name] = "Hyjal Druid",
        },
        [253945] = { -- Burning Bunny : https://wowhead.com/forever/npc=253945/burning-bunny
            [npcKeys.name] = "Burning Bunny",
        },
        [253957] = { -- Muln Earthfury : https://wowhead.com/forever/npc=253957/muln-earthfury
            [npcKeys.name] = "Muln Earthfury",
        },
        [253958] = { -- Archmage Ansirem Runeweaver : https://wowhead.com/forever/npc=253958/archmage-ansirem-runeweaver
            [npcKeys.name] = "Archmage Ansirem Runeweaver",
        },
        [253973] = { -- [DNT] Kill Credit: Eastern Large Tent Burned : https://wowhead.com/forever/npc=253973/dnt-kill-credit-eastern-large-tent-burned
            [npcKeys.name] = "[DNT] Kill Credit: Eastern Large Tent Burned",
        },
        [253975] = { -- [DNT] Kill Credit: Small Tents Burned : https://wowhead.com/forever/npc=253975/dnt-kill-credit-small-tents-burned
            [npcKeys.name] = "[DNT] Kill Credit: Small Tents Burned",
        },
        [253977] = { -- [DNT] Kill Credit: Western Large Tent Burned : https://wowhead.com/forever/npc=253977/dnt-kill-credit-western-large-tent-burned
            [npcKeys.name] = "[DNT] Kill Credit: Western Large Tent Burned",
        },
        [253986] = { -- Burning Bunny : https://wowhead.com/forever/npc=253986/burning-bunny
            [npcKeys.name] = "Burning Bunny",
        },
        [253987] = { -- Burning Bunny : https://wowhead.com/forever/npc=253987/burning-bunny
            [npcKeys.name] = "Burning Bunny",
        },
        [254003] = { -- Credit : https://wowhead.com/forever/npc=254003/credit
            [npcKeys.name] = "Credit",
        },
        [254040] = { -- Rokren : https://wowhead.com/forever/npc=254040/rokren
            [npcKeys.name] = "Rokren",
        },
        [254056] = { -- Mr. Barber : https://wowhead.com/forever/npc=254056/mr-barber
            [npcKeys.name] = "Mr. Barber",
        },
        [254078] = { -- Tom "Half-fish" Wilson : https://wowhead.com/forever/npc=254078/tom-half-fish-wilson
            [npcKeys.name] = "Tom \"Half-fish\" Wilson",
            [npcKeys.minLevel] = 31,
            [npcKeys.maxLevel] = 31,
            [npcKeys.spawns] = {[267] = {{51, 66.6}, {51.2, 66.4}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
            [npcKeys.questStarts] = {98459},
            [npcKeys.friendlyToFaction] = "A",
        },
        [254081] = { -- Naeluna Swiftmend : https://wowhead.com/forever/npc=254081/naeluna-swiftmend
            [npcKeys.name] = "Naeluna Swiftmend",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{45.2, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254082] = { -- Aarnor Galestrike : https://wowhead.com/forever/npc=254082/aarnor-galestrike
            [npcKeys.name] = "Aarnor Galestrike",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.4, 44.8}, {43.6, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {97243},
            [npcKeys.friendlyToFaction] = "H",
        },
        [254083] = { -- Cow : https://wowhead.com/forever/npc=254083/cow
            [npcKeys.name] = "Cow",
        },
        [254084] = { -- Elayaa Easewind : https://wowhead.com/forever/npc=254084/elayaa-easewind
            [npcKeys.name] = "Elayaa Easewind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{45.2, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94007},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254085] = { -- Deckard : https://wowhead.com/forever/npc=254085/deckard
            [npcKeys.name] = "Deckard",
        },
        [254086] = { -- Shenaan Spellwind : https://wowhead.com/forever/npc=254086/shenaan-spellwind
            [npcKeys.name] = "Shenaan Spellwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{45, 45.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254087] = { -- Miriaan Mistblade : https://wowhead.com/forever/npc=254087/miriaan-mistblade
            [npcKeys.name] = "Miriaan Mistblade",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.2, 43.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254088] = { -- Corsan Earthrazer : https://wowhead.com/forever/npc=254088/corsan-earthrazer
            [npcKeys.name] = "Corsan Earthrazer",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{44.8, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254089] = { -- Coriella Calmbreeze : https://wowhead.com/forever/npc=254089/coriella-calmbreeze
            [npcKeys.name] = "Coriella Calmbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43, 43.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254100] = { -- Zephras Citizen : https://wowhead.com/forever/npc=254100/zephras-citizen
            [npcKeys.name] = "Zephras Citizen",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.2, 43.6}, {43.8, 43.8}, {44.2, 44.8}, {45.2, 44.8}, {58, 74.6}, {59.4, 73.4}, {60, 74.2}, {60.4, 73.4}, {60.6, 72.8}, {60.8, 74.2}, {60.8, 76}, {62.2, 73}, {63, 77.4}, {63.6, 76.2}, {64.2, 79.2}, {66, 80.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254108] = { -- Stalker : https://wowhead.com/forever/npc=254108/stalker
            [npcKeys.name] = "Stalker",
        },
        [254128] = { -- Wardrobe : https://wowhead.com/forever/npc=254128/wardrobe
            [npcKeys.name] = "Wardrobe",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{48.8, 53.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254131] = { -- Skylord Omnuron : https://wowhead.com/forever/npc=254131/skylord-omnuron
            [npcKeys.name] = "Skylord Omnuron",
            [npcKeys.spawns] = {[616] = {{54.2, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [254149] = { -- Sirocca "Swimmers" Starfeather : https://wowhead.com/forever/npc=254149/sirocca-swimmers-starfeather
            [npcKeys.name] = "Sirocca \"Swimmers\" Starfeather",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{62.2, 72.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254151] = { -- Vayn Moongaze : https://wowhead.com/forever/npc=254151/vayn-moongaze
            [npcKeys.name] = "Vayn Moongaze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.8, 36}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93165},
            [npcKeys.questEnds] = {93165, 93459},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254152] = { -- Nightclaw Druid : https://wowhead.com/forever/npc=254152/nightclaw-druid
            [npcKeys.name] = "Nightclaw Druid",
        },
        [254283] = { -- Outcast Scout : https://wowhead.com/forever/npc=254283/outcast-scout
            [npcKeys.name] = "Outcast Scout",
        },
        [254284] = { -- Outcast Marauder : https://wowhead.com/forever/npc=254284/outcast-marauder
            [npcKeys.name] = "Outcast Marauder",
        },
        [254287] = { -- Peacekeeper Elite : https://wowhead.com/forever/npc=254287/peacekeeper-elite
            [npcKeys.name] = "Peacekeeper Elite",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{61.2, 71.2}, {63.4, 50.4}, {63.8, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254294] = { -- High Order Mage : https://wowhead.com/forever/npc=254294/high-order-mage
            [npcKeys.name] = "High Order Mage",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{60.8, 71}, {61.4, 50.6}, {62.2, 49.4}, {62.4, 50.2}, {62.6, 50.4}, {65.4, 50.2}, {66.8, 50.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [254296] = { -- Windshaper Shaman : https://wowhead.com/forever/npc=254296/windshaper-shaman
            [npcKeys.name] = "Windshaper Shaman",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{61.2, 71.4}, {61.4, 71.6}, {62.2, 49.2}, {62.4, 50.4}, {63.6, 54.4}, {63.8, 54.6}, {65.6, 50}, {66.8, 50.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [254344] = { -- Endaria Mistgaze : https://wowhead.com/forever/npc=254344/endaria-mistgaze
            [npcKeys.name] = "Endaria Mistgaze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58.2, 78.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93736},
            [npcKeys.questEnds] = {93736},
            [npcKeys.friendlyToFaction] = "H",
        },
        [254345] = { -- Syriel Nightrain : https://wowhead.com/forever/npc=254345/syriel-nightrain
            [npcKeys.name] = "Syriel Nightrain",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57.8, 75.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97968},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254349] = { -- Vailee Highwind : https://wowhead.com/forever/npc=254349/vailee-highwind
            [npcKeys.name] = "Vailee Highwind",
        },
        [254357] = { -- Khan Jehn : https://wowhead.com/forever/npc=254357/khan-jehn
            [npcKeys.name] = "Khan Jehn",
        },
        [254358] = { -- Veena Vericloud : https://wowhead.com/forever/npc=254358/veena-vericloud
            [npcKeys.name] = "Veena Vericloud",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{44.6, 45.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254360] = { -- Belandiel Farflight : https://wowhead.com/forever/npc=254360/belandiel-farflight
            [npcKeys.name] = "Belandiel Farflight",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{44.8, 45}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254362] = { -- [DNT] Kill Credit: Khan Jehn Resurrected : https://wowhead.com/forever/npc=254362/dnt-kill-credit-khan-jehn-resurrected
            [npcKeys.name] = "[DNT] Kill Credit: Khan Jehn Resurrected",
        },
        [254411] = { -- Quel'dora Quickgale : https://wowhead.com/forever/npc=254411/queldora-quickgale
            [npcKeys.name] = "Quel'dora Quickgale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.6, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {94050},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254444] = { -- Stalker : https://wowhead.com/forever/npc=254444/stalker
            [npcKeys.name] = "Stalker",
        },
        [254490] = { -- Desolace Bone Worm : https://wowhead.com/forever/npc=254490/desolace-bone-worm
            [npcKeys.name] = "Desolace Bone Worm",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
        },
        [254501] = { -- Tree Branch : https://wowhead.com/forever/npc=254501/tree-branch
            [npcKeys.name] = "Tree Branch",
        },
        [254508] = { -- Personal Survival Pack : https://wowhead.com/forever/npc=254508/personal-survival-pack
            [npcKeys.name] = "Personal Survival Pack",
        },
        [254529] = { -- Trilliax <3<3 : https://wowhead.com/forever/npc=254529/trilliax-3-3
            [npcKeys.name] = "Trilliax <3<3",
        },
        [254530] = { -- Trilliax <3<3 : https://wowhead.com/forever/npc=254530/trilliax-3-3
            [npcKeys.name] = "Trilliax <3<3",
        },
        [254560] = { -- Twilight Shadowmancer : https://wowhead.com/forever/npc=254560/twilight-shadowmancer
            [npcKeys.name] = "Twilight Shadowmancer",
        },
        [254561] = { -- Elimara : https://wowhead.com/forever/npc=254561/elimara
            [npcKeys.name] = "Elimara",
        },
        [254563] = { -- Stonetusk Boar : https://wowhead.com/forever/npc=254563/stonetusk-boar
            [npcKeys.name] = "Stonetusk Boar",
        },
        [254566] = { -- Rowdy Rose : https://wowhead.com/forever/npc=254566/rowdy-rose
            [npcKeys.name] = "Rowdy Rose",
        },
        [254567] = { -- Terrible Tulip : https://wowhead.com/forever/npc=254567/terrible-tulip
            [npcKeys.name] = "Terrible Tulip",
        },
        [254572] = { -- Malevolent Marigold : https://wowhead.com/forever/npc=254572/malevolent-marigold
            [npcKeys.name] = "Malevolent Marigold",
            [npcKeys.spawns] = {[16651] = {{65, 70.8}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [254578] = { -- Mithera : https://wowhead.com/forever/npc=254578/mithera
            [npcKeys.name] = "Mithera",
            [npcKeys.spawns] = {[16651] = {{52.8, 76}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [254588] = { -- Windsong Crawler : https://wowhead.com/forever/npc=254588/windsong-crawler
            [npcKeys.name] = "Windsong Crawler",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{42.6, 66.8}, {44, 66.4}, {44.6, 65.2}, {44.6, 66}, {45.2, 49.8}, {45.4, 63.4}, {45.6, 61.4}, {46, 48.2}, {46.2, 47.2}, {46.6, 46.8}, {47, 45.6}, {47.2, 45.4}, {47.2, 47.8}, {47.4, 50.4}, {47.4, 50.6}, {47.6, 45.4}, {47.6, 50.4}, {47.6, 50.6}, {48, 46.6}, {49.2, 46.2}, {49.2, 59.4}, {49.2, 61}, {49.2, 63.4}, {49.2, 63.8}, {49.2, 65.4}, {49.2, 65.8}, {49.4, 48.8}, {49.4, 59.6}, {49.6, 45.8}, {49.6, 61}, {49.6, 63.4}, {49.6, 63.6}, {49.6, 67}, {50, 61.8}, {50.2, 50}, {50.6, 59.6}, {50.6, 61.6}, {51, 50.4}, {51, 50.8}, {51, 61}, {51.2, 58.8}, {51.2, 69.4}, {51.2, 69.6}, {51.4, 70.6}, {51.6, 51.4}, {51.6, 69.4}, {51.6, 70.4}, {51.6, 70.6}, {51.8, 54.4}, {52, 73.2}, {52, 74.2}, {52.2, 58.4}, {52.2, 58.6}, {52.2, 74.6}, {52.4, 57.4}, {52.6, 59}, {52.6, 60.4}, {52.6, 75.2}, {52.8, 76.6}, {53, 58.2}, {53, 76.2}, {53.2, 56.2}, {53.4, 57.2}, {53.8, 59.4}, {53.8, 77}, {54.2, 57.8}, {54.2, 78}, {54.2, 78.8}, {54.6, 78.4}, {54.8, 51.4}, {55, 49}, {56, 45.6}, {56.4, 56}, {56.6, 56.2}, {57, 47.8}, {58.2, 46}, {59.6, 72.6}, {62.2, 56.6}, {62.2, 60.8}, {62.4, 60.2}, {62.8, 60.6}, {63.2, 59.2}, {63.4, 58.2}, {63.4, 60.4}, {63.4, 63.2}, {63.4, 63.6}, {63.6, 60}, {63.6, 60.6}, {63.8, 58.4}, {63.8, 59.4}, {63.8, 62.6}, {64.2, 62.4}, {65.4, 61.8}, {65.4, 62.8}, {65.6, 62.2}, {65.8, 60.4}, {68.4, 62.2}, {68.6, 62.2}, {69, 60.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254589] = { -- Vulgara the Insatiable : https://wowhead.com/forever/npc=254589/vulgara-the-insatiable
            [npcKeys.name] = "Vulgara the Insatiable",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{42.4, 52.2}, {42.4, 52.6}, {42.6, 52.6}, {42.8, 52.2}, {43, 51.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [254596] = { -- Al'Aketh Healer : https://wowhead.com/forever/npc=254596/alaketh-healer
            [npcKeys.name] = "Al'Aketh Healer",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65, 66.6}, {65.2, 65.4}, {65.4, 65.8}, {65.4, 68.4}, {65.4, 68.8}, {65.4, 69.6}, {65.6, 65.6}, {65.6, 68.6}, {65.8, 64.4}, {65.8, 65.4}, {65.8, 67}, {66.4, 67.6}, {66.6, 67.6}, {67, 67}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254607] = { -- Peacekeeper Scout : https://wowhead.com/forever/npc=254607/peacekeeper-scout
            [npcKeys.name] = "Peacekeeper Scout",
        },
        [254613] = { -- Bristleback Looter : https://wowhead.com/forever/npc=254613/bristleback-looter
            [npcKeys.name] = "Bristleback Looter",
        },
        [254614] = { -- Outcast Centaur : https://wowhead.com/forever/npc=254614/outcast-centaur
            [npcKeys.name] = "Outcast Centaur",
        },
        [254626] = { -- Al'Aketh Assassin : https://wowhead.com/forever/npc=254626/alaketh-assassin
            [npcKeys.name] = "Al'Aketh Assassin",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{54.4, 60}, {55, 61.6}, {55.4, 59}, {55.4, 60.2}, {55.4, 61.2}, {55.6, 59.8}, {56, 58}, {56, 58.8}, {56, 60.6}, {56.6, 60.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [254644] = { -- Personal Survival Pack : https://wowhead.com/forever/npc=254644/personal-survival-pack
            [npcKeys.name] = "Personal Survival Pack",
        },
        [254656] = { -- Magister Kirandis : https://wowhead.com/forever/npc=254656/magister-kirandis
            [npcKeys.name] = "Magister Kirandis",
            [npcKeys.spawns] = {[16651] = {{47.6, 76}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [254674] = { -- Woodwyrd : https://wowhead.com/forever/npc=254674/woodwyrd
            [npcKeys.name] = "Woodwyrd",
        },
        [254695] = { -- Repair Bot : https://wowhead.com/forever/npc=254695/repair-bot
            [npcKeys.name] = "Repair Bot",
            [npcKeys.spawns] = {[12] = {{33.2, 50.4}}, [14] = {{45.6, 12.8}}},
        },
        [254717] = { -- Vindael : https://wowhead.com/forever/npc=254717/vindael
            [npcKeys.name] = "Vindael",
        },
        [254762] = { -- Ball and Chain : https://wowhead.com/forever/npc=254762/ball-and-chain
            [npcKeys.name] = "Ball and Chain",
        },
        [254770] = { -- Pelluk : https://wowhead.com/forever/npc=254770/pelluk
            [npcKeys.name] = "Pelluk",
        },
        [254775] = { -- Karana : https://wowhead.com/forever/npc=254775/karana
            [npcKeys.name] = "Karana",
        },
        [254777] = { -- Personal Survival Pack : https://wowhead.com/forever/npc=254777/personal-survival-pack
            [npcKeys.name] = "Personal Survival Pack",
        },
        [254797] = { -- Lost One : https://wowhead.com/forever/npc=254797/lost-one
            [npcKeys.name] = "Lost One",
        },
        [254825] = { -- Gelkis Captive : https://wowhead.com/forever/npc=254825/gelkis-captive
            [npcKeys.name] = "Gelkis Captive",
        },
        [254826] = { -- Tattered Parachute : https://wowhead.com/forever/npc=254826/tattered-parachute
            [npcKeys.name] = "Tattered Parachute",
        },
        [254856] = { -- Angry Tome : https://wowhead.com/forever/npc=254856/angry-tome
            [npcKeys.name] = "Angry Tome",
        },
        [254915] = { -- Thisalee Crow : https://wowhead.com/forever/npc=254915/thisalee-crow
            [npcKeys.name] = "Thisalee Crow",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{69, 49.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [254930] = { -- [DNT] Kill Credit: Mulara spoken with : https://wowhead.com/forever/npc=254930/dnt-kill-credit-mulara-spoken-with
            [npcKeys.name] = "[DNT] Kill Credit: Mulara spoken with",
        },
        [254987] = { -- Horde Adventurer : https://wowhead.com/forever/npc=254987/horde-adventurer
            [npcKeys.name] = "Horde Adventurer",
        },
        [255002] = { -- Ryff : https://wowhead.com/forever/npc=255002/ryff
            [npcKeys.name] = "Ryff",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{42.4, 23.4}, {42.4, 23.6}, {42.6, 23.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255003] = { -- Gimashi : https://wowhead.com/forever/npc=255003/gimashi
            [npcKeys.name] = "Gimashi",
        },
        [255009] = { -- Veteran of the Third War : https://wowhead.com/forever/npc=255009/veteran-of-the-third-war
            [npcKeys.name] = "Veteran of the Third War",
        },
        [255013] = { -- DNT KILL CREDIT : https://wowhead.com/forever/npc=255013/dnt-kill-credit
            [npcKeys.name] = "DNT KILL CREDIT",
        },
        [255035] = { -- Archmage Pentarus : https://wowhead.com/forever/npc=255035/archmage-pentarus
            [npcKeys.name] = "Archmage Pentarus",
        },
        [255038] = { -- Veteran of the Third War : https://wowhead.com/forever/npc=255038/veteran-of-the-third-war
            [npcKeys.name] = "Veteran of the Third War",
        },
        [255065] = { -- Risen Terror : https://wowhead.com/forever/npc=255065/risen-terror
            [npcKeys.name] = "Risen Terror",
        },
        [255066] = { -- Fallen Mage : https://wowhead.com/forever/npc=255066/fallen-mage
            [npcKeys.name] = "Fallen Mage",
        },
        [255068] = { -- Mindless Horror : https://wowhead.com/forever/npc=255068/mindless-horror
            [npcKeys.name] = "Mindless Horror",
        },
        [255069] = { -- Fallen Warrior : https://wowhead.com/forever/npc=255069/fallen-warrior
            [npcKeys.name] = "Fallen Warrior",
        },
        [255070] = { -- Skeletal Warder : https://wowhead.com/forever/npc=255070/skeletal-warder
            [npcKeys.name] = "Skeletal Warder",
        },
        [255071] = { -- Sewer Fiend : https://wowhead.com/forever/npc=255071/sewer-fiend
            [npcKeys.name] = "Sewer Fiend",
        },
        [255072] = { -- Dark Caster : https://wowhead.com/forever/npc=255072/dark-caster
            [npcKeys.name] = "Dark Caster",
        },
        [255109] = { -- Flesh Golem : https://wowhead.com/forever/npc=255109/flesh-golem
            [npcKeys.name] = "Flesh Golem",
        },
        [255113] = { -- Tobin Wheeldon : https://wowhead.com/forever/npc=255113/tobin-wheeldon
            [npcKeys.name] = "Tobin Wheeldon",
        },
        [255115] = { -- Jaston Valarias : https://wowhead.com/forever/npc=255115/jaston-valarias
            [npcKeys.name] = "Jaston Valarias",
        },
        [255151] = { -- Rhylin Stonethorn : https://wowhead.com/forever/npc=255151/rhylin-stonethorn
            [npcKeys.name] = "Rhylin Stonethorn",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{70.6, 51.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [255159] = { -- Stalker : https://wowhead.com/forever/npc=255159/stalker
            [npcKeys.name] = "Stalker",
        },
        [255165] = { -- Brown Horse : https://wowhead.com/forever/npc=255165/brown-horse
            [npcKeys.name] = "Brown Horse",
        },
        [255166] = { -- Pinto : https://wowhead.com/forever/npc=255166/pinto
            [npcKeys.name] = "Pinto",
        },
        [255174] = { -- Blind Screecher : https://wowhead.com/forever/npc=255174/blind-screecher
            [npcKeys.name] = "Blind Screecher",
        },
        [255183] = { -- Jezerelle the Swaying : https://wowhead.com/forever/npc=255183/jezerelle-the-swaying
            [npcKeys.name] = "Jezerelle the Swaying",
        },
        [255191] = { -- Veteran of the Third War : https://wowhead.com/forever/npc=255191/veteran-of-the-third-war
            [npcKeys.name] = "Veteran of the Third War",
        },
        [255201] = { -- Eddard Heartweaver : https://wowhead.com/forever/npc=255201/eddard-heartweaver
            [npcKeys.name] = "Eddard Heartweaver",
        },
        [255207] = { -- Prowler : https://wowhead.com/forever/npc=255207/prowler
            [npcKeys.name] = "Prowler",
        },
        [255238] = { -- Magram Outrunner : https://wowhead.com/forever/npc=255238/magram-outrunner
            [npcKeys.name] = "Magram Outrunner",
            [npcKeys.spawns] = {[16651] = {{46.2, 51.2}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255242] = { -- Elsa : https://wowhead.com/forever/npc=255242/elsa
            [npcKeys.name] = "Elsa",
        },
        [255246] = { -- Spectral Gryphon : https://wowhead.com/forever/npc=255246/spectral-gryphon
            [npcKeys.name] = "Spectral Gryphon",
        },
        [255250] = { -- Spectral Horse : https://wowhead.com/forever/npc=255250/spectral-horse
            [npcKeys.name] = "Spectral Horse",
        },
        [255266] = { -- Spectral Cat : https://wowhead.com/forever/npc=255266/spectral-cat
            [npcKeys.name] = "Spectral Cat",
        },
        [255272] = { -- Tobin Wheeldon : https://wowhead.com/forever/npc=255272/tobin-wheeldon
            [npcKeys.name] = "Tobin Wheeldon",
        },
        [255273] = { -- Jaston Valarias : https://wowhead.com/forever/npc=255273/jaston-valarias
            [npcKeys.name] = "Jaston Valarias",
        },
        [255274] = { -- Spectral Citizen : https://wowhead.com/forever/npc=255274/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [255275] = { -- Spectral Citizen : https://wowhead.com/forever/npc=255275/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [255277] = { -- Spectral Citizen : https://wowhead.com/forever/npc=255277/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [255279] = { -- Spectral Citizen : https://wowhead.com/forever/npc=255279/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [255281] = { -- Spectral Citizen : https://wowhead.com/forever/npc=255281/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [255303] = { -- Stalker : https://wowhead.com/forever/npc=255303/stalker
            [npcKeys.name] = "Stalker",
        },
        [255305] = { -- Veteran of the Third War : https://wowhead.com/forever/npc=255305/veteran-of-the-third-war
            [npcKeys.name] = "Veteran of the Third War",
        },
        [255307] = { -- Spectral Farmer : https://wowhead.com/forever/npc=255307/spectral-farmer
            [npcKeys.name] = "Spectral Farmer",
        },
        [255308] = { -- Spectral Farmer : https://wowhead.com/forever/npc=255308/spectral-farmer
            [npcKeys.name] = "Spectral Farmer",
        },
        [255314] = { -- Jess Sunfall : https://wowhead.com/forever/npc=255314/jess-sunfall
            [npcKeys.name] = "Jess Sunfall",
        },
        [255315] = { -- Rose Irons : https://wowhead.com/forever/npc=255315/rose-irons
            [npcKeys.name] = "Rose Irons",
        },
        [255316] = { -- Falsted Krighton : https://wowhead.com/forever/npc=255316/falsted-krighton
            [npcKeys.name] = "Falsted Krighton",
        },
        [255317] = { -- Jacob Irons : https://wowhead.com/forever/npc=255317/jacob-irons
            [npcKeys.name] = "Jacob Irons",
        },
        [255318] = { -- Brother Mason : https://wowhead.com/forever/npc=255318/brother-mason
            [npcKeys.name] = "Brother Mason",
        },
        [255321] = { -- Borden : https://wowhead.com/forever/npc=255321/borden
            [npcKeys.name] = "Borden",
        },
        [255335] = { -- Emma : https://wowhead.com/forever/npc=255335/emma
            [npcKeys.name] = "Emma",
        },
        [255336] = { -- Melisa : https://wowhead.com/forever/npc=255336/melisa
            [npcKeys.name] = "Melisa",
        },
        [255337] = { -- Christopher Nelson : https://wowhead.com/forever/npc=255337/christopher-nelson
            [npcKeys.name] = "Christopher Nelson",
        },
        [255338] = { -- Brim Farkeep : https://wowhead.com/forever/npc=255338/brim-farkeep
            [npcKeys.name] = "Brim Farkeep",
        },
        [255339] = { -- Timothey Jorgen : https://wowhead.com/forever/npc=255339/timothey-jorgen
            [npcKeys.name] = "Timothey Jorgen",
        },
        [255340] = { -- Podrick : https://wowhead.com/forever/npc=255340/podrick
            [npcKeys.name] = "Podrick",
        },
        [255341] = { -- Crowley Russell : https://wowhead.com/forever/npc=255341/crowley-russell
            [npcKeys.name] = "Crowley Russell",
        },
        [255342] = { -- Wilhelm Delmar : https://wowhead.com/forever/npc=255342/wilhelm-delmar
            [npcKeys.name] = "Wilhelm Delmar",
        },
        [255343] = { -- Mikayla Marley : https://wowhead.com/forever/npc=255343/mikayla-marley
            [npcKeys.name] = "Mikayla Marley",
        },
        [255344] = { -- Yenne Aryel : https://wowhead.com/forever/npc=255344/yenne-aryel
            [npcKeys.name] = "Yenne Aryel",
        },
        [255345] = { -- Mort Anvel : https://wowhead.com/forever/npc=255345/mort-anvel
            [npcKeys.name] = "Mort Anvel",
        },
        [255346] = { -- Lordaeron Guard : https://wowhead.com/forever/npc=255346/lordaeron-guard
            [npcKeys.name] = "Lordaeron Guard",
        },
        [255385] = { -- Liranne : https://wowhead.com/forever/npc=255385/liranne
            [npcKeys.name] = "Liranne",
            [npcKeys.spawns] = {[16651] = {{47.2, 65.2}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255396] = { -- Spectral Citizen : https://wowhead.com/forever/npc=255396/spectral-citizen
            [npcKeys.name] = "Spectral Citizen",
        },
        [255398] = { -- Tom Gin : https://wowhead.com/forever/npc=255398/tom-gin
            [npcKeys.name] = "Tom Gin",
        },
        [255399] = { -- Jef McKinley : https://wowhead.com/forever/npc=255399/jef-mckinley
            [npcKeys.name] = "Jef McKinley",
        },
        [255400] = { -- Lindin B : https://wowhead.com/forever/npc=255400/lindin-b
            [npcKeys.name] = "Lindin B",
        },
        [255403] = { -- Merle Septim : https://wowhead.com/forever/npc=255403/merle-septim
            [npcKeys.name] = "Merle Septim",
        },
        [255404] = { -- Sashia Nella : https://wowhead.com/forever/npc=255404/sashia-nella
            [npcKeys.name] = "Sashia Nella",
        },
        [255424] = { -- Rift : https://wowhead.com/forever/npc=255424/rift
            [npcKeys.name] = "Rift",
        },
        [255425] = { -- Outland Imp : https://wowhead.com/forever/npc=255425/outland-imp
            [npcKeys.name] = "Outland Imp",
        },
        [255426] = { -- Outland Hound : https://wowhead.com/forever/npc=255426/outland-hound
            [npcKeys.name] = "Outland Hound",
        },
        [255428] = { -- Draenei Refugee : https://wowhead.com/forever/npc=255428/draenei-refugee
            [npcKeys.name] = "Draenei Refugee",
        },
        [255429] = { -- Outland Infernal : https://wowhead.com/forever/npc=255429/outland-infernal
            [npcKeys.name] = "Outland Infernal",
        },
        [255467] = { -- Dahlia : https://wowhead.com/forever/npc=255467/dahlia
            [npcKeys.name] = "Dahlia",
        },
        [255486] = { -- Historian Biraxas : https://wowhead.com/forever/npc=255486/historian-biraxas
            [npcKeys.name] = "Historian Biraxas",
        },
        [255523] = { -- Collector of Suffering : https://wowhead.com/forever/npc=255523/collector-of-suffering
            [npcKeys.name] = "Collector of Suffering",
        },
        [255534] = { -- "Badwind" Bennic : https://wowhead.com/forever/npc=255534/badwind-bennic
            [npcKeys.name] = "\"Badwind\" Bennic",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{50.4, 33.4}, {50.4, 33.8}, {50.6, 33.4}, {50.8, 34}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [255536] = { -- Faladiel : https://wowhead.com/forever/npc=255536/faladiel
            [npcKeys.name] = "Faladiel",
        },
        [255538] = { -- Constable Aonda : https://wowhead.com/forever/npc=255538/constable-aonda
            [npcKeys.name] = "Constable Aonda",
        },
        [255560] = { -- Magram Guardian : https://wowhead.com/forever/npc=255560/magram-guardian
            [npcKeys.name] = "Magram Guardian",
        },
        [255561] = { -- Gelkis Guardian : https://wowhead.com/forever/npc=255561/gelkis-guardian
            [npcKeys.name] = "Gelkis Guardian",
        },
        [255587] = { -- Bothered Bone Worm : https://wowhead.com/forever/npc=255587/bothered-bone-worm
            [npcKeys.name] = "Bothered Bone Worm",
        },
        [255597] = { -- Father Tuttle : https://wowhead.com/forever/npc=255597/father-tuttle
            [npcKeys.name] = "Father Tuttle",
            [npcKeys.spawns] = {[8] = {{22, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.SWAMP_OF_SORROWS,
        },
        [255638] = { -- [DNT] Kill Credit: Woodwyrd Extinguished : https://wowhead.com/forever/npc=255638/dnt-kill-credit-woodwyrd-extinguished
            [npcKeys.name] = "[DNT] Kill Credit: Woodwyrd Extinguished",
        },
        [255669] = { -- Virulent Blood of Agamaggan : https://wowhead.com/forever/npc=255669/virulent-blood-of-agamaggan
            [npcKeys.name] = "Virulent Blood of Agamaggan",
        },
        [255678] = { -- Quolga the Wise : https://wowhead.com/forever/npc=255678/quolga-the-wise
            [npcKeys.name] = "Quolga the Wise",
        },
        [255679] = { -- Corswyn Aseril : https://wowhead.com/forever/npc=255679/corswyn-aseril
            [npcKeys.name] = "Corswyn Aseril",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[1637] = {{38, 38.6}, {38.2, 38.4}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [255683] = { -- Shalla'kal : https://wowhead.com/forever/npc=255683/shallakal
            [npcKeys.name] = "Shalla'kal",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{31.4, 50}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [255685] = { -- Solstice : https://wowhead.com/forever/npc=255685/solstice
            [npcKeys.name] = "Solstice",
        },
        [255691] = { -- Spectral Frostwyrm : https://wowhead.com/forever/npc=255691/spectral-frostwyrm
            [npcKeys.name] = "Spectral Frostwyrm",
        },
        [255693] = { -- Kala'th : https://wowhead.com/forever/npc=255693/kalath
            [npcKeys.name] = "Kala'th",
            [npcKeys.spawns] = {[616] = {{28.6, 43.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [255697] = { -- Shen'dralar Scholar : https://wowhead.com/forever/npc=255697/shendralar-scholar
            [npcKeys.name] = "Shen'dralar Scholar",
            [npcKeys.spawns] = {[16651] = {{47.2, 78.8}, {47.6, 81.2}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255699] = { -- Lordaeron Captain : https://wowhead.com/forever/npc=255699/lordaeron-captain
            [npcKeys.name] = "Lordaeron Captain",
        },
        [255701] = { -- Maralus : https://wowhead.com/forever/npc=255701/maralus
            [npcKeys.name] = "Maralus",
        },
        [255703] = { -- Naria : https://wowhead.com/forever/npc=255703/naria
            [npcKeys.name] = "Naria",
        },
        [255704] = { -- Arondel : https://wowhead.com/forever/npc=255704/arondel
            [npcKeys.name] = "Arondel",
            [npcKeys.spawns] = {[16651] = {{51.4, 73}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255705] = { -- Kerelle : https://wowhead.com/forever/npc=255705/kerelle
            [npcKeys.name] = "Kerelle",
            [npcKeys.spawns] = {[16651] = {{51.8, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255721] = { -- Jarael : https://wowhead.com/forever/npc=255721/jarael
            [npcKeys.name] = "Jarael",
            [npcKeys.spawns] = {[16651] = {{42.6, 77}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255724] = { -- Melanori : https://wowhead.com/forever/npc=255724/melanori
            [npcKeys.name] = "Melanori",
        },
        [255759] = { -- Shen'dralas Protector : https://wowhead.com/forever/npc=255759/shendralas-protector
            [npcKeys.name] = "Shen'dralas Protector",
            [npcKeys.spawns] = {[16651] = {{41.6, 57}, {42.8, 61}, {43.4, 75}, {43.6, 73.8}, {46.8, 62.2}, {47.2, 67.2}, {47.2, 71}, {52.6, 77.4}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [255769] = { -- Redridge Brute : https://wowhead.com/forever/npc=255769/redridge-brute
            [npcKeys.name] = "Redridge Brute",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{30.6, 60.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255770] = { -- Redridge Mystic : https://wowhead.com/forever/npc=255770/redridge-mystic
            [npcKeys.name] = "Redridge Mystic",
        },
        [255771] = { -- Whisperfur : https://wowhead.com/forever/npc=255771/whisperfur
            [npcKeys.name] = "Whisperfur",
        },
        [255772] = { -- Redridge Trapper : https://wowhead.com/forever/npc=255772/redridge-trapper
            [npcKeys.name] = "Redridge Trapper",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 37,
        },
        [255773] = { -- Brie : https://wowhead.com/forever/npc=255773/brie
            [npcKeys.name] = "Brie",
            [npcKeys.spawns] = {[616] = {{42, 34.8}, {42, 36.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [255774] = { -- Redridge Scout : https://wowhead.com/forever/npc=255774/redridge-scout
            [npcKeys.name] = "Redridge Scout",
            [npcKeys.spawns] = {[16591] = {{22.2, 67.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255775] = { -- Butterfly : https://wowhead.com/forever/npc=255775/butterfly
            [npcKeys.name] = "Butterfly",
            [npcKeys.spawns] = {[616] = {{41.4, 36.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [255777] = { -- Credit : https://wowhead.com/forever/npc=255777/credit
            [npcKeys.name] = "Credit",
        },
        [255829] = { -- Clugfist : https://wowhead.com/forever/npc=255829/clugfist
            [npcKeys.name] = "Clugfist",
            [npcKeys.spawns] = {[16591] = {{64.4, 14.8}, {64.6, 14.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255830] = { -- Malevolent Storm : https://wowhead.com/forever/npc=255830/malevolent-storm
            [npcKeys.name] = "Malevolent Storm",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255831] = { -- Mangled Corpse : https://wowhead.com/forever/npc=255831/mangled-corpse
            [npcKeys.name] = "Mangled Corpse",
        },
        [255833] = { -- Rohash : https://wowhead.com/forever/npc=255833/rohash
            [npcKeys.name] = "Rohash",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[16593] = {{74.8, 53}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255849] = { -- Bolder'ok Magus : https://wowhead.com/forever/npc=255849/bolderok-magus
            [npcKeys.name] = "Bolder'ok Magus",
            [npcKeys.spawns] = {[16591] = {{67.8, 13.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255850] = { -- Bolder'ok Brute : https://wowhead.com/forever/npc=255850/bolderok-brute
            [npcKeys.name] = "Bolder'ok Brute",
            [npcKeys.spawns] = {[16591] = {{61.6, 17.8}, {65.6, 21.4}, {66.2, 24.4}, {66.4, 24.6}, {67.4, 15.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255851] = { -- Mature Paletusk : https://wowhead.com/forever/npc=255851/mature-paletusk
            [npcKeys.name] = "Mature Paletusk",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{66.6, 30.8}, {69, 32.8}, {69.8, 33.6}, {71.8, 50.4}, {74.2, 51.6}, {74.6, 51.4}, {77.2, 59.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255853] = { -- Urs'endris : https://wowhead.com/forever/npc=255853/ursendris
            [npcKeys.name] = "Urs'endris",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{69.8, 61.4}, {69.8, 61.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94638},
            [npcKeys.questEnds] = {94006, 94638},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255864] = { -- Seer Onku : https://wowhead.com/forever/npc=255864/seer-onku
            [npcKeys.name] = "Seer Onku",
        },
        [255867] = { -- Draenei Vision : https://wowhead.com/forever/npc=255867/draenei-vision
            [npcKeys.name] = "Draenei Vision",
        },
        [255877] = { -- Hunter Moore : https://wowhead.com/forever/npc=255877/hunter-moore
            [npcKeys.name] = "Hunter Moore",
            [npcKeys.spawns] = {[267] = {{54, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [255887] = { -- Slydris : https://wowhead.com/forever/npc=255887/slydris
            [npcKeys.name] = "Slydris",
            [npcKeys.spawns] = {[16593] = {{50.2, 51}, {50.2, 51.6}, {51, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [255890] = { -- Powderfuse Bruiser : https://wowhead.com/forever/npc=255890/powderfuse-bruiser
            [npcKeys.name] = "Powderfuse Bruiser",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[16591] = {{76.2, 51.8}, {76.4, 53}, {76.6, 52.8}, {76.8, 53.8}, {77, 51.4}, {77.2, 52.2}, {77.2, 55.2}, {77.6, 54.4}, {78, 53.4}, {78, 56}, {78.2, 52}, {78.2, 54.8}, {78.8, 51.6}, {79, 52.6}, {79.2, 50.4}, {79.2, 50.6}, {79.2, 55.2}, {79.4, 54.2}, {79.8, 51.6}, {80, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255891] = { -- Grungle : https://wowhead.com/forever/npc=255891/grungle
            [npcKeys.name] = "Grungle",
            [npcKeys.minLevel] = 43,
            [npcKeys.maxLevel] = 43,
            [npcKeys.spawns] = {[16591] = {{77.6, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [255892] = { -- Bonegnaw : https://wowhead.com/forever/npc=255892/bonegnaw
            [npcKeys.name] = "Bonegnaw",
        },
        [255894] = { -- Innkeeper Zizplink : https://wowhead.com/forever/npc=255894/innkeeper-zizplink
            [npcKeys.name] = "Innkeeper Zizplink",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{78.8, 54}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255895] = { -- Grizzek : https://wowhead.com/forever/npc=255895/grizzek
            [npcKeys.name] = "Grizzek",
            [npcKeys.minLevel] = 42,
            [npcKeys.maxLevel] = 42,
            [npcKeys.spawns] = {[16591] = {{76.6, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255897] = { -- Friz Frazzlespark : https://wowhead.com/forever/npc=255897/friz-frazzlespark
            [npcKeys.name] = "Friz Frazzlespark",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{77, 52.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255898] = { -- Murloc Oracle : https://wowhead.com/forever/npc=255898/murloc-oracle
            [npcKeys.name] = "Murloc Oracle",
            [npcKeys.spawns] = {[16591] = {{74.6, 70}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255899] = { -- Murloc Tideskimmer : https://wowhead.com/forever/npc=255899/murloc-tideskimmer
            [npcKeys.name] = "Murloc Tideskimmer",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255900] = { -- Murloc Raider : https://wowhead.com/forever/npc=255900/murloc-raider
            [npcKeys.name] = "Murloc Raider",
        },
        [255901] = { -- Sand Crawler : https://wowhead.com/forever/npc=255901/sand-crawler
            [npcKeys.name] = "Sand Crawler",
            [npcKeys.spawns] = {[16591] = {{73.8, 60.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [255903] = { -- Murloc Hunter : https://wowhead.com/forever/npc=255903/murloc-hunter
            [npcKeys.name] = "Murloc Hunter",
        },
        [255904] = { -- Murloc Tidebringer : https://wowhead.com/forever/npc=255904/murloc-tidebringer
            [npcKeys.name] = "Murloc Tidebringer",
        },
        [255906] = { -- Snargl : https://wowhead.com/forever/npc=255906/snargl
            [npcKeys.name] = "Snargl",
        },
        [255940] = { -- Donaal Downbreeze : https://wowhead.com/forever/npc=255940/donaal-downbreeze
            [npcKeys.name] = "Donaal Downbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{62.2, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255951] = { -- Gnome Engineer : https://wowhead.com/forever/npc=255951/gnome-engineer
            [npcKeys.name] = "Gnome Engineer",
        },
        [255952] = { -- Therminston Copperblast : https://wowhead.com/forever/npc=255952/therminston-copperblast
            [npcKeys.name] = "Therminston Copperblast",
        },
        [255964] = { -- Fallen Necromancer : https://wowhead.com/forever/npc=255964/fallen-necromancer
            [npcKeys.name] = "Fallen Necromancer",
        },
        [255979] = { -- Thendal Grove Ranger : https://wowhead.com/forever/npc=255979/thendal-grove-ranger
            [npcKeys.name] = "Thendal Grove Ranger",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{41.6, 23.4}, {43, 25.4}, {43, 25.6}, {43.6, 24.2}, {43.8, 23}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [255993] = { -- Grakna : https://wowhead.com/forever/npc=255993/grakna
            [npcKeys.name] = "Grakna",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[16591] = {{59.6, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [255996] = { -- Rog'mar Grunt : https://wowhead.com/forever/npc=255996/rogmar-grunt
            [npcKeys.name] = "Rog'mar Grunt",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[16591] = {{59.4, 47.4}, {59.6, 43.6}, {59.6, 47.4}, {59.8, 46.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256028] = { -- The Lost One : https://wowhead.com/forever/npc=256028/the-lost-one
            [npcKeys.name] = "The Lost One",
            [npcKeys.spawns] = {[16593] = {{52, 46.4}, {54, 48}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [256035] = { -- Viktor the Vile : https://wowhead.com/forever/npc=256035/viktor-the-vile
            [npcKeys.name] = "Viktor the Vile",
        },
        [256040] = { -- Deep Widow : https://wowhead.com/forever/npc=256040/deep-widow
            [npcKeys.name] = "Deep Widow",
        },
        [256076] = { -- Damaged Construct : https://wowhead.com/forever/npc=256076/damaged-construct
            [npcKeys.name] = "Damaged Construct",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59, 73}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256083] = { -- Riaani Nightwind : https://wowhead.com/forever/npc=256083/riaani-nightwind
            [npcKeys.name] = "Riaani Nightwind",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{59, 73}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93737, 93738},
            [npcKeys.questEnds] = {93735, 93737},
            [npcKeys.friendlyToFaction] = "H",
        },
        [256092] = { -- Shadowgale Shriekling : https://wowhead.com/forever/npc=256092/shadowgale-shriekling
            [npcKeys.name] = "Shadowgale Shriekling",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{54, 44.4}, {54.2, 39.2}, {54.4, 44.8}, {54.6, 42}, {54.6, 42.6}, {54.8, 44.6}, {55.2, 38}, {55.2, 39.4}, {55.4, 37}, {55.4, 40}, {55.4, 41.4}, {55.6, 41.2}, {55.8, 42.4}, {56, 42.6}, {56.2, 38.2}, {56.4, 37.2}, {56.4, 39.4}, {56.4, 39.6}, {56.8, 41.8}, {57, 40.6}, {57.2, 38.2}, {57.2, 38.6}, {57.2, 42.6}, {57.4, 37}, {57.4, 40.2}, {57.6, 37.2}, {57.6, 37.6}, {57.6, 39.4}, {57.6, 40.6}, {57.8, 39.8}, {58.8, 37.4}, {58.8, 37.6}, {58.8, 39}, {58.8, 39.8}, {59.2, 42}, {59.4, 40.8}, {59.4, 43.2}, {59.6, 38}, {59.6, 40.2}, {59.6, 41.4}, {59.6, 41.6}, {59.8, 42.6}, {60, 36.4}, {60, 36.6}, {60, 38.6}, {60.4, 35.2}, {60.6, 35.2}, {60.6, 38.6}, {61, 37.4}, {61, 37.6}, {61.2, 36.4}, {61.6, 36.4}, {62.2, 38.2}, {62.2, 39.2}, {62.4, 37.4}, {62.6, 37.4}, {62.6, 37.8}, {62.6, 39.4}, {62.6, 39.6}, {64.2, 41}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256097] = { -- Bjork : https://wowhead.com/forever/npc=256097/bjork
            [npcKeys.name] = "Bjork",
        },
        [256102] = { -- Crest of Lordaeron : https://wowhead.com/forever/npc=256102/crest-of-lordaeron
            [npcKeys.name] = "Crest of Lordaeron",
        },
        [256108] = { -- Shadowgale Shrieker : https://wowhead.com/forever/npc=256108/shadowgale-shrieker
            [npcKeys.name] = "Shadowgale Shrieker",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57.2, 40.2}, {57.4, 39.2}, {57.8, 39.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [256121] = { -- Broken Construct Parts : https://wowhead.com/forever/npc=256121/broken-construct-parts
            [npcKeys.name] = "Broken Construct Parts",
        },
        [256222] = { -- Ketharas : https://wowhead.com/forever/npc=256222/ketharas
            [npcKeys.name] = "Ketharas",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{73.2, 81.4}, {73.2, 81.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256247] = { -- Belathaan Brightwish : https://wowhead.com/forever/npc=256247/belathaan-brightwish
            [npcKeys.name] = "Belathaan Brightwish",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.8, 57}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256249] = { -- High Priestess Lorthuna : https://wowhead.com/forever/npc=256249/high-priestess-lorthuna
            [npcKeys.name] = "High Priestess Lorthuna",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{60, 56.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256250] = { -- Living Storm : https://wowhead.com/forever/npc=256250/living-storm
            [npcKeys.name] = "Living Storm",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{59.8, 56.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256251] = { -- Living Storm : https://wowhead.com/forever/npc=256251/living-storm
            [npcKeys.name] = "Living Storm",
        },
        [256252] = { -- Whispering Winds : https://wowhead.com/forever/npc=256252/whispering-winds
            [npcKeys.name] = "Whispering Winds",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{46.6, 38.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256256] = { -- [DNT] Quest Kill Credit - Cured Tainted Hyjal Stag : https://wowhead.com/forever/npc=256256/dnt-quest-kill-credit-cured-tainted-hyjal-stag
            [npcKeys.name] = "[DNT] Quest Kill Credit - Cured Tainted Hyjal Stag",
        },
        [256257] = { -- [DNT] Quest Kill Credit - Cured Tainted Hyjal Bear : https://wowhead.com/forever/npc=256257/dnt-quest-kill-credit-cured-tainted-hyjal-bear
            [npcKeys.name] = "[DNT] Quest Kill Credit - Cured Tainted Hyjal Bear",
        },
        [256259] = { -- Kirin Tor Guard : https://wowhead.com/forever/npc=256259/kirin-tor-guard
            [npcKeys.name] = "Kirin Tor Guard",
        },
        [256273] = { -- Sairuh Maryla : https://wowhead.com/forever/npc=256273/sairuh-maryla
            [npcKeys.name] = "Sairuh Maryla",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [256275] = { -- Kaigy Maryla : https://wowhead.com/forever/npc=256275/kaigy-maryla
            [npcKeys.name] = "Kaigy Maryla",
            [npcKeys.spawns] = {[36] = {{13.6, 64.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [256306] = { -- Arcanist Laurain : https://wowhead.com/forever/npc=256306/arcanist-laurain
            [npcKeys.name] = "Arcanist Laurain",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[36] = {{13, 52}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256309] = { -- Animated Hammer : https://wowhead.com/forever/npc=256309/animated-hammer
            [npcKeys.name] = "Animated Hammer",
        },
        [256317] = { -- Animated Broom : https://wowhead.com/forever/npc=256317/animated-broom
            [npcKeys.name] = "Animated Broom",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[36] = {{12.6, 64.6}, {14.6, 65.8}, {15, 64.6}, {15.2, 55.8}, {16, 70.6}, {17.2, 70.8}, {18.4, 68.6}, {18.6, 63.8}, {18.8, 68.2}, {19, 65.4}, {20.2, 66.6}, {21.6, 72.4}, {21.6, 73}, {25.4, 80.4}, {25.6, 80.2}, {26, 80.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [256337] = { -- Animated Tome : https://wowhead.com/forever/npc=256337/animated-tome
            [npcKeys.name] = "Animated Tome",
        },
        [256339] = { -- Animated Tome : https://wowhead.com/forever/npc=256339/animated-tome
            [npcKeys.name] = "Animated Tome",
        },
        [256340] = { -- Animated Tome : https://wowhead.com/forever/npc=256340/animated-tome
            [npcKeys.name] = "Animated Tome",
        },
        [256343] = { -- Animated Tome : https://wowhead.com/forever/npc=256343/animated-tome
            [npcKeys.name] = "Animated Tome",
        },
        [256346] = { -- Animated Tome : https://wowhead.com/forever/npc=256346/animated-tome
            [npcKeys.name] = "Animated Tome",
        },
        [256352] = { -- Animated Tome : https://wowhead.com/forever/npc=256352/animated-tome
            [npcKeys.name] = "Animated Tome",
        },
        [256359] = { -- Dalaran Wizard : https://wowhead.com/forever/npc=256359/dalaran-wizard
            [npcKeys.name] = "Dalaran Wizard",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{13, 64.2}, {13.2, 66.8}, {13.4, 65.2}, {13.4, 65.6}, {13.6, 65.2}, {13.8, 64}, {15.8, 62.2}, {16, 62.8}, {19.4, 62.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256362] = { -- Dalaran Conjuror : https://wowhead.com/forever/npc=256362/dalaran-conjuror
            [npcKeys.name] = "Dalaran Conjuror",
            [npcKeys.spawns] = {[36] = {{11.2, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [256371] = { -- Theresa Wolf : https://wowhead.com/forever/npc=256371/theresa-wolf
            [npcKeys.name] = "Theresa Wolf",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[36] = {{12.4, 65}, {12.6, 64.4}, {12.6, 64.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256372] = { -- Windle Sparkshine : https://wowhead.com/forever/npc=256372/windle-sparkshine
            [npcKeys.name] = "Windle Sparkshine",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{14.2, 66.6}, {14.4, 66.4}, {14.6, 66.4}, {14.6, 66.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256383] = { -- Meadowsbrook Farmhand : https://wowhead.com/forever/npc=256383/meadowsbrook-farmhand
            [npcKeys.name] = "Meadowsbrook Farmhand",
            [npcKeys.spawns] = {[16591] = {{45, 79}, {45.4, 78}, {46.8, 83.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256384] = { -- Gishah : https://wowhead.com/forever/npc=256384/gishah
            [npcKeys.name] = "Gishah",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[17] = {{49.4, 29.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256386] = { -- Dokimi : https://wowhead.com/forever/npc=256386/dokimi
            [npcKeys.name] = "Dokimi",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[17] = {{50, 29.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.questEnds] = {91899, 91900, 91904, 91905, 98248},
            [npcKeys.friendlyToFaction] = "H",
        },
        [256388] = { -- Jornah : https://wowhead.com/forever/npc=256388/jornah
            [npcKeys.name] = "Jornah",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[17] = {{49.8, 29.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256389] = { -- Tamelyn Aldridge : https://wowhead.com/forever/npc=256389/tamelyn-aldridge
            [npcKeys.name] = "Tamelyn Aldridge",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256390] = { -- Marcy Baker : https://wowhead.com/forever/npc=256390/marcy-baker
            [npcKeys.name] = "Marcy Baker",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.questStarts] = {91899, 91900, 91904, 91905},
            [npcKeys.questEnds] = {91899, 91900, 91904, 91905, 98247},
            [npcKeys.friendlyToFaction] = "A",
        },
        [256391] = { -- Elaine Compton : https://wowhead.com/forever/npc=256391/elaine-compton
            [npcKeys.name] = "Elaine Compton",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256392] = { -- Pack Kodo : https://wowhead.com/forever/npc=256392/pack-kodo
            [npcKeys.name] = "Pack Kodo",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.4, 29}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256393] = { -- Pack Mule : https://wowhead.com/forever/npc=256393/pack-mule
            [npcKeys.name] = "Pack Mule",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256398] = { -- Off-Duty Pack Kodo : https://wowhead.com/forever/npc=256398/off-duty-pack-kodo
            [npcKeys.name] = "Off-Duty Pack Kodo",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.8, 28.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256399] = { -- Off-Duty Pack Mule : https://wowhead.com/forever/npc=256399/off-duty-pack-mule
            [npcKeys.name] = "Off-Duty Pack Mule",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256400] = { -- Okamache : https://wowhead.com/forever/npc=256400/okamache
            [npcKeys.name] = "Okamache",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[17] = {{49.6, 28.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256410] = { -- Reginald Holmsby : https://wowhead.com/forever/npc=256410/reginald-holmsby
            [npcKeys.name] = "Reginald Holmsby",
        },
        [256418] = { -- Krom'rosh : https://wowhead.com/forever/npc=256418/kromrosh
            [npcKeys.name] = "Krom'rosh",
            [npcKeys.spawns] = {[16591] = {{59.4, 45.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256433] = { -- Woodworker : https://wowhead.com/forever/npc=256433/woodworker
            [npcKeys.name] = "Woodworker",
            [npcKeys.spawns] = {[16591] = {{41.2, 61.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256434] = { -- Turner's Mill Lumberjack : https://wowhead.com/forever/npc=256434/turners-mill-lumberjack
            [npcKeys.name] = "Turner's Mill Lumberjack",
            [npcKeys.spawns] = {[16591] = {{42.2, 58.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256438] = { -- Halligan Turner : https://wowhead.com/forever/npc=256438/halligan-turner
            [npcKeys.name] = "Halligan Turner",
            [npcKeys.spawns] = {[16591] = {{41, 62.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256442] = { -- Human Male : https://wowhead.com/forever/npc=256442/human-male
            [npcKeys.name] = "Human Male",
        },
        [256443] = { -- Human Female : https://wowhead.com/forever/npc=256443/human-female
            [npcKeys.name] = "Human Female",
        },
        [256444] = { -- Dwarf Male : https://wowhead.com/forever/npc=256444/dwarf-male
            [npcKeys.name] = "Dwarf Male",
        },
        [256445] = { -- Dwarf Female : https://wowhead.com/forever/npc=256445/dwarf-female
            [npcKeys.name] = "Dwarf Female",
        },
        [256446] = { -- Night Elf Male : https://wowhead.com/forever/npc=256446/night-elf-male
            [npcKeys.name] = "Night Elf Male",
        },
        [256448] = { -- Night Elf Female : https://wowhead.com/forever/npc=256448/night-elf-female
            [npcKeys.name] = "Night Elf Female",
        },
        [256449] = { -- Gnome Male : https://wowhead.com/forever/npc=256449/gnome-male
            [npcKeys.name] = "Gnome Male",
        },
        [256450] = { -- Gnome Female : https://wowhead.com/forever/npc=256450/gnome-female
            [npcKeys.name] = "Gnome Female",
        },
        [256451] = { -- Skyborne Male : https://wowhead.com/forever/npc=256451/skyborne-male
            [npcKeys.name] = "Skyborne Male",
        },
        [256452] = { -- Skyborne Female : https://wowhead.com/forever/npc=256452/skyborne-female
            [npcKeys.name] = "Skyborne Female",
        },
        [256453] = { -- Orc Male : https://wowhead.com/forever/npc=256453/orc-male
            [npcKeys.name] = "Orc Male",
        },
        [256454] = { -- Orc Female : https://wowhead.com/forever/npc=256454/orc-female
            [npcKeys.name] = "Orc Female",
        },
        [256455] = { -- Undead Male : https://wowhead.com/forever/npc=256455/undead-male
            [npcKeys.name] = "Undead Male",
        },
        [256456] = { -- Undead Female : https://wowhead.com/forever/npc=256456/undead-female
            [npcKeys.name] = "Undead Female",
        },
        [256457] = { -- Tauren Male : https://wowhead.com/forever/npc=256457/tauren-male
            [npcKeys.name] = "Tauren Male",
        },
        [256458] = { -- Tauren Female : https://wowhead.com/forever/npc=256458/tauren-female
            [npcKeys.name] = "Tauren Female",
        },
        [256459] = { -- Troll Male : https://wowhead.com/forever/npc=256459/troll-male
            [npcKeys.name] = "Troll Male",
        },
        [256460] = { -- Troll Female : https://wowhead.com/forever/npc=256460/troll-female
            [npcKeys.name] = "Troll Female",
        },
        [256462] = { -- Goblin Male : https://wowhead.com/forever/npc=256462/goblin-male
            [npcKeys.name] = "Goblin Male",
        },
        [256463] = { -- Goblin Female : https://wowhead.com/forever/npc=256463/goblin-female
            [npcKeys.name] = "Goblin Female",
        },
        [256464] = { -- Prototype Recalibrator : https://wowhead.com/forever/npc=256464/prototype-recalibrator
            [npcKeys.name] = "Prototype Recalibrator",
        },
        [256492] = { -- Fernfeather : https://wowhead.com/forever/npc=256492/fernfeather
            [npcKeys.name] = "Fernfeather",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{48, 85.4}, {51.4, 82.4}, {51.4, 83}, {53.6, 80}, {54, 79.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [256507] = { -- Belann Windwood : https://wowhead.com/forever/npc=256507/belann-windwood
            [npcKeys.name] = "Belann Windwood",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[16593] = {{62.8, 77.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93791, 93797},
            [npcKeys.questEnds] = {93791, 93797},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256514] = { -- Contemplative Bandit : https://wowhead.com/forever/npc=256514/contemplative-bandit
            [npcKeys.name] = "Contemplative Bandit",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{48.4, 85.8}, {48.6, 86}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256518] = { -- Raylann : https://wowhead.com/forever/npc=256518/raylann
            [npcKeys.name] = "Raylann",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{59.6, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256529] = { -- Grythden Thurdril <PH> : https://wowhead.com/forever/npc=256529/grythden-thurdril-ph
            [npcKeys.name] = "Grythden Thurdril <PH>",
        },
        [256570] = { -- Crate of Alchemy Goods : https://wowhead.com/forever/npc=256570/crate-of-alchemy-goods
            [npcKeys.name] = "Crate of Alchemy Goods",
        },
        [256571] = { -- Crate of Blacksmithing Goods : https://wowhead.com/forever/npc=256571/crate-of-blacksmithing-goods
            [npcKeys.name] = "Crate of Blacksmithing Goods",
        },
        [256573] = { -- Crate of Enchanting Supplies : https://wowhead.com/forever/npc=256573/crate-of-enchanting-supplies
            [npcKeys.name] = "Crate of Enchanting Supplies",
        },
        [256575] = { -- Basket of Textile Supplies : https://wowhead.com/forever/npc=256575/basket-of-textile-supplies
            [npcKeys.name] = "Basket of Textile Supplies",
        },
        [256617] = { -- Baron Anvillaxx : https://wowhead.com/forever/npc=256617/baron-anvillaxx
            [npcKeys.name] = "Baron Anvillaxx",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256618] = { -- Windshaper Shaman : https://wowhead.com/forever/npc=256618/windshaper-shaman
            [npcKeys.name] = "Windshaper Shaman",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{74, 52.4}, {75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256619] = { -- High Order Mage : https://wowhead.com/forever/npc=256619/high-order-mage
            [npcKeys.name] = "High Order Mage",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{74, 52.4}, {74, 52.6}, {75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256620] = { -- Muln Earthfury : https://wowhead.com/forever/npc=256620/muln-earthfury
            [npcKeys.name] = "Muln Earthfury",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256621] = { -- Archmage Ansirem Runeweaver : https://wowhead.com/forever/npc=256621/archmage-ansirem-runeweaver
            [npcKeys.name] = "Archmage Ansirem Runeweaver",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256626] = { -- Fennar Mossmane : https://wowhead.com/forever/npc=256626/fennar-mossmane
            [npcKeys.name] = "Fennar Mossmane",
        },
        [256627] = { -- Elder Mistpaw : https://wowhead.com/forever/npc=256627/elder-mistpaw
            [npcKeys.name] = "Elder Mistpaw",
        },
        [256628] = { -- Thalruk Thickfur : https://wowhead.com/forever/npc=256628/thalruk-thickfur
            [npcKeys.name] = "Thalruk Thickfur",
        },
        [256629] = { -- Dala Fairmaw : https://wowhead.com/forever/npc=256629/dala-fairmaw
            [npcKeys.name] = "Dala Fairmaw",
        },
        [256634] = { -- DNT : https://wowhead.com/forever/npc=256634/dnt
            [npcKeys.name] = "DNT",
        },
        [256635] = { -- Peacekeeper : https://wowhead.com/forever/npc=256635/peacekeeper
            [npcKeys.name] = "Peacekeeper",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{70.8, 50.4}, {70.8, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256646] = { -- Osi Mistpaw : https://wowhead.com/forever/npc=256646/osi-mistpaw
            [npcKeys.name] = "Osi Mistpaw",
        },
        [256650] = { -- Elder Pinespeaker : https://wowhead.com/forever/npc=256650/elder-pinespeaker
            [npcKeys.name] = "Elder Pinespeaker",
        },
        [256655] = { -- Gorg : https://wowhead.com/forever/npc=256655/gorg
            [npcKeys.name] = "Gorg",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{58.6, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256657] = { -- Kreza Darkthorn : https://wowhead.com/forever/npc=256657/kreza-darkthorn
            [npcKeys.name] = "Kreza Darkthorn",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{59.8, 46}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256658] = { -- Gur'dok : https://wowhead.com/forever/npc=256658/gurdok
            [npcKeys.name] = "Gur'dok",
            [npcKeys.spawns] = {[16591] = {{60, 46.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256660] = { -- Thobon Sapclaw : https://wowhead.com/forever/npc=256660/thobon-sapclaw
            [npcKeys.name] = "Thobon Sapclaw",
        },
        [256672] = { -- Kurvelk Shadowhoof : https://wowhead.com/forever/npc=256672/kurvelk-shadowhoof
            [npcKeys.name] = "Kurvelk Shadowhoof",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[17] = {{49.8, 30}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [256673] = { -- Grik : https://wowhead.com/forever/npc=256673/grik
            [npcKeys.name] = "Grik",
            [npcKeys.spawns] = {[16591] = {{58.2, 45}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256675] = { -- Innkeeper Toka : https://wowhead.com/forever/npc=256675/innkeeper-toka
            [npcKeys.name] = "Innkeeper Toka",
            [npcKeys.spawns] = {[16591] = {{58, 45}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256678] = { -- Tainted Vilethorn : https://wowhead.com/forever/npc=256678/tainted-vilethorn
            [npcKeys.name] = "Tainted Vilethorn",
        },
        [256710] = { -- Tran'gul : https://wowhead.com/forever/npc=256710/trangul
            [npcKeys.name] = "Tran'gul",
            [npcKeys.spawns] = {[16591] = {{59.4, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256714] = { -- Burrow Beetle : https://wowhead.com/forever/npc=256714/burrow-beetle
            [npcKeys.name] = "Burrow Beetle",
        },
        [256728] = { -- Na'zok : https://wowhead.com/forever/npc=256728/nazok
            [npcKeys.name] = "Na'zok",
            [npcKeys.spawns] = {[16591] = {{70.4, 28}, {70.6, 28}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256729] = { -- Nina Surefire : https://wowhead.com/forever/npc=256729/nina-surefire
            [npcKeys.name] = "Nina Surefire",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256730] = { -- Stondry Darkhammer : https://wowhead.com/forever/npc=256730/stondry-darkhammer
            [npcKeys.name] = "Stondry Darkhammer",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256731] = { -- Kalsey Sanden : https://wowhead.com/forever/npc=256731/kalsey-sanden
            [npcKeys.name] = "Kalsey Sanden",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256732] = { -- Alynsia : https://wowhead.com/forever/npc=256732/alynsia
            [npcKeys.name] = "Alynsia",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256733] = { -- Fritz Fizzle : https://wowhead.com/forever/npc=256733/fritz-fizzle
            [npcKeys.name] = "Fritz Fizzle",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256734] = { -- Daniel Stitchsong : https://wowhead.com/forever/npc=256734/daniel-stitchsong
            [npcKeys.name] = "Daniel Stitchsong",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256735] = { -- Mivin Shadowweave : https://wowhead.com/forever/npc=256735/mivin-shadowweave
            [npcKeys.name] = "Mivin Shadowweave",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256736] = { -- Huey Sunnydale : https://wowhead.com/forever/npc=256736/huey-sunnydale
            [npcKeys.name] = "Huey Sunnydale",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256738] = { -- Basket of Alchemy Goods : https://wowhead.com/forever/npc=256738/basket-of-alchemy-goods
            [npcKeys.name] = "Basket of Alchemy Goods",
        },
        [256739] = { -- Crate of Blacksmithing Goods : https://wowhead.com/forever/npc=256739/crate-of-blacksmithing-goods
            [npcKeys.name] = "Crate of Blacksmithing Goods",
        },
        [256740] = { -- Crate of Enchanting Supplies : https://wowhead.com/forever/npc=256740/crate-of-enchanting-supplies
            [npcKeys.name] = "Crate of Enchanting Supplies",
        },
        [256741] = { -- Basket of Textile Supplies : https://wowhead.com/forever/npc=256741/basket-of-textile-supplies
            [npcKeys.name] = "Basket of Textile Supplies",
        },
        [256742] = { -- Dianne Softstep : https://wowhead.com/forever/npc=256742/dianne-softstep
            [npcKeys.name] = "Dianne Softstep",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [256749] = { -- Rog'mar Trainee : https://wowhead.com/forever/npc=256749/rogmar-trainee
            [npcKeys.name] = "Rog'mar Trainee",
            [npcKeys.spawns] = {[16591] = {{60, 40.4}, {60.2, 32.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256795] = { -- Twilight Fanatic : https://wowhead.com/forever/npc=256795/twilight-fanatic
            [npcKeys.name] = "Twilight Fanatic",
            [npcKeys.spawns] = {[16591] = {{30.4, 48.4}, {31, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256797] = { -- Twilight Corrupter : https://wowhead.com/forever/npc=256797/twilight-corrupter
            [npcKeys.name] = "Twilight Corrupter",
            [npcKeys.minLevel] = 42,
            [npcKeys.maxLevel] = 42,
        },
        [256798] = { -- Twilight Neophyte : https://wowhead.com/forever/npc=256798/twilight-neophyte
            [npcKeys.name] = "Twilight Neophyte",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{42, 45.8}, {45.2, 47.4}, {46, 45.4}, {50.4, 42.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256799] = { -- Twilight Champion : https://wowhead.com/forever/npc=256799/twilight-champion
            [npcKeys.name] = "Twilight Champion",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256800] = { -- Twilight Enforcer : https://wowhead.com/forever/npc=256800/twilight-enforcer
            [npcKeys.name] = "Twilight Enforcer",
        },
        [256801] = { -- Murloc Warrior : https://wowhead.com/forever/npc=256801/murloc-warrior
            [npcKeys.name] = "Murloc Warrior",
            [npcKeys.spawns] = {[16591] = {{78.4, 69.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256807] = { -- Shore Crawler : https://wowhead.com/forever/npc=256807/shore-crawler
            [npcKeys.name] = "Shore Crawler",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256809] = { -- Predatory Hyjal Stag : https://wowhead.com/forever/npc=256809/predatory-hyjal-stag
            [npcKeys.name] = "Predatory Hyjal Stag",
        },
        [256830] = { -- Bannerwing Survivor : https://wowhead.com/forever/npc=256830/bannerwing-survivor
            [npcKeys.name] = "Bannerwing Survivor",
        },
        [256831] = { -- Apprentice Claire : https://wowhead.com/forever/npc=256831/apprentice-claire
            [npcKeys.name] = "Apprentice Claire",
        },
        [256840] = { -- Lieutenant Prenish : https://wowhead.com/forever/npc=256840/lieutenant-prenish
            [npcKeys.name] = "Lieutenant Prenish",
            [npcKeys.spawns] = {[16591] = {{61.2, 80}, {61.6, 80}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256881] = { -- Overlord Kilgar : https://wowhead.com/forever/npc=256881/overlord-kilgar
            [npcKeys.name] = "Overlord Kilgar",
        },
        [256891] = { -- Executioner Morg : https://wowhead.com/forever/npc=256891/executioner-morg
            [npcKeys.name] = "Executioner Morg",
        },
        [256892] = { -- Kargra the Blind : https://wowhead.com/forever/npc=256892/kargra-the-blind
            [npcKeys.name] = "Kargra the Blind",
        },
        [256899] = { -- Chogg'Zac : https://wowhead.com/forever/npc=256899/choggzac
            [npcKeys.name] = "Chogg'Zac",
        },
        [256904] = { -- Farholde Scout : https://wowhead.com/forever/npc=256904/farholde-scout
            [npcKeys.name] = "Farholde Scout",
        },
        [256930] = { -- Captured Bandit : https://wowhead.com/forever/npc=256930/captured-bandit
            [npcKeys.name] = "Captured Bandit",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256935] = { -- Malduko Cloudcrush : https://wowhead.com/forever/npc=256935/malduko-cloudcrush
            [npcKeys.name] = "Malduko Cloudcrush",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{36, 33.6}, {36.4, 33.2}, {36.6, 33.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256952] = { -- Twilight Raider : https://wowhead.com/forever/npc=256952/twilight-raider
            [npcKeys.name] = "Twilight Raider",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 40,
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [256966] = { -- Skypriest Aanders : https://wowhead.com/forever/npc=256966/skypriest-aanders
            [npcKeys.name] = "Skypriest Aanders",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{41, 64}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [256978] = { -- Brerufa : https://wowhead.com/forever/npc=256978/brerufa
            [npcKeys.name] = "Brerufa",
            [npcKeys.spawns] = {[616] = {{20.6, 71.6}, {20.8, 71.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [256996] = { -- Al'Aketh Warrior : https://wowhead.com/forever/npc=256996/alaketh-warrior
            [npcKeys.name] = "Al'Aketh Warrior",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{41, 64}, {41.2, 63.4}, {41.6, 62.4}, {41.6, 62.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257001] = { -- Old Rot-Chum : https://wowhead.com/forever/npc=257001/old-rot-chum
            [npcKeys.name] = "Old Rot-Chum",
        },
        [257003] = { -- Ishlee Breezewhisper : https://wowhead.com/forever/npc=257003/ishlee-breezewhisper
            [npcKeys.name] = "Ishlee Breezewhisper",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.4, 76}, {59.6, 76}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257004] = { -- Eaysaa Brightgust : https://wowhead.com/forever/npc=257004/eaysaa-brightgust
            [npcKeys.name] = "Eaysaa Brightgust",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.2, 76.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257005] = { -- Valiena Swiftgale : https://wowhead.com/forever/npc=257005/valiena-swiftgale
            [npcKeys.name] = "Valiena Swiftgale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{59.2, 76.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257006] = { -- Nyalah Brightfire : https://wowhead.com/forever/npc=257006/nyalah-brightfire
            [npcKeys.name] = "Nyalah Brightfire",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{60.6, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {93317},
            [npcKeys.questEnds] = {93317},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257007] = { -- Melasa Fairmend : https://wowhead.com/forever/npc=257007/melasa-fairmend
            [npcKeys.name] = "Melasa Fairmend",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63, 72.4}, {63, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257008] = { -- Baelann Swiftcurrent : https://wowhead.com/forever/npc=257008/baelann-swiftcurrent
            [npcKeys.name] = "Baelann Swiftcurrent",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.2, 75.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257017] = { -- Twilight Worg : https://wowhead.com/forever/npc=257017/twilight-worg
            [npcKeys.name] = "Twilight Worg",
        },
        [257018] = { -- Naleeia Tattermend : https://wowhead.com/forever/npc=257018/naleeia-tattermend
            [npcKeys.name] = "Naleeia Tattermend",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43, 46.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97965},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257019] = { -- Nyassa Swiftdraught : https://wowhead.com/forever/npc=257019/nyassa-swiftdraught
            [npcKeys.name] = "Nyassa Swiftdraught",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.6, 43.4}, {43.8, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97963},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257020] = { -- Nasalanna Windsinger : https://wowhead.com/forever/npc=257020/nasalanna-windsinger
            [npcKeys.name] = "Nasalanna Windsinger",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.2, 43.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {98284, 98286},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257021] = { -- Halassa Fernbreeze : https://wowhead.com/forever/npc=257021/halassa-fernbreeze
            [npcKeys.name] = "Halassa Fernbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43, 43.4}, {43, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257022] = { -- Messana Crestwind : https://wowhead.com/forever/npc=257022/messana-crestwind
            [npcKeys.name] = "Messana Crestwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{44.6, 44.6}, {44.8, 44.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97970},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257024] = { -- Mendalass Tattermend : https://wowhead.com/forever/npc=257024/mendalass-tattermend
            [npcKeys.name] = "Mendalass Tattermend",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.2, 43.4}, {43.2, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questEnds] = {97971},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257034] = { -- Mad Marrius : https://wowhead.com/forever/npc=257034/mad-marrius
            [npcKeys.name] = "Mad Marrius",
        },
        [257036] = { -- Baelann Favorbreeze : https://wowhead.com/forever/npc=257036/baelann-favorbreeze
            [npcKeys.name] = "Baelann Favorbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57.6, 77}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257037] = { -- Zelena Favorbreeze : https://wowhead.com/forever/npc=257037/zelena-favorbreeze
            [npcKeys.name] = "Zelena Favorbreeze",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57.8, 77}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257055] = { -- Clobrok : https://wowhead.com/forever/npc=257055/clobrok
            [npcKeys.name] = "Clobrok",
            [npcKeys.spawns] = {[16591] = {{64.2, 22}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257056] = { -- Buzzbeak : https://wowhead.com/forever/npc=257056/buzzbeak
            [npcKeys.name] = "Buzzbeak",
        },
        [257057] = { -- Glop : https://wowhead.com/forever/npc=257057/glop
            [npcKeys.name] = "Glop",
            [npcKeys.spawns] = {[16591] = {{67.2, 19.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257058] = { -- Gobam : https://wowhead.com/forever/npc=257058/gobam
            [npcKeys.name] = "Gobam",
            [npcKeys.spawns] = {[16591] = {{66.8, 17.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257059] = { -- Chub'chob : https://wowhead.com/forever/npc=257059/chubchob
            [npcKeys.name] = "Chub'chob",
            [npcKeys.spawns] = {[16591] = {{65.4, 21.4}, {65.6, 21.4}, {65.6, 21.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257062] = { -- Jezap Jinglesprocket : https://wowhead.com/forever/npc=257062/jezap-jinglesprocket
            [npcKeys.name] = "Jezap Jinglesprocket",
            [npcKeys.spawns] = {[16591] = {{65.4, 21.4}, {65.6, 21.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257065] = { -- Missionary Jasaan : https://wowhead.com/forever/npc=257065/missionary-jasaan
            [npcKeys.name] = "Missionary Jasaan",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{46.8, 56.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92528},
            [npcKeys.questEnds] = {92529},
        },
        [257066] = { -- Skyhopper : https://wowhead.com/forever/npc=257066/skyhopper
            [npcKeys.name] = "Skyhopper",
        },
        [257074] = { -- Skeletal Necromancer : https://wowhead.com/forever/npc=257074/skeletal-necromancer
            [npcKeys.name] = "Skeletal Necromancer",
        },
        [257075] = { -- Skeletal Necromancer : https://wowhead.com/forever/npc=257075/skeletal-necromancer
            [npcKeys.name] = "Skeletal Necromancer",
        },
        [257076] = { -- Fleshflayer Ravener : https://wowhead.com/forever/npc=257076/fleshflayer-ravener
            [npcKeys.name] = "Fleshflayer Ravener",
        },
        [257077] = { -- Forgotten Soldier : https://wowhead.com/forever/npc=257077/forgotten-soldier
            [npcKeys.name] = "Forgotten Soldier",
        },
        [257079] = { -- Cavalry Scout Alturin : https://wowhead.com/forever/npc=257079/cavalry-scout-alturin
            [npcKeys.name] = "Cavalry Scout Alturin",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[16591] = {{57.6, 75.4}, {59.2, 77.6}, {60, 78.4}, {60.8, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257080] = { -- Cavalry Guard : https://wowhead.com/forever/npc=257080/cavalry-guard
            [npcKeys.name] = "Cavalry Guard",
            [npcKeys.spawns] = {[16591] = {{57.6, 73.4}, {58.4, 76.2}, {59, 77.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257087] = { -- Gretchen Mayberry : https://wowhead.com/forever/npc=257087/gretchen-mayberry
            [npcKeys.name] = "Gretchen Mayberry",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[16591] = {{60.6, 81.4}, {60.6, 81.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257099] = { -- Cirrusfly Hive : https://wowhead.com/forever/npc=257099/cirrusfly-hive
            [npcKeys.name] = "Cirrusfly Hive",
        },
        [257100] = { -- Cirrusfly Drone : https://wowhead.com/forever/npc=257100/cirrusfly-drone
            [npcKeys.name] = "Cirrusfly Drone",
        },
        [257142] = { -- Reuse Me : https://wowhead.com/forever/npc=257142/reuse-me
            [npcKeys.name] = "Reuse Me",
        },
        [257166] = { -- Giant Chicken : https://wowhead.com/forever/npc=257166/giant-chicken
            [npcKeys.name] = "Giant Chicken",
        },
        [257196] = { -- Zaal Stormshield : https://wowhead.com/forever/npc=257196/zaal-stormshield
            [npcKeys.name] = "Zaal Stormshield",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{56.6, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257250] = { -- Marshal Ryan : https://wowhead.com/forever/npc=257250/marshal-ryan
            [npcKeys.name] = "Marshal Ryan",
        },
        [257274] = { -- DNT : https://wowhead.com/forever/npc=257274/dnt
            [npcKeys.name] = "DNT",
        },
        [257281] = { -- Sos'mol : https://wowhead.com/forever/npc=257281/sosmol
            [npcKeys.name] = "Sos'mol",
            [npcKeys.spawns] = {[36] = {{38.4, 61.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.questEnds] = {94004},
        },
        [257282] = { -- Alan Sneeks : https://wowhead.com/forever/npc=257282/alan-sneeks
            [npcKeys.name] = "Alan Sneeks",
            [npcKeys.spawns] = {[36] = {{30.4, 61.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.questEnds] = {94229},
        },
        [257292] = { -- Brakkit : https://wowhead.com/forever/npc=257292/brakkit
            [npcKeys.name] = "Brakkit",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[16591] = {{76.6, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257294] = { -- Lizi Pinchwhistle : https://wowhead.com/forever/npc=257294/lizi-pinchwhistle
            [npcKeys.name] = "Lizi Pinchwhistle",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[16591] = {{76.8, 54.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257296] = { -- Muggol Breezebeard : https://wowhead.com/forever/npc=257296/muggol-breezebeard
            [npcKeys.name] = "Muggol Breezebeard",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 36,
            [npcKeys.spawns] = {[45] = {{48.8, 55.8}}},
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
            [npcKeys.questEnds] = {94212, 94221},
        },
        [257300] = { -- Julia Mallard : https://wowhead.com/forever/npc=257300/julia-mallard
            [npcKeys.name] = "Julia Mallard",
        },
        [257304] = { -- Alyce : https://wowhead.com/forever/npc=257304/alyce
            [npcKeys.name] = "Alyce",
            [npcKeys.spawns] = {[45] = {{34, 23.2}}},
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
            [npcKeys.questEnds] = {94248},
        },
        [257315] = { -- Ash'alari : https://wowhead.com/forever/npc=257315/ashalari
            [npcKeys.name] = "Ash'alari",
            [npcKeys.spawns] = {[331] = {{60.2, 72.4}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.questEnds] = {94213},
        },
        [257316] = { -- Cowardly Peon : https://wowhead.com/forever/npc=257316/cowardly-peon
            [npcKeys.name] = "Cowardly Peon",
            [npcKeys.spawns] = {[331] = {{78.4, 68.8}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.questEnds] = {94249},
        },
        [257317] = { -- Grembly : https://wowhead.com/forever/npc=257317/grembly
            [npcKeys.name] = "Grembly",
        },
        [257322] = { -- Murache : https://wowhead.com/forever/npc=257322/murache
            [npcKeys.name] = "Murache",
            [npcKeys.spawns] = {[331] = {{64.6, 80.2}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [257327] = { -- Brother Aandril : https://wowhead.com/forever/npc=257327/brother-aandril
            [npcKeys.name] = "Brother Aandril",
        },
        [257328] = { -- Brother Anaan : https://wowhead.com/forever/npc=257328/brother-anaan
            [npcKeys.name] = "Brother Anaan",
        },
        [257421] = { -- Tephri Thriceforged : https://wowhead.com/forever/npc=257421/tephri-thriceforged
            [npcKeys.name] = "Tephri Thriceforged",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[16593] = {{44.8, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257422] = { -- Railee Thriceforged : https://wowhead.com/forever/npc=257422/railee-thriceforged
            [npcKeys.name] = "Railee Thriceforged",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58.8, 75.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257425] = { -- Ziv'al : https://wowhead.com/forever/npc=257425/zival
            [npcKeys.name] = "Ziv'al",
        },
        [257429] = { -- Furious Shadowforge Digger : https://wowhead.com/forever/npc=257429/furious-shadowforge-digger
            [npcKeys.name] = "Furious Shadowforge Digger",
        },
        [257437] = { -- Garyanne Fleezlebop : https://wowhead.com/forever/npc=257437/garyanne-fleezlebop
            [npcKeys.name] = "Garyanne Fleezlebop",
            [npcKeys.spawns] = {[3] = {{67.8, 52}}},
            [npcKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [257446] = { -- Teo Hammerstorm : https://wowhead.com/forever/npc=257446/teo-hammerstorm
            [npcKeys.name] = "Teo Hammerstorm",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1] = {{28.8, 66.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.questStarts] = {94373, 94374, 94472},
            [npcKeys.questEnds] = {94373, 94375, 94472, 98581},
            [npcKeys.friendlyToFaction] = "A",
        },
        [257450] = { -- Rog'mar Scout : https://wowhead.com/forever/npc=257450/rogmar-scout
            [npcKeys.name] = "Rog'mar Scout",
        },
        [257480] = { -- Traveler's Sign : https://wowhead.com/forever/npc=257480/travelers-sign
            [npcKeys.name] = "Traveler's Sign",
        },
        [257490] = { -- [DNT] Kill Credit: Stegodon : https://wowhead.com/forever/npc=257490/dnt-kill-credit-stegodon
            [npcKeys.name] = "[DNT] Kill Credit: Stegodon",
        },
        [257521] = { -- High Order Apprentice : https://wowhead.com/forever/npc=257521/high-order-apprentice
            [npcKeys.name] = "High Order Apprentice",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{45.4, 39.2}, {45.8, 39.4}, {46, 38.2}, {46, 40}, {46.6, 38.2}, {46.6, 39.2}, {46.6, 39.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257532] = { -- Windshaper Novice Seer : https://wowhead.com/forever/npc=257532/windshaper-novice-seer
            [npcKeys.name] = "Windshaper Novice Seer",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{37.4, 47}, {38, 47}, {38, 47.8}, {38.2, 46.4}, {38.4, 48.8}, {38.8, 47.6}, {38.8, 48.8}, {39.4, 47}, {39.8, 46.6}, {40, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [257533] = { -- Ley Line KC : https://wowhead.com/forever/npc=257533/ley-line-kc
            [npcKeys.name] = "Ley Line KC",
        },
        [257548] = { -- Al'Aketh Turncoat : https://wowhead.com/forever/npc=257548/alaketh-turncoat
            [npcKeys.name] = "Al'Aketh Turncoat",
        },
        [257551] = { -- Valreaa Valewind : https://wowhead.com/forever/npc=257551/valreaa-valewind
            [npcKeys.name] = "Valreaa Valewind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{42.4, 25}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92473},
            [npcKeys.questEnds] = {92473},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257554] = { -- Halaan Hawk-Eye : https://wowhead.com/forever/npc=257554/halaan-hawk-eye
            [npcKeys.name] = "Halaan Hawk-Eye",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.8, 24}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94414},
            [npcKeys.questEnds] = {94414},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257558] = { -- Demar Brant : https://wowhead.com/forever/npc=257558/demar-brant
            [npcKeys.name] = "Demar Brant",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[16591] = {{66.4, 80.8}, {66.6, 81}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257591] = { -- Ashe Amberhall : https://wowhead.com/forever/npc=257591/ashe-amberhall
            [npcKeys.name] = "Ashe Amberhall",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[16591] = {{66.6, 81}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257595] = { -- Barracks Master Harlan : https://wowhead.com/forever/npc=257595/barracks-master-harlan
            [npcKeys.name] = "Barracks Master Harlan",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{64.6, 84.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257597] = { -- Bruegs Kindleborn : https://wowhead.com/forever/npc=257597/bruegs-kindleborn
            [npcKeys.name] = "Bruegs Kindleborn",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[1] = {{87.6, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.questStarts] = {94465},
            [npcKeys.questEnds] = {94449, 94468},
            [npcKeys.friendlyToFaction] = "A",
        },
        [257615] = { -- Crazed Darkhound : https://wowhead.com/forever/npc=257615/crazed-darkhound
            [npcKeys.name] = "Crazed Darkhound",
        },
        [257640] = { -- Eknip : https://wowhead.com/forever/npc=257640/eknip
            [npcKeys.name] = "Eknip",
        },
        [257641] = { -- Hemet Nesingwary Jr. : https://wowhead.com/forever/npc=257641/hemet-nesingwary-jr
            [npcKeys.name] = "Hemet Nesingwary Jr.",
        },
        [257642] = { -- Thor'mok : https://wowhead.com/forever/npc=257642/thormok
            [npcKeys.name] = "Thor'mok",
        },
        [257648] = { -- Tanis Alderwood : https://wowhead.com/forever/npc=257648/tanis-alderwood
            [npcKeys.name] = "Tanis Alderwood",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[1497] = {{65.4, 37.8}, {65.6, 37.8}, {66, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.questStarts] = {94434, 94435},
            [npcKeys.questEnds] = {94427, 94434},
            [npcKeys.friendlyToFaction] = "H",
        },
        [257655] = { -- Deathguard Billmuth : https://wowhead.com/forever/npc=257655/deathguard-billmuth
            [npcKeys.name] = "Deathguard Billmuth",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{22, 44.4}, {22, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {94438, 94441},
            [npcKeys.questEnds] = {94436, 94440},
            [npcKeys.friendlyToFaction] = "H",
        },
        [257663] = { -- Deathguard Falgan : https://wowhead.com/forever/npc=257663/deathguard-falgan
            [npcKeys.name] = "Deathguard Falgan",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{86.4, 47.8}, {86.6, 47.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {94440},
            [npcKeys.questEnds] = {94438},
            [npcKeys.friendlyToFaction] = "H",
        },
        [257673] = { -- Ugkragg : https://wowhead.com/forever/npc=257673/ugkragg
            [npcKeys.name] = "Ugkragg",
            [npcKeys.spawns] = {[46] = {{38.2, 35.6}}},
            [npcKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [257699] = { -- Steed : https://wowhead.com/forever/npc=257699/steed
            [npcKeys.name] = "Steed",
            [npcKeys.spawns] = {[16591] = {{63.6, 84.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257743] = { -- Hastings : https://wowhead.com/forever/npc=257743/hastings
            [npcKeys.name] = "Hastings",
            [npcKeys.spawns] = {[41] = {{47.2, 75}}},
            [npcKeys.zoneID] = zoneIDs.DEADWIND_PASS,
        },
        [257750] = { -- Calliard : https://wowhead.com/forever/npc=257750/calliard
            [npcKeys.name] = "Calliard",
            [npcKeys.spawns] = {[41] = {{48.2, 68}}},
            [npcKeys.zoneID] = zoneIDs.DEADWIND_PASS,
        },
        [257753] = { -- Curious Crow : https://wowhead.com/forever/npc=257753/curious-crow
            [npcKeys.name] = "Curious Crow",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{48.4, 86}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257754] = { -- Spectral Charger : https://wowhead.com/forever/npc=257754/spectral-charger
            [npcKeys.name] = "Spectral Charger",
            [npcKeys.zoneID] = zoneIDs.DEADWIND_PASS,
        },
        [257808] = { -- Braldir Ashmantle : https://wowhead.com/forever/npc=257808/braldir-ashmantle
            [npcKeys.name] = "Braldir Ashmantle",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[38] = {{32, 66}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [npcKeys.questStarts] = {94466, 94467, 94473},
            [npcKeys.questEnds] = {94465, 94466, 94473},
            [npcKeys.friendlyToFaction] = "A",
        },
        [257841] = { -- Cap'n Placeholder : https://wowhead.com/forever/npc=257841/capn-placeholder
            [npcKeys.name] = "Cap'n Placeholder",
        },
        [257861] = { -- Admiral Lamora : https://wowhead.com/forever/npc=257861/admiral-lamora
            [npcKeys.name] = "Admiral Lamora",
        },
        [257862] = { -- Earthen Ring Shaman : https://wowhead.com/forever/npc=257862/earthen-ring-shaman
            [npcKeys.name] = "Earthen Ring Shaman",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [257866] = { -- Kirin Tor Mage : https://wowhead.com/forever/npc=257866/kirin-tor-mage
            [npcKeys.name] = "Kirin Tor Mage",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.spawns] = {[16593] = {{75.2, 53.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [257901] = { -- Eastsea Buccaneer : https://wowhead.com/forever/npc=257901/eastsea-buccaneer
            [npcKeys.name] = "Eastsea Buccaneer",
        },
        [257910] = { -- Eastsea Musketeer : https://wowhead.com/forever/npc=257910/eastsea-musketeer
            [npcKeys.name] = "Eastsea Musketeer",
        },
        [257915] = { -- Eastsea Raider : https://wowhead.com/forever/npc=257915/eastsea-raider
            [npcKeys.name] = "Eastsea Raider",
        },
        [257916] = { -- Eastsea Bombardier : https://wowhead.com/forever/npc=257916/eastsea-bombardier
            [npcKeys.name] = "Eastsea Bombardier",
        },
        [257923] = { -- Wisp : https://wowhead.com/forever/npc=257923/wisp
            [npcKeys.name] = "Wisp",
        },
        [257926] = { -- Farholde Scout Trainee : https://wowhead.com/forever/npc=257926/farholde-scout-trainee
            [npcKeys.name] = "Farholde Scout Trainee",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{44, 63.2}, {52, 69.6}, {65.8, 79.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [257944] = { -- Elegael Thornpaw : https://wowhead.com/forever/npc=257944/elegael-thornpaw
            [npcKeys.name] = "Elegael Thornpaw",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{61.6, 39.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94485, 94486, 94487, 94488, 94489, 94491, 94493},
            [npcKeys.questEnds] = {94484, 94485, 94486, 94487, 94488, 94489, 94490, 94493},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [257964] = { -- Injured Druid : https://wowhead.com/forever/npc=257964/injured-druid
            [npcKeys.name] = "Injured Druid",
        },
        [257965] = { -- Bealor'eth Skyfurry : https://wowhead.com/forever/npc=257965/bealoreth-skyfurry
            [npcKeys.name] = "Bealor'eth Skyfurry",
        },
        [258023] = { -- Sergeant Riftan : https://wowhead.com/forever/npc=258023/sergeant-riftan
            [npcKeys.name] = "Sergeant Riftan",
            [npcKeys.spawns] = {[16591] = {{30.4, 49}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258031] = { -- Neza Bloodsnout : https://wowhead.com/forever/npc=258031/neza-bloodsnout
            [npcKeys.name] = "Neza Bloodsnout",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258032] = { -- Twilight Forgemaster : https://wowhead.com/forever/npc=258032/twilight-forgemaster
            [npcKeys.name] = "Twilight Forgemaster",
        },
        [258043] = { -- Norric Lochthane : https://wowhead.com/forever/npc=258043/norric-lochthane
            [npcKeys.name] = "Norric Lochthane",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[38] = {{41.8, 19}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [npcKeys.questStarts] = {94495, 94502, 94616},
            [npcKeys.questEnds] = {86667, 94494, 94501, 94505, 94616},
            [npcKeys.friendlyToFaction] = "A",
        },
        [258048] = { -- Jom-jom : https://wowhead.com/forever/npc=258048/jom-jom
            [npcKeys.name] = "Jom-jom",
        },
        [258049] = { -- Al'Aketh Turncoat : https://wowhead.com/forever/npc=258049/alaketh-turncoat
            [npcKeys.name] = "Al'Aketh Turncoat",
        },
        [258088] = { -- Irna Kindlevein : https://wowhead.com/forever/npc=258088/irna-kindlevein
            [npcKeys.name] = "Irna Kindlevein",
        },
        [258098] = { -- Eldrun Stormbreaker : https://wowhead.com/forever/npc=258098/eldrun-stormbreaker
            [npcKeys.name] = "Eldrun Stormbreaker",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1537] = {{46.2, 13}, {46.4, 12.4}, {47, 13.4}, {47.2, 12.2}, {47.4, 13.6}, {47.6, 13.4}, {47.6, 13.6}, {47.6, 14.8}, {47.8, 12.4}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.questStarts] = {94449, 94494},
            [npcKeys.questEnds] = {97263},
            [npcKeys.friendlyToFaction] = "A",
        },
        [258113] = { -- Ingrid Dunwald : https://wowhead.com/forever/npc=258113/ingrid-dunwald
            [npcKeys.name] = "Ingrid Dunwald",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1] = {{47.4, 52}, {47.6, 52}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.questStarts] = {94449},
            [npcKeys.friendlyToFaction] = "A",
        },
        [258130] = { -- Jorel Windsinger : https://wowhead.com/forever/npc=258130/jorel-windsinger
            [npcKeys.name] = "Jorel Windsinger",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.4, 34.4}, {64.4, 34.6}, {64.6, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258133] = { -- Naanel Shadowfoot : https://wowhead.com/forever/npc=258133/naanel-shadowfoot
            [npcKeys.name] = "Naanel Shadowfoot",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.6, 35}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258134] = { -- Naaleos Leafwhisper : https://wowhead.com/forever/npc=258134/naaleos-leafwhisper
            [npcKeys.name] = "Naaleos Leafwhisper",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.8, 34.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258135] = { -- Falleeah Gustrunner : https://wowhead.com/forever/npc=258135/falleeah-gustrunner
            [npcKeys.name] = "Falleeah Gustrunner",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.8, 34.8}, {64.2, 34.2}, {64.6, 34.4}, {65.2, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258136] = { -- Hyneena Fiercefang : https://wowhead.com/forever/npc=258136/hyneena-fiercefang
            [npcKeys.name] = "Hyneena Fiercefang",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.6, 36.2}, {63.8, 36.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258137] = { -- Telenos <br />Leafwhisper : https://wowhead.com/forever/npc=258137/telenos-leafwhisper
            [npcKeys.name] = "Telenos <br />Leafwhisper",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.6, 35}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258138] = { -- Nayeela Snarlfang : https://wowhead.com/forever/npc=258138/nayeela-snarlfang
            [npcKeys.name] = "Nayeela Snarlfang",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.4, 34.8}, {64.6, 34.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258139] = { -- Frothrik Saegrund : https://wowhead.com/forever/npc=258139/frothrik-saegrund
            [npcKeys.name] = "Frothrik Saegrund",
            [npcKeys.spawns] = {[11] = {{65.8, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [258203] = { -- Hervdana Saegrund : https://wowhead.com/forever/npc=258203/hervdana-saegrund
            [npcKeys.name] = "Hervdana Saegrund",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[11] = {{65.6, 76.4}, {65.8, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
            [npcKeys.questStarts] = {94497, 94499, 94500, 94501},
            [npcKeys.questEnds] = {94495, 94497, 94499, 94500},
            [npcKeys.friendlyToFaction] = "A",
        },
        [258239] = { -- Maelgwyn <br />Shadowtale : https://wowhead.com/forever/npc=258239/maelgwyn-shadowtale
            [npcKeys.name] = "Maelgwyn <br />Shadowtale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.6, 36}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258253] = { -- Kaena Swiftpaw : https://wowhead.com/forever/npc=258253/kaena-swiftpaw
            [npcKeys.name] = "Kaena Swiftpaw",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.4, 30.6}, {64.4, 34}, {64.4, 34.6}, {64.6, 31.4}, {64.6, 34.4}, {64.6, 34.6}, {64.8, 30.2}, {64.8, 32}, {65, 32.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258260] = { -- Thylonell Bitterwind : https://wowhead.com/forever/npc=258260/thylonell-bitterwind
            [npcKeys.name] = "Thylonell Bitterwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65, 31.6}, {65.2, 31.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258267] = { -- Mithraless Sterngale : https://wowhead.com/forever/npc=258267/mithraless-sterngale
            [npcKeys.name] = "Mithraless Sterngale",
        },
        [258272] = { -- Maeleneth <br />Barrowbrother : https://wowhead.com/forever/npc=258272/maeleneth-barrowbrother
            [npcKeys.name] = "Maeleneth <br />Barrowbrother",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64, 32}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258275] = { -- Neyasteel Mossmender : https://wowhead.com/forever/npc=258275/neyasteel-mossmender
            [npcKeys.name] = "Neyasteel Mossmender",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64, 32}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258277] = { -- Bryaes Galechaser : https://wowhead.com/forever/npc=258277/bryaes-galechaser
            [npcKeys.name] = "Bryaes Galechaser",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.4, 31.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258279] = { -- Beyaa Gustbellow : https://wowhead.com/forever/npc=258279/beyaa-gustbellow
            [npcKeys.name] = "Beyaa Gustbellow",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.6, 33}, {64, 32}, {64, 34}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258282] = { -- Maeyeen Brightfeather : https://wowhead.com/forever/npc=258282/maeyeen-brightfeather
            [npcKeys.name] = "Maeyeen Brightfeather",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{63.4, 36.4}, {63.6, 36.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258284] = { -- Holaan Glenprancer : https://wowhead.com/forever/npc=258284/holaan-glenprancer
            [npcKeys.name] = "Holaan Glenprancer",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.2, 31.4}, {65.2, 31.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258288] = { -- Mithraless Sterngale : https://wowhead.com/forever/npc=258288/mithraless-sterngale
            [npcKeys.name] = "Mithraless Sterngale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.8, 32.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258289] = { -- Baeo Sharpstrike : https://wowhead.com/forever/npc=258289/baeo-sharpstrike
            [npcKeys.name] = "Baeo Sharpstrike",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.8, 33.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258294] = { -- Eelitha Fernstep : https://wowhead.com/forever/npc=258294/eelitha-fernstep
            [npcKeys.name] = "Eelitha Fernstep",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.2, 31.4}, {65.2, 31.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258295] = { -- Arnorea Shadowfoot : https://wowhead.com/forever/npc=258295/arnorea-shadowfoot
            [npcKeys.name] = "Arnorea Shadowfoot",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.2, 31.4}, {65.2, 31.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258302] = { -- Sita Tivashal : https://wowhead.com/forever/npc=258302/sita-tivashal
            [npcKeys.name] = "Sita Tivashal",
        },
        [258303] = { -- Kyridel Truline : https://wowhead.com/forever/npc=258303/kyridel-truline
            [npcKeys.name] = "Kyridel Truline",
        },
        [258306] = { -- Granny Finespindle : https://wowhead.com/forever/npc=258306/granny-finespindle
            [npcKeys.name] = "Granny Finespindle",
            [npcKeys.minLevel] = 24,
            [npcKeys.maxLevel] = 24,
            [npcKeys.spawns] = {[1537] = {{39, 32.4}, {39.2, 33.4}, {39.2, 33.6}, {39.6, 33.4}, {39.8, 32.4}, {39.8, 34}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258316] = { -- Farholde Scout : https://wowhead.com/forever/npc=258316/farholde-scout
            [npcKeys.name] = "Farholde Scout",
        },
        [258317] = { -- Benjy Wheeler : https://wowhead.com/forever/npc=258317/benjy-wheeler
            [npcKeys.name] = "Benjy Wheeler",
            [npcKeys.spawns] = {[16591] = {{55, 72.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258326] = { -- Peacekeeper Elite : https://wowhead.com/forever/npc=258326/peacekeeper-elite
            [npcKeys.name] = "Peacekeeper Elite",
        },
        [258331] = { -- Young Paletusk : https://wowhead.com/forever/npc=258331/young-paletusk
            [npcKeys.name] = "Young Paletusk",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 37,
            [npcKeys.spawns] = {[16591] = {{24.8, 64.4}, {26.6, 62.8}, {27.6, 60.4}, {31.8, 37.6}, {53.2, 77.6}, {56.4, 73.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258335] = { -- Arondis : https://wowhead.com/forever/npc=258335/arondis
            [npcKeys.name] = "Arondis",
        },
        [258339] = { -- Kelly Tanner : https://wowhead.com/forever/npc=258339/kelly-tanner
            [npcKeys.name] = "Kelly Tanner",
        },
        [258349] = { -- Kora : https://wowhead.com/forever/npc=258349/kora
            [npcKeys.name] = "Kora",
        },
        [258352] = { -- Ola : https://wowhead.com/forever/npc=258352/ola
            [npcKeys.name] = "Ola",
        },
        [258371] = { -- Thena Moore : https://wowhead.com/forever/npc=258371/thena-moore
            [npcKeys.name] = "Thena Moore",
        },
        [258380] = { -- Caitir Flinthew : https://wowhead.com/forever/npc=258380/caitir-flinthew
            [npcKeys.name] = "Caitir Flinthew",
            [npcKeys.spawns] = {[616] = {{15.6, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258403] = { -- Jasmine Van Brunt : https://wowhead.com/forever/npc=258403/jasmine-van-brunt
            [npcKeys.name] = "Jasmine Van Brunt",
        },
        [258415] = { -- Angela Ward : https://wowhead.com/forever/npc=258415/angela-ward
            [npcKeys.name] = "Angela Ward",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1497] = {{70.4, 29.4}, {70.4, 29.8}, {70.6, 29.4}, {70.6, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.friendlyToFaction] = "H",
        },
        [258443] = { -- Ur'endra : https://wowhead.com/forever/npc=258443/urendra
            [npcKeys.name] = "Ur'endra",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{53.4, 64.8}, {54, 65.4}, {54.2, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [258445] = { -- Sadie Bizniz : https://wowhead.com/forever/npc=258445/sadie-bizniz
            [npcKeys.name] = "Sadie Bizniz",
        },
        [258451] = { -- Derek Spark : https://wowhead.com/forever/npc=258451/derek-spark
            [npcKeys.name] = "Derek Spark",
        },
        [258452] = { -- Aldo Bizniz : https://wowhead.com/forever/npc=258452/aldo-bizniz
            [npcKeys.name] = "Aldo Bizniz",
        },
        [258453] = { -- Sofia Bizniz : https://wowhead.com/forever/npc=258453/sofia-bizniz
            [npcKeys.name] = "Sofia Bizniz",
        },
        [258454] = { -- Danny Bizniz : https://wowhead.com/forever/npc=258454/danny-bizniz
            [npcKeys.name] = "Danny Bizniz",
        },
        [258455] = { -- Jazz Bizniz : https://wowhead.com/forever/npc=258455/jazz-bizniz
            [npcKeys.name] = "Jazz Bizniz",
        },
        [258456] = { -- Donna Bizniz : https://wowhead.com/forever/npc=258456/donna-bizniz
            [npcKeys.name] = "Donna Bizniz",
        },
        [258457] = { -- Darryl Spark : https://wowhead.com/forever/npc=258457/darryl-spark
            [npcKeys.name] = "Darryl Spark",
        },
        [258458] = { -- Slain Fledgling : https://wowhead.com/forever/npc=258458/slain-fledgling
            [npcKeys.name] = "Slain Fledgling",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{54.2, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [258459] = { -- Trey Spark : https://wowhead.com/forever/npc=258459/trey-spark
            [npcKeys.name] = "Trey Spark",
        },
        [258460] = { -- Tina Spark : https://wowhead.com/forever/npc=258460/tina-spark
            [npcKeys.name] = "Tina Spark",
        },
        [258461] = { -- Dora Spark : https://wowhead.com/forever/npc=258461/dora-spark
            [npcKeys.name] = "Dora Spark",
        },
        [258462] = { -- Zixi Spark : https://wowhead.com/forever/npc=258462/zixi-spark
            [npcKeys.name] = "Zixi Spark",
        },
        [258463] = { -- Darah : https://wowhead.com/forever/npc=258463/darah
            [npcKeys.name] = "Darah",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[1637] = {{63.4, 50.4}, {63.4, 50.6}, {63.6, 50.4}, {63.6, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [258464] = { -- Bettana : https://wowhead.com/forever/npc=258464/bettana
            [npcKeys.name] = "Bettana",
        },
        [258465] = { -- Hana Stonehoof : https://wowhead.com/forever/npc=258465/hana-stonehoof
            [npcKeys.name] = "Hana Stonehoof",
        },
        [258466] = { -- Boramu : https://wowhead.com/forever/npc=258466/boramu
            [npcKeys.name] = "Boramu",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1638] = {{44, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [npcKeys.friendlyToFaction] = "H",
        },
        [258491] = { -- Kronk : https://wowhead.com/forever/npc=258491/kronk
            [npcKeys.name] = "Kronk",
        },
        [258522] = { -- Sootfur : https://wowhead.com/forever/npc=258522/sootfur
            [npcKeys.name] = "Sootfur",
        },
        [258546] = { -- Heidi Deepforge : https://wowhead.com/forever/npc=258546/heidi-deepforge
            [npcKeys.name] = "Heidi Deepforge",
        },
        [258548] = { -- Ellie Stonebrow : https://wowhead.com/forever/npc=258548/ellie-stonebrow
            [npcKeys.name] = "Ellie Stonebrow",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1537] = {{43.4, 27.4}, {43.4, 27.8}, {43.6, 27.8}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258553] = { -- Peacebloom : https://wowhead.com/forever/npc=258553/peacebloom
            [npcKeys.name] = "Peacebloom",
        },
        [258568] = { -- Antonio Bolero : https://wowhead.com/forever/npc=258568/antonio-bolero
            [npcKeys.name] = "Antonio Bolero",
            [npcKeys.minLevel] = 31,
            [npcKeys.maxLevel] = 31,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258570] = { -- Da'grosh : https://wowhead.com/forever/npc=258570/dagrosh
            [npcKeys.name] = "Da'grosh",
        },
        [258571] = { -- Therbor Deepforge : https://wowhead.com/forever/npc=258571/therbor-deepforge
            [npcKeys.name] = "Therbor Deepforge",
        },
        [258572] = { -- Dani'ill : https://wowhead.com/forever/npc=258572/daniill
            [npcKeys.name] = "Dani'ill",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[1657] = {{64, 21.2}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258573] = { -- Mudfin Oracle : https://wowhead.com/forever/npc=258573/mudfin-oracle
            [npcKeys.name] = "Mudfin Oracle",
        },
        [258574] = { -- Mudfin Warrior : https://wowhead.com/forever/npc=258574/mudfin-warrior
            [npcKeys.name] = "Mudfin Warrior",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258576] = { -- Dolgan Steelhand : https://wowhead.com/forever/npc=258576/dolgan-steelhand
            [npcKeys.name] = "Dolgan Steelhand",
        },
        [258588] = { -- Jumbo Crawfish : https://wowhead.com/forever/npc=258588/jumbo-crawfish
            [npcKeys.name] = "Jumbo Crawfish",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{42.8, 51}, {53.4, 68.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258595] = { -- Snufflesnout : https://wowhead.com/forever/npc=258595/snufflesnout
            [npcKeys.name] = "Snufflesnout",
        },
        [258617] = { -- Snort : https://wowhead.com/forever/npc=258617/snort
            [npcKeys.name] = "Snort",
        },
        [258626] = { -- Mog'thar : https://wowhead.com/forever/npc=258626/mogthar
            [npcKeys.name] = "Mog'thar",
        },
        [258652] = { -- Twilight Thrall : https://wowhead.com/forever/npc=258652/twilight-thrall
            [npcKeys.name] = "Twilight Thrall",
        },
        [258657] = { -- "Lucky" Lazzo Shortshot : https://wowhead.com/forever/npc=258657/lucky-lazzo-shortshot
            [npcKeys.name] = "\"Lucky\" Lazzo Shortshot",
        },
        [258661] = { -- Minor Manifestation of Water : https://wowhead.com/forever/npc=258661/minor-manifestation-of-water
            [npcKeys.name] = "Minor Manifestation of Water",
        },
        [258686] = { -- Farholde Lookout : https://wowhead.com/forever/npc=258686/farholde-lookout
            [npcKeys.name] = "Farholde Lookout",
            [npcKeys.minLevel] = 46,
            [npcKeys.maxLevel] = 46,
            [npcKeys.spawns] = {[16591] = {{28.8, 49.6}, {29, 49.2}, {30, 48.8}, {30.8, 47.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258697] = { -- Farmer Elbrim : https://wowhead.com/forever/npc=258697/farmer-elbrim
            [npcKeys.name] = "Farmer Elbrim",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258785] = { -- High Priestess Mims : https://wowhead.com/forever/npc=258785/high-priestess-mims
            [npcKeys.name] = "High Priestess Mims",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1537] = {{24.8, 10}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.questStarts] = {94817},
            [npcKeys.questEnds] = {94817, 94819, 94822, 94824},
            [npcKeys.friendlyToFaction] = "A",
        },
        [258873] = { -- Vendor : https://wowhead.com/forever/npc=258873/vendor
            [npcKeys.name] = "Vendor",
        },
        [258878] = { -- Auctioneer Quickcoin : https://wowhead.com/forever/npc=258878/auctioneer-quickcoin
            [npcKeys.name] = "Auctioneer Quickcoin",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[17] = {{49.8, 29.4}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258879] = { -- Steamwheedle Courier : https://wowhead.com/forever/npc=258879/steamwheedle-courier
            [npcKeys.name] = "Steamwheedle Courier",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[17] = {{49.8, 29.4}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258880] = { -- Uninspected Shipment : https://wowhead.com/forever/npc=258880/uninspected-shipment
            [npcKeys.name] = "Uninspected Shipment",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[17] = {{49.8, 29.4}}},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [258906] = { -- [DNT] Kill Credit: Loose Soil : https://wowhead.com/forever/npc=258906/dnt-kill-credit-loose-soil
            [npcKeys.name] = "[DNT] Kill Credit: Loose Soil",
        },
        [258908] = { -- Noruu : https://wowhead.com/forever/npc=258908/noruu
            [npcKeys.name] = "Noruu",
            [npcKeys.spawns] = {[616] = {{68.6, 50.4}, {69, 51}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [258912] = { -- Elaren Stargrove : https://wowhead.com/forever/npc=258912/elaren-stargrove
            [npcKeys.name] = "Elaren Stargrove",
            [npcKeys.spawns] = {[493] = {{66.8, 58.8}, {66.8, 59.6}}},
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [258921] = { -- Volunteer Lumberjack : https://wowhead.com/forever/npc=258921/volunteer-lumberjack
            [npcKeys.name] = "Volunteer Lumberjack",
        },
        [258922] = { -- Hungry Crocolisk : https://wowhead.com/forever/npc=258922/hungry-crocolisk
            [npcKeys.name] = "Hungry Crocolisk",
        },
        [258930] = { -- Isaac Chan : https://wowhead.com/forever/npc=258930/isaac-chan
            [npcKeys.name] = "Isaac Chan",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[12] = {{41.8, 66.4}, {41.8, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questEnds] = {94793},
            [npcKeys.friendlyToFaction] = "A",
        },
        [258934] = { -- Reason : https://wowhead.com/forever/npc=258934/reason
            [npcKeys.name] = "Reason",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[12] = {{41.8, 66.4}, {42, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.friendlyToFaction] = "A",
        },
        [258935] = { -- Curly : https://wowhead.com/forever/npc=258935/curly
            [npcKeys.name] = "Curly",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258963] = { -- Hurley : https://wowhead.com/forever/npc=258963/hurley
            [npcKeys.name] = "Hurley",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [258973] = { -- [DNT] Kill Credit: Slumbering Druid Communed with : https://wowhead.com/forever/npc=258973/dnt-kill-credit-slumbering-druid-communed-with
            [npcKeys.name] = "[DNT] Kill Credit: Slumbering Druid Communed with",
        },
        [258976] = { -- Slumbering Druid : https://wowhead.com/forever/npc=258976/slumbering-druid
            [npcKeys.name] = "Slumbering Druid",
        },
        [259003] = { -- Terry Lawrence : https://wowhead.com/forever/npc=259003/terry-lawrence
            [npcKeys.name] = "Terry Lawrence",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [259004] = { -- Wind Spirit (Ghost Visual Only) : https://wowhead.com/forever/npc=259004/wind-spirit-ghost-visual-only
            [npcKeys.name] = "Wind Spirit (Ghost Visual Only)",
        },
        [259005] = { -- Gustjumper : https://wowhead.com/forever/npc=259005/gustjumper
            [npcKeys.name] = "Gustjumper",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{51.2, 71.4}, {51.2, 71.6}, {51.4, 69.2}, {51.4, 69.8}, {51.6, 69.2}, {51.8, 70.4}, {52, 71.4}, {52, 73}, {52.2, 73.8}, {52.4, 71.6}, {53, 77.4}, {53.2, 79.4}, {53.4, 76.4}, {53.8, 76.4}, {53.8, 79}, {54, 77.2}, {54.4, 79.8}, {54.6, 77.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [259006] = { -- Musical Gustjumper : https://wowhead.com/forever/npc=259006/musical-gustjumper
            [npcKeys.name] = "Musical Gustjumper",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{51.4, 72.2}, {51.6, 72.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [259011] = { -- Ban'aethal Refugee : https://wowhead.com/forever/npc=259011/banaethal-refugee
            [npcKeys.name] = "Ban'aethal Refugee",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{61, 76}, {65.4, 73.2}, {65.4, 73.6}, {65.6, 73.4}, {66, 74.4}, {66, 74.6}, {68.2, 74.4}, {68.4, 74.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [259012] = { -- Ealaane Nimbuswalker : https://wowhead.com/forever/npc=259012/ealaane-nimbuswalker
            [npcKeys.name] = "Ealaane Nimbuswalker",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.8, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {94896, 94897},
            [npcKeys.questEnds] = {94896, 94897},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [259013] = { -- Resaan Nimbuswalker : https://wowhead.com/forever/npc=259013/resaan-nimbuswalker
            [npcKeys.name] = "Resaan Nimbuswalker",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57, 29.4}, {57, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [259021] = { -- Zavirax : https://wowhead.com/forever/npc=259021/zavirax
            [npcKeys.name] = "Zavirax",
        },
        [259023] = { -- Veyric Thunderhame : https://wowhead.com/forever/npc=259023/veyric-thunderhame
            [npcKeys.name] = "Veyric Thunderhame",
            [npcKeys.zoneID] = zoneIDs.ARATHI_HIGHLANDS,
        },
        [259034] = { -- [DNT] Kill Credit: Bough cleansed : https://wowhead.com/forever/npc=259034/dnt-kill-credit-bough-cleansed
            [npcKeys.name] = "[DNT] Kill Credit: Bough cleansed",
        },
        [259046] = { -- Freshwater Crocolisk : https://wowhead.com/forever/npc=259046/freshwater-crocolisk
            [npcKeys.name] = "Freshwater Crocolisk",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{58.8, 43.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259049] = { -- Robbie Holmsby : https://wowhead.com/forever/npc=259049/robbie-holmsby
            [npcKeys.name] = "Robbie Holmsby",
            [npcKeys.spawns] = {[16591] = {{43.4, 82.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259050] = { -- Eleanor Holmsby : https://wowhead.com/forever/npc=259050/eleanor-holmsby
            [npcKeys.name] = "Eleanor Holmsby",
            [npcKeys.spawns] = {[16591] = {{43.4, 82.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259051] = { -- Watcher Fredericks : https://wowhead.com/forever/npc=259051/watcher-fredericks
            [npcKeys.name] = "Watcher Fredericks",
        },
        [259052] = { -- Rog'mar Poacher : https://wowhead.com/forever/npc=259052/rogmar-poacher
            [npcKeys.name] = "Rog'mar Poacher",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{54.2, 55.8}, {56.6, 63}, {58.2, 50.4}, {58.4, 61}, {64.8, 49}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [259054] = { -- Wildplains Patriarch : https://wowhead.com/forever/npc=259054/wildplains-patriarch
            [npcKeys.name] = "Wildplains Patriarch",
        },
        [259055] = { -- Wildplains Huntress : https://wowhead.com/forever/npc=259055/wildplains-huntress
            [npcKeys.name] = "Wildplains Huntress",
        },
        [259056] = { -- Komuk : https://wowhead.com/forever/npc=259056/komuk
            [npcKeys.name] = "Komuk",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
        },
        [259057] = { -- Dunston Willis : https://wowhead.com/forever/npc=259057/dunston-willis
            [npcKeys.name] = "Dunston Willis",
            [npcKeys.spawns] = {[16591] = {{68.6, 12.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259058] = { -- Windshaper Shaman : https://wowhead.com/forever/npc=259058/windshaper-shaman
            [npcKeys.name] = "Windshaper Shaman",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58.2, 79.2}, {58.8, 79.4}, {59, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [259060] = { -- High Order Mage : https://wowhead.com/forever/npc=259060/high-order-mage
            [npcKeys.name] = "High Order Mage",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.6, 80.8}, {65.4, 79.2}, {65.6, 79.2}, {66, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259084] = { -- Denaaris Stargale : https://wowhead.com/forever/npc=259084/denaaris-stargale
            [npcKeys.name] = "Denaaris Stargale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[36] = {{12.2, 56.6}, {12.4, 56.2}, {12.6, 56}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.questStarts] = {94947},
            [npcKeys.questEnds] = {94946},
            [npcKeys.friendlyToFaction] = "A",
        },
        [259093] = { -- Hallin : https://wowhead.com/forever/npc=259093/hallin
            [npcKeys.name] = "Hallin",
        },
        [259094] = { -- Riding Gryphon : https://wowhead.com/forever/npc=259094/riding-gryphon
            [npcKeys.name] = "Riding Gryphon",
        },
        [259096] = { -- Cenarion Warden : https://wowhead.com/forever/npc=259096/cenarion-warden
            [npcKeys.name] = "Cenarion Warden",
            [npcKeys.spawns] = {[493] = {{68.4, 54.4}, {69.4, 54.8}}},
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [259102] = { -- Gurgthock : https://wowhead.com/forever/npc=259102/gurgthock
            [npcKeys.name] = "Gurgthock",
        },
        [259118] = { -- Muln Earthfury : https://wowhead.com/forever/npc=259118/muln-earthfury
            [npcKeys.name] = "Muln Earthfury",
            [npcKeys.minLevel] = 9999,
            [npcKeys.maxLevel] = 9999,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {94911},
            [npcKeys.friendlyToFaction] = "H",
        },
        [259119] = { -- Alaana Stormwalker : https://wowhead.com/forever/npc=259119/alaana-stormwalker
            [npcKeys.name] = "Alaana Stormwalker",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {95350},
            [npcKeys.questEnds] = {95349},
            [npcKeys.friendlyToFaction] = "H",
        },
        [259158] = { -- Fuzzle : https://wowhead.com/forever/npc=259158/fuzzle
            [npcKeys.name] = "Fuzzle",
        },
        [259175] = { -- Docile Galestrider : https://wowhead.com/forever/npc=259175/docile-galestrider
            [npcKeys.name] = "Docile Galestrider",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{61.4, 76.2}, {61.6, 76.2}, {61.6, 76.6}, {63.4, 74.4}, {63.4, 75.2}, {64, 74.2}, {64.6, 73.6}, {65.2, 73.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [259177] = { -- Gom'rok : https://wowhead.com/forever/npc=259177/gomrok
            [npcKeys.name] = "Gom'rok",
        },
        [259178] = { -- Nimblarg : https://wowhead.com/forever/npc=259178/nimblarg
            [npcKeys.name] = "Nimblarg",
        },
        [259179] = { -- Redridge Thug : https://wowhead.com/forever/npc=259179/redridge-thug
            [npcKeys.name] = "Redridge Thug",
        },
        [259189] = { -- Riding Horse (Warhorse) : https://wowhead.com/forever/npc=259189/riding-horse-warhorse
            [npcKeys.name] = "Riding Horse (Warhorse)",
        },
        [259190] = { -- Ephram Barbaro : https://wowhead.com/forever/npc=259190/ephram-barbaro
            [npcKeys.name] = "Ephram Barbaro",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{20.2, 46.4}, {20.2, 46.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {99153},
            [npcKeys.questEnds] = {99153},
            [npcKeys.friendlyToFaction] = "H",
        },
        [259198] = { -- Silverleaf : https://wowhead.com/forever/npc=259198/silverleaf
            [npcKeys.name] = "Silverleaf",
        },
        [259199] = { -- Earthroot : https://wowhead.com/forever/npc=259199/earthroot
            [npcKeys.name] = "Earthroot",
        },
        [259200] = { -- Mageroyal : https://wowhead.com/forever/npc=259200/mageroyal
            [npcKeys.name] = "Mageroyal",
        },
        [259201] = { -- Briarthorn : https://wowhead.com/forever/npc=259201/briarthorn
            [npcKeys.name] = "Briarthorn",
        },
        [259202] = { -- Bruiseweed : https://wowhead.com/forever/npc=259202/bruiseweed
            [npcKeys.name] = "Bruiseweed",
        },
        [259206] = { -- Wild Steelbloom : https://wowhead.com/forever/npc=259206/wild-steelbloom
            [npcKeys.name] = "Wild Steelbloom",
        },
        [259207] = { -- Kingsblood : https://wowhead.com/forever/npc=259207/kingsblood
            [npcKeys.name] = "Kingsblood",
        },
        [259208] = { -- Grave Moss : https://wowhead.com/forever/npc=259208/grave-moss
            [npcKeys.name] = "Grave Moss",
        },
        [259209] = { -- Copper Vein : https://wowhead.com/forever/npc=259209/copper-vein
            [npcKeys.name] = "Copper Vein",
        },
        [259210] = { -- Tin Vein : https://wowhead.com/forever/npc=259210/tin-vein
            [npcKeys.name] = "Tin Vein",
        },
        [259211] = { -- Iron Deposit : https://wowhead.com/forever/npc=259211/iron-deposit
            [npcKeys.name] = "Iron Deposit",
        },
        [259219] = { -- Herb Garden : https://wowhead.com/forever/npc=259219/herb-garden
            [npcKeys.name] = "Herb Garden",
        },
        [259224] = { -- Rock Garden : https://wowhead.com/forever/npc=259224/rock-garden
            [npcKeys.name] = "Rock Garden",
        },
        [259232] = { -- Slumbering Druid : https://wowhead.com/forever/npc=259232/slumbering-druid
            [npcKeys.name] = "Slumbering Druid",
        },
        [259233] = { -- Slumbering Druid : https://wowhead.com/forever/npc=259233/slumbering-druid
            [npcKeys.name] = "Slumbering Druid",
        },
        [259234] = { -- Slumbering Druid : https://wowhead.com/forever/npc=259234/slumbering-druid
            [npcKeys.name] = "Slumbering Druid",
        },
        [259235] = { -- Slumbering Druid : https://wowhead.com/forever/npc=259235/slumbering-druid
            [npcKeys.name] = "Slumbering Druid",
        },
        [259236] = { -- Slumbering Druid : https://wowhead.com/forever/npc=259236/slumbering-druid
            [npcKeys.name] = "Slumbering Druid",
            [npcKeys.spawns] = {[493] = {{72.8, 49}}},
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [259250] = { -- Alphonse Dumas : https://wowhead.com/forever/npc=259250/alphonse-dumas
            [npcKeys.name] = "Alphonse Dumas",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[16591] = {{64.4, 82}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259251] = { -- Emerald Dreamer : https://wowhead.com/forever/npc=259251/emerald-dreamer
            [npcKeys.name] = "Emerald Dreamer",
        },
        [259254] = { -- Lost Horse : https://wowhead.com/forever/npc=259254/lost-horse
            [npcKeys.name] = "Lost Horse",
        },
        [259258] = { -- Converted Farmer : https://wowhead.com/forever/npc=259258/converted-farmer
            [npcKeys.name] = "Converted Farmer",
        },
        [259263] = { -- Coyote Prowler : https://wowhead.com/forever/npc=259263/coyote-prowler
            [npcKeys.name] = "Coyote Prowler",
        },
        [259266] = { -- Fiendish Imp : https://wowhead.com/forever/npc=259266/fiendish-imp
            [npcKeys.name] = "Fiendish Imp",
        },
        [259267] = { -- Plains Coyote : https://wowhead.com/forever/npc=259267/plains-coyote
            [npcKeys.name] = "Plains Coyote",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 36,
            [npcKeys.spawns] = {[16591] = {{49, 83.6}, {52.4, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259269] = { -- High Plains Buzzard : https://wowhead.com/forever/npc=259269/high-plains-buzzard
            [npcKeys.name] = "High Plains Buzzard",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 39,
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259287] = { -- Melanie Sable : https://wowhead.com/forever/npc=259287/melanie-sable
            [npcKeys.name] = "Melanie Sable",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{66.2, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259288] = { -- Hyjal Dryad : https://wowhead.com/forever/npc=259288/hyjal-dryad
            [npcKeys.name] = "Hyjal Dryad",
        },
        [259352] = { -- Watcher Cornelius : https://wowhead.com/forever/npc=259352/watcher-cornelius
            [npcKeys.name] = "Watcher Cornelius",
            [npcKeys.spawns] = {[16591] = {{59.4, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259353] = { -- Cedric Dalton : https://wowhead.com/forever/npc=259353/cedric-dalton
            [npcKeys.name] = "Cedric Dalton",
            [npcKeys.spawns] = {[16591] = {{39.4, 74.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259358] = { -- Treant : https://wowhead.com/forever/npc=259358/treant
            [npcKeys.name] = "Treant",
            [npcKeys.spawns] = {[616] = {{54, 84}, {55, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [259363] = { -- Sapling : https://wowhead.com/forever/npc=259363/sapling
            [npcKeys.name] = "Sapling",
        },
        [259377] = { -- Injured Deathguard : https://wowhead.com/forever/npc=259377/injured-deathguard
            [npcKeys.name] = "Injured Deathguard",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{30, 63.8}, {31.4, 63}, {31.4, 64.6}, {31.4, 66}, {31.4, 66.6}, {31.6, 64.4}, {31.6, 64.8}, {31.6, 65.6}, {32, 62.2}, {32.4, 63.4}, {32.6, 63.4}, {32.6, 64.8}, {32.8, 62}, {33.4, 63.6}, {33.6, 63.4}, {33.6, 63.6}, {33.6, 64.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [259385] = { -- Tel'daeor the Stormspeaker : https://wowhead.com/forever/npc=259385/teldaeor-the-stormspeaker
            [npcKeys.name] = "Tel'daeor the Stormspeaker",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{66, 53}, {66, 53.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [259388] = { -- Mystmane : https://wowhead.com/forever/npc=259388/mystmane
            [npcKeys.name] = "Mystmane",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{57.6, 37}, {58, 38}, {59.2, 37.6}, {60.2, 34.6}, {60.2, 36.8}, {60.2, 37.8}, {60.4, 36.2}, {60.8, 35.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [259390] = { -- Farholde Laborer : https://wowhead.com/forever/npc=259390/farholde-laborer
            [npcKeys.name] = "Farholde Laborer",
        },
        [259394] = { -- Snapbeak the Quick : https://wowhead.com/forever/npc=259394/snapbeak-the-quick
            [npcKeys.name] = "Snapbeak the Quick",
            [npcKeys.spawns] = {[16593] = {{34.2, 60}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [259398] = { -- Galemender Delanea : https://wowhead.com/forever/npc=259398/galemender-delanea
            [npcKeys.name] = "Galemender Delanea",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[16593] = {{62.4, 62}, {63.2, 62.6}, {63.6, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [259430] = { -- Thief : https://wowhead.com/forever/npc=259430/thief
            [npcKeys.name] = "Thief",
        },
        [259431] = { -- Rudolph Gelhardt : https://wowhead.com/forever/npc=259431/rudolph-gelhardt
            [npcKeys.name] = "Rudolph Gelhardt",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{11.4, 64.2}, {11.6, 64.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [259433] = { -- Tarnished Zealot : https://wowhead.com/forever/npc=259433/tarnished-zealot
            [npcKeys.name] = "Tarnished Zealot",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[85] = {{10.4, 63.2}, {10.8, 62.4}, {11, 61.4}, {11, 62.8}, {11.2, 60.2}, {11.4, 64.4}, {11.6, 64}, {11.8, 62}, {12, 60.8}, {12, 64.8}, {12.2, 63.2}, {12.4, 65.8}, {12.8, 61}, {12.8, 62}, {12.8, 64.8}, {13, 64}, {13, 65.6}, {13.4, 63}, {13.6, 67.2}, {13.8, 67.6}, {14, 63}, {14, 64.2}, {14, 66.2}, {14.2, 65}, {14.6, 65}, {14.8, 64.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [259434] = { -- Tarnished Drudge : https://wowhead.com/forever/npc=259434/tarnished-drudge
            [npcKeys.name] = "Tarnished Drudge",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[85] = {{10.8, 62.4}, {11, 63.2}, {11.2, 60.4}, {11.4, 61.2}, {11.4, 64.2}, {11.6, 61}, {11.6, 64.2}, {11.8, 62}, {12, 64.6}, {12.2, 63}, {12.4, 65.8}, {12.6, 64.6}, {12.8, 61}, {12.8, 61.8}, {13, 64.2}, {13, 65.6}, {13.2, 63.2}, {13.6, 67.4}, {13.8, 65.8}, {13.8, 67.6}, {14, 63}, {14, 64.2}, {14.2, 65}, {14.6, 64.6}, {14.8, 64}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [259463] = { -- Fiendish Imp : https://wowhead.com/forever/npc=259463/fiendish-imp
            [npcKeys.name] = "Fiendish Imp",
        },
        [259585] = { -- Master Mycologist Shurome : https://wowhead.com/forever/npc=259585/master-mycologist-shurome
            [npcKeys.name] = "Master Mycologist Shurome",
            [npcKeys.spawns] = {[361] = {{51.4, 82}}},
            [npcKeys.zoneID] = zoneIDs.FELWOOD,
        },
        [259595] = { -- Hacktooth : https://wowhead.com/forever/npc=259595/hacktooth
            [npcKeys.name] = "Hacktooth",
        },
        [259600] = { -- Fala Featherdark : https://wowhead.com/forever/npc=259600/fala-featherdark
            [npcKeys.name] = "Fala Featherdark",
        },
        [259611] = { -- Deathguard Baldren : https://wowhead.com/forever/npc=259611/deathguard-baldren
            [npcKeys.name] = "Deathguard Baldren",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[130] = {{45.8, 41.8}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.questStarts] = {91860},
            [npcKeys.questEnds] = {91859},
            [npcKeys.friendlyToFaction] = "H",
        },
        [259616] = { -- DNT KC 02 : https://wowhead.com/forever/npc=259616/dnt-kc-02
            [npcKeys.name] = "DNT KC 02",
        },
        [259620] = { -- Lumina Windsinger : https://wowhead.com/forever/npc=259620/lumina-windsinger
            [npcKeys.name] = "Lumina Windsinger",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[130] = {{43.2, 40.8}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.questStarts] = {95034, 95036, 95140},
            [npcKeys.questEnds] = {95034, 95140, 96204},
            [npcKeys.friendlyToFaction] = "H",
        },
        [259649] = { -- Ulric Frostveil : https://wowhead.com/forever/npc=259649/ulric-frostveil
            [npcKeys.name] = "Ulric Frostveil",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[331] = {{11.8, 34.4}}},
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
            [npcKeys.questStarts] = {95042},
            [npcKeys.questEnds] = {95042},
            [npcKeys.friendlyToFaction] = "H",
        },
        [259695] = { -- Renalard : https://wowhead.com/forever/npc=259695/renalard
            [npcKeys.name] = "Renalard",
            [npcKeys.spawns] = {[616] = {{59.8, 49}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [259758] = { -- Gul'gash : https://wowhead.com/forever/npc=259758/gulgash
            [npcKeys.name] = "Gul'gash",
        },
        [259766] = { -- Mika Darby : https://wowhead.com/forever/npc=259766/mika-darby
            [npcKeys.name] = "Mika Darby",
            [npcKeys.minLevel] = 44,
            [npcKeys.maxLevel] = 44,
            [npcKeys.spawns] = {[16591] = {{77.8, 52}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259776] = { -- Emerald Dreamer : https://wowhead.com/forever/npc=259776/emerald-dreamer
            [npcKeys.name] = "Emerald Dreamer",
        },
        [259782] = { -- Trip Vine : https://wowhead.com/forever/npc=259782/trip-vine
            [npcKeys.name] = "Trip Vine",
        },
        [259801] = { -- Mosh'gra : https://wowhead.com/forever/npc=259801/moshgra
            [npcKeys.name] = "Mosh'gra",
        },
        [259818] = { -- Ivory Galestrider : https://wowhead.com/forever/npc=259818/ivory-galestrider
            [npcKeys.name] = "Ivory Galestrider",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 2,
            [npcKeys.spawns] = {[16593] = {{58, 73.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259842] = { -- Musical Gustjumper : https://wowhead.com/forever/npc=259842/musical-gustjumper
            [npcKeys.name] = "Musical Gustjumper",
        },
        [259843] = { -- Musical Gustjumper : https://wowhead.com/forever/npc=259843/musical-gustjumper
            [npcKeys.name] = "Musical Gustjumper",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{51.4, 72.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [259852] = { -- Nightmare Fiend : https://wowhead.com/forever/npc=259852/nightmare-fiend
            [npcKeys.name] = "Nightmare Fiend",
        },
        [259857] = { -- Farholde Sentry : https://wowhead.com/forever/npc=259857/farholde-sentry
            [npcKeys.name] = "Farholde Sentry",
        },
        [259859] = { -- Wheatley : https://wowhead.com/forever/npc=259859/wheatley
            [npcKeys.name] = "Wheatley",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{63.6, 85}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259860] = { -- Martha Wellsworth : https://wowhead.com/forever/npc=259860/martha-wellsworth
            [npcKeys.name] = "Martha Wellsworth",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[16591] = {{64.2, 84}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259861] = { -- Paige Armstrong : https://wowhead.com/forever/npc=259861/paige-armstrong
            [npcKeys.name] = "Paige Armstrong",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{64.2, 82}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259863] = { -- Cassandra Wheeler : https://wowhead.com/forever/npc=259863/cassandra-wheeler
            [npcKeys.name] = "Cassandra Wheeler",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{64.6, 82.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259868] = { -- Shurome's Specimen : https://wowhead.com/forever/npc=259868/shuromes-specimen
            [npcKeys.name] = "Shurome's Specimen",
        },
        [259869] = { -- Mushroom : https://wowhead.com/forever/npc=259869/mushroom
            [npcKeys.name] = "Mushroom",
        },
        [259874] = { -- Deadwood Warden : https://wowhead.com/forever/npc=259874/deadwood-warden
            [npcKeys.name] = "Deadwood Warden",
        },
        [259875] = { -- Chieftain Deeproar : https://wowhead.com/forever/npc=259875/chieftain-deeproar
            [npcKeys.name] = "Chieftain Deeproar",
        },
        [259876] = { -- Deadwood Death Mystic : https://wowhead.com/forever/npc=259876/deadwood-death-mystic
            [npcKeys.name] = "Deadwood Death Mystic",
        },
        [259887] = { -- [DNT] Kill Credit: Mycelium network calibrated : https://wowhead.com/forever/npc=259887/dnt-kill-credit-mycelium-network-calibrated
            [npcKeys.name] = "[DNT] Kill Credit: Mycelium network calibrated",
        },
        [259897] = { -- Old Fire-Eye : https://wowhead.com/forever/npc=259897/old-fire-eye
            [npcKeys.name] = "Old Fire-Eye",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[130] = {{49, 88.4}, {49.4, 87.2}, {49.6, 87.2}, {50.4, 87.6}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
        },
        [259900] = { -- Hadurk Mendelsen : https://wowhead.com/forever/npc=259900/hadurk-mendelsen
            [npcKeys.name] = "Hadurk Mendelsen",
        },
        [259901] = { -- Igthar Forgefury : https://wowhead.com/forever/npc=259901/igthar-forgefury
            [npcKeys.name] = "Igthar Forgefury",
            [npcKeys.spawns] = {[46] = {{26.6, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.BURNING_STEPPES,
        },
        [259908] = { -- Naia Moonsong : https://wowhead.com/forever/npc=259908/naia-moonsong
            [npcKeys.name] = "Naia Moonsong",
        },
        [259909] = { -- Or'kug : https://wowhead.com/forever/npc=259909/orkug
            [npcKeys.name] = "Or'kug",
        },
        [259944] = { -- Jereman : https://wowhead.com/forever/npc=259944/jereman
            [npcKeys.name] = "Jereman",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.friendlyToFaction] = "A",
        },
        [259957] = { -- Dummy : https://wowhead.com/forever/npc=259957/dummy
            [npcKeys.name] = "Dummy",
        },
        [259961] = { -- Wharfmaster Whizzbuzz : https://wowhead.com/forever/npc=259961/wharfmaster-whizzbuzz
            [npcKeys.name] = "Wharfmaster Whizzbuzz",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[16591] = {{79.4, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259962] = { -- Fimbo Greasemitz : https://wowhead.com/forever/npc=259962/fimbo-greasemitz
            [npcKeys.name] = "Fimbo Greasemitz",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{79, 54}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [259966] = { -- Ott : https://wowhead.com/forever/npc=259966/ott
            [npcKeys.name] = "Ott",
        },
        [259983] = { -- Rinkle : https://wowhead.com/forever/npc=259983/rinkle
            [npcKeys.name] = "Rinkle",
        },
        [259988] = { -- Gorgegut : https://wowhead.com/forever/npc=259988/gorgegut
            [npcKeys.name] = "Gorgegut",
            [npcKeys.spawns] = {[16591] = {{69.6, 25.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260017] = { -- Greenhouse : https://wowhead.com/forever/npc=260017/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [260018] = { -- Greenhouse : https://wowhead.com/forever/npc=260018/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [260019] = { -- Greenhouse : https://wowhead.com/forever/npc=260019/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [260020] = { -- Greenhouse : https://wowhead.com/forever/npc=260020/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [260021] = { -- Greenhouse : https://wowhead.com/forever/npc=260021/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [260023] = { -- Farholde Ambusher : https://wowhead.com/forever/npc=260023/farholde-ambusher
            [npcKeys.name] = "Farholde Ambusher",
        },
        [260026] = { -- Scout Bolain : https://wowhead.com/forever/npc=260026/scout-bolain
            [npcKeys.name] = "Scout Bolain",
            [npcKeys.spawns] = {[16591] = {{23.8, 68}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260045] = { -- Sentry Woods : https://wowhead.com/forever/npc=260045/sentry-woods
            [npcKeys.name] = "Sentry Woods",
            [npcKeys.spawns] = {[16591] = {{63.4, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260046] = { -- Sentry Mayberry : https://wowhead.com/forever/npc=260046/sentry-mayberry
            [npcKeys.name] = "Sentry Mayberry",
        },
        [260047] = { -- Sentry Albright : https://wowhead.com/forever/npc=260047/sentry-albright
            [npcKeys.name] = "Sentry Albright",
            [npcKeys.spawns] = {[16591] = {{61.6, 80.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260048] = { -- Sentry Larsen : https://wowhead.com/forever/npc=260048/sentry-larsen
            [npcKeys.name] = "Sentry Larsen",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260049] = { -- Sentry Hartley : https://wowhead.com/forever/npc=260049/sentry-hartley
            [npcKeys.name] = "Sentry Hartley",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260050] = { -- Sentry Denning : https://wowhead.com/forever/npc=260050/sentry-denning
            [npcKeys.name] = "Sentry Denning",
            [npcKeys.spawns] = {[16591] = {{65.4, 80.8}, {65.6, 80.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260051] = { -- Sentry Fleming : https://wowhead.com/forever/npc=260051/sentry-fleming
            [npcKeys.name] = "Sentry Fleming",
            [npcKeys.spawns] = {[16591] = {{63.6, 85.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260052] = { -- Sentry Gant : https://wowhead.com/forever/npc=260052/sentry-gant
            [npcKeys.name] = "Sentry Gant",
            [npcKeys.spawns] = {[16591] = {{60, 78.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260053] = { -- Sentry Olgan : https://wowhead.com/forever/npc=260053/sentry-olgan
            [npcKeys.name] = "Sentry Olgan",
            [npcKeys.spawns] = {[16591] = {{66.4, 80.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260054] = { -- Sentry Shaw : https://wowhead.com/forever/npc=260054/sentry-shaw
            [npcKeys.name] = "Sentry Shaw",
            [npcKeys.spawns] = {[16591] = {{65.4, 80.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260055] = { -- Sentry Rigley : https://wowhead.com/forever/npc=260055/sentry-rigley
            [npcKeys.name] = "Sentry Rigley",
            [npcKeys.spawns] = {[16591] = {{64.2, 82.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260056] = { -- Sentry Brennan : https://wowhead.com/forever/npc=260056/sentry-brennan
            [npcKeys.name] = "Sentry Brennan",
            [npcKeys.spawns] = {[16591] = {{66.2, 81.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260057] = { -- Sentry Jacobs : https://wowhead.com/forever/npc=260057/sentry-jacobs
            [npcKeys.name] = "Sentry Jacobs",
        },
        [260058] = { -- Sentry Keenan : https://wowhead.com/forever/npc=260058/sentry-keenan
            [npcKeys.name] = "Sentry Keenan",
        },
        [260060] = { -- Sentry Price : https://wowhead.com/forever/npc=260060/sentry-price
            [npcKeys.name] = "Sentry Price",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{61.4, 84.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260061] = { -- Lieutenant Maclan : https://wowhead.com/forever/npc=260061/lieutenant-maclan
            [npcKeys.name] = "Lieutenant Maclan",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[16591] = {{61.8, 84.8}, {63, 83.4}, {63.8, 82.8}, {64.4, 80.2}, {64.6, 80.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260062] = { -- Lieutenant Shelby : https://wowhead.com/forever/npc=260062/lieutenant-shelby
            [npcKeys.name] = "Lieutenant Shelby",
            [npcKeys.spawns] = {[16591] = {{61.2, 80.8}, {61.4, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260063] = { -- Hare : https://wowhead.com/forever/npc=260063/hare
            [npcKeys.name] = "Hare",
        },
        [260066] = { -- Sentry Gellin : https://wowhead.com/forever/npc=260066/sentry-gellin
            [npcKeys.name] = "Sentry Gellin",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{58.8, 77.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260067] = { -- Sentry Kalis : https://wowhead.com/forever/npc=260067/sentry-kalis
            [npcKeys.name] = "Sentry Kalis",
            [npcKeys.spawns] = {[16591] = {{59.2, 77}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260068] = { -- Sentry Drevan : https://wowhead.com/forever/npc=260068/sentry-drevan
            [npcKeys.name] = "Sentry Drevan",
            [npcKeys.spawns] = {[16591] = {{62, 81.2}, {62.4, 81.8}, {62.6, 82}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260070] = { -- Bertrand Ironbrow : https://wowhead.com/forever/npc=260070/bertrand-ironbrow
            [npcKeys.name] = "Bertrand Ironbrow",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{63.4, 80.4}, {63.4, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260075] = { -- Sentry Nolan : https://wowhead.com/forever/npc=260075/sentry-nolan
            [npcKeys.name] = "Sentry Nolan",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260078] = { -- Greenhouse : https://wowhead.com/forever/npc=260078/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [260079] = { -- Sentry Wolthrup : https://wowhead.com/forever/npc=260079/sentry-wolthrup
            [npcKeys.name] = "Sentry Wolthrup",
            [npcKeys.spawns] = {[16591] = {{66.6, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260080] = { -- Ember Bladewhisper : https://wowhead.com/forever/npc=260080/ember-bladewhisper
            [npcKeys.name] = "Ember Bladewhisper",
            [npcKeys.minLevel] = 43,
            [npcKeys.maxLevel] = 43,
            [npcKeys.spawns] = {[16591] = {{66, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260091] = { -- Explosive Charge : https://wowhead.com/forever/npc=260091/explosive-charge
            [npcKeys.name] = "Explosive Charge",
        },
        [260093] = { -- Garen Largo : https://wowhead.com/forever/npc=260093/garen-largo
            [npcKeys.name] = "Garen Largo",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[1497] = {{47.2, 14.4}, {47.4, 15}, {47.4, 15.8}, {47.6, 14.8}, {47.6, 15.6}, {48.2, 14.4}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.friendlyToFaction] = "H",
        },
        [260101] = { -- Paladin Trainee : https://wowhead.com/forever/npc=260101/paladin-trainee
            [npcKeys.name] = "Paladin Trainee",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{21.8, 47}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [260102] = { -- Bandarion Keep Paladin : https://wowhead.com/forever/npc=260102/bandarion-keep-paladin
            [npcKeys.name] = "Bandarion Keep Paladin",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{21.2, 46.2}, {21.2, 46.8}, {21.2, 47.8}, {21.6, 45.8}, {21.6, 46.6}, {21.6, 47.8}, {22, 44.8}, {22.2, 49.4}, {22.2, 49.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [260105] = { -- Seed Hybridizer : https://wowhead.com/forever/npc=260105/seed-hybridizer
            [npcKeys.name] = "Seed Hybridizer",
        },
        [260107] = { -- Illusion : https://wowhead.com/forever/npc=260107/illusion
            [npcKeys.name] = "Illusion",
        },
        [260114] = { -- Azka Bloodsnout : https://wowhead.com/forever/npc=260114/azka-bloodsnout
            [npcKeys.name] = "Azka Bloodsnout",
        },
        [260117] = { -- Liferoot : https://wowhead.com/forever/npc=260117/liferoot
            [npcKeys.name] = "Liferoot",
        },
        [260119] = { -- Fadeleaf : https://wowhead.com/forever/npc=260119/fadeleaf
            [npcKeys.name] = "Fadeleaf",
        },
        [260120] = { -- Khadgar's Whisker : https://wowhead.com/forever/npc=260120/khadgars-whisker
            [npcKeys.name] = "Khadgar's Whisker",
        },
        [260121] = { -- Wintersbite : https://wowhead.com/forever/npc=260121/wintersbite
            [npcKeys.name] = "Wintersbite",
        },
        [260122] = { -- Stranglekelp : https://wowhead.com/forever/npc=260122/stranglekelp
            [npcKeys.name] = "Stranglekelp",
        },
        [260123] = { -- Firebloom : https://wowhead.com/forever/npc=260123/firebloom
            [npcKeys.name] = "Firebloom",
        },
        [260124] = { -- Purple Lotus : https://wowhead.com/forever/npc=260124/purple-lotus
            [npcKeys.name] = "Purple Lotus",
        },
        [260125] = { -- Goldthorn : https://wowhead.com/forever/npc=260125/goldthorn
            [npcKeys.name] = "Goldthorn",
        },
        [260126] = { -- Arthas' Tears : https://wowhead.com/forever/npc=260126/arthas-tears
            [npcKeys.name] = "Arthas' Tears",
        },
        [260127] = { -- Sungrass : https://wowhead.com/forever/npc=260127/sungrass
            [npcKeys.name] = "Sungrass",
        },
        [260128] = { -- Blindweed : https://wowhead.com/forever/npc=260128/blindweed
            [npcKeys.name] = "Blindweed",
        },
        [260129] = { -- Ghost Mushroom : https://wowhead.com/forever/npc=260129/ghost-mushroom
            [npcKeys.name] = "Ghost Mushroom",
        },
        [260130] = { -- Gromsblood : https://wowhead.com/forever/npc=260130/gromsblood
            [npcKeys.name] = "Gromsblood",
        },
        [260131] = { -- Golden Sansam : https://wowhead.com/forever/npc=260131/golden-sansam
            [npcKeys.name] = "Golden Sansam",
        },
        [260132] = { -- Dreamfoil : https://wowhead.com/forever/npc=260132/dreamfoil
            [npcKeys.name] = "Dreamfoil",
        },
        [260133] = { -- Mountain Silversage : https://wowhead.com/forever/npc=260133/mountain-silversage
            [npcKeys.name] = "Mountain Silversage",
        },
        [260134] = { -- Icecap : https://wowhead.com/forever/npc=260134/icecap
            [npcKeys.name] = "Icecap",
        },
        [260135] = { -- Plaguebloom : https://wowhead.com/forever/npc=260135/plaguebloom
            [npcKeys.name] = "Plaguebloom",
        },
        [260138] = { -- Prisoner : https://wowhead.com/forever/npc=260138/prisoner
            [npcKeys.name] = "Prisoner",
        },
        [260146] = { -- Sully McCleary : https://wowhead.com/forever/npc=260146/sully-mccleary
            [npcKeys.name] = "Sully McCleary",
            [npcKeys.spawns] = {[15] = {{66.2, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [260148] = { -- Scourge Reanimator : https://wowhead.com/forever/npc=260148/scourge-reanimator
            [npcKeys.name] = "Scourge Reanimator",
        },
        [260157] = { -- Elder Snow Leopard : https://wowhead.com/forever/npc=260157/elder-snow-leopard
            [npcKeys.name] = "Elder Snow Leopard",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[1] = {{70.4, 53.4}, {71, 52.4}, {71, 53.6}, {71.4, 53}, {71.4, 54.8}, {71.4, 61.4}, {71.4, 62}, {71.6, 52.8}, {71.6, 61.8}, {71.8, 53.6}, {71.8, 61.4}, {72.2, 59.4}, {72.2, 59.8}, {72.4, 55}, {72.4, 55.8}, {72.4, 56.6}, {72.4, 58.2}, {72.6, 55.6}, {72.6, 56.6}, {72.6, 59.2}, {72.6, 60.4}, {72.8, 54.4}, {72.8, 55.2}, {73, 61.8}, {73.2, 61}, {73.4, 50.4}, {73.4, 52.4}, {73.4, 52.6}, {73.6, 54.2}, {73.6, 61}, {73.8, 54.6}, {73.8, 55.6}, {74, 50.4}, {74, 52.2}, {74, 52.8}, {74.4, 51.2}, {74.6, 51.2}, {74.6, 52.4}, {74.6, 53}, {75.2, 61.8}, {75.4, 55.4}, {75.4, 56.4}, {75.4, 56.6}, {75.4, 60.8}, {75.6, 56.4}, {75.6, 56.6}, {75.8, 55.2}, {75.8, 61.8}, {76, 62.6}, {76.4, 58}, {76.4, 58.6}, {76.4, 61.4}, {76.6, 61.4}, {76.6, 61.8}, {77, 58.8}, {77, 59.6}, {77.2, 57.2}, {77.2, 57.6}, {77.6, 60.6}, {77.8, 61.6}, {78, 59.4}, {78, 60}, {78.2, 55.2}, {78.4, 56.4}, {78.4, 57.4}, {78.4, 57.8}, {78.6, 57}, {78.6, 57.8}, {78.6, 59.2}, {78.6, 59.6}, {78.8, 55.4}, {79, 55.6}, {80.2, 56.4}, {80.4, 55.4}, {81, 55}, {81, 55.6}, {81, 57.6}, {81.4, 54.4}, {81.4, 57.2}, {81.6, 55.6}, {81.8, 55}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [260211] = { -- Scoutmaster Vargas : https://wowhead.com/forever/npc=260211/scoutmaster-vargas
            [npcKeys.name] = "Scoutmaster Vargas",
            [npcKeys.spawns] = {[16591] = {{75.6, 34.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260215] = { -- Scout Reynolds : https://wowhead.com/forever/npc=260215/scout-reynolds
            [npcKeys.name] = "Scout Reynolds",
        },
        [260216] = { -- Scout Williamson : https://wowhead.com/forever/npc=260216/scout-williamson
            [npcKeys.name] = "Scout Williamson",
        },
        [260218] = { -- Scout Reede : https://wowhead.com/forever/npc=260218/scout-reede
            [npcKeys.name] = "Scout Reede",
        },
        [260225] = { -- Bloodsnout : https://wowhead.com/forever/npc=260225/bloodsnout
            [npcKeys.name] = "Bloodsnout",
        },
        [260231] = { -- Argo Brinewhistle : https://wowhead.com/forever/npc=260231/argo-brinewhistle
            [npcKeys.name] = "Argo Brinewhistle",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{79.8, 52.4}, {79.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260235] = { -- Trapclaw : https://wowhead.com/forever/npc=260235/trapclaw
            [npcKeys.name] = "Trapclaw",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260244] = { -- Monstrous Threshadon : https://wowhead.com/forever/npc=260244/monstrous-threshadon
            [npcKeys.name] = "Monstrous Threshadon",
        },
        [260271] = { -- Sully McCleary : https://wowhead.com/forever/npc=260271/sully-mccleary
            [npcKeys.name] = "Sully McCleary",
        },
        [260322] = { -- Saltspine : https://wowhead.com/forever/npc=260322/saltspine
            [npcKeys.name] = "Saltspine",
        },
        [260325] = { -- Shadetooth : https://wowhead.com/forever/npc=260325/shadetooth
            [npcKeys.name] = "Shadetooth",
        },
        [260326] = { -- Relic Guardian : https://wowhead.com/forever/npc=260326/relic-guardian
            [npcKeys.name] = "Relic Guardian",
        },
        [260343] = { -- Maka : https://wowhead.com/forever/npc=260343/maka
            [npcKeys.name] = "Maka",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{58.2, 45.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260359] = { -- Sadi : https://wowhead.com/forever/npc=260359/sadi
            [npcKeys.name] = "Sadi",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{79.8, 54}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260373] = { -- Credit : https://wowhead.com/forever/npc=260373/credit
            [npcKeys.name] = "Credit",
        },
        [260374] = { -- Credit : https://wowhead.com/forever/npc=260374/credit
            [npcKeys.name] = "Credit",
        },
        [260383] = { -- Sergeant Ulka : https://wowhead.com/forever/npc=260383/sergeant-ulka
            [npcKeys.name] = "Sergeant Ulka",
        },
        [260386] = { -- Commander Folkar : https://wowhead.com/forever/npc=260386/commander-folkar
            [npcKeys.name] = "Commander Folkar",
        },
        [260390] = { -- Captain Bentcoin : https://wowhead.com/forever/npc=260390/captain-bentcoin
            [npcKeys.name] = "Captain Bentcoin",
        },
        [260391] = { -- Captain Haynes : https://wowhead.com/forever/npc=260391/captain-haynes
            [npcKeys.name] = "Captain Haynes",
        },
        [260396] = { -- Whispering Horror : https://wowhead.com/forever/npc=260396/whispering-horror
            [npcKeys.name] = "Whispering Horror",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[85] = {{8.4, 59.4}, {8.6, 59.4}, {8.6, 59.8}, {9, 60.8}, {9, 62.4}, {9.6, 59.2}, {9.6, 59.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [260405] = { -- Wharfmaster Steamfizzle : https://wowhead.com/forever/npc=260405/wharfmaster-steamfizzle
            [npcKeys.name] = "Wharfmaster Steamfizzle",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[440] = {{67.6, 23}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
        },
        [260417] = { -- [DNT] Kill Credit: Ogre Miner : https://wowhead.com/forever/npc=260417/dnt-kill-credit-ogre-miner
            [npcKeys.name] = "[DNT] Kill Credit: Ogre Miner",
        },
        [260419] = { -- Slugjaw : https://wowhead.com/forever/npc=260419/slugjaw
            [npcKeys.name] = "Slugjaw",
            [npcKeys.spawns] = {[440] = {{67.4, 23.8}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
        },
        [260422] = { -- Ashen Acolyte : https://wowhead.com/forever/npc=260422/ashen-acolyte
            [npcKeys.name] = "Ashen Acolyte",
            [npcKeys.minLevel] = 56,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[616] = {{42.8, 71.8}, {43.4, 71}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [260425] = { -- Venture Co. Mercenary : https://wowhead.com/forever/npc=260425/venture-co-mercenary
            [npcKeys.name] = "Venture Co. Mercenary",
        },
        [260428] = { -- Shadowvale Lurcher : https://wowhead.com/forever/npc=260428/shadowvale-lurcher
            [npcKeys.name] = "Shadowvale Lurcher",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{8.4, 65.6}, {8.4, 67}, {8.6, 65.6}, {8.6, 67}, {9.4, 65}, {9.4, 68}, {9.8, 68}, {10.2, 66.2}, {10.2, 66.8}, {10.4, 65.4}, {10.6, 65.2}, {10.6, 66.8}, {11, 66}, {11.8, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [260429] = { -- Venture Co. Agent : https://wowhead.com/forever/npc=260429/venture-co-agent
            [npcKeys.name] = "Venture Co. Agent",
        },
        [260430] = { -- Shadowvale Mystic : https://wowhead.com/forever/npc=260430/shadowvale-mystic
            [npcKeys.name] = "Shadowvale Mystic",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{8.4, 67}, {8.6, 67}, {9, 66.2}, {9.4, 64.8}, {9.4, 68.2}, {9.6, 65}, {9.8, 66.8}, {10, 68.2}, {10.2, 66.4}, {10.6, 65.2}, {10.6, 66.6}, {11.4, 65.8}, {11.8, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [260431] = { -- Shadowvale Lurcher : https://wowhead.com/forever/npc=260431/shadowvale-lurcher
            [npcKeys.name] = "Shadowvale Lurcher",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[85] = {{9.4, 59.4}, {9.4, 60.4}, {9.4, 60.6}, {9.4, 62.2}, {9.4, 63.4}, {9.4, 63.6}, {9.4, 64.6}, {9.6, 59.4}, {9.6, 60.4}, {9.6, 60.6}, {9.6, 62}, {9.6, 63.4}, {9.6, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [260432] = { -- Shadowvale Mystic : https://wowhead.com/forever/npc=260432/shadowvale-mystic
            [npcKeys.name] = "Shadowvale Mystic",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[85] = {{8.6, 59.4}, {9.2, 64.8}, {9.4, 60.4}, {9.4, 60.6}, {9.4, 61.8}, {9.4, 63.4}, {9.4, 63.6}, {9.6, 63}, {9.6, 63.6}, {9.6, 64.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [260438] = { -- Grot Pondskipper : https://wowhead.com/forever/npc=260438/grot-pondskipper
            [npcKeys.name] = "Grot Pondskipper",
        },
        [260439] = { -- Subjugated Assistant : https://wowhead.com/forever/npc=260439/subjugated-assistant
            [npcKeys.name] = "Subjugated Assistant",
        },
        [260440] = { -- Brashann Grimdark : https://wowhead.com/forever/npc=260440/brashann-grimdark
            [npcKeys.name] = "Brashann Grimdark",
        },
        [260443] = { -- Dazka Shadowsleep : https://wowhead.com/forever/npc=260443/dazka-shadowsleep
            [npcKeys.name] = "Dazka Shadowsleep",
        },
        [260444] = { -- Tyaeha Darkoath : https://wowhead.com/forever/npc=260444/tyaeha-darkoath
            [npcKeys.name] = "Tyaeha Darkoath",
        },
        [260445] = { -- Wriggling Slime : https://wowhead.com/forever/npc=260445/wriggling-slime
            [npcKeys.name] = "Wriggling Slime",
        },
        [260450] = { -- Rattlebones : https://wowhead.com/forever/npc=260450/rattlebones
            [npcKeys.name] = "Rattlebones",
        },
        [260466] = { -- Grubbub : https://wowhead.com/forever/npc=260466/grubbub
            [npcKeys.name] = "Grubbub",
        },
        [260471] = { -- Thrash : https://wowhead.com/forever/npc=260471/thrash
            [npcKeys.name] = "Thrash",
            [npcKeys.spawns] = {[16591] = {{78, 52.4}, {78.2, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260481] = { -- Om'kug : https://wowhead.com/forever/npc=260481/omkug
            [npcKeys.name] = "Om'kug",
        },
        [260487] = { -- Gritta Chumwater : https://wowhead.com/forever/npc=260487/gritta-chumwater
            [npcKeys.name] = "Gritta Chumwater",
            [npcKeys.minLevel] = 44,
            [npcKeys.maxLevel] = 44,
            [npcKeys.spawns] = {[16591] = {{78.4, 55}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [260494] = { -- Farholde Sentry : https://wowhead.com/forever/npc=260494/farholde-sentry
            [npcKeys.name] = "Farholde Sentry",
            [npcKeys.spawns] = {[16591] = {{61.6, 84.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260525] = { -- Tallow Sparksocket : https://wowhead.com/forever/npc=260525/tallow-sparksocket
            [npcKeys.name] = "Tallow Sparksocket",
            [npcKeys.spawns] = {[16591] = {{78.4, 54}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260540] = { -- Jasper Geartoggle : https://wowhead.com/forever/npc=260540/jasper-geartoggle
            [npcKeys.name] = "Jasper Geartoggle",
            [npcKeys.spawns] = {[16591] = {{75.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260543] = { -- Mizzy : https://wowhead.com/forever/npc=260543/mizzy
            [npcKeys.name] = "Mizzy",
            [npcKeys.spawns] = {[16591] = {{76.6, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260558] = { -- Krix : https://wowhead.com/forever/npc=260558/krix
            [npcKeys.name] = "Krix",
            [npcKeys.minLevel] = 43,
            [npcKeys.maxLevel] = 43,
            [npcKeys.spawns] = {[16591] = {{79.2, 54.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260559] = { -- Gilliwigs : https://wowhead.com/forever/npc=260559/gilliwigs
            [npcKeys.name] = "Gilliwigs",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{79.2, 54.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260560] = { -- Krikshank : https://wowhead.com/forever/npc=260560/krikshank
            [npcKeys.name] = "Krikshank",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{76.8, 51}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [260561] = { -- Dina Mite : https://wowhead.com/forever/npc=260561/dina-mite
            [npcKeys.name] = "Dina Mite",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{77.6, 54.4}, {77.6, 54.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260562] = { -- Melbin Powderfuse : https://wowhead.com/forever/npc=260562/melbin-powderfuse
            [npcKeys.name] = "Melbin Powderfuse",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[16591] = {{77.6, 50.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [260563] = { -- Mia Tanglewrench : https://wowhead.com/forever/npc=260563/mia-tanglewrench
            [npcKeys.name] = "Mia Tanglewrench",
            [npcKeys.spawns] = {[16591] = {{77.8, 50.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260564] = { -- Rex Hardwire : https://wowhead.com/forever/npc=260564/rex-hardwire
            [npcKeys.name] = "Rex Hardwire",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{76.4, 52.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260565] = { -- Kor'gar : https://wowhead.com/forever/npc=260565/korgar
            [npcKeys.name] = "Kor'gar",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{77.6, 50.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260566] = { -- Fizzix Boomshot : https://wowhead.com/forever/npc=260566/fizzix-boomshot
            [npcKeys.name] = "Fizzix Boomshot",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{78.4, 53.6}, {78.6, 53.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [260567] = { -- Tuppins Coppercheck : https://wowhead.com/forever/npc=260567/tuppins-coppercheck
            [npcKeys.name] = "Tuppins Coppercheck",
        },
        [260568] = { -- Jazzle Cheapshot : https://wowhead.com/forever/npc=260568/jazzle-cheapshot
            [npcKeys.name] = "Jazzle Cheapshot",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{77.6, 53.4}, {77.6, 54}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260569] = { -- Shady Smuggler : https://wowhead.com/forever/npc=260569/shady-smuggler
            [npcKeys.name] = "Shady Smuggler",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 39,
            [npcKeys.spawns] = {[16591] = {{76.4, 53}, {77, 51}, {79, 55}, {79.8, 51.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260570] = { -- Stitch Pinwizzle : https://wowhead.com/forever/npc=260570/stitch-pinwizzle
            [npcKeys.name] = "Stitch Pinwizzle",
            [npcKeys.minLevel] = 41,
            [npcKeys.maxLevel] = 41,
            [npcKeys.spawns] = {[16591] = {{77.2, 51.4}, {77.2, 51.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [260580] = { -- Mini Uber Diablo : https://wowhead.com/forever/npc=260580/mini-uber-diablo
            [npcKeys.name] = "Mini Uber Diablo",
        },
        [260626] = { -- Bluebell : https://wowhead.com/forever/npc=260626/bluebell
            [npcKeys.name] = "Bluebell",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{55, 82.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [260628] = { -- Valennia Stormfist : https://wowhead.com/forever/npc=260628/valennia-stormfist
            [npcKeys.name] = "Valennia Stormfist",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[16593] = {{66, 76.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [260661] = { -- Suma Mossmane : https://wowhead.com/forever/npc=260661/suma-mossmane
            [npcKeys.name] = "Suma Mossmane",
        },
        [260674] = { -- Ve'ho Manyhorns : https://wowhead.com/forever/npc=260674/veho-manyhorns
            [npcKeys.name] = "Ve'ho Manyhorns",
        },
        [260731] = { -- Diseased Experiment : https://wowhead.com/forever/npc=260731/diseased-experiment
            [npcKeys.name] = "Diseased Experiment",
        },
        [260796] = { -- Marsh Crocolisk : https://wowhead.com/forever/npc=260796/marsh-crocolisk
            [npcKeys.name] = "Marsh Crocolisk",
        },
        [260797] = { -- Elder Crocolisk : https://wowhead.com/forever/npc=260797/elder-crocolisk
            [npcKeys.name] = "Elder Crocolisk",
        },
        [260798] = { -- Young Crocolisk : https://wowhead.com/forever/npc=260798/young-crocolisk
            [npcKeys.name] = "Young Crocolisk",
        },
        [260799] = { -- Young Riptooth : https://wowhead.com/forever/npc=260799/young-riptooth
            [npcKeys.name] = "Young Riptooth",
        },
        [260800] = { -- Thicket Lurker : https://wowhead.com/forever/npc=260800/thicket-lurker
            [npcKeys.name] = "Thicket Lurker",
        },
        [260801] = { -- Thicket Hunter : https://wowhead.com/forever/npc=260801/thicket-hunter
            [npcKeys.name] = "Thicket Hunter",
        },
        [260802] = { -- Thicket Matriarch : https://wowhead.com/forever/npc=260802/thicket-matriarch
            [npcKeys.name] = "Thicket Matriarch",
        },
        [260803] = { -- Highland Spider : https://wowhead.com/forever/npc=260803/highland-spider
            [npcKeys.name] = "Highland Spider",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[11] = {{48.4, 56.4}, {50, 58}, {52.4, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [260804] = { -- Highland Lurker : https://wowhead.com/forever/npc=260804/highland-lurker
            [npcKeys.name] = "Highland Lurker",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [260807] = { -- Highland Creeper : https://wowhead.com/forever/npc=260807/highland-creeper
            [npcKeys.name] = "Highland Creeper",
        },
        [260808] = { -- Highland Horror : https://wowhead.com/forever/npc=260808/highland-horror
            [npcKeys.name] = "Highland Horror",
        },
        [260809] = { -- Highland Tortoise : https://wowhead.com/forever/npc=260809/highland-tortoise
            [npcKeys.name] = "Highland Tortoise",
            [npcKeys.spawns] = {[11] = {{48.4, 56.2}, {49.4, 55.8}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [260810] = { -- Highland Snapper : https://wowhead.com/forever/npc=260810/highland-snapper
            [npcKeys.name] = "Highland Snapper",
        },
        [260818] = { -- Frezzlie Popwhiz : https://wowhead.com/forever/npc=260818/frezzlie-popwhiz
            [npcKeys.name] = "Frezzlie Popwhiz",
        },
        [260822] = { -- Tainted Grovewalker : https://wowhead.com/forever/npc=260822/tainted-grovewalker
            [npcKeys.name] = "Tainted Grovewalker",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[616] = {{41.4, 78.2}, {45.6, 81.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [260823] = { -- Overseer Myoleth : https://wowhead.com/forever/npc=260823/overseer-myoleth
            [npcKeys.name] = "Overseer Myoleth",
        },
        [260825] = { -- Phoebe Highfeather : https://wowhead.com/forever/npc=260825/phoebe-highfeather
            [npcKeys.name] = "Phoebe Highfeather",
            [npcKeys.spawns] = {[616] = {{54.2, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [260826] = { -- Zarrat Wormwing : https://wowhead.com/forever/npc=260826/zarrat-wormwing
            [npcKeys.name] = "Zarrat Wormwing",
        },
        [260857] = { -- Tazzik : https://wowhead.com/forever/npc=260857/tazzik
            [npcKeys.name] = "Tazzik",
            [npcKeys.spawns] = {[440] = {{67.4, 23.8}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
        },
        [260860] = { -- Sentry Childers : https://wowhead.com/forever/npc=260860/sentry-childers
            [npcKeys.name] = "Sentry Childers",
            [npcKeys.spawns] = {[16591] = {{39.4, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [260861] = { -- Sentry Welgrin : https://wowhead.com/forever/npc=260861/sentry-welgrin
            [npcKeys.name] = "Sentry Welgrin",
        },
        [260862] = { -- Sentry Egan : https://wowhead.com/forever/npc=260862/sentry-egan
            [npcKeys.name] = "Sentry Egan",
        },
        [260863] = { -- Sentry Rivers : https://wowhead.com/forever/npc=260863/sentry-rivers
            [npcKeys.name] = "Sentry Rivers",
        },
        [260864] = { -- Sentry Tillman : https://wowhead.com/forever/npc=260864/sentry-tillman
            [npcKeys.name] = "Sentry Tillman",
        },
        [260865] = { -- Tainted Bramblepaw : https://wowhead.com/forever/npc=260865/tainted-bramblepaw
            [npcKeys.name] = "Tainted Bramblepaw",
        },
        [260867] = { -- Ash-Tainted Branch-Horn : https://wowhead.com/forever/npc=260867/ash-tainted-branch-horn
            [npcKeys.name] = "Ash-Tainted Branch-Horn",
        },
        [260873] = { -- Dudd Fizzlescroll : https://wowhead.com/forever/npc=260873/dudd-fizzlescroll
            [npcKeys.name] = "Dudd Fizzlescroll",
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [260901] = { -- Credit : https://wowhead.com/forever/npc=260901/credit
            [npcKeys.name] = "Credit",
        },
        [260915] = { -- Credit : https://wowhead.com/forever/npc=260915/credit
            [npcKeys.name] = "Credit",
        },
        [260931] = { -- Clubtoe : https://wowhead.com/forever/npc=260931/clubtoe
            [npcKeys.name] = "Clubtoe",
        },
        [260968] = { -- Twilight Mauler : https://wowhead.com/forever/npc=260968/twilight-mauler
            [npcKeys.name] = "Twilight Mauler",
        },
        [260969] = { -- Twilight Instigator : https://wowhead.com/forever/npc=260969/twilight-instigator
            [npcKeys.name] = "Twilight Instigator",
        },
        [260973] = { -- Klunk : https://wowhead.com/forever/npc=260973/klunk
            [npcKeys.name] = "Klunk",
        },
        [260975] = { -- Vile Moonwell Ooze : https://wowhead.com/forever/npc=260975/vile-moonwell-ooze
            [npcKeys.name] = "Vile Moonwell Ooze",
        },
        [260993] = { -- Crag'rog : https://wowhead.com/forever/npc=260993/cragrog
            [npcKeys.name] = "Crag'rog",
        },
        [260995] = { -- Ogre Miner : https://wowhead.com/forever/npc=260995/ogre-miner
            [npcKeys.name] = "Ogre Miner",
        },
        [260996] = { -- Twilight Subjugator : https://wowhead.com/forever/npc=260996/twilight-subjugator
            [npcKeys.name] = "Twilight Subjugator",
        },
        [261023] = { -- Bonzo "The Brain" Greasepit : https://wowhead.com/forever/npc=261023/bonzo-the-brain-greasepit
            [npcKeys.name] = "Bonzo \"The Brain\" Greasepit",
        },
        [261026] = { -- Ka'ya Speartusk : https://wowhead.com/forever/npc=261026/kaya-speartusk
            [npcKeys.name] = "Ka'ya Speartusk",
        },
        [261027] = { -- Liu the Lookout : https://wowhead.com/forever/npc=261027/liu-the-lookout
            [npcKeys.name] = "Liu the Lookout",
        },
        [261028] = { -- Cadrya Balen : https://wowhead.com/forever/npc=261028/cadrya-balen
            [npcKeys.name] = "Cadrya Balen",
        },
        [261029] = { -- Mercer Chapman : https://wowhead.com/forever/npc=261029/mercer-chapman
            [npcKeys.name] = "Mercer Chapman",
        },
        [261030] = { -- Gothuc Blackhowl : https://wowhead.com/forever/npc=261030/gothuc-blackhowl
            [npcKeys.name] = "Gothuc Blackhowl",
        },
        [261031] = { -- Scrapper Frazzi : https://wowhead.com/forever/npc=261031/scrapper-frazzi
            [npcKeys.name] = "Scrapper Frazzi",
        },
        [261160] = { -- Zavirax : https://wowhead.com/forever/npc=261160/zavirax
            [npcKeys.name] = "Zavirax",
        },
        [261207] = { -- Blipzy : https://wowhead.com/forever/npc=261207/blipzy
            [npcKeys.name] = "Blipzy",
        },
        [261208] = { -- Twilight Brute : https://wowhead.com/forever/npc=261208/twilight-brute
            [npcKeys.name] = "Twilight Brute",
        },
        [261221] = { -- Placeholder Skyborne Mount Trainer : https://wowhead.com/forever/npc=261221/placeholder-skyborne-mount-trainer
            [npcKeys.name] = "Placeholder Skyborne Mount Trainer",
        },
        [261222] = { -- Placeholder Skyborne Mount Vendor : https://wowhead.com/forever/npc=261222/placeholder-skyborne-mount-vendor
            [npcKeys.name] = "Placeholder Skyborne Mount Vendor",
        },
        [261280] = { -- Red Crystal : https://wowhead.com/forever/npc=261280/red-crystal
            [npcKeys.name] = "Red Crystal",
        },
        [261286] = { -- Green Crystal : https://wowhead.com/forever/npc=261286/green-crystal
            [npcKeys.name] = "Green Crystal",
        },
        [261287] = { -- Blue Crystal : https://wowhead.com/forever/npc=261287/blue-crystal
            [npcKeys.name] = "Blue Crystal",
        },
        [261306] = { -- Faldrim Anvilmar : https://wowhead.com/forever/npc=261306/faldrim-anvilmar
            [npcKeys.name] = "Faldrim Anvilmar",
        },
        [261311] = { -- Plunder : https://wowhead.com/forever/npc=261311/plunder
            [npcKeys.name] = "Plunder",
        },
        [261313] = { -- Naluk : https://wowhead.com/forever/npc=261313/naluk
            [npcKeys.name] = "Naluk",
            [npcKeys.spawns] = {[16591] = {{58, 45.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [261316] = { -- Magmatus : https://wowhead.com/forever/npc=261316/magmatus
            [npcKeys.name] = "Magmatus",
        },
        [261319] = { -- Durgen Dirgehammer : https://wowhead.com/forever/npc=261319/durgen-dirgehammer
            [npcKeys.name] = "Durgen Dirgehammer",
        },
        [261330] = { -- Bik Zipzit : https://wowhead.com/forever/npc=261330/bik-zipzit
            [npcKeys.name] = "Bik Zipzit",
        },
        [261345] = { -- Stalker : https://wowhead.com/forever/npc=261345/stalker
            [npcKeys.name] = "Stalker",
        },
        [261363] = { -- Ranthor the Severer : https://wowhead.com/forever/npc=261363/ranthor-the-severer
            [npcKeys.name] = "Ranthor the Severer",
        },
        [261365] = { -- Brimstone Bellman : https://wowhead.com/forever/npc=261365/brimstone-bellman
            [npcKeys.name] = "Brimstone Bellman",
        },
        [261366] = { -- Walton : https://wowhead.com/forever/npc=261366/walton
            [npcKeys.name] = "Walton",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[17] = {{42, 11.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.questStarts] = {95508, 95621},
            [npcKeys.questEnds] = {95495, 95508, 95621},
            [npcKeys.friendlyToFaction] = "H",
        },
        [261367] = { -- Terry Longdrink : https://wowhead.com/forever/npc=261367/terry-longdrink
            [npcKeys.name] = "Terry Longdrink",
            [npcKeys.minLevel] = 19,
            [npcKeys.maxLevel] = 19,
            [npcKeys.spawns] = {[17] = {{41.8, 11.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [261368] = { -- Kul Tiras Marine : https://wowhead.com/forever/npc=261368/kul-tiras-marine
            [npcKeys.name] = "Kul Tiras Marine",
            [npcKeys.minLevel] = 16,
            [npcKeys.maxLevel] = 18,
            [npcKeys.spawns] = {[17] = {{41.2, 16.4}, {41.4, 14.6}, {41.4, 16.8}, {41.8, 14.2}, {42, 11.4}, {42, 15.4}, {42, 16.2}, {42, 16.6}, {42.8, 15.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [261371] = { -- Vrang Wildgore : https://wowhead.com/forever/npc=261371/vrang-wildgore
            [npcKeys.name] = "Vrang Wildgore",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[17] = {{42, 11.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [261385] = { -- Dwarf Miner : https://wowhead.com/forever/npc=261385/dwarf-miner
            [npcKeys.name] = "Dwarf Miner",
        },
        [261428] = { -- Horde Graveyard Teleporter : https://wowhead.com/forever/npc=261428/horde-graveyard-teleporter
            [npcKeys.name] = "Horde Graveyard Teleporter",
        },
        [261429] = { -- Alliance Graveyard Teleporter : https://wowhead.com/forever/npc=261429/alliance-graveyard-teleporter
            [npcKeys.name] = "Alliance Graveyard Teleporter",
        },
        [261455] = { -- Lelanai : https://wowhead.com/forever/npc=261455/lelanai
            [npcKeys.name] = "Lelanai",
        },
        [261471] = { -- Shadowsilk Backrunner : https://wowhead.com/forever/npc=261471/shadowsilk-backrunner
            [npcKeys.name] = "Shadowsilk Backrunner",
        },
        [261485] = { -- Theramore Guard : https://wowhead.com/forever/npc=261485/theramore-guard
            [npcKeys.name] = "Theramore Guard",
            [npcKeys.spawns] = {[15] = {{66.4, 49.2}}},
            [npcKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [261497] = { -- Twilight Firecaller : https://wowhead.com/forever/npc=261497/twilight-firecaller
            [npcKeys.name] = "Twilight Firecaller",
        },
        [261525] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=261525/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit: ",
        },
        [261529] = { -- Riding Striped Frostsaber : https://wowhead.com/forever/npc=261529/riding-striped-frostsaber
            [npcKeys.name] = "Riding Striped Frostsaber",
            [npcKeys.spawns] = {[1657] = {{37.8, 15.6}, {38.6, 15.8}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [261530] = { -- Credit : https://wowhead.com/forever/npc=261530/credit
            [npcKeys.name] = "Credit",
        },
        [261531] = { -- Gaznik Gearsnaps : https://wowhead.com/forever/npc=261531/gaznik-gearsnaps
            [npcKeys.name] = "Gaznik Gearsnaps",
        },
        [261566] = { -- Noruu : https://wowhead.com/forever/npc=261566/noruu
            [npcKeys.name] = "Noruu",
        },
        [261578] = { -- Riding Striped Nightsaber : https://wowhead.com/forever/npc=261578/riding-striped-nightsaber
            [npcKeys.name] = "Riding Striped Nightsaber",
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [261579] = { -- Riding Spotted Frostsaber : https://wowhead.com/forever/npc=261579/riding-spotted-frostsaber
            [npcKeys.name] = "Riding Spotted Frostsaber",
            [npcKeys.spawns] = {[1657] = {{38.6, 15.8}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [261593] = { -- Noruu : https://wowhead.com/forever/npc=261593/noruu
            [npcKeys.name] = "Noruu",
        },
        [261603] = { -- Dwarf Excavator : https://wowhead.com/forever/npc=261603/dwarf-excavator
            [npcKeys.name] = "Dwarf Excavator",
        },
        [261662] = { -- Old Ironfang : https://wowhead.com/forever/npc=261662/old-ironfang
            [npcKeys.name] = "Old Ironfang",
        },
        [261680] = { -- Snowy Wolf Pup : https://wowhead.com/forever/npc=261680/snowy-wolf-pup
            [npcKeys.name] = "Snowy Wolf Pup",
        },
        [261689] = { -- Diseased Forest Walker : https://wowhead.com/forever/npc=261689/diseased-forest-walker
            [npcKeys.name] = "Diseased Forest Walker",
        },
        [261692] = { -- Dead Diseased Forest Walker : https://wowhead.com/forever/npc=261692/dead-diseased-forest-walker
            [npcKeys.name] = "Dead Diseased Forest Walker",
        },
        [261710] = { -- Twilight Brute : https://wowhead.com/forever/npc=261710/twilight-brute
            [npcKeys.name] = "Twilight Brute",
        },
        [261711] = { -- Empowered Brute : https://wowhead.com/forever/npc=261711/empowered-brute
            [npcKeys.name] = "Empowered Brute",
        },
        [261791] = { -- Parrot : https://wowhead.com/forever/npc=261791/parrot
            [npcKeys.name] = "Parrot",
        },
        [261906] = { -- Ner'ran Bloodgrip : https://wowhead.com/forever/npc=261906/nerran-bloodgrip
            [npcKeys.name] = "Ner'ran Bloodgrip",
        },
        [261914] = { -- Tainted Hyjal Owl : https://wowhead.com/forever/npc=261914/tainted-hyjal-owl
            [npcKeys.name] = "Tainted Hyjal Owl",
        },
        [261928] = { -- Webbed Mudsnout Gnoll : https://wowhead.com/forever/npc=261928/webbed-mudsnout-gnoll
            [npcKeys.name] = "Webbed Mudsnout Gnoll",
            [npcKeys.spawns] = {[267] = {{62.2, 69.2}, {62.6, 69.4}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
            [npcKeys.questEnds] = {94215},
        },
        [261932] = { -- Gorgrash : https://wowhead.com/forever/npc=261932/gorgrash
            [npcKeys.name] = "Gorgrash",
            [npcKeys.spawns] = {[267] = {{80, 48.4}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
            [npcKeys.questEnds] = {94233},
        },
        [261961] = { -- Hekshi : https://wowhead.com/forever/npc=261961/hekshi
            [npcKeys.name] = "Hekshi",
            [npcKeys.spawns] = {[33] = {{50.4, 19.2}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [261992] = { -- Injured Soldier : https://wowhead.com/forever/npc=261992/injured-soldier
            [npcKeys.name] = "Injured Soldier",
            [npcKeys.zoneID] = zoneIDs.EASTERN_PLAGUELANDS,
        },
        [261998] = { -- Cenarion Hold Berserker : https://wowhead.com/forever/npc=261998/cenarion-hold-berserker
            [npcKeys.name] = "Cenarion Hold Berserker",
        },
        [262006] = { -- Twilight Ritual Circle : https://wowhead.com/forever/npc=262006/twilight-ritual-circle
            [npcKeys.name] = "Twilight Ritual Circle",
        },
        [262016] = { -- Fallen Adventurer : https://wowhead.com/forever/npc=262016/fallen-adventurer
            [npcKeys.name] = "Fallen Adventurer",
            [npcKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [262024] = { -- Kirala Fairgrass : https://wowhead.com/forever/npc=262024/kirala-fairgrass
            [npcKeys.name] = "Kirala Fairgrass",
        },
        [262031] = { -- Sister Rowland : https://wowhead.com/forever/npc=262031/sister-rowland
            [npcKeys.name] = "Sister Rowland",
            [npcKeys.spawns] = {[16591] = {{61.8, 83}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [262033] = { -- Suspicious Adventurer : https://wowhead.com/forever/npc=262033/suspicious-adventurer
            [npcKeys.name] = "Suspicious Adventurer",
            [npcKeys.spawns] = {[28] = {{65.4, 76}}},
            [npcKeys.zoneID] = zoneIDs.WESTERN_PLAGUELANDS,
        },
        [262036] = { -- Ruined Ballista : https://wowhead.com/forever/npc=262036/ruined-ballista
            [npcKeys.name] = "Ruined Ballista",
        },
        [262037] = { -- Roosting Duskbat : https://wowhead.com/forever/npc=262037/roosting-duskbat
            [npcKeys.name] = "Roosting Duskbat",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{60.4, 84.4}, {60.4, 84.8}, {60.4, 85.6}, {60.8, 85}, {61.6, 84.4}, {61.6, 84.8}, {62.6, 84.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [262041] = { -- Bor'dorc : https://wowhead.com/forever/npc=262041/bordorc
            [npcKeys.name] = "Bor'dorc",
        },
        [262044] = { -- Zelizax : https://wowhead.com/forever/npc=262044/zelizax
            [npcKeys.name] = "Zelizax",
            [npcKeys.spawns] = {[618] = {{57.6, 88.2}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [262049] = { -- Spirit of the Stag : https://wowhead.com/forever/npc=262049/spirit-of-the-stag
            [npcKeys.name] = "Spirit of the Stag",
        },
        [262072] = { -- The Ravenous : https://wowhead.com/forever/npc=262072/the-ravenous
            [npcKeys.name] = "The Ravenous",
        },
        [262119] = { -- Corporal Adamore : https://wowhead.com/forever/npc=262119/corporal-adamore
            [npcKeys.name] = "Corporal Adamore",
            [npcKeys.minLevel] = 17,
            [npcKeys.maxLevel] = 17,
            [npcKeys.spawns] = {[17] = {{40.6, 16}, {41.4, 14.8}, {42, 16.6}, {42.2, 14.6}, {42.4, 16}, {42.8, 16}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [262143] = { -- Scout Raroul : https://wowhead.com/forever/npc=262143/scout-raroul
            [npcKeys.name] = "Scout Raroul",
            [npcKeys.spawns] = {[357] = {{72.4, 52.2}}},
            [npcKeys.zoneID] = zoneIDs.FERALAS,
        },
        [262169] = { -- Twilight Ritualist : https://wowhead.com/forever/npc=262169/twilight-ritualist
            [npcKeys.name] = "Twilight Ritualist",
        },
        [262176] = { -- Stalker : https://wowhead.com/forever/npc=262176/stalker
            [npcKeys.name] = "Stalker",
        },
        [262224] = { -- [DNT] Template Creature : https://wowhead.com/forever/npc=262224/dnt-template-creature
            [npcKeys.name] = "[DNT] Template Creature",
        },
        [262284] = { -- Spek : https://wowhead.com/forever/npc=262284/spek
            [npcKeys.name] = "Spek",
            [npcKeys.spawns] = {[16591] = {{76.6, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [262294] = { -- Durganon : https://wowhead.com/forever/npc=262294/durganon
            [npcKeys.name] = "Durganon",
        },
        [262306] = { -- Mukomonji : https://wowhead.com/forever/npc=262306/mukomonji
            [npcKeys.name] = "Mukomonji",
        },
        [262379] = { -- Bullets Bigblast : https://wowhead.com/forever/npc=262379/bullets-bigblast
            [npcKeys.name] = "Bullets Bigblast",
        },
        [262383] = { -- Darkspear Shark : https://wowhead.com/forever/npc=262383/darkspear-shark
            [npcKeys.name] = "Darkspear Shark",
        },
        [262388] = { -- Juo : https://wowhead.com/forever/npc=262388/juo
            [npcKeys.name] = "Juo",
        },
        [262397] = { -- Brinescale Skirmisher : https://wowhead.com/forever/npc=262397/brinescale-skirmisher
            [npcKeys.name] = "Brinescale Skirmisher",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[33] = {{23, 21.8}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [262399] = { -- Gelinda Coppergleam : https://wowhead.com/forever/npc=262399/gelinda-coppergleam
            [npcKeys.name] = "Gelinda Coppergleam",
        },
        [262465] = { -- Daewyn Songblade : https://wowhead.com/forever/npc=262465/daewyn-songblade
            [npcKeys.name] = "Daewyn Songblade",
        },
        [262469] = { -- Tuu'li : https://wowhead.com/forever/npc=262469/tuuli
            [npcKeys.name] = "Tuu'li",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262471] = { -- Xaphod Bizznox : https://wowhead.com/forever/npc=262471/xaphod-bizznox
            [npcKeys.name] = "Xaphod Bizznox",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[406] = {{71.4, 99.4}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262472] = { -- Cinderscale Flamecaller : https://wowhead.com/forever/npc=262472/cinderscale-flamecaller
            [npcKeys.name] = "Cinderscale Flamecaller",
        },
        [262473] = { -- Cinderscale Whelp : https://wowhead.com/forever/npc=262473/cinderscale-whelp
            [npcKeys.name] = "Cinderscale Whelp",
        },
        [262477] = { -- Cinderscale Warrior : https://wowhead.com/forever/npc=262477/cinderscale-warrior
            [npcKeys.name] = "Cinderscale Warrior",
        },
        [262492] = { -- Rimblat Earthshatter : https://wowhead.com/forever/npc=262492/rimblat-earthshatter
            [npcKeys.name] = "Rimblat Earthshatter",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262502] = { -- Brix Xizzix : https://wowhead.com/forever/npc=262502/brix-xizzix
            [npcKeys.name] = "Brix Xizzix",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262504] = { -- Earthen Ring Shaman : https://wowhead.com/forever/npc=262504/earthen-ring-shaman
            [npcKeys.name] = "Earthen Ring Shaman",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262520] = { -- Pack Kodo : https://wowhead.com/forever/npc=262520/pack-kodo
            [npcKeys.name] = "Pack Kodo",
        },
        [262523] = { -- Galestrider : https://wowhead.com/forever/npc=262523/galestrider
            [npcKeys.name] = "Galestrider",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262539] = { -- Forlorn Ghost : https://wowhead.com/forever/npc=262539/forlorn-ghost
            [npcKeys.name] = "Forlorn Ghost",
        },
        [262558] = { -- Palah Thunderhoof : https://wowhead.com/forever/npc=262558/palah-thunderhoof
            [npcKeys.name] = "Palah Thunderhoof",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262560] = { -- Hana Lighthoof : https://wowhead.com/forever/npc=262560/hana-lighthoof
            [npcKeys.name] = "Hana Lighthoof",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [262585] = { -- Enraged Ghost : https://wowhead.com/forever/npc=262585/enraged-ghost
            [npcKeys.name] = "Enraged Ghost",
        },
        [262681] = { -- Ardin Grassman : https://wowhead.com/forever/npc=262681/ardin-grassman
            [npcKeys.name] = "Ardin Grassman",
        },
        [262692] = { -- Gharan Mountainstride : https://wowhead.com/forever/npc=262692/gharan-mountainstride
            [npcKeys.name] = "Gharan Mountainstride",
        },
        [262694] = { -- Melrissen Moonlight : https://wowhead.com/forever/npc=262694/melrissen-moonlight
            [npcKeys.name] = "Melrissen Moonlight",
        },
        [262713] = { -- Orcish Tradeskill Signpost : https://wowhead.com/forever/npc=262713/orcish-tradeskill-signpost
            [npcKeys.name] = "Orcish Tradeskill Signpost",
        },
        [262718] = { -- Alchemy : https://wowhead.com/forever/npc=262718/alchemy
            [npcKeys.name] = "Alchemy",
        },
        [262720] = { -- Blacksmithing : https://wowhead.com/forever/npc=262720/blacksmithing
            [npcKeys.name] = "Blacksmithing",
        },
        [262721] = { -- Cooking : https://wowhead.com/forever/npc=262721/cooking
            [npcKeys.name] = "Cooking",
        },
        [262722] = { -- Enchanting : https://wowhead.com/forever/npc=262722/enchanting
            [npcKeys.name] = "Enchanting",
        },
        [262723] = { -- Engineering : https://wowhead.com/forever/npc=262723/engineering
            [npcKeys.name] = "Engineering",
        },
        [262724] = { -- Leatherworking : https://wowhead.com/forever/npc=262724/leatherworking
            [npcKeys.name] = "Leatherworking",
        },
        [262725] = { -- Tailoring : https://wowhead.com/forever/npc=262725/tailoring
            [npcKeys.name] = "Tailoring",
        },
        [262727] = { -- Dwarven Tradeskill Signpost : https://wowhead.com/forever/npc=262727/dwarven-tradeskill-signpost
            [npcKeys.name] = "Dwarven Tradeskill Signpost",
        },
        [262728] = { -- Alchemy : https://wowhead.com/forever/npc=262728/alchemy
            [npcKeys.name] = "Alchemy",
        },
        [262729] = { -- Blacksmithing : https://wowhead.com/forever/npc=262729/blacksmithing
            [npcKeys.name] = "Blacksmithing",
        },
        [262730] = { -- Cooking : https://wowhead.com/forever/npc=262730/cooking
            [npcKeys.name] = "Cooking",
        },
        [262731] = { -- Enchanting : https://wowhead.com/forever/npc=262731/enchanting
            [npcKeys.name] = "Enchanting",
        },
        [262732] = { -- Engineering : https://wowhead.com/forever/npc=262732/engineering
            [npcKeys.name] = "Engineering",
        },
        [262733] = { -- Leatherworking : https://wowhead.com/forever/npc=262733/leatherworking
            [npcKeys.name] = "Leatherworking",
        },
        [262734] = { -- Tailoring : https://wowhead.com/forever/npc=262734/tailoring
            [npcKeys.name] = "Tailoring",
        },
        [262838] = { -- Magram Marauder : https://wowhead.com/forever/npc=262838/magram-marauder
            [npcKeys.name] = "Magram Marauder",
            [npcKeys.spawns] = {[16651] = {{45.2, 39.2}, {45.6, 42.8}, {60.2, 68.8}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [262986] = { -- Rusty Wolf Pup : https://wowhead.com/forever/npc=262986/rusty-wolf-pup
            [npcKeys.name] = "Rusty Wolf Pup",
        },
        [263071] = { -- Blademaster Kaijo : https://wowhead.com/forever/npc=263071/blademaster-kaijo
            [npcKeys.name] = "Blademaster Kaijo",
            [npcKeys.spawns] = {[16591] = {{57.4, 36.6}, {58.2, 37.8}, {58.4, 39.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263072] = { -- Piranha : https://wowhead.com/forever/npc=263072/piranha
            [npcKeys.name] = "Piranha",
        },
        [263089] = { -- Tessa Dawnbright : https://wowhead.com/forever/npc=263089/tessa-dawnbright
            [npcKeys.name] = "Tessa Dawnbright",
            [npcKeys.spawns] = {[16591] = {{63.8, 82.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263113] = { -- Myriaal Mistwake : https://wowhead.com/forever/npc=263113/myriaal-mistwake
            [npcKeys.name] = "Myriaal Mistwake",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{43.6, 24}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {92474},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [263120] = { -- Gray Dawnbright : https://wowhead.com/forever/npc=263120/gray-dawnbright
            [npcKeys.name] = "Gray Dawnbright",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{78.8, 54}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263141] = { -- Scaldaron : https://wowhead.com/forever/npc=263141/scaldaron
            [npcKeys.name] = "Scaldaron",
        },
        [263190] = { -- Tan'jani : https://wowhead.com/forever/npc=263190/tanjani
            [npcKeys.name] = "Tan'jani",
            [npcKeys.spawns] = {[16591] = {{58, 45}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263225] = { -- [DNT] Kill Credit: Freshwater Crocolisk : https://wowhead.com/forever/npc=263225/dnt-kill-credit-freshwater-crocolisk
            [npcKeys.name] = "[DNT] Kill Credit: Freshwater Crocolisk",
        },
        [263230] = { -- Dorb : https://wowhead.com/forever/npc=263230/dorb
            [npcKeys.name] = "Dorb",
            [npcKeys.spawns] = {[16591] = {{63.8, 17.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263277] = { -- [DNT] Kill Credit: Drained Crystal : https://wowhead.com/forever/npc=263277/dnt-kill-credit-drained-crystal
            [npcKeys.name] = "[DNT] Kill Credit: Drained Crystal",
        },
        [263307] = { -- Glade Viper : https://wowhead.com/forever/npc=263307/glade-viper
            [npcKeys.name] = "Glade Viper",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 37,
        },
        [263315] = { -- Ombassa : https://wowhead.com/forever/npc=263315/ombassa
            [npcKeys.name] = "Ombassa",
        },
        [263316] = { -- Picked Carcass : https://wowhead.com/forever/npc=263316/picked-carcass
            [npcKeys.name] = "Picked Carcass",
        },
        [263326] = { -- Madam Swyndle : https://wowhead.com/forever/npc=263326/madam-swyndle
            [npcKeys.name] = "Madam Swyndle",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[16591] = {{78.2, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [263343] = { -- Low Plains Buzzard : https://wowhead.com/forever/npc=263343/low-plains-buzzard
            [npcKeys.name] = "Low Plains Buzzard",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 38,
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263348] = { -- Roving Tallstrider : https://wowhead.com/forever/npc=263348/roving-tallstrider
            [npcKeys.name] = "Roving Tallstrider",
            [npcKeys.minLevel] = 37,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{65.4, 65}, {65.4, 68.2}, {67, 48}, {69.2, 55.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [263349] = { -- James Battlewing : https://wowhead.com/forever/npc=263349/james-battlewing
            [npcKeys.name] = "James Battlewing",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [263367] = { -- Sleebo Fizzlespout : https://wowhead.com/forever/npc=263367/sleebo-fizzlespout
            [npcKeys.name] = "Sleebo Fizzlespout",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[16591] = {{68, 48.6}, {68.2, 48.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263369] = { -- G45-B4G : https://wowhead.com/forever/npc=263369/g45-b4g
            [npcKeys.name] = "G45-B4G",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
        },
        [263380] = { -- Ghostmaw : https://wowhead.com/forever/npc=263380/ghostmaw
            [npcKeys.name] = "Ghostmaw",
            [npcKeys.minLevel] = 42,
            [npcKeys.maxLevel] = 42,
        },
        [263384] = { -- Mister Graphed : https://wowhead.com/forever/npc=263384/mister-graphed
            [npcKeys.name] = "Mister Graphed",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[16591] = {{78.2, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [263389] = { -- Enraged Apparition : https://wowhead.com/forever/npc=263389/enraged-apparition
            [npcKeys.name] = "Enraged Apparition",
        },
        [263390] = { -- Tormented Soul : https://wowhead.com/forever/npc=263390/tormented-soul
            [npcKeys.name] = "Tormented Soul",
        },
        [263394] = { -- Bethra'zel : https://wowhead.com/forever/npc=263394/bethrazel
            [npcKeys.name] = "Bethra'zel",
        },
        [263396] = { -- Dark Iron Looter : https://wowhead.com/forever/npc=263396/dark-iron-looter
            [npcKeys.name] = "Dark Iron Looter",
        },
        [263397] = { -- Dark Iron Engineer : https://wowhead.com/forever/npc=263397/dark-iron-engineer
            [npcKeys.name] = "Dark Iron Engineer",
        },
        [263398] = { -- Camp Tent : https://wowhead.com/forever/npc=263398/camp-tent
            [npcKeys.name] = "Camp Tent",
        },
        [263399] = { -- Sam Sarsaparilla : https://wowhead.com/forever/npc=263399/sam-sarsaparilla
            [npcKeys.name] = "Sam Sarsaparilla",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[12] = {{44.8, 63.2}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.questStarts] = {95998, 96626, 97915, 97916, 97917, 97918, 97919, 97920, 97921, 97922, 97923, 97924, 97925},
            [npcKeys.questEnds] = {95998, 96627},
            [npcKeys.friendlyToFaction] = "A",
        },
        [263406] = { -- Elaena Moonwhisper : https://wowhead.com/forever/npc=263406/elaena-moonwhisper
            [npcKeys.name] = "Elaena Moonwhisper",
            [npcKeys.spawns] = {[616] = {{43.6, 32.4}, {43.6, 32.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [263426] = { -- Mazzogore the Weak : https://wowhead.com/forever/npc=263426/mazzogore-the-weak
            [npcKeys.name] = "Mazzogore the Weak",
        },
        [263427] = { -- Bethra'zel the Feeble : https://wowhead.com/forever/npc=263427/bethrazel-the-feeble
            [npcKeys.name] = "Bethra'zel the Feeble",
        },
        [263428] = { -- Stalker : https://wowhead.com/forever/npc=263428/stalker
            [npcKeys.name] = "Stalker",
        },
        [263435] = { -- [DNT] Kill Credit: Western pylon repaired : https://wowhead.com/forever/npc=263435/dnt-kill-credit-western-pylon-repaired
            [npcKeys.name] = "[DNT] Kill Credit: Western pylon repaired",
        },
        [263436] = { -- [DNT] Kill Credit: Eastern pylon repaired : https://wowhead.com/forever/npc=263436/dnt-kill-credit-eastern-pylon-repaired
            [npcKeys.name] = "[DNT] Kill Credit: Eastern pylon repaired",
        },
        [263438] = { -- Dark Iron Summoner : https://wowhead.com/forever/npc=263438/dark-iron-summoner
            [npcKeys.name] = "Dark Iron Summoner",
        },
        [263440] = { -- Hamur : https://wowhead.com/forever/npc=263440/hamur
            [npcKeys.name] = "Hamur",
            [npcKeys.spawns] = {[16591] = {{67, 21.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263445] = { -- Mayena Earthseeker : https://wowhead.com/forever/npc=263445/mayena-earthseeker
            [npcKeys.name] = "Mayena Earthseeker",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [263455] = { -- Bal'mog : https://wowhead.com/forever/npc=263455/balmog
            [npcKeys.name] = "Bal'mog",
            [npcKeys.spawns] = {[16591] = {{62.6, 18}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263458] = { -- [DNT] Kill Credit: Pillar of Assimilation : https://wowhead.com/forever/npc=263458/dnt-kill-credit-pillar-of-assimilation
            [npcKeys.name] = "[DNT] Kill Credit: Pillar of Assimilation",
        },
        [263460] = { -- [DNT] Kill Credit:Regrowth Vestibule : https://wowhead.com/forever/npc=263460/dnt-kill-credit-regrowth-vestibule
            [npcKeys.name] = "[DNT] Kill Credit:Regrowth Vestibule",
        },
        [263461] = { -- [DNT] Kill Credit: The Doors : https://wowhead.com/forever/npc=263461/dnt-kill-credit-the-doors
            [npcKeys.name] = "[DNT] Kill Credit: The Doors",
        },
        [263462] = { -- [DNT] Kill Credit: Destroyed Watcher : https://wowhead.com/forever/npc=263462/dnt-kill-credit-destroyed-watcher
            [npcKeys.name] = "[DNT] Kill Credit: Destroyed Watcher",
        },
        [263466] = { -- Lesser Stone Golem : https://wowhead.com/forever/npc=263466/lesser-stone-golem
            [npcKeys.name] = "Lesser Stone Golem",
        },
        [263467] = { -- Fiery Assistant : https://wowhead.com/forever/npc=263467/fiery-assistant
            [npcKeys.name] = "Fiery Assistant",
        },
        [263470] = { -- Bloodhound Runt : https://wowhead.com/forever/npc=263470/bloodhound-runt
            [npcKeys.name] = "Bloodhound Runt",
        },
        [263491] = { -- [DNT] Kill Credit: Shen'dralas wildlife slain with the blade : https://wowhead.com/forever/npc=263491/dnt-kill-credit-shendralas-wildlife-slain-with-the-blade
            [npcKeys.name] = "[DNT] Kill Credit: Shen'dralas wildlife slain with the blade",
        },
        [263493] = { -- Ghostly Beast : https://wowhead.com/forever/npc=263493/ghostly-beast
            [npcKeys.name] = "Ghostly Beast",
        },
        [263558] = { -- By'zaali : https://wowhead.com/forever/npc=263558/byzaali
            [npcKeys.name] = "By'zaali",
        },
        [263559] = { -- Child of By'zaali : https://wowhead.com/forever/npc=263559/child-of-byzaali
            [npcKeys.name] = "Child of By'zaali",
        },
        [263569] = { -- Bryanna Embreeze : https://wowhead.com/forever/npc=263569/bryanna-embreeze
            [npcKeys.name] = "Bryanna Embreeze",
            [npcKeys.spawns] = {[17] = {{63.4, 58.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [263570] = { -- Creeg Bothunk : https://wowhead.com/forever/npc=263570/creeg-bothunk
            [npcKeys.name] = "Creeg Bothunk",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[17] = {{65, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [263611] = { -- Diseased Soldier : https://wowhead.com/forever/npc=263611/diseased-soldier
            [npcKeys.name] = "Diseased Soldier",
            [npcKeys.spawns] = {[16591] = {{61.8, 83}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263613] = { -- Brother Lowley : https://wowhead.com/forever/npc=263613/brother-lowley
            [npcKeys.name] = "Brother Lowley",
            [npcKeys.spawns] = {[16591] = {{65.4, 78.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263614] = { -- Wounded Soldier : https://wowhead.com/forever/npc=263614/wounded-soldier
            [npcKeys.name] = "Wounded Soldier",
            [npcKeys.spawns] = {[16591] = {{65.4, 79.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263615] = { -- Krek the Noxious : https://wowhead.com/forever/npc=263615/krek-the-noxious
            [npcKeys.name] = "Krek the Noxious",
        },
        [263643] = { -- Sean Guardoff : https://wowhead.com/forever/npc=263643/sean-guardoff
            [npcKeys.name] = "Sean Guardoff",
            [npcKeys.spawns] = {[1537] = {{70.2, 89.2}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [263644] = { -- Pherry Leftee : https://wowhead.com/forever/npc=263644/pherry-leftee
            [npcKeys.name] = "Pherry Leftee",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.spawns] = {[1657] = {{58.4, 34.4}, {58.4, 34.6}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [263645] = { -- Gruga Bloodblade : https://wowhead.com/forever/npc=263645/gruga-bloodblade
            [npcKeys.name] = "Gruga Bloodblade",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.spawns] = {[1637] = {{79.6, 30.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [263646] = { -- Rugbul Boomfirst : https://wowhead.com/forever/npc=263646/rugbul-boomfirst
            [npcKeys.name] = "Rugbul Boomfirst",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.spawns] = {[1497] = {{60, 86.8}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.friendlyToFaction] = "H",
        },
        [263647] = { -- Borook Gallfist : https://wowhead.com/forever/npc=263647/borook-gallfist
            [npcKeys.name] = "Borook Gallfist",
            [npcKeys.minLevel] = 61,
            [npcKeys.maxLevel] = 61,
            [npcKeys.spawns] = {[1638] = {{57, 76.8}}},
            [npcKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [npcKeys.friendlyToFaction] = "H",
        },
        [263664] = { -- Raan Wildwind : https://wowhead.com/forever/npc=263664/raan-wildwind
            [npcKeys.name] = "Raan Wildwind",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{41.6, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {96101, 96646, 97963, 97964, 97965, 97967, 97968, 97969, 97970, 97971, 97972, 97973, 98284, 98286},
            [npcKeys.questEnds] = {96101, 96638},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [263681] = { -- Bear : https://wowhead.com/forever/npc=263681/bear
            [npcKeys.name] = "Bear",
        },
        [263718] = { -- Bristleback Bodyguard : https://wowhead.com/forever/npc=263718/bristleback-bodyguard
            [npcKeys.name] = "Bristleback Bodyguard",
        },
        [263749] = { -- Gronok the Butcher : https://wowhead.com/forever/npc=263749/gronok-the-butcher
            [npcKeys.name] = "Gronok the Butcher",
            [npcKeys.spawns] = {[16591] = {{67.6, 19.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [263757] = { -- Felflick : https://wowhead.com/forever/npc=263757/felflick
            [npcKeys.name] = "Felflick",
            [npcKeys.spawns] = {[616] = {{49, 77.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [263758] = { -- Felfire Imp : https://wowhead.com/forever/npc=263758/felfire-imp
            [npcKeys.name] = "Felfire Imp",
        },
        [263806] = { -- [DNT] Kill Credit: Work Stations Disrupted [Vessel] : https://wowhead.com/forever/npc=263806/dnt-kill-credit-work-stations-disrupted-vessel
            [npcKeys.name] = "[DNT] Kill Credit: Work Stations Disrupted [Vessel]",
        },
        [263807] = { -- [DNT] Kill Credit: Work Stations Disrupted [Alchemy] : https://wowhead.com/forever/npc=263807/dnt-kill-credit-work-stations-disrupted-alchemy
            [npcKeys.name] = "[DNT] Kill Credit: Work Stations Disrupted [Alchemy]",
        },
        [263808] = { -- [DNT] Kill Credit: Work Stations Disrupted [Disease] : https://wowhead.com/forever/npc=263808/dnt-kill-credit-work-stations-disrupted-disease
            [npcKeys.name] = "[DNT] Kill Credit: Work Stations Disrupted [Disease]",
        },
        [263833] = { -- Caalaan Corswaain : https://wowhead.com/forever/npc=263833/caalaan-corswaain
            [npcKeys.name] = "Caalaan Corswaain",
        },
        [263852] = { -- High Order Mage : https://wowhead.com/forever/npc=263852/high-order-mage
            [npcKeys.name] = "High Order Mage",
        },
        [263854] = { -- Translocation : https://wowhead.com/forever/npc=263854/translocation
            [npcKeys.name] = "Translocation",
        },
        [263860] = { -- Altar of the Wind Spirit : https://wowhead.com/forever/npc=263860/altar-of-the-wind-spirit
            [npcKeys.name] = "Altar of the Wind Spirit",
        },
        [263911] = { -- Dummy Quest Kill Credit : https://wowhead.com/forever/npc=263911/dummy-quest-kill-credit
            [npcKeys.name] = "Dummy Quest Kill Credit",
        },
        [263918] = { -- Thalanaar Hippogryph : https://wowhead.com/forever/npc=263918/thalanaar-hippogryph
            [npcKeys.name] = "Thalanaar Hippogryph",
        },
        [263919] = { -- Searshrike Wormwing : https://wowhead.com/forever/npc=263919/searshrike-wormwing
            [npcKeys.name] = "Searshrike Wormwing",
        },
        [263922] = { -- [DNT] Kill Credit: Bones thrown into the Sime Pit : https://wowhead.com/forever/npc=263922/dnt-kill-credit-bones-thrown-into-the-sime-pit
            [npcKeys.name] = "[DNT] Kill Credit: Bones thrown into the Sime Pit",
        },
        [263930] = { -- Peacekeeper : https://wowhead.com/forever/npc=263930/peacekeeper
            [npcKeys.name] = "Peacekeeper",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57.8, 68.8}, {57.8, 70}, {57.8, 70.6}, {58, 64.4}, {58, 65}, {58, 66}, {58, 67.2}, {58, 68}, {58.2, 72.4}, {58.2, 72.8}, {58.4, 63}, {58.4, 73.6}, {58.6, 61.8}, {58.6, 63}, {58.6, 73.6}, {58.8, 60.4}, {58.8, 61}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [263935] = { -- Old Rusthowl : https://wowhead.com/forever/npc=263935/old-rusthowl
            [npcKeys.name] = "Old Rusthowl",
        },
        [263980] = { -- Seaforium Blasting Powder : https://wowhead.com/forever/npc=263980/seaforium-blasting-powder
            [npcKeys.name] = "Seaforium Blasting Powder",
        },
        [263981] = { -- Bloodhound Runt : https://wowhead.com/forever/npc=263981/bloodhound-runt
            [npcKeys.name] = "Bloodhound Runt",
        },
        [264041] = { -- Burning Bunny : https://wowhead.com/forever/npc=264041/burning-bunny
            [npcKeys.name] = "Burning Bunny",
        },
        [264072] = { -- Yorn Grimtotem : https://wowhead.com/forever/npc=264072/yorn-grimtotem
            [npcKeys.name] = "Yorn Grimtotem",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [264074] = { -- Mazu'kon : https://wowhead.com/forever/npc=264074/mazukon
            [npcKeys.name] = "Mazu'kon",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [264078] = { -- Sutara Plainstalker : https://wowhead.com/forever/npc=264078/sutara-plainstalker
            [npcKeys.name] = "Sutara Plainstalker",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [264079] = { -- Gloomrise Hatchling : https://wowhead.com/forever/npc=264079/gloomrise-hatchling
            [npcKeys.name] = "Gloomrise Hatchling",
        },
        [264081] = { -- Gloomrise Spinner : https://wowhead.com/forever/npc=264081/gloomrise-spinner
            [npcKeys.name] = "Gloomrise Spinner",
        },
        [264082] = { -- Broodmother Valraxx : https://wowhead.com/forever/npc=264082/broodmother-valraxx
            [npcKeys.name] = "Broodmother Valraxx",
        },
        [264083] = { -- Gloomrise Soldier : https://wowhead.com/forever/npc=264083/gloomrise-soldier
            [npcKeys.name] = "Gloomrise Soldier",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 29,
        },
        [264089] = { -- Eluneth : https://wowhead.com/forever/npc=264089/eluneth
            [npcKeys.name] = "Eluneth",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{18.4, 61.8}, {18.8, 61.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [264096] = { -- Gnawed Corpse : https://wowhead.com/forever/npc=264096/gnawed-corpse
            [npcKeys.name] = "Gnawed Corpse",
        },
        [264139] = { -- Stalker : https://wowhead.com/forever/npc=264139/stalker
            [npcKeys.name] = "Stalker",
        },
        [264149] = { -- Unstable Mana Rift : https://wowhead.com/forever/npc=264149/unstable-mana-rift
            [npcKeys.name] = "Unstable Mana Rift",
            [npcKeys.spawns] = {[16651] = {{48.6, 43}}},
            [npcKeys.zoneID] = zoneIDs.SHEN_DRALAS,
        },
        [264176] = { -- Rare Proxy Stalker : https://wowhead.com/forever/npc=264176/rare-proxy-stalker
            [npcKeys.name] = "Rare Proxy Stalker",
        },
        [264232] = { -- [DNT] Quest Kill Credit - Cured Tainted Hyjal Grovewalker : https://wowhead.com/forever/npc=264232/dnt-quest-kill-credit-cured-tainted-hyjal-grovewalker
            [npcKeys.name] = "[DNT] Quest Kill Credit - Cured Tainted Hyjal Grovewalker",
        },
        [264235] = { -- Alliance Rank PvP Vendor : https://wowhead.com/forever/npc=264235/alliance-rank-pvp-vendor
            [npcKeys.name] = "Alliance Rank PvP Vendor",
        },
        [264236] = { -- Horde Rank PvP Vendor : https://wowhead.com/forever/npc=264236/horde-rank-pvp-vendor
            [npcKeys.name] = "Horde Rank PvP Vendor",
        },
        [264238] = { -- Alliance Rank PvP Vendor : https://wowhead.com/forever/npc=264238/alliance-rank-pvp-vendor
            [npcKeys.name] = "Alliance Rank PvP Vendor",
        },
        [264239] = { -- Horde Rank PvP Vendor : https://wowhead.com/forever/npc=264239/horde-rank-pvp-vendor
            [npcKeys.name] = "Horde Rank PvP Vendor",
        },
        [264265] = { -- Magus Olvek : https://wowhead.com/forever/npc=264265/magus-olvek
            [npcKeys.name] = "Magus Olvek",
            [npcKeys.spawns] = {[36] = {{9.6, 62.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [264266] = { -- Olvek : https://wowhead.com/forever/npc=264266/olvek
            [npcKeys.name] = "Olvek",
        },
        [264272] = { -- Stalker : https://wowhead.com/forever/npc=264272/stalker
            [npcKeys.name] = "Stalker",
        },
        [264287] = { -- Galestrider Handler : https://wowhead.com/forever/npc=264287/galestrider-handler
            [npcKeys.name] = "Galestrider Handler",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [264302] = { -- Awakened Fel Ash Slime : https://wowhead.com/forever/npc=264302/awakened-fel-ash-slime
            [npcKeys.name] = "Awakened Fel Ash Slime",
        },
        [264306] = { -- Awakened Fel Ash Slime : https://wowhead.com/forever/npc=264306/awakened-fel-ash-slime
            [npcKeys.name] = "Awakened Fel Ash Slime",
        },
        [264333] = { -- Grimroot : https://wowhead.com/forever/npc=264333/grimroot
            [npcKeys.name] = "Grimroot",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{17.4, 60.4}, {17.6, 60.2}, {18.2, 60.8}, {18.8, 61.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [264352] = { -- [DNT] Kill Credit: Work Stations Disrupted [Slime] : https://wowhead.com/forever/npc=264352/dnt-kill-credit-work-stations-disrupted-slime
            [npcKeys.name] = "[DNT] Kill Credit: Work Stations Disrupted [Slime]",
        },
        [264403] = { -- Equipment Enchants : https://wowhead.com/forever/npc=264403/equipment-enchants
            [npcKeys.name] = "Equipment Enchants",
        },
        [264428] = { -- Doraan : https://wowhead.com/forever/npc=264428/doraan
            [npcKeys.name] = "Doraan",
            [npcKeys.spawns] = {[15] = {{65.4, 66.6}, {65.6, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [264473] = { -- Highfeather Maverick : https://wowhead.com/forever/npc=264473/highfeather-maverick
            [npcKeys.name] = "Highfeather Maverick",
            [npcKeys.spawns] = {[616] = {{54.2, 64.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [264508] = { -- Blackthorne Courier : https://wowhead.com/forever/npc=264508/blackthorne-courier
            [npcKeys.name] = "Blackthorne Courier",
        },
        [264521] = { -- Daythor Brellan : https://wowhead.com/forever/npc=264521/daythor-brellan
            [npcKeys.name] = "Daythor Brellan",
            [npcKeys.spawns] = {[616] = {{15.4, 52}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [264528] = { -- [DNT] Kill Credit : https://wowhead.com/forever/npc=264528/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit",
        },
        [264551] = { -- Disturbed Ghoul : https://wowhead.com/forever/npc=264551/disturbed-ghoul
            [npcKeys.name] = "Disturbed Ghoul",
        },
        [264570] = { -- Blackthorne Adept : https://wowhead.com/forever/npc=264570/blackthorne-adept
            [npcKeys.name] = "Blackthorne Adept",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
        },
        [264632] = { -- Sister : https://wowhead.com/forever/npc=264632/sister
            [npcKeys.name] = "Sister",
        },
        [264634] = { -- Leo : https://wowhead.com/forever/npc=264634/leo
            [npcKeys.name] = "Leo",
        },
        [264636] = { -- Buster : https://wowhead.com/forever/npc=264636/buster
            [npcKeys.name] = "Buster",
        },
        [264638] = { -- Callie : https://wowhead.com/forever/npc=264638/callie
            [npcKeys.name] = "Callie",
        },
        [264639] = { -- Bebe : https://wowhead.com/forever/npc=264639/bebe
            [npcKeys.name] = "Bebe",
        },
        [264663] = { -- Dead Orc : https://wowhead.com/forever/npc=264663/dead-orc
            [npcKeys.name] = "Dead Orc",
            [npcKeys.spawns] = {[15] = {{72.6, 18.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [264707] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=264707/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit:",
        },
        [264708] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=264708/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit: ",
        },
        [264709] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=264709/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit:",
        },
        [264712] = { -- High Priestess Lorthuna : https://wowhead.com/forever/npc=264712/high-priestess-lorthuna
            [npcKeys.name] = "High Priestess Lorthuna",
        },
        [264713] = { -- Commander Haalien : https://wowhead.com/forever/npc=264713/commander-haalien
            [npcKeys.name] = "Commander Haalien",
        },
        [264715] = { -- Wisp : https://wowhead.com/forever/npc=264715/wisp
            [npcKeys.name] = "Wisp",
        },
        [264795] = { -- Marn Euhorn : https://wowhead.com/forever/npc=264795/marn-euhorn
            [npcKeys.name] = "Marn Euhorn",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{68.4, 46.6}, {68.6, 46.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [264797] = { -- Aisarra Nightmeadow : https://wowhead.com/forever/npc=264797/aisarra-nightmeadow
            [npcKeys.name] = "Aisarra Nightmeadow",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.spawns] = {[616] = {{71, 51.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [264839] = { -- [DNT] Kill Credit: Armor slot selected for study : https://wowhead.com/forever/npc=264839/dnt-kill-credit-armor-slot-selected-for-study
            [npcKeys.name] = "[DNT] Kill Credit: Armor slot selected for study",
        },
        [264850] = { -- Hawk : https://wowhead.com/forever/npc=264850/hawk
            [npcKeys.name] = "Hawk",
        },
        [264861] = { -- KC Creature : https://wowhead.com/forever/npc=264861/kc-creature
            [npcKeys.name] = "KC Creature",
        },
        [264867] = { -- Ghansurok : https://wowhead.com/forever/npc=264867/ghansurok
            [npcKeys.name] = "Ghansurok",
        },
        [264881] = { -- [DNT] Kill Credit : https://wowhead.com/forever/npc=264881/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit",
        },
        [264936] = { -- Earthseer Farsen : https://wowhead.com/forever/npc=264936/earthseer-farsen
            [npcKeys.name] = "Earthseer Farsen",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[1] = {{64.8, 58.4}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.questStarts] = {96390, 96392, 96393},
            [npcKeys.questEnds] = {96390, 96391, 96392, 96408},
            [npcKeys.friendlyToFaction] = "A",
        },
        [264937] = { -- Farsen's Totem : https://wowhead.com/forever/npc=264937/farsens-totem
            [npcKeys.name] = "Farsen's Totem",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.friendlyToFaction] = "A",
        },
        [264943] = { -- Afadra Dunwall : https://wowhead.com/forever/npc=264943/afadra-dunwall
            [npcKeys.name] = "Afadra Dunwall",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[1537] = {{32.4, 47.8}, {32.8, 48.6}, {33.2, 47.4}, {33.2, 47.8}, {33.6, 48}, {34, 45.8}, {34, 48.8}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.questStarts] = {96394},
            [npcKeys.questEnds] = {96394},
            [npcKeys.friendlyToFaction] = "A",
        },
        [265002] = { -- Ghostly Attendant : https://wowhead.com/forever/npc=265002/ghostly-attendant
            [npcKeys.name] = "Ghostly Attendant",
        },
        [265003] = { -- Thom Filch : https://wowhead.com/forever/npc=265003/thom-filch
            [npcKeys.name] = "Thom Filch",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[1537] = {{31.4, 45.4}, {31.4, 45.8}, {31.6, 45.6}, {32.4, 44.4}, {32.4, 44.8}, {32.6, 44.4}, {32.6, 44.6}, {32.8, 42.8}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.questStarts] = {96403},
            [npcKeys.questEnds] = {96403},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [265026] = { -- Murkborn Elemental : https://wowhead.com/forever/npc=265026/murkborn-elemental
            [npcKeys.name] = "Murkborn Elemental",
        },
        [265143] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=265143/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit: ",
        },
        [265148] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=265148/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit: ",
        },
        [265155] = { -- Barkskin Ancestor : https://wowhead.com/forever/npc=265155/barkskin-ancestor
            [npcKeys.name] = "Barkskin Ancestor",
        },
        [265190] = { -- Stalker : https://wowhead.com/forever/npc=265190/stalker
            [npcKeys.name] = "Stalker",
        },
        [265207] = { -- Statue : https://wowhead.com/forever/npc=265207/statue
            [npcKeys.name] = "Statue",
        },
        [265208] = { -- Tent : https://wowhead.com/forever/npc=265208/tent
            [npcKeys.name] = "Tent",
        },
        [265220] = { -- Ward of Zum'rah : https://wowhead.com/forever/npc=265220/ward-of-zumrah
            [npcKeys.name] = "Ward of Zum'rah",
        },
        [265223] = { -- Zombie Troll of Zum'rah : https://wowhead.com/forever/npc=265223/zombie-troll-of-zumrah
            [npcKeys.name] = "Zombie Troll of Zum'rah",
        },
        [265315] = { -- [DNT] Kill Credit: Speak to the demon captive : https://wowhead.com/forever/npc=265315/dnt-kill-credit-speak-to-the-demon-captive
            [npcKeys.name] = "[DNT] Kill Credit: Speak to the demon captive",
        },
        [265346] = { -- Aurian Highgrove : https://wowhead.com/forever/npc=265346/aurian-highgrove
            [npcKeys.name] = "Aurian Highgrove",
            [npcKeys.spawns] = {[11] = {{52.6, 80.2}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [265347] = { -- Bhalir Firebrew : https://wowhead.com/forever/npc=265347/bhalir-firebrew
            [npcKeys.name] = "Bhalir Firebrew",
            [npcKeys.spawns] = {[11] = {{52.8, 80}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [265348] = { -- Agriel Firebrew : https://wowhead.com/forever/npc=265348/agriel-firebrew
            [npcKeys.name] = "Agriel Firebrew",
            [npcKeys.spawns] = {[11] = {{52.8, 80}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [265375] = { -- Veteran of the Third War : https://wowhead.com/forever/npc=265375/veteran-of-the-third-war
            [npcKeys.name] = "Veteran of the Third War",
        },
        [265472] = { -- Riding Striped Dawnsaber : https://wowhead.com/forever/npc=265472/riding-striped-dawnsaber
            [npcKeys.name] = "Riding Striped Dawnsaber",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[1657] = {{38.4, 15.4}, {38.4, 15.6}, {38.6, 16.6}, {38.8, 15.8}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [265574] = { -- Winklespark : https://wowhead.com/forever/npc=265574/winklespark
            [npcKeys.name] = "Winklespark",
            [npcKeys.minLevel] = 22,
            [npcKeys.maxLevel] = 22,
            [npcKeys.spawns] = {[17] = {{62.4, 37.6}, {62.6, 37.4}, {62.6, 37.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [265575] = { -- Gezzy Gunkgear : https://wowhead.com/forever/npc=265575/gezzy-gunkgear
            [npcKeys.name] = "Gezzy Gunkgear",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 36,
            [npcKeys.spawns] = {[33] = {{28.2, 74.8}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [265576] = { -- Rettrick : https://wowhead.com/forever/npc=265576/rettrick
            [npcKeys.name] = "Rettrick",
            [npcKeys.minLevel] = 44,
            [npcKeys.maxLevel] = 44,
            [npcKeys.spawns] = {[440] = {{51.6, 28.6}}},
            [npcKeys.zoneID] = zoneIDs.TANARIS,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [265577] = { -- Zippie Fizzbolt : https://wowhead.com/forever/npc=265577/zippie-fizzbolt
            [npcKeys.name] = "Zippie Fizzbolt",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[618] = {{61.4, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [265586] = { -- Thylaen : https://wowhead.com/forever/npc=265586/thylaen
            [npcKeys.name] = "Thylaen",
            [npcKeys.spawns] = {[616] = {{54.8, 84.2}, {54.8, 84.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265653] = { -- Ochre Skeletal Warhorse : https://wowhead.com/forever/npc=265653/ochre-skeletal-warhorse
            [npcKeys.name] = "Ochre Skeletal Warhorse",
            [npcKeys.spawns] = {[85] = {{59.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [265654] = { -- Faladriaal Featherfall : https://wowhead.com/forever/npc=265654/faladriaal-featherfall
            [npcKeys.name] = "Faladriaal Featherfall",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{61, 76.4}, {61, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [265675] = { -- High Order Mage : https://wowhead.com/forever/npc=265675/high-order-mage
            [npcKeys.name] = "High Order Mage",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[36] = {{11.6, 54.8}, {11.8, 56.8}, {11.8, 57.6}, {12.2, 52.4}, {12.2, 52.6}, {12.4, 59}, {12.6, 55.8}, {12.6, 59}, {12.6, 63.2}, {12.8, 55.4}, {13.6, 64.4}, {13.8, 57.6}, {14, 52.8}, {14.4, 60.2}, {14.6, 58.2}, {14.6, 60.2}, {15, 62.4}, {15.2, 63}, {15.6, 56}}},
            [npcKeys.friendlyToFaction] = "A",
        },
        [265682] = { -- Stalker : https://wowhead.com/forever/npc=265682/stalker
            [npcKeys.name] = "Stalker",
        },
        [265684] = { -- Darkspear Islands Battlemaster : https://wowhead.com/forever/npc=265684/darkspear-islands-battlemaster
            [npcKeys.name] = "Darkspear Islands Battlemaster",
        },
        [265696] = { -- Knight Jaston Valarias : https://wowhead.com/forever/npc=265696/knight-jaston-valarias
            [npcKeys.name] = "Knight Jaston Valarias",
        },
        [265697] = { -- Sergeant Tobin Wheeldon : https://wowhead.com/forever/npc=265697/sergeant-tobin-wheeldon
            [npcKeys.name] = "Sergeant Tobin Wheeldon",
        },
        [265701] = { -- Captain Truman : https://wowhead.com/forever/npc=265701/captain-truman
            [npcKeys.name] = "Captain Truman",
        },
        [265724] = { -- Shimmering Outline : https://wowhead.com/forever/npc=265724/shimmering-outline
            [npcKeys.name] = "Shimmering Outline",
        },
        [265727] = { -- Seasoned Adventurer : https://wowhead.com/forever/npc=265727/seasoned-adventurer
            [npcKeys.name] = "Seasoned Adventurer",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [265730] = { -- Ajay Green : https://wowhead.com/forever/npc=265730/ajay-green
            [npcKeys.name] = "Ajay Green",
            [npcKeys.spawns] = {[36] = {{14.4, 64.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [265747] = { -- Parachute-Priest : https://wowhead.com/forever/npc=265747/parachute-priest
            [npcKeys.name] = "Parachute-Priest",
        },
        [265756] = { -- Genn Fairweather : https://wowhead.com/forever/npc=265756/genn-fairweather
            [npcKeys.name] = "Genn Fairweather",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[16593] = {{53.8, 81.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [265757] = { -- Stormy Galestrider : https://wowhead.com/forever/npc=265757/stormy-galestrider
            [npcKeys.name] = "Stormy Galestrider",
        },
        [265758] = { -- Regal Galestrider : https://wowhead.com/forever/npc=265758/regal-galestrider
            [npcKeys.name] = "Regal Galestrider",
        },
        [265759] = { -- Empyrean Galestrider : https://wowhead.com/forever/npc=265759/empyrean-galestrider
            [npcKeys.name] = "Empyrean Galestrider",
        },
        [265760] = { -- Swift Umber Galestrider : https://wowhead.com/forever/npc=265760/swift-umber-galestrider
            [npcKeys.name] = "Swift Umber Galestrider",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[16593] = {{54, 80.4}, {54, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [265761] = { -- Swift Stormy Galestrider : https://wowhead.com/forever/npc=265761/swift-stormy-galestrider
            [npcKeys.name] = "Swift Stormy Galestrider",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[16593] = {{53.8, 80.8}, {54, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [265762] = { -- Swift Empyrean Galestrider : https://wowhead.com/forever/npc=265762/swift-empyrean-galestrider
            [npcKeys.name] = "Swift Empyrean Galestrider",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[16593] = {{54, 80.6}, {54.2, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [265788] = { -- Kal'tinzan : https://wowhead.com/forever/npc=265788/kaltinzan
            [npcKeys.name] = "Kal'tinzan",
            [npcKeys.spawns] = {[616] = {{13.6, 52.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265796] = { -- Wild Chicken : https://wowhead.com/forever/npc=265796/wild-chicken
            [npcKeys.name] = "Wild Chicken",
        },
        [265797] = { -- Wild Chicken : https://wowhead.com/forever/npc=265797/wild-chicken
            [npcKeys.name] = "Wild Chicken",
        },
        [265804] = { -- Elaadrin Evengale : https://wowhead.com/forever/npc=265804/elaadrin-evengale
            [npcKeys.name] = "Elaadrin Evengale",
        },
        [265809] = { -- Brakk : https://wowhead.com/forever/npc=265809/brakk
            [npcKeys.name] = "Brakk",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[14] = {{52, 47.4}, {52, 47.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.questStarts] = {96102, 96604, 96655, 97899, 97900, 97901, 97902, 97903, 97904, 97905, 97906, 97907, 97908},
            [npcKeys.questEnds] = {96604, 96652},
            [npcKeys.friendlyToFaction] = "H",
        },
        [265810] = { -- Kaga Wildhoof : https://wowhead.com/forever/npc=265810/kaga-wildhoof
            [npcKeys.name] = "Kaga Wildhoof",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {96605, 96661, 97927, 97928, 97929, 97931, 97932, 97933, 97934, 97935, 97936, 97937},
            [npcKeys.questEnds] = {96605, 96659},
            [npcKeys.friendlyToFaction] = "H",
        },
        [265811] = { -- Lyreena Duskblade : https://wowhead.com/forever/npc=265811/lyreena-duskblade
            [npcKeys.name] = "Lyreena Duskblade",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[141] = {{57.4, 56.6}, {57.6, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.questStarts] = {96606, 96634, 97938, 97939, 97940, 97941, 97942, 97943, 97944, 97946, 97948, 97949, 97950},
            [npcKeys.questEnds] = {96606, 96630},
            [npcKeys.friendlyToFaction] = "A",
        },
        [265812] = { -- Eleanor Shackleton : https://wowhead.com/forever/npc=265812/eleanor-shackleton
            [npcKeys.name] = "Eleanor Shackleton",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[85] = {{57.2, 55.4}, {57.2, 55.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {96607, 96658, 97951, 97952, 97953, 97954, 97955, 97956, 97957, 97958, 97959, 97960, 97961},
            [npcKeys.questEnds] = {86784, 96607, 96656},
            [npcKeys.friendlyToFaction] = "H",
        },
        [265813] = { -- Eric Brighthammer : https://wowhead.com/forever/npc=265813/eric-brighthammer
            [npcKeys.name] = "Eric Brighthammer",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[1] = {{46.6, 53.8}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.questStarts] = {96031, 96044, 96046, 96047, 96050, 96055, 96056, 96057, 96058, 96608, 96629},
            [npcKeys.questEnds] = {96608, 96628},
            [npcKeys.friendlyToFaction] = "A",
        },
        [265841] = { -- An'zalam the Keeper : https://wowhead.com/forever/npc=265841/anzalam-the-keeper
            [npcKeys.name] = "An'zalam the Keeper",
        },
        [265862] = { -- Enho Runehoof : https://wowhead.com/forever/npc=265862/enho-runehoof
            [npcKeys.name] = "Enho Runehoof",
            [npcKeys.spawns] = {[616] = {{13, 53.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265866] = { -- Trigg Ironhand : https://wowhead.com/forever/npc=265866/trigg-ironhand
            [npcKeys.name] = "Trigg Ironhand",
            [npcKeys.spawns] = {[616] = {{15.6, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [265883] = { -- Chagrak Hammerstrike : https://wowhead.com/forever/npc=265883/chagrak-hammerstrike
            [npcKeys.name] = "Chagrak Hammerstrike",
            [npcKeys.spawns] = {[616] = {{13.4, 52.4}, {13.6, 52.4}, {13.6, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265892] = { -- Shok'tara : https://wowhead.com/forever/npc=265892/shoktara
            [npcKeys.name] = "Shok'tara",
        },
        [265893] = { -- Dendarro : https://wowhead.com/forever/npc=265893/dendarro
            [npcKeys.name] = "Dendarro",
            [npcKeys.spawns] = {[616] = {{11.8, 48.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265895] = { -- Maruke : https://wowhead.com/forever/npc=265895/maruke
            [npcKeys.name] = "Maruke",
            [npcKeys.spawns] = {[616] = {{11.8, 48.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265896] = { -- Elderly War Kodo : https://wowhead.com/forever/npc=265896/elderly-war-kodo
            [npcKeys.name] = "Elderly War Kodo",
            [npcKeys.spawns] = {[616] = {{11.8, 49}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265899] = { -- [DNT] Kill Credit: Poultice Delivered to Enho : https://wowhead.com/forever/npc=265899/dnt-kill-credit-poultice-delivered-to-enho
            [npcKeys.name] = "[DNT] Kill Credit: Poultice Delivered to Enho",
        },
        [265900] = { -- [DNT] Kill Credit: Poultice Delivered to Maruke : https://wowhead.com/forever/npc=265900/dnt-kill-credit-poultice-delivered-to-maruke
            [npcKeys.name] = "[DNT] Kill Credit: Poultice Delivered to Maruke",
        },
        [265944] = { -- William Pickman : https://wowhead.com/forever/npc=265944/william-pickman
            [npcKeys.name] = "William Pickman",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[85] = {{61.8, 51.4}, {61.8, 51.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questEnds] = {96658},
            [npcKeys.friendlyToFaction] = "H",
        },
        [265962] = { -- Escaped Sheep : https://wowhead.com/forever/npc=265962/escaped-sheep
            [npcKeys.name] = "Escaped Sheep",
            [npcKeys.spawns] = {[616] = {{10.6, 48.2}, {12.2, 49.8}, {12.8, 51.4}, {14, 51.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [265987] = { -- Spell Resistant Dummy : https://wowhead.com/forever/npc=265987/spell-resistant-dummy
            [npcKeys.name] = "Spell Resistant Dummy",
        },
        [265988] = { -- [DNT] Kill Credit: Escaped Sheep : https://wowhead.com/forever/npc=265988/dnt-kill-credit-escaped-sheep
            [npcKeys.name] = "[DNT] Kill Credit: Escaped Sheep",
        },
        [266014] = { -- [DNT] Kill Credit: Escaped Sheep : https://wowhead.com/forever/npc=266014/dnt-kill-credit-escaped-sheep
            [npcKeys.name] = "[DNT] Kill Credit: Escaped Sheep",
        },
        [266016] = { -- [DNT] Kill Credit: Escaped Sheep : https://wowhead.com/forever/npc=266016/dnt-kill-credit-escaped-sheep
            [npcKeys.name] = "[DNT] Kill Credit: Escaped Sheep",
        },
        [266025] = { -- Rat Familiar : https://wowhead.com/forever/npc=266025/rat-familiar
            [npcKeys.name] = "Rat Familiar",
        },
        [266216] = { -- Lord Tomas : https://wowhead.com/forever/npc=266216/lord-tomas
            [npcKeys.name] = "Lord Tomas",
            [npcKeys.spawns] = {[267] = {{79.6, 46.8}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [266310] = { -- Falric Fellhollow : https://wowhead.com/forever/npc=266310/falric-fellhollow
            [npcKeys.name] = "Falric Fellhollow",
        },
        [266345] = { -- Spider : https://wowhead.com/forever/npc=266345/spider
            [npcKeys.name] = "Spider",
        },
        [266357] = { -- Barton : https://wowhead.com/forever/npc=266357/barton
            [npcKeys.name] = "Barton",
        },
        [266401] = { -- (DNT) Lava Eruption Stalker : https://wowhead.com/forever/npc=266401/dnt-lava-eruption-stalker
            [npcKeys.name] = "(DNT) Lava Eruption Stalker",
        },
        [266449] = { -- Jeremy Heartweaver : https://wowhead.com/forever/npc=266449/jeremy-heartweaver
            [npcKeys.name] = "Jeremy Heartweaver",
            [npcKeys.minLevel] = 2,
            [npcKeys.maxLevel] = 2,
            [npcKeys.spawns] = {[10] = {{73, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
            [npcKeys.friendlyToFaction] = "A",
        },
        [266484] = { -- Morbin Lightbane : https://wowhead.com/forever/npc=266484/morbin-lightbane
            [npcKeys.name] = "Morbin Lightbane",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1497] = {{57.4, 90.4}, {57.4, 90.6}, {57.6, 90.6}, {57.8, 88.2}, {57.8, 89.2}, {57.8, 89.8}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.questStarts] = {92421},
            [npcKeys.questEnds] = {92421},
            [npcKeys.friendlyToFaction] = "H",
        },
        [266508] = { -- Sergeant Danneth : https://wowhead.com/forever/npc=266508/sergeant-danneth
            [npcKeys.name] = "Sergeant Danneth",
        },
        [266513] = { -- [DNT] Kill Credit: Warlock Bones Thrown on Slime Altar : https://wowhead.com/forever/npc=266513/dnt-kill-credit-warlock-bones-thrown-on-slime-altar
            [npcKeys.name] = "[DNT] Kill Credit: Warlock Bones Thrown on Slime Altar",
        },
        [266524] = { -- Lieutenant Connar : https://wowhead.com/forever/npc=266524/lieutenant-connar
            [npcKeys.name] = "Lieutenant Connar",
        },
        [266593] = { -- Sergeant Danneth : https://wowhead.com/forever/npc=266593/sergeant-danneth
            [npcKeys.name] = "Sergeant Danneth",
        },
        [266735] = { -- Excitable Slime : https://wowhead.com/forever/npc=266735/excitable-slime
            [npcKeys.name] = "Excitable Slime",
        },
        [266802] = { -- Thark Gorax : https://wowhead.com/forever/npc=266802/thark-gorax
            [npcKeys.name] = "Thark Gorax",
            [npcKeys.minLevel] = 57,
            [npcKeys.maxLevel] = 57,
            [npcKeys.spawns] = {[616] = {{80, 71}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [266803] = { -- Quintus Wainworth : https://wowhead.com/forever/npc=266803/quintus-wainworth
            [npcKeys.name] = "Quintus Wainworth",
            [npcKeys.minLevel] = 54,
            [npcKeys.maxLevel] = 54,
            [npcKeys.spawns] = {[616] = {{80, 70.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [266847] = { -- Anastasia Miller : https://wowhead.com/forever/npc=266847/anastasia-miller
            [npcKeys.name] = "Anastasia Miller",
        },
        [266849] = { -- Ridgeshade Lurker : https://wowhead.com/forever/npc=266849/ridgeshade-lurker
            [npcKeys.name] = "Ridgeshade Lurker",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[14] = {{49.4, 56.8}, {49.8, 54.6}, {49.8, 56.6}, {50, 56.4}, {50.2, 54.4}, {50.4, 51.2}, {50.4, 51.8}, {50.4, 52.6}, {50.6, 52}, {50.8, 51.4}, {50.8, 53.4}, {50.8, 56.6}, {50.8, 63.4}, {51, 54}, {51, 54.6}, {51.2, 55.8}, {51.2, 64}, {51.4, 49.2}, {51.4, 49.8}, {51.4, 58.4}, {51.4, 58.6}, {51.4, 60}, {51.4, 61}, {51.4, 62.2}, {51.4, 64.6}, {51.6, 49.2}, {51.6, 50.2}, {51.6, 50.6}, {51.6, 53.2}, {51.6, 53.8}, {51.6, 55.8}, {51.6, 59.2}, {51.6, 61}, {51.6, 63}, {51.6, 63.8}, {51.8, 47.8}, {52, 55.4}, {52, 57.4}, {52, 58}, {52, 60.2}, {52, 65}, {52.2, 62}, {52.2, 66}, {52.6, 57.6}, {52.6, 58.8}, {52.6, 60}, {52.6, 63.8}, {52.8, 63.4}, {53, 60.6}, {53.4, 61.8}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [266850] = { -- Ridgeshade Creeper : https://wowhead.com/forever/npc=266850/ridgeshade-creeper
            [npcKeys.name] = "Ridgeshade Creeper",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[14] = {{50, 56.4}, {50, 56.6}, {50.2, 50.4}, {50.2, 53.4}, {50.2, 53.6}, {50.4, 50.6}, {50.4, 52}, {50.4, 54.6}, {50.6, 51}, {50.6, 55.2}, {50.8, 51.6}, {51, 53.6}, {51, 55.8}, {51.2, 50.4}, {51.2, 56.6}, {51.2, 63.8}, {51.4, 49.4}, {51.4, 53.2}, {51.4, 57.8}, {51.4, 59.2}, {51.4, 60.2}, {51.4, 61.2}, {51.4, 61.6}, {51.4, 63.2}, {51.6, 49.4}, {51.6, 50.4}, {51.6, 53.8}, {51.6, 55.8}, {51.6, 57.4}, {51.6, 58.6}, {51.6, 62}, {51.6, 63}, {51.6, 64.6}, {51.8, 51.4}, {51.8, 55.4}, {51.8, 57.8}, {51.8, 60.4}, {51.8, 61}, {51.8, 63.6}, {52, 53}, {52.4, 52.4}, {52.6, 51.4}, {52.6, 58}, {52.8, 60.2}, {52.8, 61.2}, {53, 59}, {53, 61.8}, {53.6, 59.8}, {53.6, 60.8}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [266851] = { -- Ukorsbane : https://wowhead.com/forever/npc=266851/ukorsbane
            [npcKeys.name] = "Ukorsbane",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[14] = {{49.2, 56.6}, {49.6, 56.4}, {49.6, 56.6}, {50.8, 54.4}, {50.8, 56.2}, {53, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [266852] = { -- Halikor : https://wowhead.com/forever/npc=266852/halikor
            [npcKeys.name] = "Halikor",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[14] = {{39, 26.4}, {39.8, 27.8}, {40.4, 29}, {40.4, 29.8}, {40.8, 30}, {41, 30.6}, {42.4, 23.6}, {42.6, 23.4}, {42.8, 24.8}, {43.2, 23.8}, {43.6, 24}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [266860] = { -- Galestrider Chick : https://wowhead.com/forever/npc=266860/galestrider-chick
            [npcKeys.name] = "Galestrider Chick",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{61.6, 76.6}, {62, 75.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [266861] = { -- Nelanna Keeneye : https://wowhead.com/forever/npc=266861/nelanna-keeneye
            [npcKeys.name] = "Nelanna Keeneye",
        },
        [266862] = { -- Juvenile Paletusk : https://wowhead.com/forever/npc=266862/juvenile-paletusk
            [npcKeys.name] = "Juvenile Paletusk",
        },
        [266878] = { -- Valiant Watcher : https://wowhead.com/forever/npc=266878/valiant-watcher
            [npcKeys.name] = "Valiant Watcher",
        },
        [266880] = { -- Warden : https://wowhead.com/forever/npc=266880/warden
            [npcKeys.name] = "Warden",
        },
        [266881] = { -- Pa'zula : https://wowhead.com/forever/npc=266881/pazula
            [npcKeys.name] = "Pa'zula",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[14] = {{56.4, 73.6}, {56.6, 73.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.questStarts] = {96873},
            [npcKeys.questEnds] = {96873},
            [npcKeys.friendlyToFaction] = "H",
        },
        [266883] = { -- [DNT] Kill Credit Young Paletusk : https://wowhead.com/forever/npc=266883/dnt-kill-credit-young-paletusk
            [npcKeys.name] = "[DNT] Kill Credit Young Paletusk",
        },
        [266886] = { -- Ruined Flying Machine : https://wowhead.com/forever/npc=266886/ruined-flying-machine
            [npcKeys.name] = "Ruined Flying Machine",
        },
        [266887] = { -- Ruined Catapult : https://wowhead.com/forever/npc=266887/ruined-catapult
            [npcKeys.name] = "Ruined Catapult",
        },
        [266889] = { -- Eddie : https://wowhead.com/forever/npc=266889/eddie
            [npcKeys.name] = "Eddie",
        },
        [266890] = { -- Max : https://wowhead.com/forever/npc=266890/max
            [npcKeys.name] = "Max",
        },
        [266892] = { -- Ofalo Stonesnow : https://wowhead.com/forever/npc=266892/ofalo-stonesnow
            [npcKeys.name] = "Ofalo Stonesnow",
        },
        [266901] = { -- Pexmit : https://wowhead.com/forever/npc=266901/pexmit
            [npcKeys.name] = "Pexmit",
            [npcKeys.spawns] = {[616] = {{58.8, 41.8}, {59.6, 49.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [266940] = { -- Turroc : https://wowhead.com/forever/npc=266940/turroc
            [npcKeys.name] = "Turroc",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[14] = {{54, 42.4}, {54, 42.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.questStarts] = {96822},
            [npcKeys.questEnds] = {96822},
            [npcKeys.friendlyToFaction] = "H",
        },
        [266995] = { -- [DNT] Kill Credit: Finale : https://wowhead.com/forever/npc=266995/dnt-kill-credit-finale
            [npcKeys.name] = "[DNT] Kill Credit: Finale",
        },
        [266999] = { -- Liam : https://wowhead.com/forever/npc=266999/liam
            [npcKeys.name] = "Liam",
            [npcKeys.spawns] = {[36] = {{21.6, 72.4}, {21.6, 72.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [267000] = { -- Paige : https://wowhead.com/forever/npc=267000/paige
            [npcKeys.name] = "Paige",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{20.8, 74.6}, {21, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267001] = { -- Cody : https://wowhead.com/forever/npc=267001/cody
            [npcKeys.name] = "Cody",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{21.6, 74}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267002] = { -- Luna : https://wowhead.com/forever/npc=267002/luna
            [npcKeys.name] = "Luna",
            [npcKeys.spawns] = {[36] = {{21.4, 74.2}, {21.6, 72.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [267004] = { -- Dock Worker (Bag) : https://wowhead.com/forever/npc=267004/dock-worker-bag
            [npcKeys.name] = "Dock Worker (Bag)",
        },
        [267006] = { -- Dark Neophyte : https://wowhead.com/forever/npc=267006/dark-neophyte
            [npcKeys.name] = "Dark Neophyte",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[85] = {{66.2, 63.4}, {66.2, 63.6}, {66.6, 65.4}, {66.6, 65.6}, {67, 63.4}, {67.2, 64.4}, {67.4, 67}, {67.6, 65.4}, {67.6, 66.8}, {67.8, 66.2}, {68.2, 64.2}, {68.6, 62.8}, {69, 63.6}, {69, 65.6}, {69.4, 64.8}, {69.8, 64.4}, {69.8, 64.6}, {70.4, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [267007] = { -- Stormwind Harbor Guard : https://wowhead.com/forever/npc=267007/stormwind-harbor-guard
            [npcKeys.name] = "Stormwind Harbor Guard",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267008] = { -- Leonid Barthalomew the Revered : https://wowhead.com/forever/npc=267008/leonid-barthalomew-the-revered
            [npcKeys.name] = "Leonid Barthalomew the Revered",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[85] = {{22, 44.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {96896, 98545},
            [npcKeys.questEnds] = {96896, 96899},
            [npcKeys.friendlyToFaction] = "H",
        },
        [267009] = { -- Hadric Harlson : https://wowhead.com/forever/npc=267009/hadric-harlson
            [npcKeys.name] = "Hadric Harlson",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[85] = {{65.8, 61}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {96897, 96898, 96899},
            [npcKeys.questEnds] = {96895, 96897, 96898},
            [npcKeys.friendlyToFaction] = "H",
        },
        [267064] = { -- Stormwind Cannoneer : https://wowhead.com/forever/npc=267064/stormwind-cannoneer
            [npcKeys.name] = "Stormwind Cannoneer",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [267065] = { -- Syndicate Smuggler : https://wowhead.com/forever/npc=267065/syndicate-smuggler
            [npcKeys.name] = "Syndicate Smuggler",
        },
        [267072] = { -- Ravenous Shark : https://wowhead.com/forever/npc=267072/ravenous-shark
            [npcKeys.name] = "Ravenous Shark",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267081] = { -- Menacing Ravager : https://wowhead.com/forever/npc=267081/menacing-ravager
            [npcKeys.name] = "Menacing Ravager",
        },
        [267097] = { -- Maerion Thaelemaches : https://wowhead.com/forever/npc=267097/maerion-thaelemaches
            [npcKeys.name] = "Maerion Thaelemaches",
            [npcKeys.spawns] = {[616] = {{63, 25.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [267109] = { -- Galvinquam Leafsyre : https://wowhead.com/forever/npc=267109/galvinquam-leafsyre
            [npcKeys.name] = "Galvinquam Leafsyre",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.spawns] = {[616] = {{32.6, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267113] = { -- Marrosis : https://wowhead.com/forever/npc=267113/marrosis
            [npcKeys.name] = "Marrosis",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{27, 50.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [267118] = { -- Gilbert Gray : https://wowhead.com/forever/npc=267118/gilbert-gray
            [npcKeys.name] = "Gilbert Gray",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.questStarts] = {95065},
            [npcKeys.questEnds] = {95065},
            [npcKeys.friendlyToFaction] = "A",
        },
        [267121] = { -- Yashiro : https://wowhead.com/forever/npc=267121/yashiro
            [npcKeys.name] = "Yashiro",
            [npcKeys.spawns] = {[616] = {{49.2, 32.6}, {49.4, 32.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [267125] = { -- Fleshflayer Ravener : https://wowhead.com/forever/npc=267125/fleshflayer-ravener
            [npcKeys.name] = "Fleshflayer Ravener",
            [npcKeys.spawns] = {[616] = {{27.2, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [267158] = { -- Jereman : https://wowhead.com/forever/npc=267158/jereman
            [npcKeys.name] = "Jereman",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{41.4, 45}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267182] = { -- Ve'ho Manyhorns : https://wowhead.com/forever/npc=267182/veho-manyhorns
            [npcKeys.name] = "Ve'ho Manyhorns",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{75.8, 32.6}, {75.8, 35}, {76.2, 34}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [267183] = { -- Outfoxed Demon : https://wowhead.com/forever/npc=267183/outfoxed-demon
            [npcKeys.name] = "Outfoxed Demon",
        },
        [267197] = { -- Onyxian Lair Guard : https://wowhead.com/forever/npc=267197/onyxian-lair-guard
            [npcKeys.name] = "Onyxian Lair Guard",
        },
        [267213] = { -- [DNT] Kill Credit : https://wowhead.com/forever/npc=267213/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit",
        },
        [267214] = { -- Va'xug Firefure : https://wowhead.com/forever/npc=267214/vaxug-firefure
            [npcKeys.name] = "Va'xug Firefure",
            [npcKeys.zoneID] = zoneIDs.ASHENVALE,
        },
        [267216] = { -- White Riding Kodo : https://wowhead.com/forever/npc=267216/white-riding-kodo
            [npcKeys.name] = "White Riding Kodo",
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [267226] = { -- Grey Riding Kodo : https://wowhead.com/forever/npc=267226/grey-riding-kodo
            [npcKeys.name] = "Grey Riding Kodo",
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [267227] = { -- Brown Riding Kodo : https://wowhead.com/forever/npc=267227/brown-riding-kodo
            [npcKeys.name] = "Brown Riding Kodo",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267279] = { -- Cadoc Winterheart : https://wowhead.com/forever/npc=267279/cadoc-winterheart
            [npcKeys.name] = "Cadoc Winterheart",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1] = {{29.4, 70}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267287] = { -- Sylassa Moonglow : https://wowhead.com/forever/npc=267287/sylassa-moonglow
            [npcKeys.name] = "Sylassa Moonglow",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[141] = {{61, 41.8}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267291] = { -- Emerald Riding Raptor : https://wowhead.com/forever/npc=267291/emerald-riding-raptor
            [npcKeys.name] = "Emerald Riding Raptor",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[14] = {{55.2, 75.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267297] = { -- Turquoise Riding Raptor : https://wowhead.com/forever/npc=267297/turquoise-riding-raptor
            [npcKeys.name] = "Turquoise Riding Raptor",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[14] = {{55, 75.2}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267298] = { -- Violet Riding Raptor : https://wowhead.com/forever/npc=267298/violet-riding-raptor
            [npcKeys.name] = "Violet Riding Raptor",
            [npcKeys.spawns] = {[14] = {{55.2, 75.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [267299] = { -- Brown Riding Wolf : https://wowhead.com/forever/npc=267299/brown-riding-wolf
            [npcKeys.name] = "Brown Riding Wolf",
        },
        [267300] = { -- Dire Riding Wolf : https://wowhead.com/forever/npc=267300/dire-riding-wolf
            [npcKeys.name] = "Dire Riding Wolf",
        },
        [267301] = { -- Timber Riding Wolf : https://wowhead.com/forever/npc=267301/timber-riding-wolf
            [npcKeys.name] = "Timber Riding Wolf",
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [267302] = { -- Black Riding Wolf : https://wowhead.com/forever/npc=267302/black-riding-wolf
            [npcKeys.name] = "Black Riding Wolf",
        },
        [267304] = { -- Empyrean Galestrider : https://wowhead.com/forever/npc=267304/empyrean-galestrider
            [npcKeys.name] = "Empyrean Galestrider",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{53.4, 81.4}, {53.6, 81}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267305] = { -- Stormy Galestrider : https://wowhead.com/forever/npc=267305/stormy-galestrider
            [npcKeys.name] = "Stormy Galestrider",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{53.6, 81.2}, {53.6, 81.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [267306] = { -- Umber Galestrider : https://wowhead.com/forever/npc=267306/umber-galestrider
            [npcKeys.name] = "Umber Galestrider",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{53.8, 81.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267307] = { -- Chol'aruk : https://wowhead.com/forever/npc=267307/cholaruk
            [npcKeys.name] = "Chol'aruk",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[17] = {{57.4, 27.2}, {57.6, 27.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [267308] = { -- Razormane Flesheater : https://wowhead.com/forever/npc=267308/razormane-flesheater
            [npcKeys.name] = "Razormane Flesheater",
            [npcKeys.minLevel] = 18,
            [npcKeys.maxLevel] = 19,
            [npcKeys.spawns] = {[17] = {{57.4, 27.2}, {57.8, 25.8}, {57.8, 27.2}, {57.8, 27.6}, {58, 25.2}, {58.4, 24.4}, {58.8, 25.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [267309] = { -- Bainham : https://wowhead.com/forever/npc=267309/bainham
            [npcKeys.name] = "Bainham",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[17] = {{61.8, 39.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.questStarts] = {97005},
            [npcKeys.questEnds] = {97005},
            [npcKeys.friendlyToFaction] = "A",
        },
        [267310] = { -- Gur'ak : https://wowhead.com/forever/npc=267310/gurak
            [npcKeys.name] = "Gur'ak",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[17] = {{52.6, 29}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.questStarts] = {97003},
            [npcKeys.questEnds] = {97003},
            [npcKeys.friendlyToFaction] = "H",
        },
        [267314] = { -- Razormane Berserker : https://wowhead.com/forever/npc=267314/razormane-berserker
            [npcKeys.name] = "Razormane Berserker",
            [npcKeys.minLevel] = 18,
            [npcKeys.maxLevel] = 19,
            [npcKeys.spawns] = {[17] = {{57.6, 27.6}, {57.8, 26.4}, {58, 25.4}, {58, 26.8}, {58.2, 24.4}, {58.8, 24.8}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [267321] = { -- Karne Grayhoof : https://wowhead.com/forever/npc=267321/karne-grayhoof
            [npcKeys.name] = "Karne Grayhoof",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267322] = { -- Thedda : https://wowhead.com/forever/npc=267322/thedda
            [npcKeys.name] = "Thedda",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[14] = {{44.6, 68.4}, {44.6, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267323] = { -- Clarence Gillian : https://wowhead.com/forever/npc=267323/clarence-gillian
            [npcKeys.name] = "Clarence Gillian",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[85] = {{32.6, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267324] = { -- Margaret Weaver : https://wowhead.com/forever/npc=267324/margaret-weaver
            [npcKeys.name] = "Margaret Weaver",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[85] = {{32.6, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267325] = { -- Walter Mason : https://wowhead.com/forever/npc=267325/walter-mason
            [npcKeys.name] = "Walter Mason",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[85] = {{32.2, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267326] = { -- Florence Nightshade : https://wowhead.com/forever/npc=267326/florence-nightshade
            [npcKeys.name] = "Florence Nightshade",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[85] = {{32.4, 65.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267327] = { -- Kagil : https://wowhead.com/forever/npc=267327/kagil
            [npcKeys.name] = "Kagil",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[14] = {{40.8, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267328] = { -- Norzsh : https://wowhead.com/forever/npc=267328/norzsh
            [npcKeys.name] = "Norzsh",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[14] = {{40.4, 68}, {40.6, 68}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267329] = { -- Zor'la : https://wowhead.com/forever/npc=267329/zorla
            [npcKeys.name] = "Zor'la",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[14] = {{42.6, 67.4}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267330] = { -- Nawka Wildsong : https://wowhead.com/forever/npc=267330/nawka-wildsong
            [npcKeys.name] = "Nawka Wildsong",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267331] = { -- Vartha Rockmane : https://wowhead.com/forever/npc=267331/vartha-rockmane
            [npcKeys.name] = "Vartha Rockmane",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267332] = { -- Garan Sunstrider : https://wowhead.com/forever/npc=267332/garan-sunstrider
            [npcKeys.name] = "Garan Sunstrider",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267333] = { -- Terunne Bearshaper : https://wowhead.com/forever/npc=267333/terunne-bearshaper
            [npcKeys.name] = "Terunne Bearshaper",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[141] = {{59.4, 38.6}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267334] = { -- Fanorran Stilloak : https://wowhead.com/forever/npc=267334/fanorran-stilloak
            [npcKeys.name] = "Fanorran Stilloak",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[141] = {{58.2, 41.4}, {58.2, 41.6}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267335] = { -- Eleyna Duskbreeze : https://wowhead.com/forever/npc=267335/eleyna-duskbreeze
            [npcKeys.name] = "Eleyna Duskbreeze",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[141] = {{59.8, 41.4}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267336] = { -- Brighid Stormflayer : https://wowhead.com/forever/npc=267336/brighid-stormflayer
            [npcKeys.name] = "Brighid Stormflayer",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1] = {{29, 67.4}, {29.2, 67.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267337] = { -- Sally Swiftwrench : https://wowhead.com/forever/npc=267337/sally-swiftwrench
            [npcKeys.name] = "Sally Swiftwrench",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1] = {{28.8, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267338] = { -- Emrys Flintbeard : https://wowhead.com/forever/npc=267338/emrys-flintbeard
            [npcKeys.name] = "Emrys Flintbeard",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1] = {{28.8, 66.4}, {28.8, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267354] = { -- Black Skeletal Horse : https://wowhead.com/forever/npc=267354/black-skeletal-horse
            [npcKeys.name] = "Black Skeletal Horse",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{60, 52.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267357] = { -- Red Skeletal Horse : https://wowhead.com/forever/npc=267357/red-skeletal-horse
            [npcKeys.name] = "Red Skeletal Horse",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{59.8, 52.6}, {60, 52.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267358] = { -- Blue Skeletal Horse : https://wowhead.com/forever/npc=267358/blue-skeletal-horse
            [npcKeys.name] = "Blue Skeletal Horse",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{59.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267364] = { -- Brown Skeletal Horse : https://wowhead.com/forever/npc=267364/brown-skeletal-horse
            [npcKeys.name] = "Brown Skeletal Horse",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{59.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [267439] = { -- Doomguard Xarkul : https://wowhead.com/forever/npc=267439/doomguard-xarkul
            [npcKeys.name] = "Doomguard Xarkul",
        },
        [267462] = { -- [DNT] Kill Credit : https://wowhead.com/forever/npc=267462/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit",
        },
        [267473] = { -- Brown Ram : https://wowhead.com/forever/npc=267473/brown-ram
            [npcKeys.name] = "Brown Ram",
            [npcKeys.spawns] = {[1] = {{64, 50.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [267474] = { -- White Ram : https://wowhead.com/forever/npc=267474/white-ram
            [npcKeys.name] = "White Ram",
            [npcKeys.spawns] = {[1] = {{64.2, 50}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [267475] = { -- Gray Ram : https://wowhead.com/forever/npc=267475/gray-ram
            [npcKeys.name] = "Gray Ram",
            [npcKeys.spawns] = {[1] = {{64, 50.4}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [267525] = { -- Wizzik Dustfizz : https://wowhead.com/forever/npc=267525/wizzik-dustfizz
            [npcKeys.name] = "Wizzik Dustfizz",
            [npcKeys.zoneID] = zoneIDs.TANARIS,
        },
        [267599] = { -- Energizing Vortex : https://wowhead.com/forever/npc=267599/energizing-vortex
            [npcKeys.name] = "Energizing Vortex",
        },
        [267674] = { -- Brown Horse : https://wowhead.com/forever/npc=267674/brown-horse
            [npcKeys.name] = "Brown Horse",
            [npcKeys.spawns] = {[12] = {{84.2, 64.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [267677] = { -- Chestnut Mare : https://wowhead.com/forever/npc=267677/chestnut-mare
            [npcKeys.name] = "Chestnut Mare",
            [npcKeys.spawns] = {[12] = {{84.8, 64.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [267678] = { -- Pinto : https://wowhead.com/forever/npc=267678/pinto
            [npcKeys.name] = "Pinto",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[12] = {{84, 65.2}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [267683] = { -- Red Mechanostrider : https://wowhead.com/forever/npc=267683/red-mechanostrider
            [npcKeys.name] = "Red Mechanostrider",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1] = {{49.2, 48.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [267684] = { -- Green Mechanostrider : https://wowhead.com/forever/npc=267684/green-mechanostrider
            [npcKeys.name] = "Green Mechanostrider",
            [npcKeys.spawns] = {[1] = {{49, 48.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [267687] = { -- Blue Mechanostrider : https://wowhead.com/forever/npc=267687/blue-mechanostrider
            [npcKeys.name] = "Blue Mechanostrider",
            [npcKeys.spawns] = {[1] = {{49, 48.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [267688] = { -- Unpainted Mechanostrider : https://wowhead.com/forever/npc=267688/unpainted-mechanostrider
            [npcKeys.name] = "Unpainted Mechanostrider",
            [npcKeys.spawns] = {[1] = {{49, 48}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [267745] = { -- PTR Fishing Tournament Vendor : https://wowhead.com/forever/npc=267745/ptr-fishing-tournament-vendor
            [npcKeys.name] = "PTR Fishing Tournament Vendor",
        },
        [267806] = { -- "Flipfin" : https://wowhead.com/forever/npc=267806/flipfin
            [npcKeys.name] = "\"Flipfin\"",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[33] = {{27.8, 76.8}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [267842] = { -- Bitter Baitling : https://wowhead.com/forever/npc=267842/bitter-baitling
            [npcKeys.name] = "Bitter Baitling",
        },
        [267876] = { -- Aana : https://wowhead.com/forever/npc=267876/aana
            [npcKeys.name] = "Aana",
        },
        [267917] = { -- Stalker : https://wowhead.com/forever/npc=267917/stalker
            [npcKeys.name] = "Stalker",
        },
        [267936] = { -- Refugee Child : https://wowhead.com/forever/npc=267936/refugee-child
            [npcKeys.name] = "Refugee Child",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{65.8, 74.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [267963] = { -- Quadcopter : https://wowhead.com/forever/npc=267963/quadcopter
            [npcKeys.name] = "Quadcopter",
        },
        [268044] = { -- Loren Ravenlock : https://wowhead.com/forever/npc=268044/loren-ravenlock
            [npcKeys.name] = "Loren Ravenlock",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[616] = {{68.6, 47.6}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [268047] = { -- Theramore Emissary : https://wowhead.com/forever/npc=268047/theramore-emissary
            [npcKeys.name] = "Theramore Emissary",
        },
        [268048] = { -- Darkspear Emissary : https://wowhead.com/forever/npc=268048/darkspear-emissary
            [npcKeys.name] = "Darkspear Emissary",
        },
        [268079] = { -- Dummy Beast : https://wowhead.com/forever/npc=268079/dummy-beast
            [npcKeys.name] = "Dummy Beast",
        },
        [268080] = { -- Dummy Demon : https://wowhead.com/forever/npc=268080/dummy-demon
            [npcKeys.name] = "Dummy Demon",
        },
        [268081] = { -- Dummy Dragonkin : https://wowhead.com/forever/npc=268081/dummy-dragonkin
            [npcKeys.name] = "Dummy Dragonkin",
        },
        [268082] = { -- Dummy Elemental : https://wowhead.com/forever/npc=268082/dummy-elemental
            [npcKeys.name] = "Dummy Elemental",
        },
        [268083] = { -- Dummy Giant : https://wowhead.com/forever/npc=268083/dummy-giant
            [npcKeys.name] = "Dummy Giant",
        },
        [268084] = { -- Dummy Humanoid : https://wowhead.com/forever/npc=268084/dummy-humanoid
            [npcKeys.name] = "Dummy Humanoid",
        },
        [268085] = { -- Dummy Undead : https://wowhead.com/forever/npc=268085/dummy-undead
            [npcKeys.name] = "Dummy Undead",
        },
        [268120] = { -- Mourning's Rest Spirit : https://wowhead.com/forever/npc=268120/mournings-rest-spirit
            [npcKeys.name] = "Mourning's Rest Spirit",
        },
        [268168] = { -- Lisbael Highfeather : https://wowhead.com/forever/npc=268168/lisbael-highfeather
            [npcKeys.name] = "Lisbael Highfeather",
            [npcKeys.spawns] = {[616] = {{42.2, 52.2}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [268220] = { -- DNT Sunderbark kill credit : https://wowhead.com/forever/npc=268220/dnt-sunderbark-kill-credit
            [npcKeys.name] = "DNT Sunderbark kill credit",
        },
        [268231] = { -- Ta'shkal : https://wowhead.com/forever/npc=268231/tashkal
            [npcKeys.name] = "Ta'shkal",
        },
        [268238] = { -- Nordun Steadysight : https://wowhead.com/forever/npc=268238/nordun-steadysight
            [npcKeys.name] = "Nordun Steadysight",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[12] = {{42, 66.4}, {42, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.friendlyToFaction] = "A",
        },
        [268257] = { -- Dummy Mechanical : https://wowhead.com/forever/npc=268257/dummy-mechanical
            [npcKeys.name] = "Dummy Mechanical",
        },
        [268313] = { -- Black Stallion : https://wowhead.com/forever/npc=268313/black-stallion
            [npcKeys.name] = "Black Stallion",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [268314] = { -- Brown Horse : https://wowhead.com/forever/npc=268314/brown-horse
            [npcKeys.name] = "Brown Horse",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [268316] = { -- Chestnut Mare : https://wowhead.com/forever/npc=268316/chestnut-mare
            [npcKeys.name] = "Chestnut Mare",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [268318] = { -- Pinto : https://wowhead.com/forever/npc=268318/pinto
            [npcKeys.name] = "Pinto",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [268401] = { -- Onyxia Prime : https://wowhead.com/forever/npc=268401/onyxia-prime
            [npcKeys.name] = "Onyxia Prime",
        },
        [268420] = { -- Skittering Spider : https://wowhead.com/forever/npc=268420/skittering-spider
            [npcKeys.name] = "Skittering Spider",
        },
        [268425] = { -- Ranath Nightstride : https://wowhead.com/forever/npc=268425/ranath-nightstride
            [npcKeys.name] = "Ranath Nightstride",
            [npcKeys.minLevel] = 45,
            [npcKeys.maxLevel] = 45,
            [npcKeys.spawns] = {[36] = {{17.8, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [268433] = { -- Nub : https://wowhead.com/forever/npc=268433/nub
            [npcKeys.name] = "Nub",
        },
        [268444] = { -- Place Figurine : https://wowhead.com/forever/npc=268444/place-figurine
            [npcKeys.name] = "Place Figurine",
        },
        [268511] = { -- Manifest Clerk Philmor : https://wowhead.com/forever/npc=268511/manifest-clerk-philmor
            [npcKeys.name] = "Manifest Clerk Philmor",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.questStarts] = {97220},
            [npcKeys.friendlyToFaction] = "A",
        },
        [268518] = { -- [DNT] Zephras Isle Appearance Rewards : https://wowhead.com/forever/npc=268518/dnt-zephras-isle-appearance-rewards
            [npcKeys.name] = "[DNT] Zephras Isle Appearance Rewards",
        },
        [268519] = { -- Kirin Tor Guard : https://wowhead.com/forever/npc=268519/kirin-tor-guard
            [npcKeys.name] = "Kirin Tor Guard",
        },
        [268530] = { -- Bloodtalon Matriarch : https://wowhead.com/forever/npc=268530/bloodtalon-matriarch
            [npcKeys.name] = "Bloodtalon Matriarch",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[14] = {{68.2, 71.8}, {68.4, 71}, {68.4, 72.6}, {68.4, 73.6}, {68.6, 71.4}, {68.6, 72.6}, {68.8, 71.6}, {69.6, 73}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [268557] = { -- Olana Brighthoof : https://wowhead.com/forever/npc=268557/olana-brighthoof
            [npcKeys.name] = "Olana Brighthoof",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268558] = { -- Chakuyak : https://wowhead.com/forever/npc=268558/chakuyak
            [npcKeys.name] = "Chakuyak",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [268568] = { -- Roy Lewells : https://wowhead.com/forever/npc=268568/roy-lewells
            [npcKeys.name] = "Roy Lewells",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.questStarts] = {97234},
            [npcKeys.questEnds] = {97237},
            [npcKeys.friendlyToFaction] = "A",
        },
        [268571] = { -- Credit : https://wowhead.com/forever/npc=268571/credit
            [npcKeys.name] = "Credit",
        },
        [268575] = { -- [DNT] Reward Vendor : https://wowhead.com/forever/npc=268575/dnt-reward-vendor
            [npcKeys.name] = "[DNT] Reward Vendor",
        },
        [268592] = { -- Olariaan Swiftburn : https://wowhead.com/forever/npc=268592/olariaan-swiftburn
            [npcKeys.name] = "Olariaan Swiftburn",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{51.2, 86}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {97244, 97245, 97257},
            [npcKeys.questEnds] = {97243, 97244, 97245},
            [npcKeys.friendlyToFaction] = "H",
        },
        [268602] = { -- Skypriest Faladiel : https://wowhead.com/forever/npc=268602/skypriest-faladiel
            [npcKeys.name] = "Skypriest Faladiel",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.2, 63.4}, {64.4, 63.8}, {64.6, 63.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [268605] = { -- Kuramaa : https://wowhead.com/forever/npc=268605/kuramaa
            [npcKeys.name] = "Kuramaa",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{42.4, 69}, {42.6, 69.2}, {42.8, 69.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [268606] = { -- Thera Duskwhisper : https://wowhead.com/forever/npc=268606/thera-duskwhisper
            [npcKeys.name] = "Thera Duskwhisper",
        },
        [268614] = { -- Ghost of Olgra : https://wowhead.com/forever/npc=268614/ghost-of-olgra
            [npcKeys.name] = "Ghost of Olgra",
            [npcKeys.spawns] = {[17] = {{52, 31.4}, {52, 31.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [268622] = { -- Encroaching Soldier : https://wowhead.com/forever/npc=268622/encroaching-soldier
            [npcKeys.name] = "Encroaching Soldier",
            [npcKeys.minLevel] = 22,
            [npcKeys.maxLevel] = 23,
            [npcKeys.spawns] = {[15] = {{29.8, 48.2}}, [17] = {{47.4, 76}, {47.6, 76.6}, {47.8, 76.2}, {48.6, 77.8}, {49, 77}, {50, 78.4}}},
        },
        [268623] = { -- Outraged Pillager : https://wowhead.com/forever/npc=268623/outraged-pillager
            [npcKeys.name] = "Outraged Pillager",
            [npcKeys.minLevel] = 23,
            [npcKeys.maxLevel] = 23,
            [npcKeys.spawns] = {[17] = {{49, 77}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [268624] = { -- Razormane Raider : https://wowhead.com/forever/npc=268624/razormane-raider
            [npcKeys.name] = "Razormane Raider",
            [npcKeys.minLevel] = 16,
            [npcKeys.maxLevel] = 19,
            [npcKeys.spawns] = {[17] = {{47.4, 51}, {47.4, 52.2}, {47.6, 50.6}, {47.6, 52.6}, {47.8, 49.8}, {48, 49}, {48, 53.6}, {48.2, 54.6}, {48.4, 52}, {49.2, 50.4}, {49.2, 50.6}, {49.2, 54.6}, {49.4, 46}, {49.4, 49.2}, {49.4, 54.2}, {49.6, 46.4}, {49.6, 50.6}, {49.8, 49.4}, {49.8, 51.6}, {49.8, 54.6}, {50, 50}, {50, 56}, {50.2, 53}, {50.4, 48.4}, {50.4, 53.8}, {50.6, 48.4}, {50.6, 50}, {51.2, 51.6}, {51.2, 52.8}, {51.4, 51.4}, {51.6, 49.4}, {51.6, 50}, {51.6, 51.2}, {51.6, 52.8}, {52.6, 50.4}, {52.6, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [268663] = { -- Penny Pinderton : https://wowhead.com/forever/npc=268663/penny-pinderton
            [npcKeys.name] = "Penny Pinderton",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[16591] = {{62, 81.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [268677] = { -- Skeleton : https://wowhead.com/forever/npc=268677/skeleton
            [npcKeys.name] = "Skeleton",
        },
        [268679] = { -- Brazier of Eternal Flame : https://wowhead.com/forever/npc=268679/brazier-of-eternal-flame
            [npcKeys.name] = "Brazier of Eternal Flame",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{58.4, 78.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268682] = { -- Migi : https://wowhead.com/forever/npc=268682/migi
            [npcKeys.name] = "Migi",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{36.4, 28.8}, {36.8, 29}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.questEnds] = {97249},
            [npcKeys.friendlyToFaction] = "H",
        },
        [268683] = { -- Brog : https://wowhead.com/forever/npc=268683/brog
            [npcKeys.name] = "Brog",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{36.8, 29}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268684] = { -- Thra : https://wowhead.com/forever/npc=268684/thra
            [npcKeys.name] = "Thra",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{34.8, 28.8}, {36, 28.2}, {36.4, 28.8}, {36.8, 29}, {37, 28.4}, {37, 29.6}, {37.8, 28.2}, {37.8, 29}, {38.4, 27.2}, {38.6, 29}, {38.8, 28.4}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.questStarts] = {97326},
            [npcKeys.questEnds] = {97326},
            [npcKeys.friendlyToFaction] = "H",
        },
        [268685] = { -- Mogra : https://wowhead.com/forever/npc=268685/mogra
            [npcKeys.name] = "Mogra",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{34.4, 29}, {36.8, 29}, {38.4, 27.8}, {39, 27.8}, {39.2, 29}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268686] = { -- Puk : https://wowhead.com/forever/npc=268686/puk
            [npcKeys.name] = "Puk",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{36.2, 28.8}, {37, 29}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [268690] = { -- Electrified Vortex : https://wowhead.com/forever/npc=268690/electrified-vortex
            [npcKeys.name] = "Electrified Vortex",
        },
        [268700] = { -- Tycho : https://wowhead.com/forever/npc=268700/tycho
            [npcKeys.name] = "Tycho",
        },
        [268701] = { -- Thatog : https://wowhead.com/forever/npc=268701/thatog
            [npcKeys.name] = "Thatog",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.spawns] = {[1637] = {{55.4, 72}, {55.6, 72}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.questStarts] = {97246},
            [npcKeys.friendlyToFaction] = "H",
        },
        [268705] = { -- Aka'rai : https://wowhead.com/forever/npc=268705/akarai
            [npcKeys.name] = "Aka'rai",
        },
        [268707] = { -- Prairie Wolf Pup : https://wowhead.com/forever/npc=268707/prairie-wolf-pup
            [npcKeys.name] = "Prairie Wolf Pup",
        },
        [268731] = { -- Jacko Boie : https://wowhead.com/forever/npc=268731/jacko-boie
            [npcKeys.name] = "Jacko Boie",
        },
        [268743] = { -- Rexxie Copperclutch : https://wowhead.com/forever/npc=268743/rexxie-copperclutch
            [npcKeys.name] = "Rexxie Copperclutch",
        },
        [268744] = { -- Frog Familiar : https://wowhead.com/forever/npc=268744/frog-familiar
            [npcKeys.name] = "Frog Familiar",
        },
        [268745] = { -- Mayhoa Skyhoof : https://wowhead.com/forever/npc=268745/mayhoa-skyhoof
            [npcKeys.name] = "Mayhoa Skyhoof",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[1637] = {{36.6, 29}, {39, 29.2}, {40, 30}, {40.4, 29.2}, {40.6, 28.6}, {41, 29.6}, {41.6, 30}, {41.6, 30.8}, {42.4, 32}, {42.4, 33}, {42.6, 33}, {42.8, 33.6}, {43.2, 35.2}, {44, 35.4}, {44.2, 35.8}, {44.4, 36.6}, {44.6, 36.2}, {45.8, 36.2}, {47.2, 35.2}, {47.4, 36}, {48, 35.4}, {49.4, 34.8}, {51, 34.8}, {54.4, 36}, {54.6, 35}, {54.8, 35.8}, {56.4, 36.4}, {56.4, 37.2}, {56.6, 37}, {57, 37.6}, {57.4, 38.6}, {58, 38.2}, {58.2, 38.8}, {59, 39.4}, {59.2, 40.2}, {59.6, 39.6}, {60, 40.8}, {60.6, 41.2}, {60.6, 41.8}, {60.8, 40.4}, {62, 39.6}, {62.4, 39.4}, {63, 38.6}, {63.4, 38.4}, {63.6, 38.2}, {64.2, 37.4}, {64.6, 37.4}, {64.8, 38.2}, {65.4, 39.4}, {65.4, 39.6}, {65.8, 40}, {66, 40.6}, {66.4, 22.8}, {66.8, 39.8}, {67.4, 39}, {68, 13.8}, {68, 36.8}, {68, 38.6}, {68.4, 38}, {69, 16.2}, {69, 28.4}, {69.2, 37.2}, {69.2, 37.6}, {69.4, 18}, {69.4, 36.4}, {69.6, 18.2}, {69.8, 34.6}, {69.8, 36.6}, {70.2, 36}, {70.4, 19.2}, {70.6, 18.6}, {70.6, 35.6}, {71, 35.2}, {71.2, 33.4}, {71.2, 34.4}, {71.4, 26.2}, {71.4, 31}, {71.6, 26.8}, {71.6, 33.6}, {71.8, 31.8}, {71.8, 32.6}, {72, 28}, {72, 31.2}, {72.2, 19.4}, {72.2, 24.8}, {72.4, 29.8}, {72.6, 31.2}, {73, 20.8}, {73, 21.8}, {73, 23}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268761] = { -- Randal : https://wowhead.com/forever/npc=268761/randal
            [npcKeys.name] = "Randal",
            [npcKeys.spawns] = {[36] = {{21.8, 74.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [268762] = { -- Brazier of Offering : https://wowhead.com/forever/npc=268762/brazier-of-offering
            [npcKeys.name] = "Brazier of Offering",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{51.2, 86}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268763] = { -- Manifestation of Flames : https://wowhead.com/forever/npc=268763/manifestation-of-flames
            [npcKeys.name] = "Manifestation of Flames",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{51, 85.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [268765] = { -- Lava Spout Totem : https://wowhead.com/forever/npc=268765/lava-spout-totem
            [npcKeys.name] = "Lava Spout Totem",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [268831] = { -- Plains Prowler : https://wowhead.com/forever/npc=268831/plains-prowler
            [npcKeys.name] = "Plains Prowler",
            [npcKeys.spawns] = {[16591] = {{73, 40}, {77.2, 39}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [268840] = { -- Spectral Bear Cub : https://wowhead.com/forever/npc=268840/spectral-bear-cub
            [npcKeys.name] = "Spectral Bear Cub",
        },
        [268900] = { -- Dron : https://wowhead.com/forever/npc=268900/dron
            [npcKeys.name] = "Dron",
        },
        [268907] = { -- Bock : https://wowhead.com/forever/npc=268907/bock
            [npcKeys.name] = "Bock",
        },
        [268924] = { -- Pretty Flower : https://wowhead.com/forever/npc=268924/pretty-flower
            [npcKeys.name] = "Pretty Flower",
        },
        [268925] = { -- Night Elf Courier : https://wowhead.com/forever/npc=268925/night-elf-courier
            [npcKeys.name] = "Night Elf Courier",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[406] = {{48.6, 39.8}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [268992] = { -- Zimmix Sputterspark : https://wowhead.com/forever/npc=268992/zimmix-sputterspark
            [npcKeys.name] = "Zimmix Sputterspark",
        },
        [269003] = { -- Spell Eater : https://wowhead.com/forever/npc=269003/spell-eater
            [npcKeys.name] = "Spell Eater",
        },
        [269004] = { -- Icemaw : https://wowhead.com/forever/npc=269004/icemaw
            [npcKeys.name] = "Icemaw",
        },
        [269005] = { -- Frostseeker : https://wowhead.com/forever/npc=269005/frostseeker
            [npcKeys.name] = "Frostseeker",
        },
        [269057] = { -- Mirrorscale : https://wowhead.com/forever/npc=269057/mirrorscale
            [npcKeys.name] = "Mirrorscale",
        },
        [269068] = { -- Eylah Sunhorn : https://wowhead.com/forever/npc=269068/eylah-sunhorn
            [npcKeys.name] = "Eylah Sunhorn",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1638] = {{37, 56.2}, {38.2, 56.2}, {38.2, 56.6}, {38.6, 55.4}, {38.6, 56.4}, {38.6, 56.8}}},
            [npcKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [npcKeys.questStarts] = {97485},
            [npcKeys.questEnds] = {97485},
            [npcKeys.friendlyToFaction] = "H",
        },
        [269075] = { -- Snow Leopard Prowler : https://wowhead.com/forever/npc=269075/snow-leopard-prowler
            [npcKeys.name] = "Snow Leopard Prowler",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[1] = {{27.2, 62.4}, {27.4, 62.8}, {27.4, 63.6}, {27.6, 62.8}, {27.6, 63.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [269077] = { -- Reuse : https://wowhead.com/forever/npc=269077/reuse
            [npcKeys.name] = "Reuse",
        },
        [269127] = { -- Image of Archmage Modera : https://wowhead.com/forever/npc=269127/image-of-archmage-modera
            [npcKeys.name] = "Image of Archmage Modera",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[130] = {{68.4, 45.4}, {68.6, 45.2}}},
            [npcKeys.zoneID] = zoneIDs.SILVERPINE_FOREST,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [269133] = { -- Skeleton : https://wowhead.com/forever/npc=269133/skeleton
            [npcKeys.name] = "Skeleton",
        },
        [269134] = { -- Kirin Tor Necromancer : https://wowhead.com/forever/npc=269134/kirin-tor-necromancer
            [npcKeys.name] = "Kirin Tor Necromancer",
        },
        [269138] = { -- White Riding Kodo : https://wowhead.com/forever/npc=269138/white-riding-kodo
            [npcKeys.name] = "White Riding Kodo",
            [npcKeys.spawns] = {[406] = {{46, 60}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [269139] = { -- Grey Riding Kodo : https://wowhead.com/forever/npc=269139/grey-riding-kodo
            [npcKeys.name] = "Grey Riding Kodo",
        },
        [269140] = { -- Brown Riding Kodo : https://wowhead.com/forever/npc=269140/brown-riding-kodo
            [npcKeys.name] = "Brown Riding Kodo",
            [npcKeys.spawns] = {[406] = {{46.2, 59.8}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [269141] = { -- Lavender Riding Kodo : https://wowhead.com/forever/npc=269141/lavender-riding-kodo
            [npcKeys.name] = "Lavender Riding Kodo",
            [npcKeys.spawns] = {[406] = {{46.2, 59.8}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
        },
        [269152] = { -- Tylana Clawhoof : https://wowhead.com/forever/npc=269152/tylana-clawhoof
            [npcKeys.name] = "Tylana Clawhoof",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[406] = {{46, 60}}},
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [269153] = { -- Mountaineer Ylva : https://wowhead.com/forever/npc=269153/mountaineer-ylva
            [npcKeys.name] = "Mountaineer Ylva",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 17,
            [npcKeys.spawns] = {[38] = {{31.8, 86.4}, {31.8, 86.6}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
            [npcKeys.questStarts] = {86585},
            [npcKeys.friendlyToFaction] = "A",
        },
        [269166] = { -- Gemmil : https://wowhead.com/forever/npc=269166/gemmil
            [npcKeys.name] = "Gemmil",
        },
        [269175] = { -- Carnivorous Weed : https://wowhead.com/forever/npc=269175/carnivorous-weed
            [npcKeys.name] = "Carnivorous Weed",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[33] = {{33.6, 27.6}, {33.6, 31.6}, {34, 29.2}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [269185] = { -- Headsplitter : https://wowhead.com/forever/npc=269185/headsplitter
            [npcKeys.name] = "Headsplitter",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 17,
            [npcKeys.spawns] = {[38] = {{31.8, 86.2}, {31.8, 86.8}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [269206] = { -- Venomhide Ravasaur : https://wowhead.com/forever/npc=269206/venomhide-ravasaur
            [npcKeys.name] = "Venomhide Ravasaur",
        },
        [269213] = { -- Hailspite : https://wowhead.com/forever/npc=269213/hailspite
            [npcKeys.name] = "Hailspite",
        },
        [269230] = { -- Kur'gok : https://wowhead.com/forever/npc=269230/kurgok
            [npcKeys.name] = "Kur'gok",
        },
        [269232] = { -- Spread Incense : https://wowhead.com/forever/npc=269232/spread-incense
            [npcKeys.name] = "Spread Incense",
        },
        [269234] = { -- Ettina Humblerange : https://wowhead.com/forever/npc=269234/ettina-humblerange
            [npcKeys.name] = "Ettina Humblerange",
        },
        [269254] = { -- Famished Blackworg : https://wowhead.com/forever/npc=269254/famished-blackworg
            [npcKeys.name] = "Famished Blackworg",
            [npcKeys.spawns] = {[51] = {{46.8, 35.6}}},
            [npcKeys.zoneID] = zoneIDs.SEARING_GORGE,
        },
        [269255] = { -- [DNT] Kill Credit: Spread Incense : https://wowhead.com/forever/npc=269255/dnt-kill-credit-spread-incense
            [npcKeys.name] = "[DNT] Kill Credit: Spread Incense",
        },
        [269270] = { -- [DNT] Kill Credit: Bundle of Herbs : https://wowhead.com/forever/npc=269270/dnt-kill-credit-bundle-of-herbs
            [npcKeys.name] = "[DNT] Kill Credit: Bundle of Herbs",
        },
        [269271] = { -- [DNT] Kill Credit: Bundle of Dried Cedar Twigs : https://wowhead.com/forever/npc=269271/dnt-kill-credit-bundle-of-dried-cedar-twigs
            [npcKeys.name] = "[DNT] Kill Credit: Bundle of Dried Cedar Twigs",
        },
        [269272] = { -- [DNT] Kill Credit: Bundle of Herbs : https://wowhead.com/forever/npc=269272/dnt-kill-credit-bundle-of-herbs
            [npcKeys.name] = "[DNT] Kill Credit: Bundle of Herbs",
        },
        [269273] = { -- [DNT] Kill Credit: Sinew Thread : https://wowhead.com/forever/npc=269273/dnt-kill-credit-sinew-thread
            [npcKeys.name] = "[DNT] Kill Credit: Sinew Thread",
        },
        [269274] = { -- [DNT] Kill Credit: Ceremonial Flint and Tinder : https://wowhead.com/forever/npc=269274/dnt-kill-credit-ceremonial-flint-and-tinder
            [npcKeys.name] = "[DNT] Kill Credit: Ceremonial Flint and Tinder",
        },
        [269275] = { -- Kuroma : https://wowhead.com/forever/npc=269275/kuroma
            [npcKeys.name] = "Kuroma",
        },
        [269276] = { -- Kamuro : https://wowhead.com/forever/npc=269276/kamuro
            [npcKeys.name] = "Kamuro",
        },
        [269280] = { -- Kirin Tor Wizard : https://wowhead.com/forever/npc=269280/kirin-tor-wizard
            [npcKeys.name] = "Kirin Tor Wizard",
        },
        [269281] = { -- Kirin Tor Guard : https://wowhead.com/forever/npc=269281/kirin-tor-guard
            [npcKeys.name] = "Kirin Tor Guard",
        },
        [269299] = { -- [DNT] Kill Credit: Slave Workers rescued : https://wowhead.com/forever/npc=269299/dnt-kill-credit-slave-workers-rescued
            [npcKeys.name] = "[DNT] Kill Credit: Slave Workers rescued",
        },
        [269319] = { -- Credit : https://wowhead.com/forever/npc=269319/credit
            [npcKeys.name] = "Credit",
        },
        [269452] = { -- Excitable Slime : https://wowhead.com/forever/npc=269452/excitable-slime
            [npcKeys.name] = "Excitable Slime",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1497] = {{50.6, 44.8}, {51.6, 58.8}, {52, 31.8}, {52.6, 58.2}, {55, 62.2}, {55.2, 63}, {55.2, 63.6}, {55.6, 63.2}, {57.2, 66.4}, {57.4, 63.6}, {74.6, 23.2}, {76.2, 24.8}, {76.2, 25.6}, {76.4, 60}, {81.2, 32.2}, {81.4, 34.4}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.questEnds] = {97583},
            [npcKeys.friendlyToFaction] = "H",
        },
        [269453] = { -- Theramore Elite : https://wowhead.com/forever/npc=269453/theramore-elite
            [npcKeys.name] = "Theramore Elite",
            [npcKeys.spawns] = {[17] = {{63.4, 58.6}, {63.6, 58.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [269454] = { -- Darkspear Elite : https://wowhead.com/forever/npc=269454/darkspear-elite
            [npcKeys.name] = "Darkspear Elite",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[17] = {{64.8, 35}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [269467] = { -- Arcane Manaling : https://wowhead.com/forever/npc=269467/arcane-manaling
            [npcKeys.name] = "Arcane Manaling",
        },
        [269475] = { -- Mana Phantom : https://wowhead.com/forever/npc=269475/mana-phantom
            [npcKeys.name] = "Mana Phantom",
        },
        [269577] = { -- Dorgaron : https://wowhead.com/forever/npc=269577/dorgaron
            [npcKeys.name] = "Dorgaron",
        },
        [269647] = { -- Mus'hale : https://wowhead.com/forever/npc=269647/mushale
            [npcKeys.name] = "Mus'hale",
            [npcKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [269668] = { -- Credit : https://wowhead.com/forever/npc=269668/credit
            [npcKeys.name] = "Credit",
        },
        [269682] = { -- Dakotah : https://wowhead.com/forever/npc=269682/dakotah
            [npcKeys.name] = "Dakotah",
            [npcKeys.spawns] = {[16591] = {{62.6, 86}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269683] = { -- Marcus : https://wowhead.com/forever/npc=269683/marcus
            [npcKeys.name] = "Marcus",
            [npcKeys.spawns] = {[16591] = {{65, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269684] = { -- Selene : https://wowhead.com/forever/npc=269684/selene
            [npcKeys.name] = "Selene",
            [npcKeys.spawns] = {[16591] = {{62.4, 86}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269685] = { -- Matthew : https://wowhead.com/forever/npc=269685/matthew
            [npcKeys.name] = "Matthew",
            [npcKeys.spawns] = {[16591] = {{62.2, 86}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269686] = { -- Michael : https://wowhead.com/forever/npc=269686/michael
            [npcKeys.name] = "Michael",
            [npcKeys.spawns] = {[16591] = {{62.2, 86}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269687] = { -- Katrixa : https://wowhead.com/forever/npc=269687/katrixa
            [npcKeys.name] = "Katrixa",
            [npcKeys.spawns] = {[16591] = {{62.2, 86}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269688] = { -- Paul : https://wowhead.com/forever/npc=269688/paul
            [npcKeys.name] = "Paul",
            [npcKeys.spawns] = {[16591] = {{65, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269689] = { -- Sentry Bartley : https://wowhead.com/forever/npc=269689/sentry-bartley
            [npcKeys.name] = "Sentry Bartley",
            [npcKeys.spawns] = {[16591] = {{60.4, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269690] = { -- Elizabeth : https://wowhead.com/forever/npc=269690/elizabeth
            [npcKeys.name] = "Elizabeth",
            [npcKeys.spawns] = {[16591] = {{64.8, 83.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269691] = { -- Horse : https://wowhead.com/forever/npc=269691/horse
            [npcKeys.name] = "Horse",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269692] = { -- Sentry Dallon : https://wowhead.com/forever/npc=269692/sentry-dallon
            [npcKeys.name] = "Sentry Dallon",
            [npcKeys.spawns] = {[16591] = {{62.2, 86.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269693] = { -- Sentry Munch : https://wowhead.com/forever/npc=269693/sentry-munch
            [npcKeys.name] = "Sentry Munch",
            [npcKeys.spawns] = {[16591] = {{62.2, 86.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269695] = { -- Cady Lloydriel : https://wowhead.com/forever/npc=269695/cady-lloydriel
            [npcKeys.name] = "Cady Lloydriel",
            [npcKeys.spawns] = {[16591] = {{66.4, 82.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269697] = { -- Luna : https://wowhead.com/forever/npc=269697/luna
            [npcKeys.name] = "Luna",
            [npcKeys.spawns] = {[16591] = {{66.4, 82.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269698] = { -- Aedamas : https://wowhead.com/forever/npc=269698/aedamas
            [npcKeys.name] = "Aedamas",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269699] = { -- Thaddeus Brillyard : https://wowhead.com/forever/npc=269699/thaddeus-brillyard
            [npcKeys.name] = "Thaddeus Brillyard",
            [npcKeys.spawns] = {[16591] = {{64.8, 83.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [269729] = { -- Risen Warhorse : https://wowhead.com/forever/npc=269729/risen-warhorse
            [npcKeys.name] = "Risen Warhorse",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 2,
            [npcKeys.spawns] = {[85] = {{20, 46}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [269730] = { -- Risen Charger : https://wowhead.com/forever/npc=269730/risen-charger
            [npcKeys.name] = "Risen Charger",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 2,
            [npcKeys.spawns] = {[85] = {{20, 46.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [269756] = { -- Malevolent Mirage : https://wowhead.com/forever/npc=269756/malevolent-mirage
            [npcKeys.name] = "Malevolent Mirage",
            [npcKeys.zoneID] = zoneIDs.BADLANDS,
        },
        [269760] = { -- Credit : https://wowhead.com/forever/npc=269760/credit
            [npcKeys.name] = "Credit",
        },
        [269795] = { -- Deception : https://wowhead.com/forever/npc=269795/deception
            [npcKeys.name] = "Deception",
        },
        [269862] = { -- Onyxia Whelpling : https://wowhead.com/forever/npc=269862/onyxia-whelpling
            [npcKeys.name] = "Onyxia Whelpling",
        },
        [269863] = { -- Stormwind Crier : https://wowhead.com/forever/npc=269863/stormwind-crier
            [npcKeys.name] = "Stormwind Crier",
        },
        [270038] = { -- Calder Gray : https://wowhead.com/forever/npc=270038/calder-gray
            [npcKeys.name] = "Calder Gray",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[1497] = {{49, 68.6}, {49, 71.4}, {49.2, 69.8}, {50, 70.4}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.friendlyToFaction] = "H",
        },
        [270054] = { -- Tove Redstone : https://wowhead.com/forever/npc=270054/tove-redstone
            [npcKeys.name] = "Tove Redstone",
            [npcKeys.spawns] = {[47] = {{12, 47}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [270094] = { -- Stormheart : https://wowhead.com/forever/npc=270094/stormheart
            [npcKeys.name] = "Stormheart",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.THOUSAND_NEEDLES,
        },
        [270112] = { -- Saera Wirraway : https://wowhead.com/forever/npc=270112/saera-wirraway
            [npcKeys.name] = "Saera Wirraway",
            [npcKeys.minLevel] = 58,
            [npcKeys.maxLevel] = 58,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270191] = { -- Fallen Skyborne : https://wowhead.com/forever/npc=270191/fallen-skyborne
            [npcKeys.name] = "Fallen Skyborne",
        },
        [270192] = { -- Drowned Skyborne : https://wowhead.com/forever/npc=270192/drowned-skyborne
            [npcKeys.name] = "Drowned Skyborne",
        },
        [270196] = { -- Jai'vhanel : https://wowhead.com/forever/npc=270196/jaivhanel
            [npcKeys.name] = "Jai'vhanel",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[148] = {{45, 58.2}, {45, 58.6}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [270201] = { -- Al'Aketh Brawler : https://wowhead.com/forever/npc=270201/alaketh-brawler
            [npcKeys.name] = "Al'Aketh Brawler",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{64.4, 66.2}, {65, 65.4}, {65, 66.6}, {65, 67.6}, {65.2, 65.8}, {65.4, 64.4}, {65.4, 69.4}, {65.4, 69.6}, {65.6, 64.4}, {65.6, 64.6}, {65.6, 66.4}, {65.6, 69.6}, {66, 67.2}, {66.2, 67.8}, {66.6, 67.8}, {66.8, 67.4}, {68.6, 67.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [270214] = { -- Peacekeeper : https://wowhead.com/forever/npc=270214/peacekeeper
            [npcKeys.name] = "Peacekeeper",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{68.4, 67.2}, {68.6, 67.4}, {68.6, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [270263] = { -- Farseer Maret Firetend : https://wowhead.com/forever/npc=270263/farseer-maret-firetend
            [npcKeys.name] = "Farseer Maret Firetend",
        },
        [270269] = { -- Arbal : https://wowhead.com/forever/npc=270269/arbal
            [npcKeys.name] = "Arbal",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[148] = {{43.6, 76.4}, {43.6, 76.6}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
            [npcKeys.questStarts] = {98013},
            [npcKeys.questEnds] = {98013},
            [npcKeys.friendlyToFaction] = "A",
        },
        [270278] = { -- Bordolf Axegrim : https://wowhead.com/forever/npc=270278/bordolf-axegrim
            [npcKeys.name] = "Bordolf Axegrim",
        },
        [270280] = { -- Torin Treehame : https://wowhead.com/forever/npc=270280/torin-treehame
            [npcKeys.name] = "Torin Treehame",
        },
        [270294] = { -- Baron Marinous : https://wowhead.com/forever/npc=270294/baron-marinous
            [npcKeys.name] = "Baron Marinous",
            [npcKeys.minLevel] = 21,
            [npcKeys.maxLevel] = 21,
            [npcKeys.spawns] = {[148] = {{59.2, 22.8}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [270298] = { -- Child of Jai'vhanel : https://wowhead.com/forever/npc=270298/child-of-jaivhanel
            [npcKeys.name] = "Child of Jai'vhanel",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[148] = {{44, 59}, {44.4, 60.4}, {44.4, 60.8}, {44.6, 59.2}, {45, 58.4}, {45.6, 57.2}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270307] = { -- Argent Wayfinder : https://wowhead.com/forever/npc=270307/argent-wayfinder
            [npcKeys.name] = "Argent Wayfinder",
        },
        [270310] = { -- Farholde Steed : https://wowhead.com/forever/npc=270310/farholde-steed
            [npcKeys.name] = "Farholde Steed",
            [npcKeys.spawns] = {[16591] = {{45, 79}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [270313] = { -- Generic Bunny : https://wowhead.com/forever/npc=270313/generic-bunny
            [npcKeys.name] = "Generic Bunny",
        },
        [270388] = { -- [DNT] Reward Vendor : https://wowhead.com/forever/npc=270388/dnt-reward-vendor
            [npcKeys.name] = "[DNT] Reward Vendor",
        },
        [270418] = { -- Credit : https://wowhead.com/forever/npc=270418/credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1657] = {{33.2, 16}, {33.8, 15.8}, {34.2, 16.8}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [270419] = { -- Credit : https://wowhead.com/forever/npc=270419/credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1657] = {{40.4, 44.4}, {40.6, 42.2}, {40.6, 44.6}, {40.8, 43.6}, {41.4, 43.2}, {41.6, 43}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270420] = { -- Credit : https://wowhead.com/forever/npc=270420/credit
            [npcKeys.name] = "Credit",
            [npcKeys.spawns] = {[1657] = {{66.4, 15.4}, {66.8, 15.6}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [270421] = { -- Credit : https://wowhead.com/forever/npc=270421/credit
            [npcKeys.name] = "Credit",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[141] = {{35.8, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [270422] = { -- Sentinel Owl : https://wowhead.com/forever/npc=270422/sentinel-owl
            [npcKeys.name] = "Sentinel Owl",
        },
        [270424] = { -- Credit : https://wowhead.com/forever/npc=270424/credit
            [npcKeys.name] = "Credit",
        },
        [270426] = { -- Credit : https://wowhead.com/forever/npc=270426/credit
            [npcKeys.name] = "Credit",
        },
        [270438] = { -- Deathstalker Masoj : https://wowhead.com/forever/npc=270438/deathstalker-masoj
            [npcKeys.name] = "Deathstalker Masoj",
            [npcKeys.spawns] = {[267] = {{64.2, 54}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [270451] = { -- Executor Asharell : https://wowhead.com/forever/npc=270451/executor-asharell
            [npcKeys.name] = "Executor Asharell",
        },
        [270459] = { -- Alfina Nightgaze : https://wowhead.com/forever/npc=270459/alfina-nightgaze
            [npcKeys.name] = "Alfina Nightgaze",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{11.8, 56.4}, {11.8, 56.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.questStarts] = {6121},
            [npcKeys.friendlyToFaction] = "A",
        },
        [270513] = { -- Spellweaver Thaldris : https://wowhead.com/forever/npc=270513/spellweaver-thaldris
            [npcKeys.name] = "Spellweaver Thaldris",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[36] = {{17.8, 60.4}, {17.8, 60.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270542] = { -- Brown Horse : https://wowhead.com/forever/npc=270542/brown-horse
            [npcKeys.name] = "Brown Horse",
            [npcKeys.zoneID] = zoneIDs.DUSTWALLOW_MARSH,
        },
        [270543] = { -- Chestnut Mare : https://wowhead.com/forever/npc=270543/chestnut-mare
            [npcKeys.name] = "Chestnut Mare",
        },
        [270544] = { -- Pinto : https://wowhead.com/forever/npc=270544/pinto
            [npcKeys.name] = "Pinto",
        },
        [270545] = { -- Kenneth "Kirby" Millstead : https://wowhead.com/forever/npc=270545/kenneth-kirby-millstead
            [npcKeys.name] = "Kenneth \"Kirby\" Millstead",
            [npcKeys.minLevel] = 49,
            [npcKeys.maxLevel] = 49,
            [npcKeys.spawns] = {[16591] = {{65.4, 89.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270570] = { -- Justine Kai : https://wowhead.com/forever/npc=270570/justine-kai
            [npcKeys.name] = "Justine Kai",
            [npcKeys.spawns] = {[16591] = {{64, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [270571] = { -- Donald Armstrong : https://wowhead.com/forever/npc=270571/donald-armstrong
            [npcKeys.name] = "Donald Armstrong",
            [npcKeys.spawns] = {[16591] = {{62.2, 85.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [270572] = { -- Emily : https://wowhead.com/forever/npc=270572/emily
            [npcKeys.name] = "Emily",
            [npcKeys.spawns] = {[16591] = {{64.8, 83.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [270573] = { -- Credit : https://wowhead.com/forever/npc=270573/credit
            [npcKeys.name] = "Credit",
        },
        [270574] = { -- Credit : https://wowhead.com/forever/npc=270574/credit
            [npcKeys.name] = "Credit",
        },
        [270575] = { -- Credit : https://wowhead.com/forever/npc=270575/credit
            [npcKeys.name] = "Credit",
        },
        [270581] = { -- Fyrenz Vishonar : https://wowhead.com/forever/npc=270581/fyrenz-vishonar
            [npcKeys.name] = "Fyrenz Vishonar",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270582] = { -- Mon'ye : https://wowhead.com/forever/npc=270582/monye
            [npcKeys.name] = "Mon'ye",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1637] = {{46, 53.4}, {46.2, 53.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [270589] = { -- Nightveiled Rotheap : https://wowhead.com/forever/npc=270589/nightveiled-rotheap
            [npcKeys.name] = "Nightveiled Rotheap",
            [npcKeys.minLevel] = 31,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[11] = {{11.6, 52.6}, {12.6, 49.6}, {13, 48.8}, {16, 44.4}, {16.2, 44.6}, {16.2, 48.4}, {17.4, 43.6}, {17.6, 33.6}, {18, 25}, {18, 42.4}, {18.4, 47.6}, {19.6, 43.4}, {19.8, 43.6}, {20, 45.8}, {20.2, 27.4}, {20.2, 28}, {20.2, 49.4}, {20.4, 26.2}, {20.4, 44.6}, {20.8, 43.4}, {21, 44.2}, {21.6, 45.2}, {21.8, 28.2}, {21.8, 43.4}, {22.6, 27.8}, {22.8, 27.2}, {24.6, 34}, {25.2, 42.6}, {25.8, 42.2}, {26.2, 21.2}, {26.2, 23.8}, {26.6, 41.8}, {27, 20.4}, {27.4, 18.2}, {27.4, 21.6}, {27.4, 23}, {27.6, 26.6}, {27.8, 39.6}, {28, 18.4}, {28, 41.2}, {28.4, 29.4}, {28.8, 25.2}, {28.8, 31.6}, {28.8, 41}, {29.4, 30.6}, {29.4, 33.8}, {29.6, 30.4}, {29.8, 23.2}, {30, 31.2}, {31, 23.8}, {31.2, 39.6}, {32.6, 21.2}, {32.8, 38.6}, {33, 35.4}, {33.2, 22.6}, {34.2, 24.8}, {34.8, 25}, {35.6, 24.6}, {37.8, 32.2}, {37.8, 32.8}, {39.4, 37.4}, {41, 36}, {41.2, 37.6}, {42.6, 28.8}, {43.2, 30.4}, {43.6, 38}, {43.8, 31.8}, {44, 29}, {44.8, 38.6}, {46, 32.6}, {47.4, 38.8}, {47.6, 34}, {48.4, 39.4}, {49, 36.2}, {49.2, 39.4}, {49.6, 35.8}, {49.8, 35.2}, {49.8, 38.4}, {50.2, 40.6}, {52, 36.2}, {53.4, 45.2}, {57.6, 55.6}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [270637] = { -- Howin Kindfeather : https://wowhead.com/forever/npc=270637/howin-kindfeather
            [npcKeys.name] = "Howin Kindfeather",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[11] = {{49.4, 42}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [270664] = { -- Venomweb Spitter : https://wowhead.com/forever/npc=270664/venomweb-spitter
            [npcKeys.name] = "Venomweb Spitter",
        },
        [270667] = { -- Farholde Priest Initiate : https://wowhead.com/forever/npc=270667/farholde-priest-initiate
            [npcKeys.name] = "Farholde Priest Initiate",
            [npcKeys.spawns] = {[16591] = {{45.8, 65.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [270693] = { -- Daggerfang : https://wowhead.com/forever/npc=270693/daggerfang
            [npcKeys.name] = "Daggerfang",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[38] = {{59, 39}, {59.2, 34.4}, {59.4, 37.2}, {59.6, 37}, {60, 39}, {60.2, 41.2}, {60.8, 41.6}, {61.4, 43.2}, {61.6, 41.6}, {61.6, 44.2}, {62.2, 44.8}, {62.4, 46.2}, {62.6, 52.8}, {63, 50.6}, {63, 51.8}, {63.2, 45.6}, {63.2, 49.4}, {63.2, 50.4}, {63.4, 47.4}, {63.4, 47.8}, {63.6, 48}, {63.6, 50}, {63.8, 48.8}, {64, 46.4}}},
            [npcKeys.zoneID] = zoneIDs.LOCH_MODAN,
        },
        [270723] = { -- Drazzit Dripvalve : https://wowhead.com/forever/npc=270723/drazzit-dripvalve
            [npcKeys.name] = "Drazzit Dripvalve",
        },
        [270727] = { -- Gizzix Grimegurgle : https://wowhead.com/forever/npc=270727/gizzix-grimegurgle
            [npcKeys.name] = "Gizzix Grimegurgle",
        },
        [270728] = { -- Miss Melly : https://wowhead.com/forever/npc=270728/miss-melly
            [npcKeys.name] = "Miss Melly",
        },
        [270772] = { -- Witch Doctor Ti'ik : https://wowhead.com/forever/npc=270772/witch-doctor-tiik
            [npcKeys.name] = "Witch Doctor Ti'ik",
        },
        [270780] = { -- Qujo : https://wowhead.com/forever/npc=270780/qujo
            [npcKeys.name] = "Qujo",
            [npcKeys.spawns] = {[47] = {{77.8, 78}}},
            [npcKeys.zoneID] = zoneIDs.THE_HINTERLANDS,
        },
        [270807] = { -- Hexed Larva : https://wowhead.com/forever/npc=270807/hexed-larva
            [npcKeys.name] = "Hexed Larva",
        },
        [270844] = { -- Sylessa Duskwhisper : https://wowhead.com/forever/npc=270844/sylessa-duskwhisper
            [npcKeys.name] = "Sylessa Duskwhisper",
            [npcKeys.spawns] = {[11] = {{8, 55.8}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [270846] = { -- Twilight Shadowmancer : https://wowhead.com/forever/npc=270846/twilight-shadowmancer
            [npcKeys.name] = "Twilight Shadowmancer",
            [npcKeys.spawns] = {[16591] = {{45.2, 56}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [270847] = { -- Twilight Neophyte : https://wowhead.com/forever/npc=270847/twilight-neophyte
            [npcKeys.name] = "Twilight Neophyte",
        },
        [270882] = { -- Zul'Alai : https://wowhead.com/forever/npc=270882/zulalai
            [npcKeys.name] = "Zul'Alai",
        },
        [270883] = { -- Var'Taka : https://wowhead.com/forever/npc=270883/vartaka
            [npcKeys.name] = "Var'Taka",
        },
        [270884] = { -- Captain Dreadrise : https://wowhead.com/forever/npc=270884/captain-dreadrise
            [npcKeys.name] = "Captain Dreadrise",
        },
        [270885] = { -- Deathless Marrow : https://wowhead.com/forever/npc=270885/deathless-marrow
            [npcKeys.name] = "Deathless Marrow",
        },
        [270886] = { -- Min'loth the Serpent : https://wowhead.com/forever/npc=270886/minloth-the-serpent
            [npcKeys.name] = "Min'loth the Serpent",
        },
        [270887] = { -- Primeval Elemental : https://wowhead.com/forever/npc=270887/primeval-elemental
            [npcKeys.name] = "Primeval Elemental",
        },
        [270888] = { -- Gill : https://wowhead.com/forever/npc=270888/gill
            [npcKeys.name] = "Gill",
        },
        [270892] = { -- Goaz Warder : https://wowhead.com/forever/npc=270892/goaz-warder
            [npcKeys.name] = "Goaz Warder",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [270904] = { -- Chasm Crawler : https://wowhead.com/forever/npc=270904/chasm-crawler
            [npcKeys.name] = "Chasm Crawler",
        },
        [270905] = { -- Makrura Snapper : https://wowhead.com/forever/npc=270905/makrura-snapper
            [npcKeys.name] = "Makrura Snapper",
        },
        [270910] = { -- Brinescale Priestess : https://wowhead.com/forever/npc=270910/brinescale-priestess
            [npcKeys.name] = "Brinescale Priestess",
        },
        [270911] = { -- Saltscale Muckdweller : https://wowhead.com/forever/npc=270911/saltscale-muckdweller
            [npcKeys.name] = "Saltscale Muckdweller",
        },
        [270912] = { -- Saltseer Manhunter : https://wowhead.com/forever/npc=270912/saltseer-manhunter
            [npcKeys.name] = "Saltseer Manhunter",
        },
        [270913] = { -- Deathless Sorcerer : https://wowhead.com/forever/npc=270913/deathless-sorcerer
            [npcKeys.name] = "Deathless Sorcerer",
        },
        [270915] = { -- Snake : https://wowhead.com/forever/npc=270915/snake
            [npcKeys.name] = "Snake",
        },
        [270919] = { -- Ugbert : https://wowhead.com/forever/npc=270919/ugbert
            [npcKeys.name] = "Ugbert",
        },
        [271005] = { -- Burt Lazlo : https://wowhead.com/forever/npc=271005/burt-lazlo
            [npcKeys.name] = "Burt Lazlo",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{64.6, 84.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [271006] = { -- Christina Von Stavern : https://wowhead.com/forever/npc=271006/christina-von-stavern
            [npcKeys.name] = "Christina Von Stavern",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 36,
            [npcKeys.spawns] = {[16591] = {{64.6, 84.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [271007] = { -- Interrogator Ravenwing : https://wowhead.com/forever/npc=271007/interrogator-ravenwing
            [npcKeys.name] = "Interrogator Ravenwing",
            [npcKeys.spawns] = {[16591] = {{66.6, 81}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [271008] = { -- Rog'mar Shaman Initiate : https://wowhead.com/forever/npc=271008/rogmar-shaman-initiate
            [npcKeys.name] = "Rog'mar Shaman Initiate",
        },
        [271012] = { -- Bassbeak : https://wowhead.com/forever/npc=271012/bassbeak
            [npcKeys.name] = "Bassbeak",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[11] = {{50, 40.6}, {50.2, 40.4}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [271034] = { -- Gragtharr : https://wowhead.com/forever/npc=271034/gragtharr
            [npcKeys.name] = "Gragtharr",
            [npcKeys.spawns] = {[1637] = {{56.6, 34.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [271035] = { -- Nalrekk Fizzlewrench : https://wowhead.com/forever/npc=271035/nalrekk-fizzlewrench
            [npcKeys.name] = "Nalrekk Fizzlewrench",
            [npcKeys.spawns] = {[1637] = {{56.6, 34.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [271036] = { -- Rorschak : https://wowhead.com/forever/npc=271036/rorschak
            [npcKeys.name] = "Rorschak",
            [npcKeys.spawns] = {[1637] = {{56.6, 34.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [271080] = { -- Blightsculler : https://wowhead.com/forever/npc=271080/blightsculler
            [npcKeys.name] = "Blightsculler",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[85] = {{15.4, 55.8}, {15.6, 55.8}, {16, 55}, {16.4, 56.6}, {16.8, 57.8}, {17, 56.4}, {17, 57}, {17.2, 53.8}, {17.6, 57}, {17.8, 52.2}, {18, 50.8}, {18, 53}, {18, 53.6}, {18, 55.8}, {18.4, 55.2}, {18.6, 51.2}, {18.6, 53.8}, {18.8, 53}, {18.8, 54.8}, {19, 52.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [271167] = { -- Guard Jameson : https://wowhead.com/forever/npc=271167/guard-jameson
            [npcKeys.name] = "Guard Jameson",
        },
        [271181] = { -- Eye of Kilrogg : https://wowhead.com/forever/npc=271181/eye-of-kilrogg
            [npcKeys.name] = "Eye of Kilrogg",
        },
        [271182] = { -- Credit : https://wowhead.com/forever/npc=271182/credit
            [npcKeys.name] = "Credit",
        },
        [271293] = { -- [DNT] Kill Credit: Twilight Thrall : https://wowhead.com/forever/npc=271293/dnt-kill-credit-twilight-thrall
            [npcKeys.name] = "[DNT] Kill Credit: Twilight Thrall",
        },
        [271322] = { -- Essene Villard : https://wowhead.com/forever/npc=271322/essene-villard
            [npcKeys.name] = "Essene Villard",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271332] = { -- Aerie Gryphon : https://wowhead.com/forever/npc=271332/aerie-gryphon
            [npcKeys.name] = "Aerie Gryphon",
        },
        [271333] = { -- Aerie Gryphon : https://wowhead.com/forever/npc=271333/aerie-gryphon
            [npcKeys.name] = "Aerie Gryphon",
        },
        [271334] = { -- Maddened Rotclaw : https://wowhead.com/forever/npc=271334/maddened-rotclaw
            [npcKeys.name] = "Maddened Rotclaw",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271335] = { -- Aerie Gryphon Hatchling : https://wowhead.com/forever/npc=271335/aerie-gryphon-hatchling
            [npcKeys.name] = "Aerie Gryphon Hatchling",
        },
        [271336] = { -- Carnage : https://wowhead.com/forever/npc=271336/carnage
            [npcKeys.name] = "Carnage",
        },
        [271338] = { -- Ados : https://wowhead.com/forever/npc=271338/ados
            [npcKeys.name] = "Ados",
            [npcKeys.spawns] = {[11] = {{77.4, 46.8}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271339] = { -- Ent : https://wowhead.com/forever/npc=271339/ent
            [npcKeys.name] = "Ent",
        },
        [271346] = { -- Dragonmaw Infiltrator : https://wowhead.com/forever/npc=271346/dragonmaw-infiltrator
            [npcKeys.name] = "Dragonmaw Infiltrator",
            [npcKeys.spawns] = {[11] = {{57.6, 49.6}, {58.2, 47.6}, {72, 48.6}, {76, 45.8}, {77.4, 47.2}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271348] = { -- Dragonmaw Soulbinder : https://wowhead.com/forever/npc=271348/dragonmaw-soulbinder
            [npcKeys.name] = "Dragonmaw Soulbinder",
            [npcKeys.spawns] = {[11] = {{71.2, 47}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271351] = { -- Dragonmaw Reclaimer : https://wowhead.com/forever/npc=271351/dragonmaw-reclaimer
            [npcKeys.name] = "Dragonmaw Reclaimer",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271368] = { -- Shadowgale Squirrel : https://wowhead.com/forever/npc=271368/shadowgale-squirrel
            [npcKeys.name] = "Shadowgale Squirrel",
        },
        [271373] = { -- Subdued Dragonspawn : https://wowhead.com/forever/npc=271373/subdued-dragonspawn
            [npcKeys.name] = "Subdued Dragonspawn",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271437] = { -- Portal : https://wowhead.com/forever/npc=271437/portal
            [npcKeys.name] = "Portal",
        },
        [271446] = { -- Red Drake : https://wowhead.com/forever/npc=271446/red-drake
            [npcKeys.name] = "Red Drake",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271458] = { -- Neru : https://wowhead.com/forever/npc=271458/neru
            [npcKeys.name] = "Neru",
        },
        [271460] = { -- Modr : https://wowhead.com/forever/npc=271460/modr
            [npcKeys.name] = "Modr",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[11] = {{51.4, 17.2}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271462] = { -- Golm : https://wowhead.com/forever/npc=271462/golm
            [npcKeys.name] = "Golm",
            [npcKeys.minLevel] = 32,
            [npcKeys.maxLevel] = 32,
            [npcKeys.spawns] = {[11] = {{67.6, 72.2}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271465] = { -- Falfaan Halfwind : https://wowhead.com/forever/npc=271465/falfaan-halfwind
            [npcKeys.name] = "Falfaan Halfwind",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{59.4, 75.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [271478] = { -- Elaria Anvilwind : https://wowhead.com/forever/npc=271478/elaria-anvilwind
            [npcKeys.name] = "Elaria Anvilwind",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{59.4, 76}, {59.6, 76}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [271480] = { -- Taliaa Brightsky : https://wowhead.com/forever/npc=271480/taliaa-brightsky
            [npcKeys.name] = "Taliaa Brightsky",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{59.2, 76.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [271481] = { -- Captive Fire Elemental : https://wowhead.com/forever/npc=271481/captive-fire-elemental
            [npcKeys.name] = "Captive Fire Elemental",
            [npcKeys.spawns] = {[11] = {{45.6, 16.6}}},
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [271483] = { -- Ergaan Eastwind : https://wowhead.com/forever/npc=271483/ergaan-eastwind
            [npcKeys.name] = "Ergaan Eastwind",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[16593] = {{59.6, 75.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [271486] = { -- Wendigo Shaman : https://wowhead.com/forever/npc=271486/wendigo-shaman
            [npcKeys.name] = "Wendigo Shaman",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{39, 47.8}, {39.2, 49.4}, {39.4, 46.2}, {39.4, 47.4}, {39.6, 49.2}, {40.2, 47.6}, {40.4, 45.4}, {40.4, 45.6}, {40.4, 47.2}, {40.6, 45.4}, {40.6, 45.6}, {41.8, 45.4}, {42, 46.2}, {42, 46.8}, {42, 48.4}, {42, 49.4}, {42.6, 49.2}, {42.8, 50}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [271511] = { -- Renegade Fire Elemental : https://wowhead.com/forever/npc=271511/renegade-fire-elemental
            [npcKeys.name] = "Renegade Fire Elemental",
        },
        [271530] = { -- Elder Wendigo : https://wowhead.com/forever/npc=271530/elder-wendigo
            [npcKeys.name] = "Elder Wendigo",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{38.8, 48.2}, {39.4, 46.2}, {39.4, 47.2}, {40, 48.6}, {40.2, 48.4}, {40.4, 46.4}, {40.4, 46.6}, {40.6, 46.2}, {40.6, 46.8}, {41.2, 45.2}, {41.4, 48.4}, {41.6, 45.4}, {42, 46.4}, {42, 46.6}, {42, 47.6}, {42.4, 49.4}, {42.4, 50.4}, {42.4, 50.8}, {42.6, 47}, {42.6, 49.4}, {42.6, 50.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [271546] = { -- Mountaineer Gretchen : https://wowhead.com/forever/npc=271546/mountaineer-gretchen
            [npcKeys.name] = "Mountaineer Gretchen",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[1] = {{44, 57}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.questStarts] = {98319, 98323},
            [npcKeys.questEnds] = {98319, 98322},
            [npcKeys.friendlyToFaction] = "A",
        },
        [271587] = { -- Frosthowl : https://wowhead.com/forever/npc=271587/frosthowl
            [npcKeys.name] = "Frosthowl",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[1] = {{39.2, 49.6}, {39.4, 48.4}, {39.4, 48.8}, {39.6, 47.4}, {39.8, 48.6}, {40, 48.4}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [271613] = { -- Unfinished Abomination : https://wowhead.com/forever/npc=271613/unfinished-abomination
            [npcKeys.name] = "Unfinished Abomination",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[1497] = {{46, 62.2}, {46.2, 63}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.questStarts] = {97290},
            [npcKeys.questEnds] = {97289},
            [npcKeys.friendlyToFaction] = "H",
        },
        [271636] = { -- Weevil K. Neevil : https://wowhead.com/forever/npc=271636/weevil-k-neevil
            [npcKeys.name] = "Weevil K. Neevil",
        },
        [271637] = { -- Vigilantes Active : https://wowhead.com/forever/npc=271637/vigilantes-active
            [npcKeys.name] = "Vigilantes Active",
        },
        [271638] = { -- Here! : https://wowhead.com/forever/npc=271638/here
            [npcKeys.name] = "Here!",
        },
        [271639] = { -- Watchful Eyes : https://wowhead.com/forever/npc=271639/watchful-eyes
            [npcKeys.name] = "Watchful Eyes",
        },
        [271640] = { -- Good Camping : https://wowhead.com/forever/npc=271640/good-camping
            [npcKeys.name] = "Good Camping",
        },
        [271641] = { -- Bad Farm : https://wowhead.com/forever/npc=271641/bad-farm
            [npcKeys.name] = "Bad Farm",
        },
        [271642] = { -- Missed You : https://wowhead.com/forever/npc=271642/missed-you
            [npcKeys.name] = "Missed You",
        },
        [271643] = { -- Do Not Follow : https://wowhead.com/forever/npc=271643/do-not-follow
            [npcKeys.name] = "Do Not Follow",
        },
        [271644] = { -- Unsafe Area : https://wowhead.com/forever/npc=271644/unsafe-area
            [npcKeys.name] = "Unsafe Area",
        },
        [271645] = { -- I Went This Way : https://wowhead.com/forever/npc=271645/i-went-this-way
            [npcKeys.name] = "I Went This Way",
        },
        [271646] = { -- Follow : https://wowhead.com/forever/npc=271646/follow
            [npcKeys.name] = "Follow",
        },
        [271647] = { -- Need Special Item : https://wowhead.com/forever/npc=271647/need-special-item
            [npcKeys.name] = "Need Special Item",
        },
        [271648] = { -- Secret Nearby : https://wowhead.com/forever/npc=271648/secret-nearby
            [npcKeys.name] = "Secret Nearby",
        },
        [271649] = { -- Death Trap : https://wowhead.com/forever/npc=271649/death-trap
            [npcKeys.name] = "Death Trap",
        },
        [271698] = { -- Restless Spirit : https://wowhead.com/forever/npc=271698/restless-spirit
            [npcKeys.name] = "Restless Spirit",
            [npcKeys.minLevel] = 23,
            [npcKeys.maxLevel] = 23,
            [npcKeys.spawns] = {[493] = {{70.6, 61.2}, {72, 62}, {72, 62.6}, {72.4, 66.4}, {73, 64.2}, {73.2, 66.4}, {73.6, 68}, {73.8, 67.4}, {74.4, 66}, {74.8, 64.8}, {75, 66.6}}},
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [271707] = { -- Juvenile Cloudrunner : https://wowhead.com/forever/npc=271707/juvenile-cloudrunner
            [npcKeys.name] = "Juvenile Cloudrunner",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[16593] = {{45.6, 80.8}, {46.2, 80.4}, {46.6, 81.8}, {47.4, 84.2}, {48.2, 85.2}, {49, 77.6}, {50.2, 77.6}, {50.6, 85.4}, {51, 78.6}, {52.4, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [271710] = { -- Cloudrunner Matriarch : https://wowhead.com/forever/npc=271710/cloudrunner-matriarch
            [npcKeys.name] = "Cloudrunner Matriarch",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[16593] = {{46.8, 81.8}, {47.4, 84.2}, {47.6, 80.6}, {48.2, 85.2}, {48.6, 85}, {49.2, 77.8}, {50.6, 85.2}, {52.4, 80.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [271712] = { -- Cloudrunner : https://wowhead.com/forever/npc=271712/cloudrunner
            [npcKeys.name] = "Cloudrunner",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.spawns] = {[16593] = {{36.4, 58}, {36.4, 58.6}, {36.6, 58.4}, {37, 58.6}, {38.8, 53.4}, {39, 53.8}, {39.6, 53.4}, {39.6, 58}, {41, 52.4}, {41.2, 52.6}, {41.2, 62.8}, {41.6, 52}, {42, 61.2}, {42.6, 60.6}, {43.6, 58.8}, {43.6, 60}, {43.8, 69.2}, {44.2, 68}, {44.6, 57.8}, {44.6, 66.8}, {46, 59.8}, {46, 68}, {46.4, 57.8}, {46.4, 67.4}, {47.2, 57.8}, {47.8, 63}, {48.6, 63.6}, {49, 62.4}, {49.2, 66}, {50.6, 51.4}, {50.6, 52.2}, {50.6, 57.4}, {52.2, 41.2}, {52.4, 42.2}, {52.4, 57.4}, {52.6, 42.4}, {52.6, 57.2}, {52.6, 62.4}, {52.8, 58}, {53.2, 43.6}, {53.8, 44.2}, {54.2, 44.8}, {54.6, 61.2}, {54.8, 45}, {54.8, 50.4}, {54.8, 60.2}, {55, 50.6}, {55.4, 57.2}, {57.2, 56.4}, {57.4, 56.6}, {58, 57}, {58.4, 58.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [271732] = { -- Thicket Stalker : https://wowhead.com/forever/npc=271732/thicket-stalker
            [npcKeys.name] = "Thicket Stalker",
        },
        [271736] = { -- Josh : https://wowhead.com/forever/npc=271736/josh
            [npcKeys.name] = "Josh",
            [npcKeys.spawns] = {[16591] = {{60, 87.8}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [271742] = { -- Abbot Schuncke : https://wowhead.com/forever/npc=271742/abbot-schuncke
            [npcKeys.name] = "Abbot Schuncke",
            [npcKeys.spawns] = {[16591] = {{60.8, 85.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [271746] = { -- Corporal Twohig : https://wowhead.com/forever/npc=271746/corporal-twohig
            [npcKeys.name] = "Corporal Twohig",
            [npcKeys.spawns] = {[16591] = {{66.8, 81.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [271749] = { -- Oil Slime : https://wowhead.com/forever/npc=271749/oil-slime
            [npcKeys.name] = "Oil Slime",
        },
        [271750] = { -- Tar Ooze : https://wowhead.com/forever/npc=271750/tar-ooze
            [npcKeys.name] = "Tar Ooze",
        },
        [271751] = { -- Blistered Ooze : https://wowhead.com/forever/npc=271751/blistered-ooze
            [npcKeys.name] = "Blistered Ooze",
        },
        [271786] = { -- Cerulean Prideclaw : https://wowhead.com/forever/npc=271786/cerulean-prideclaw
            [npcKeys.name] = "Cerulean Prideclaw",
        },
        [271804] = { -- Black Warden Saber Mount : https://wowhead.com/forever/npc=271804/black-warden-saber-mount
            [npcKeys.name] = "Black Warden Saber Mount",
        },
        [271805] = { -- Brown Warden Saber Mount : https://wowhead.com/forever/npc=271805/brown-warden-saber-mount
            [npcKeys.name] = "Brown Warden Saber Mount",
        },
        [271806] = { -- Gray Warden Saber Mount : https://wowhead.com/forever/npc=271806/gray-warden-saber-mount
            [npcKeys.name] = "Gray Warden Saber Mount",
        },
        [271807] = { -- White Warden Saber Mount : https://wowhead.com/forever/npc=271807/white-warden-saber-mount
            [npcKeys.name] = "White Warden Saber Mount",
        },
        [271845] = { -- Black Devilsaur Mount : https://wowhead.com/forever/npc=271845/black-devilsaur-mount
            [npcKeys.name] = "Black Devilsaur Mount",
        },
        [271846] = { -- Blue Devilsaur Mount : https://wowhead.com/forever/npc=271846/blue-devilsaur-mount
            [npcKeys.name] = "Blue Devilsaur Mount",
        },
        [271847] = { -- Green Devilsaur Mount : https://wowhead.com/forever/npc=271847/green-devilsaur-mount
            [npcKeys.name] = "Green Devilsaur Mount",
        },
        [271848] = { -- Purple Devilsaur Mount : https://wowhead.com/forever/npc=271848/purple-devilsaur-mount
            [npcKeys.name] = "Purple Devilsaur Mount",
        },
        [271849] = { -- White Devilsaur Mount : https://wowhead.com/forever/npc=271849/white-devilsaur-mount
            [npcKeys.name] = "White Devilsaur Mount",
        },
        [271855] = { -- Black Druid Moose Mount : https://wowhead.com/forever/npc=271855/black-druid-moose-mount
            [npcKeys.name] = "Black Druid Moose Mount",
        },
        [271856] = { -- White Druid Moose Mount : https://wowhead.com/forever/npc=271856/white-druid-moose-mount
            [npcKeys.name] = "White Druid Moose Mount",
        },
        [271857] = { -- Green Druid Moose Mount : https://wowhead.com/forever/npc=271857/green-druid-moose-mount
            [npcKeys.name] = "Green Druid Moose Mount",
        },
        [271858] = { -- Gray Druid Moose Mount : https://wowhead.com/forever/npc=271858/gray-druid-moose-mount
            [npcKeys.name] = "Gray Druid Moose Mount",
        },
        [271863] = { -- Veteran Adventurer's Loyal Companion : https://wowhead.com/forever/npc=271863/veteran-adventurers-loyal-companion
            [npcKeys.name] = "Veteran Adventurer's Loyal Companion",
        },
        [271866] = { -- Night Watch Guard : https://wowhead.com/forever/npc=271866/night-watch-guard
            [npcKeys.name] = "Night Watch Guard",
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
            [npcKeys.questStarts] = {99267},
            [npcKeys.questEnds] = {99267},
        },
        [271867] = { -- Pachimari : https://wowhead.com/forever/npc=271867/pachimari
            [npcKeys.name] = "Pachimari",
        },
        [271870] = { -- Galestrider Chick : https://wowhead.com/forever/npc=271870/galestrider-chick
            [npcKeys.name] = "Galestrider Chick",
        },
        [271874] = { -- Black Furbolg Pet : https://wowhead.com/forever/npc=271874/black-furbolg-pet
            [npcKeys.name] = "Black Furbolg Pet",
        },
        [271875] = { -- Brown Furbolg Pet : https://wowhead.com/forever/npc=271875/brown-furbolg-pet
            [npcKeys.name] = "Brown Furbolg Pet",
        },
        [271876] = { -- Gray Furbolg Pet : https://wowhead.com/forever/npc=271876/gray-furbolg-pet
            [npcKeys.name] = "Gray Furbolg Pet",
        },
        [271877] = { -- Tan Furbolg Pet : https://wowhead.com/forever/npc=271877/tan-furbolg-pet
            [npcKeys.name] = "Tan Furbolg Pet",
        },
        [271878] = { -- White Furbolg Pet : https://wowhead.com/forever/npc=271878/white-furbolg-pet
            [npcKeys.name] = "White Furbolg Pet",
        },
        [271888] = { -- Purple Ent Pet : https://wowhead.com/forever/npc=271888/purple-ent-pet
            [npcKeys.name] = "Purple Ent Pet",
        },
        [271889] = { -- Red Ent Pet : https://wowhead.com/forever/npc=271889/red-ent-pet
            [npcKeys.name] = "Red Ent Pet",
        },
        [271890] = { -- Blue Ent Pet : https://wowhead.com/forever/npc=271890/blue-ent-pet
            [npcKeys.name] = "Blue Ent Pet",
        },
        [271891] = { -- Gray Ent Pet : https://wowhead.com/forever/npc=271891/gray-ent-pet
            [npcKeys.name] = "Gray Ent Pet",
        },
        [271892] = { -- Orange Ent Pet : https://wowhead.com/forever/npc=271892/orange-ent-pet
            [npcKeys.name] = "Orange Ent Pet",
        },
        [271893] = { -- Yellow Ent Pet : https://wowhead.com/forever/npc=271893/yellow-ent-pet
            [npcKeys.name] = "Yellow Ent Pet",
        },
        [271897] = { -- [DNT] Dummy Quest Kill Credit : https://wowhead.com/forever/npc=271897/dnt-dummy-quest-kill-credit
            [npcKeys.name] = "[DNT] Dummy Quest Kill Credit",
        },
        [271898] = { -- Greater Tarantula : https://wowhead.com/forever/npc=271898/greater-tarantula
            [npcKeys.name] = "Greater Tarantula",
            [npcKeys.minLevel] = 18,
            [npcKeys.maxLevel] = 19,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [271903] = { -- Stormscale Beastmistress : https://wowhead.com/forever/npc=271903/stormscale-beastmistress
            [npcKeys.name] = "Stormscale Beastmistress",
            [npcKeys.minLevel] = 19,
            [npcKeys.maxLevel] = 19,
            [npcKeys.spawns] = {[148] = {{49.2, 11.6}, {49.6, 11.4}, {49.6, 11.8}, {49.8, 13.4}, {50, 13.6}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [271904] = { -- Skeleton : https://wowhead.com/forever/npc=271904/skeleton
            [npcKeys.name] = "Skeleton",
        },
        [271912] = { -- [DNT] Kill Credit: Tarantula Egg : https://wowhead.com/forever/npc=271912/dnt-kill-credit-tarantula-egg
            [npcKeys.name] = "[DNT] Kill Credit: Tarantula Egg",
        },
        [271913] = { -- Plagued Cockroach : https://wowhead.com/forever/npc=271913/plagued-cockroach
            [npcKeys.name] = "Plagued Cockroach",
            [npcKeys.spawns] = {[1497] = {{67.2, 43.6}, {67.8, 45.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [271914] = { -- Undercity Cockroach : https://wowhead.com/forever/npc=271914/undercity-cockroach
            [npcKeys.name] = "Undercity Cockroach",
            [npcKeys.spawns] = {[1497] = {{67.2, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [271915] = { -- Jungle Boa : https://wowhead.com/forever/npc=271915/jungle-boa
            [npcKeys.name] = "Jungle Boa",
        },
        [271918] = { -- Valaquenia : https://wowhead.com/forever/npc=271918/valaquenia
            [npcKeys.name] = "Valaquenia",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [271919] = { -- Aeigelyges : https://wowhead.com/forever/npc=271919/aeigelyges
            [npcKeys.name] = "Aeigelyges",
            [npcKeys.minLevel] = 50,
            [npcKeys.maxLevel] = 50,
            [npcKeys.spawns] = {[1637] = {{38.2, 38.4}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [271929] = { -- Shen'dorei Windwell : https://wowhead.com/forever/npc=271929/shendorei-windwell
            [npcKeys.name] = "Shen'dorei Windwell",
        },
        [271961] = { -- Webbed Forsaken : https://wowhead.com/forever/npc=271961/webbed-forsaken
            [npcKeys.name] = "Webbed Forsaken",
            [npcKeys.minLevel] = 2,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[85] = {{23.2, 60.2}, {23.4, 58.2}, {23.4, 59}, {23.8, 60.6}, {24.4, 59.4}, {24.4, 59.6}, {24.6, 59.4}, {25.4, 59.8}, {25.8, 59.4}, {26.2, 60.2}, {26.6, 59.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [271968] = { -- Forsaken Adventurer : https://wowhead.com/forever/npc=271968/forsaken-adventurer
            [npcKeys.name] = "Forsaken Adventurer",
            [npcKeys.minLevel] = 2,
            [npcKeys.maxLevel] = 3,
            [npcKeys.spawns] = {[85] = {{23.2, 60}, {23.8, 58.8}, {24.4, 59.6}, {25, 59.2}, {25.2, 59.8}, {26.2, 60.2}, {26.4, 59.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [271972] = { -- Brown Prairie Dog : https://wowhead.com/forever/npc=271972/brown-prairie-dog
            [npcKeys.name] = "Brown Prairie Dog",
        },
        [271979] = { -- Brown Ground Squirrel : https://wowhead.com/forever/npc=271979/brown-ground-squirrel
            [npcKeys.name] = "Brown Ground Squirrel",
        },
        [271980] = { -- Red Ground Squirrel : https://wowhead.com/forever/npc=271980/red-ground-squirrel
            [npcKeys.name] = "Red Ground Squirrel",
        },
        [271988] = { -- Greater Tarantula : https://wowhead.com/forever/npc=271988/greater-tarantula
            [npcKeys.name] = "Greater Tarantula",
        },
        [271993] = { -- Brown Rabbit : https://wowhead.com/forever/npc=271993/brown-rabbit
            [npcKeys.name] = "Brown Rabbit",
        },
        [272012] = { -- Cat Familiar : https://wowhead.com/forever/npc=272012/cat-familiar
            [npcKeys.name] = "Cat Familiar",
        },
        [272020] = { -- Steam Tonk : https://wowhead.com/forever/npc=272020/steam-tonk
            [npcKeys.name] = "Steam Tonk",
        },
        [272034] = { -- Hatescreech : https://wowhead.com/forever/npc=272034/hatescreech
            [npcKeys.name] = "Hatescreech",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[141] = {{35, 39.2}, {35.4, 38.4}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [272044] = { -- Windmistress Gaedress : https://wowhead.com/forever/npc=272044/windmistress-gaedress
            [npcKeys.name] = "Windmistress Gaedress",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[141] = {{33.2, 36}, {33.6, 35.6}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [272045] = { -- Brother Zendraas : https://wowhead.com/forever/npc=272045/brother-zendraas
            [npcKeys.name] = "Brother Zendraas",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{57.8, 52}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [272046] = { -- Witchmother Arysa : https://wowhead.com/forever/npc=272046/witchmother-arysa
            [npcKeys.name] = "Witchmother Arysa",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[141] = {{33.2, 27.8}, {34.2, 27.2}, {34.2, 28}, {34.2, 28.6}, {34.2, 29.6}, {34.2, 30.8}, {34.6, 28.2}, {34.8, 27}, {35, 28.8}, {35, 29.6}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [272049] = { -- Saeyleenan : https://wowhead.com/forever/npc=272049/saeyleenan
            [npcKeys.name] = "Saeyleenan",
            [npcKeys.spawns] = {[16593] = {{48.4, 32}, {48.8, 32.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [272051] = { -- Aana : https://wowhead.com/forever/npc=272051/aana
            [npcKeys.name] = "Aana",
        },
        [272054] = { -- Avatar of Saeyleenan : https://wowhead.com/forever/npc=272054/avatar-of-saeyleenan
            [npcKeys.name] = "Avatar of Saeyleenan",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[493] = {{44, 73.4}, {44, 73.6}}},
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
            [npcKeys.questStarts] = {98404, 98738},
            [npcKeys.questEnds] = {98341, 98404},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [272096] = { -- Befouled Webwood : https://wowhead.com/forever/npc=272096/befouled-webwood
            [npcKeys.name] = "Befouled Webwood",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[141] = {{47.8, 49}, {48, 50.2}, {48.2, 51}, {48.6, 49.6}, {48.8, 37.4}, {48.8, 38.4}, {48.8, 48.8}, {49, 48.2}, {49, 50.6}, {49.2, 47.4}, {49.4, 39.4}, {49.4, 39.6}, {49.4, 45.2}, {49.4, 46}, {49.4, 52.2}, {49.6, 39.8}, {49.6, 44.4}, {49.6, 45.2}, {49.8, 40.8}, {49.8, 43.4}, {50, 41.8}, {50.6, 42}, {51, 43}, {51.4, 44.4}, {51.4, 44.8}, {51.4, 45.6}, {51.6, 44.4}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [272101] = { -- Deathguard Lizabetha : https://wowhead.com/forever/npc=272101/deathguard-lizabetha
            [npcKeys.name] = "Deathguard Lizabetha",
            [npcKeys.minLevel] = 22,
            [npcKeys.maxLevel] = 22,
            [npcKeys.spawns] = {[85] = {{52.4, 54.4}, {52.4, 54.6}, {52.6, 54.4}, {52.6, 54.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [272112] = { -- Kurothel : https://wowhead.com/forever/npc=272112/kurothel
            [npcKeys.name] = "Kurothel",
        },
        [272116] = { -- Xethorr the Wicked : https://wowhead.com/forever/npc=272116/xethorr-the-wicked
            [npcKeys.name] = "Xethorr the Wicked",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[141] = {{51.4, 44.2}, {51.4, 45.4}, {51.4, 45.6}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [272173] = { -- Venture Co. Clearclutter : https://wowhead.com/forever/npc=272173/venture-co-clearclutter
            [npcKeys.name] = "Venture Co. Clearclutter",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [272203] = { -- Perith Stormhoof : https://wowhead.com/forever/npc=272203/perith-stormhoof
            [npcKeys.name] = "Perith Stormhoof",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {98430},
            [npcKeys.friendlyToFaction] = "H",
        },
        [272210] = { -- Orc Mage : https://wowhead.com/forever/npc=272210/orc-mage
            [npcKeys.name] = "Orc Mage",
        },
        [272213] = { -- Human Hunter : https://wowhead.com/forever/npc=272213/human-hunter
            [npcKeys.name] = "Human Hunter",
        },
        [272214] = { -- Tauren Druid : https://wowhead.com/forever/npc=272214/tauren-druid
            [npcKeys.name] = "Tauren Druid",
        },
        [272215] = { -- Night Elf Warrior : https://wowhead.com/forever/npc=272215/night-elf-warrior
            [npcKeys.name] = "Night Elf Warrior",
        },
        [272219] = { -- Troll Warlock : https://wowhead.com/forever/npc=272219/troll-warlock
            [npcKeys.name] = "Troll Warlock",
        },
        [272226] = { -- Gnome Priest : https://wowhead.com/forever/npc=272226/gnome-priest
            [npcKeys.name] = "Gnome Priest",
        },
        [272227] = { -- Skyborne Shaman : https://wowhead.com/forever/npc=272227/skyborne-shaman
            [npcKeys.name] = "Skyborne Shaman",
        },
        [272228] = { -- Harvest Sentry : https://wowhead.com/forever/npc=272228/harvest-sentry
            [npcKeys.name] = "Harvest Sentry",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 37,
            [npcKeys.spawns] = {[16591] = {{56.2, 72.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [272229] = { -- Skyborne Mage Alliance : https://wowhead.com/forever/npc=272229/skyborne-mage-alliance
            [npcKeys.name] = "Skyborne Mage Alliance",
        },
        [272231] = { -- Undead Paladin : https://wowhead.com/forever/npc=272231/undead-paladin
            [npcKeys.name] = "Undead Paladin",
        },
        [272235] = { -- Dwarf Shaman : https://wowhead.com/forever/npc=272235/dwarf-shaman
            [npcKeys.name] = "Dwarf Shaman",
        },
        [272238] = { -- Orc Warrior : https://wowhead.com/forever/npc=272238/orc-warrior
            [npcKeys.name] = "Orc Warrior",
        },
        [272239] = { -- Human Warlock : https://wowhead.com/forever/npc=272239/human-warlock
            [npcKeys.name] = "Human Warlock",
        },
        [272241] = { -- Tauren Hunter : https://wowhead.com/forever/npc=272241/tauren-hunter
            [npcKeys.name] = "Tauren Hunter",
        },
        [272242] = { -- Night Elf Druid : https://wowhead.com/forever/npc=272242/night-elf-druid
            [npcKeys.name] = "Night Elf Druid",
        },
        [272243] = { -- Gnome Rogue : https://wowhead.com/forever/npc=272243/gnome-rogue
            [npcKeys.name] = "Gnome Rogue",
        },
        [272245] = { -- Troll Rogue : https://wowhead.com/forever/npc=272245/troll-rogue
            [npcKeys.name] = "Troll Rogue",
        },
        [272249] = { -- Skyborne Warrior Alliance : https://wowhead.com/forever/npc=272249/skyborne-warrior-alliance
            [npcKeys.name] = "Skyborne Warrior Alliance",
        },
        [272250] = { -- Skyborne Druid : https://wowhead.com/forever/npc=272250/skyborne-druid
            [npcKeys.name] = "Skyborne Druid",
        },
        [272251] = { -- Dwarf Paladin : https://wowhead.com/forever/npc=272251/dwarf-paladin
            [npcKeys.name] = "Dwarf Paladin",
        },
        [272252] = { -- Undead Warlock : https://wowhead.com/forever/npc=272252/undead-warlock
            [npcKeys.name] = "Undead Warlock",
        },
        [272260] = { -- Lost Stalker : https://wowhead.com/forever/npc=272260/lost-stalker
            [npcKeys.name] = "Lost Stalker",
            [npcKeys.minLevel] = 24,
            [npcKeys.maxLevel] = 24,
            [npcKeys.spawns] = {[10] = {{33.2, 43.2}, {41, 21.4}, {51, 63.2}, {56.4, 60.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [272273] = { -- Lost Watcher : https://wowhead.com/forever/npc=272273/lost-watcher
            [npcKeys.name] = "Lost Watcher",
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [272279] = { -- Swiftwind : https://wowhead.com/forever/npc=272279/swiftwind
            [npcKeys.name] = "Swiftwind",
        },
        [272280] = { -- Keenclaw : https://wowhead.com/forever/npc=272280/keenclaw
            [npcKeys.name] = "Keenclaw",
        },
        [272282] = { -- Sharpbeak : https://wowhead.com/forever/npc=272282/sharpbeak
            [npcKeys.name] = "Sharpbeak",
        },
        [272284] = { -- Lost Defender : https://wowhead.com/forever/npc=272284/lost-defender
            [npcKeys.name] = "Lost Defender",
        },
        [272291] = { -- Lost Knight : https://wowhead.com/forever/npc=272291/lost-knight
            [npcKeys.name] = "Lost Knight",
            [npcKeys.spawns] = {[10] = {{24.2, 41}, {24.6, 32.2}, {80.6, 57.8}, {81, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [272309] = { -- Tux : https://wowhead.com/forever/npc=272309/tux
            [npcKeys.name] = "Tux",
        },
        [272310] = { -- Mocha : https://wowhead.com/forever/npc=272310/mocha
            [npcKeys.name] = "Mocha",
        },
        [272313] = { -- Brineshell Clacker : https://wowhead.com/forever/npc=272313/brineshell-clacker
            [npcKeys.name] = "Brineshell Clacker",
            [npcKeys.minLevel] = 39,
            [npcKeys.maxLevel] = 40,
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [272315] = { -- Brineshell Snapper : https://wowhead.com/forever/npc=272315/brineshell-snapper
            [npcKeys.name] = "Brineshell Snapper",
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [272328] = { -- Mini Diablo : https://wowhead.com/forever/npc=272328/mini-diablo
            [npcKeys.name] = "Mini Diablo",
        },
        [272329] = { -- Zergling : https://wowhead.com/forever/npc=272329/zergling
            [npcKeys.name] = "Zergling",
        },
        [272330] = { -- Panda Cub : https://wowhead.com/forever/npc=272330/panda-cub
            [npcKeys.name] = "Panda Cub",
        },
        [272342] = { -- Gargantuan Plaguebat : https://wowhead.com/forever/npc=272342/gargantuan-plaguebat
            [npcKeys.name] = "Gargantuan Plaguebat",
        },
        [272346] = { -- [DNT] Loot Scarab : https://wowhead.com/forever/npc=272346/dnt-loot-scarab
            [npcKeys.name] = "[DNT] Loot Scarab",
        },
        [272374] = { -- Enormous Crustacean : https://wowhead.com/forever/npc=272374/enormous-crustacean
            [npcKeys.name] = "Enormous Crustacean",
        },
        [272377] = { -- Methuselah Crab : https://wowhead.com/forever/npc=272377/methuselah-crab
            [npcKeys.name] = "Methuselah Crab",
        },
        [272384] = { -- Elder Daggermaw : https://wowhead.com/forever/npc=272384/elder-daggermaw
            [npcKeys.name] = "Elder Daggermaw",
        },
        [272386] = { -- Snickerfang Matriarch : https://wowhead.com/forever/npc=272386/snickerfang-matriarch
            [npcKeys.name] = "Snickerfang Matriarch",
        },
        [272387] = { -- Darkshore Owl : https://wowhead.com/forever/npc=272387/darkshore-owl
            [npcKeys.name] = "Darkshore Owl",
        },
        [272388] = { -- Duskwood Owl : https://wowhead.com/forever/npc=272388/duskwood-owl
            [npcKeys.name] = "Duskwood Owl",
        },
        [272389] = { -- Marsh Owl : https://wowhead.com/forever/npc=272389/marsh-owl
            [npcKeys.name] = "Marsh Owl",
        },
        [272390] = { -- Greenhouse : https://wowhead.com/forever/npc=272390/greenhouse
            [npcKeys.name] = "Greenhouse",
        },
        [272391] = { -- Moonstrider : https://wowhead.com/forever/npc=272391/moonstrider
            [npcKeys.name] = "Moonstrider",
        },
        [272392] = { -- Giant Moonstrider : https://wowhead.com/forever/npc=272392/giant-moonstrider
            [npcKeys.name] = "Giant Moonstrider",
        },
        [272396] = { -- Durotar Windviper : https://wowhead.com/forever/npc=272396/durotar-windviper
            [npcKeys.name] = "Durotar Windviper",
        },
        [272401] = { -- Vale Screamer : https://wowhead.com/forever/npc=272401/vale-screamer
            [npcKeys.name] = "Vale Screamer",
        },
        [272415] = { -- Ashen Sentinel : https://wowhead.com/forever/npc=272415/ashen-sentinel
            [npcKeys.name] = "Ashen Sentinel",
        },
        [272420] = { -- Gal'nok : https://wowhead.com/forever/npc=272420/galnok
            [npcKeys.name] = "Gal'nok",
            [npcKeys.spawns] = {[16591] = {{61.2, 17.4}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [272435] = { -- Goren Grayfellow : https://wowhead.com/forever/npc=272435/goren-grayfellow
            [npcKeys.name] = "Goren Grayfellow",
            [npcKeys.spawns] = {[16591] = {{37.8, 76}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [272437] = { -- Marla Bell : https://wowhead.com/forever/npc=272437/marla-bell
            [npcKeys.name] = "Marla Bell",
            [npcKeys.minLevel] = 38,
            [npcKeys.maxLevel] = 38,
            [npcKeys.spawns] = {[16591] = {{62.2, 86}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [272450] = { -- Ol' Sandy : https://wowhead.com/forever/npc=272450/ol-sandy
            [npcKeys.name] = "Ol' Sandy",
            [npcKeys.minLevel] = 22,
            [npcKeys.maxLevel] = 22,
            [npcKeys.spawns] = {[10] = {{17.2, 53.8}, {17.8, 53.4}, {17.8, 53.6}}},
            [npcKeys.zoneID] = zoneIDs.DUSKWOOD,
        },
        [272470] = { -- [DNT] Loot Scarab : https://wowhead.com/forever/npc=272470/dnt-loot-scarab
            [npcKeys.name] = "[DNT] Loot Scarab",
        },
        [272497] = { -- Wounded Farholde Scout : https://wowhead.com/forever/npc=272497/wounded-farholde-scout
            [npcKeys.name] = "Wounded Farholde Scout",
        },
        [272513] = { -- [DNT] Kill Credit: Hissing Serum : https://wowhead.com/forever/npc=272513/dnt-kill-credit-hissing-serum
            [npcKeys.name] = "[DNT] Kill Credit: Hissing Serum",
        },
        [272517] = { -- Lost Valor : https://wowhead.com/forever/npc=272517/lost-valor
            [npcKeys.name] = "Lost Valor",
        },
        [272519] = { -- Highland Snapper : https://wowhead.com/forever/npc=272519/highland-snapper
            [npcKeys.name] = "Highland Snapper",
        },
        [272520] = { -- Highland Tortoise : https://wowhead.com/forever/npc=272520/highland-tortoise
            [npcKeys.name] = "Highland Tortoise",
        },
        [272521] = { -- Thicket Stalker : https://wowhead.com/forever/npc=272521/thicket-stalker
            [npcKeys.name] = "Thicket Stalker",
        },
        [272522] = { -- Highland Wanderer : https://wowhead.com/forever/npc=272522/highland-wanderer
            [npcKeys.name] = "Highland Wanderer",
        },
        [272523] = { -- Highland Ripper : https://wowhead.com/forever/npc=272523/highland-ripper
            [npcKeys.name] = "Highland Ripper",
        },
        [272524] = { -- Rampant Terror : https://wowhead.com/forever/npc=272524/rampant-terror
            [npcKeys.name] = "Rampant Terror",
        },
        [272525] = { -- Xander Salsbury : https://wowhead.com/forever/npc=272525/xander-salsbury
            [npcKeys.name] = "Xander Salsbury",
        },
        [272526] = { -- Glix Xizzix : https://wowhead.com/forever/npc=272526/glix-xizzix
            [npcKeys.name] = "Glix Xizzix",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1497] = {{69.8, 46}, {69.8, 47}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.questEnds] = {98545},
            [npcKeys.friendlyToFaction] = "H",
        },
        [272527] = { -- Ironforge Guard : https://wowhead.com/forever/npc=272527/ironforge-guard
            [npcKeys.name] = "Ironforge Guard",
        },
        [272537] = { -- Windshaper Assassin : https://wowhead.com/forever/npc=272537/windshaper-assassin
            [npcKeys.name] = "Windshaper Assassin",
        },
        [272538] = { -- Windshaper Adventurer : https://wowhead.com/forever/npc=272538/windshaper-adventurer
            [npcKeys.name] = "Windshaper Adventurer",
        },
        [272539] = { -- High Order Magister : https://wowhead.com/forever/npc=272539/high-order-magister
            [npcKeys.name] = "High Order Magister",
        },
        [272540] = { -- High Order Adventurer : https://wowhead.com/forever/npc=272540/high-order-adventurer
            [npcKeys.name] = "High Order Adventurer",
        },
        [272541] = { -- Valaaria Banewind : https://wowhead.com/forever/npc=272541/valaaria-banewind
            [npcKeys.name] = "Valaaria Banewind",
        },
        [272542] = { -- Falsaan Fallbreeze : https://wowhead.com/forever/npc=272542/falsaan-fallbreeze
            [npcKeys.name] = "Falsaan Fallbreeze",
        },
        [272603] = { -- [DNT] Kill Credit : https://wowhead.com/forever/npc=272603/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit",
        },
        [272608] = { -- Traveling Adventurer : https://wowhead.com/forever/npc=272608/traveling-adventurer
            [npcKeys.name] = "Traveling Adventurer",
        },
        [272609] = { -- Tavern Regular : https://wowhead.com/forever/npc=272609/tavern-regular
            [npcKeys.name] = "Tavern Regular",
        },
        [272610] = { -- Hungry Patron : https://wowhead.com/forever/npc=272610/hungry-patron
            [npcKeys.name] = "Hungry Patron",
        },
        [272612] = { -- Performer : https://wowhead.com/forever/npc=272612/performer
            [npcKeys.name] = "Performer",
        },
        [272614] = { -- Cappy : https://wowhead.com/forever/npc=272614/cappy
            [npcKeys.name] = "Cappy",
        },
        [272633] = { -- Nuara Tremorhoof : https://wowhead.com/forever/npc=272633/nuara-tremorhoof
            [npcKeys.name] = "Nuara Tremorhoof",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [272641] = { -- Samantha Wheeler : https://wowhead.com/forever/npc=272641/samantha-wheeler
            [npcKeys.name] = "Samantha Wheeler",
            [npcKeys.spawns] = {[16591] = {{55, 72.2}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [272646] = { -- Miranda Turner : https://wowhead.com/forever/npc=272646/miranda-turner
            [npcKeys.name] = "Miranda Turner",
            [npcKeys.minLevel] = 36,
            [npcKeys.maxLevel] = 36,
            [npcKeys.spawns] = {[16591] = {{63.4, 82.4}, {63.6, 82.6}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
            [npcKeys.friendlyToFaction] = "A",
        },
        [272690] = { -- Tavern Regular : https://wowhead.com/forever/npc=272690/tavern-regular
            [npcKeys.name] = "Tavern Regular",
        },
        [272691] = { -- Tavern Regular : https://wowhead.com/forever/npc=272691/tavern-regular
            [npcKeys.name] = "Tavern Regular",
        },
        [272692] = { -- Tavern Regular : https://wowhead.com/forever/npc=272692/tavern-regular
            [npcKeys.name] = "Tavern Regular",
        },
        [272693] = { -- Traveling Adventurer : https://wowhead.com/forever/npc=272693/traveling-adventurer
            [npcKeys.name] = "Traveling Adventurer",
        },
        [272737] = { -- [DNT] Kill Credit : https://wowhead.com/forever/npc=272737/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit",
        },
        [272914] = { -- Cat : https://wowhead.com/forever/npc=272914/cat
            [npcKeys.name] = "Cat",
            [npcKeys.zoneID] = zoneIDs.WETLANDS,
        },
        [272944] = { -- Dog : https://wowhead.com/forever/npc=272944/dog
            [npcKeys.name] = "Dog",
        },
        [272945] = { -- Traveling Adventurer : https://wowhead.com/forever/npc=272945/traveling-adventurer
            [npcKeys.name] = "Traveling Adventurer",
        },
        [272957] = { -- Adelbert Edmunds : https://wowhead.com/forever/npc=272957/adelbert-edmunds
            [npcKeys.name] = "Adelbert Edmunds",
            [npcKeys.spawns] = {[85] = {{83.2, 72.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [272958] = { -- Rickard Hardee : https://wowhead.com/forever/npc=272958/rickard-hardee
            [npcKeys.name] = "Rickard Hardee",
            [npcKeys.spawns] = {[85] = {{83.2, 72.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [272963] = { -- Charred Ghoul : https://wowhead.com/forever/npc=272963/charred-ghoul
            [npcKeys.name] = "Charred Ghoul",
        },
        [272996] = { -- Scarlet Invoker : https://wowhead.com/forever/npc=272996/scarlet-invoker
            [npcKeys.name] = "Scarlet Invoker",
        },
        [273002] = { -- Traveling Adventurer : https://wowhead.com/forever/npc=273002/traveling-adventurer
            [npcKeys.name] = "Traveling Adventurer",
        },
        [273003] = { -- Worg Pup : https://wowhead.com/forever/npc=273003/worg-pup
            [npcKeys.name] = "Worg Pup",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{38.6, 28.6}, {39, 28.2}, {39.2, 27.4}, {39.6, 28.2}, {39.6, 28.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [273004] = { -- Cat : https://wowhead.com/forever/npc=273004/cat
            [npcKeys.name] = "Cat",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[1637] = {{36.8, 28.4}, {37.4, 29.4}, {37.8, 28.6}, {38, 28.2}, {39.6, 28.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [273006] = { -- Ironforge Guard : https://wowhead.com/forever/npc=273006/ironforge-guard
            [npcKeys.name] = "Ironforge Guard",
        },
        [273017] = { -- Fendaal Windstone : https://wowhead.com/forever/npc=273017/fendaal-windstone
            [npcKeys.name] = "Fendaal Windstone",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{56.8, 61}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.questStarts] = {98512},
            [npcKeys.questEnds] = {98512},
            [npcKeys.friendlyToFaction] = "AH",
        },
        [273057] = { -- Fyrenz Vishonar : https://wowhead.com/forever/npc=273057/fyrenz-vishonar
            [npcKeys.name] = "Fyrenz Vishonar",
        },
        [273065] = { -- Ribbly Spinwhistle : https://wowhead.com/forever/npc=273065/ribbly-spinwhistle
            [npcKeys.name] = "Ribbly Spinwhistle",
            [npcKeys.minLevel] = 34,
            [npcKeys.maxLevel] = 34,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [273077] = { -- Judith Carol : https://wowhead.com/forever/npc=273077/judith-carol
            [npcKeys.name] = "Judith Carol",
            [npcKeys.minLevel] = 16,
            [npcKeys.maxLevel] = 16,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [273084] = { -- Chadsworth : https://wowhead.com/forever/npc=273084/chadsworth
            [npcKeys.name] = "Chadsworth",
            [npcKeys.spawns] = {[1497] = {{47, 27}, {48.2, 27.4}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [273097] = { -- KC Creature : https://wowhead.com/forever/npc=273097/kc-creature
            [npcKeys.name] = "KC Creature",
        },
        [273127] = { -- Finaida Earthbore : https://wowhead.com/forever/npc=273127/finaida-earthbore
            [npcKeys.name] = "Finaida Earthbore",
            [npcKeys.spawns] = {[1537] = {{57, 87}, {61.6, 83.4}, {67, 89.4}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [273140] = { -- Pikwin Dobblefritz : https://wowhead.com/forever/npc=273140/pikwin-dobblefritz
            [npcKeys.name] = "Pikwin Dobblefritz",
        },
        [273193] = { -- Rakkamar : https://wowhead.com/forever/npc=273193/rakkamar
            [npcKeys.name] = "Rakkamar",
        },
        [273214] = { -- Blizzard Customer Service : https://wowhead.com/forever/npc=273214/blizzard-customer-service
            [npcKeys.name] = "Blizzard Customer Service",
        },
        [273256] = { -- Arrgrah Stonewall : https://wowhead.com/forever/npc=273256/arrgrah-stonewall
            [npcKeys.name] = "Arrgrah Stonewall",
        },
        [273258] = { -- Faith Duggins : https://wowhead.com/forever/npc=273258/faith-duggins
            [npcKeys.name] = "Faith Duggins",
        },
        [273264] = { -- Talisara Valewind : https://wowhead.com/forever/npc=273264/talisara-valewind
            [npcKeys.name] = "Talisara Valewind",
        },
        [273286] = { -- Crimeon : https://wowhead.com/forever/npc=273286/crimeon
            [npcKeys.name] = "Crimeon",
        },
        [273287] = { -- Tyler Samuels : https://wowhead.com/forever/npc=273287/tyler-samuels
            [npcKeys.name] = "Tyler Samuels",
        },
        [273391] = { -- Baby Crocolisk : https://wowhead.com/forever/npc=273391/baby-crocolisk
            [npcKeys.name] = "Baby Crocolisk",
        },
        [273437] = { -- Turlethion Moonrage : https://wowhead.com/forever/npc=273437/turlethion-moonrage
            [npcKeys.name] = "Turlethion Moonrage",
        },
        [273458] = { -- Wisp : https://wowhead.com/forever/npc=273458/wisp
            [npcKeys.name] = "Wisp",
        },
        [273459] = { -- Haal : https://wowhead.com/forever/npc=273459/haal
            [npcKeys.name] = "Haal",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 2,
            [npcKeys.spawns] = {[16593] = {{41.6, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [273460] = { -- Meeri : https://wowhead.com/forever/npc=273460/meeri
            [npcKeys.name] = "Meeri",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[16593] = {{41.6, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [273530] = { -- Skeleton Warrior : https://wowhead.com/forever/npc=273530/skeleton-warrior
            [npcKeys.name] = "Skeleton Warrior",
        },
        [273531] = { -- Skeletal Mage : https://wowhead.com/forever/npc=273531/skeletal-mage
            [npcKeys.name] = "Skeletal Mage",
        },
        [273532] = { -- Skeletal Mage : https://wowhead.com/forever/npc=273532/skeletal-mage
            [npcKeys.name] = "Skeletal Mage",
        },
        [273533] = { -- Skeletal Mage : https://wowhead.com/forever/npc=273533/skeletal-mage
            [npcKeys.name] = "Skeletal Mage",
        },
        [273690] = { -- Armor Debuffed Dummy : https://wowhead.com/forever/npc=273690/armor-debuffed-dummy
            [npcKeys.name] = "Armor Debuffed Dummy",
        },
        [273691] = { -- [DNT] Kill Credit: : https://wowhead.com/forever/npc=273691/dnt-kill-credit
            [npcKeys.name] = "[DNT] Kill Credit: ",
        },
        [273822] = { -- Crazed Darkhound : https://wowhead.com/forever/npc=273822/crazed-darkhound
            [npcKeys.name] = "Crazed Darkhound",
        },
        [273916] = { -- Human Paladin : https://wowhead.com/forever/npc=273916/human-paladin
            [npcKeys.name] = "Human Paladin",
        },
        [273917] = { -- Night Elf Priest : https://wowhead.com/forever/npc=273917/night-elf-priest
            [npcKeys.name] = "Night Elf Priest",
        },
        [273918] = { -- Skyborne Hunter : https://wowhead.com/forever/npc=273918/skyborne-hunter
            [npcKeys.name] = "Skyborne Hunter",
        },
        [273919] = { -- Dwarf Hunter : https://wowhead.com/forever/npc=273919/dwarf-hunter
            [npcKeys.name] = "Dwarf Hunter",
        },
        [273920] = { -- Human Mage : https://wowhead.com/forever/npc=273920/human-mage
            [npcKeys.name] = "Human Mage",
        },
        [273921] = { -- Dwarf Warrior : https://wowhead.com/forever/npc=273921/dwarf-warrior
            [npcKeys.name] = "Dwarf Warrior",
        },
        [273925] = { -- Gnome Warrior : https://wowhead.com/forever/npc=273925/gnome-warrior
            [npcKeys.name] = "Gnome Warrior",
        },
        [273926] = { -- Gnome Warlock : https://wowhead.com/forever/npc=273926/gnome-warlock
            [npcKeys.name] = "Gnome Warlock",
        },
        [273927] = { -- Night Elf Rogue : https://wowhead.com/forever/npc=273927/night-elf-rogue
            [npcKeys.name] = "Night Elf Rogue",
        },
        [273928] = { -- Human Priest : https://wowhead.com/forever/npc=273928/human-priest
            [npcKeys.name] = "Human Priest",
        },
        [273946] = { -- Armor Debuffed Dummy : https://wowhead.com/forever/npc=273946/armor-debuffed-dummy
            [npcKeys.name] = "Armor Debuffed Dummy",
        },
        [273956] = { -- Condor Hatchling : https://wowhead.com/forever/npc=273956/condor-hatchling
            [npcKeys.name] = "Condor Hatchling",
        },
        [273967] = { -- High Order Messenger : https://wowhead.com/forever/npc=273967/high-order-messenger
            [npcKeys.name] = "High Order Messenger",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58.8, 79.4}, {59, 79.6}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [273968] = { -- High Order Messenger : https://wowhead.com/forever/npc=273968/high-order-messenger
            [npcKeys.name] = "High Order Messenger",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{66.4, 79.8}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [273972] = { -- Credit : https://wowhead.com/forever/npc=273972/credit
            [npcKeys.name] = "Credit",
        },
        [273982] = { -- [DNT] Invisible Stalker : https://wowhead.com/forever/npc=273982/dnt-invisible-stalker
            [npcKeys.name] = "[DNT] Invisible Stalker",
        },
        [274028] = { -- Spider Swarmling : https://wowhead.com/forever/npc=274028/spider-swarmling
            [npcKeys.name] = "Spider Swarmling",
        },
        [274081] = { -- Princess : https://wowhead.com/forever/npc=274081/princess
            [npcKeys.name] = "Princess",
        },
        [274144] = { -- Tavern Regular : https://wowhead.com/forever/npc=274144/tavern-regular
            [npcKeys.name] = "Tavern Regular",
        },
        [274257] = { -- Ice Elemental : https://wowhead.com/forever/npc=274257/ice-elemental
            [npcKeys.name] = "Ice Elemental",
            [npcKeys.spawns] = {[618] = {{48.6, 49.6}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [274258] = { -- Deepscar Brute : https://wowhead.com/forever/npc=274258/deepscar-brute
            [npcKeys.name] = "Deepscar Brute",
            [npcKeys.spawns] = {[618] = {{48, 50.6}}},
            [npcKeys.zoneID] = zoneIDs.WINTERSPRING,
        },
        [274259] = { -- Deepscar Yeti : https://wowhead.com/forever/npc=274259/deepscar-yeti
            [npcKeys.name] = "Deepscar Yeti",
        },
        [274262] = { -- Milo : https://wowhead.com/forever/npc=274262/milo
            [npcKeys.name] = "Milo",
            [npcKeys.spawns] = {[36] = {{15.4, 69.6}, {15.6, 69.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274298] = { -- Rhahk'Zor : https://wowhead.com/forever/npc=274298/rhahkzor
            [npcKeys.name] = "Rhahk'Zor",
        },
        [274300] = { -- Coldrasp : https://wowhead.com/forever/npc=274300/coldrasp
            [npcKeys.name] = "Coldrasp",
            [npcKeys.spawns] = {[85] = {{19.4, 64.4}, {19.8, 65}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [274334] = { -- Tallstrider Hatchling : https://wowhead.com/forever/npc=274334/tallstrider-hatchling
            [npcKeys.name] = "Tallstrider Hatchling",
        },
        [274340] = { -- Umber Galestrider : https://wowhead.com/forever/npc=274340/umber-galestrider
            [npcKeys.name] = "Umber Galestrider",
        },
        [274403] = { -- Furious Hyjal Sentinel : https://wowhead.com/forever/npc=274403/furious-hyjal-sentinel
            [npcKeys.name] = "Furious Hyjal Sentinel",
        },
        [274405] = { -- Hyjal Protector : https://wowhead.com/forever/npc=274405/hyjal-protector
            [npcKeys.name] = "Hyjal Protector",
        },
        [274411] = { -- Fungus : https://wowhead.com/forever/npc=274411/fungus
            [npcKeys.name] = "Fungus",
        },
        [274412] = { -- Minfernal : https://wowhead.com/forever/npc=274412/minfernal
            [npcKeys.name] = "Minfernal",
        },
        [274574] = { -- Dummy Healing : https://wowhead.com/forever/npc=274574/dummy-healing
            [npcKeys.name] = "Dummy Healing",
        },
        [274669] = { -- Countess Bunidict : https://wowhead.com/forever/npc=274669/countess-bunidict
            [npcKeys.name] = "Countess Bunidict",
            [npcKeys.spawns] = {[36] = {{21.8, 74.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274671] = { -- Count Ash Bunnington : https://wowhead.com/forever/npc=274671/count-ash-bunnington
            [npcKeys.name] = "Count Ash Bunnington",
            [npcKeys.spawns] = {[36] = {{21.2, 72.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274672] = { -- Duchess Elisabun : https://wowhead.com/forever/npc=274672/duchess-elisabun
            [npcKeys.name] = "Duchess Elisabun",
            [npcKeys.spawns] = {[36] = {{21.2, 73}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274673] = { -- Baron Von Bunwick : https://wowhead.com/forever/npc=274673/baron-von-bunwick
            [npcKeys.name] = "Baron Von Bunwick",
            [npcKeys.spawns] = {[36] = {{21, 73.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274675] = { -- Nyx : https://wowhead.com/forever/npc=274675/nyx
            [npcKeys.name] = "Nyx",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274676] = { -- Tailypo : https://wowhead.com/forever/npc=274676/tailypo
            [npcKeys.name] = "Tailypo",
            [npcKeys.spawns] = {[36] = {{10, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274677] = { -- Bub : https://wowhead.com/forever/npc=274677/bub
            [npcKeys.name] = "Bub",
            [npcKeys.spawns] = {[36] = {{18, 65.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274715] = { -- Marsh Skulker : https://wowhead.com/forever/npc=274715/marsh-skulker
            [npcKeys.name] = "Marsh Skulker",
        },
        [274734] = { -- Yiyo Nightwalker : https://wowhead.com/forever/npc=274734/yiyo-nightwalker
            [npcKeys.name] = "Yiyo Nightwalker",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1637] = {{46.4, 53}, {46.6, 52}, {46.8, 52.6}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274739] = { -- Aggrend Anvilsmash : https://wowhead.com/forever/npc=274739/aggrend-anvilsmash
            [npcKeys.name] = "Aggrend Anvilsmash",
        },
        [274740] = { -- Kitzy Werkblaster : https://wowhead.com/forever/npc=274740/kitzy-werkblaster
            [npcKeys.name] = "Kitzy Werkblaster",
            [npcKeys.minLevel] = 22,
            [npcKeys.maxLevel] = 22,
            [npcKeys.spawns] = {[17] = {{62, 39.4}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274757] = { -- Temple Highguard : https://wowhead.com/forever/npc=274757/temple-highguard
            [npcKeys.name] = "Temple Highguard",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1657] = {{35.2, 82.8}, {35.2, 88.4}, {35.4, 84.6}, {35.8, 88.4}, {35.8, 88.6}, {36.8, 80}, {37.4, 81}, {37.6, 79.8}, {38.4, 76}, {38.8, 76.4}, {38.8, 76.6}, {38.8, 81.4}, {39, 75.2}, {39.8, 80.4}, {40, 91.4}, {40.2, 89.8}, {40.4, 76}, {40.6, 90}, {40.6, 91}, {40.8, 79}, {40.8, 91.8}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [274770] = { -- Brave Stonetorch : https://wowhead.com/forever/npc=274770/brave-stonetorch
            [npcKeys.name] = "Brave Stonetorch",
        },
        [274776] = { -- Doctor Nimer : https://wowhead.com/forever/npc=274776/doctor-nimer
            [npcKeys.name] = "Doctor Nimer",
        },
        [274780] = { -- Damin Dawnshadow : https://wowhead.com/forever/npc=274780/damin-dawnshadow
            [npcKeys.name] = "Damin Dawnshadow",
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [274781] = { -- Iron Kingsguard : https://wowhead.com/forever/npc=274781/iron-kingsguard
            [npcKeys.name] = "Iron Kingsguard",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[1537] = {{39, 51.4}, {40.8, 50.4}, {41, 51.4}, {42.8, 54.8}, {43, 54.4}, {44, 49.6}, {44.2, 47}, {44.4, 48.6}, {44.4, 51.4}, {44.6, 48.4}, {44.8, 49.6}, {45.2, 49.4}, {45.6, 49.4}, {45.6, 52.2}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [274786] = { -- Pollero Rene : https://wowhead.com/forever/npc=274786/pollero-rene
            [npcKeys.name] = "Pollero Rene",
            [npcKeys.spawns] = {[36] = {{21.8, 62.6}, {22, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274789] = { -- Aradia : https://wowhead.com/forever/npc=274789/aradia
            [npcKeys.name] = "Aradia",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [274795] = { -- Viktor Walker : https://wowhead.com/forever/npc=274795/viktor-walker
            [npcKeys.name] = "Viktor Walker",
        },
        [274833] = { -- An'drak : https://wowhead.com/forever/npc=274833/andrak
            [npcKeys.name] = "An'drak",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1637] = {{41, 71.2}, {41, 72.6}, {41.2, 71.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274834] = { -- Evermore : https://wowhead.com/forever/npc=274834/evermore
            [npcKeys.name] = "Evermore",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1637] = {{40.6, 72.6}, {41.2, 71.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274838] = { -- Maximus Warwick : https://wowhead.com/forever/npc=274838/maximus-warwick
            [npcKeys.name] = "Maximus Warwick",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 15,
            [npcKeys.spawns] = {[12] = {{23.8, 74}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [274844] = { -- Culli Springwind : https://wowhead.com/forever/npc=274844/culli-springwind
            [npcKeys.name] = "Culli Springwind",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{66.8, 78.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [274845] = { -- Pallwick Boneset : https://wowhead.com/forever/npc=274845/pallwick-boneset
            [npcKeys.name] = "Pallwick Boneset",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.spawns] = {[17] = {{51.4, 30}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274852] = { -- Zeglo Kruptorr : https://wowhead.com/forever/npc=274852/zeglo-kruptorr
            [npcKeys.name] = "Zeglo Kruptorr",
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [274853] = { -- Barrelmaker Ishtar : https://wowhead.com/forever/npc=274853/barrelmaker-ishtar
            [npcKeys.name] = "Barrelmaker Ishtar",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.spawns] = {[1497] = {{77.2, 43.6}, {77.4, 43.2}, {77.8, 43.8}, {77.8, 44.8}, {78.6, 44}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274854] = { -- Bub : https://wowhead.com/forever/npc=274854/bub
            [npcKeys.name] = "Bub",
            [npcKeys.spawns] = {[1497] = {{76.8, 43.4}, {77, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [274855] = { -- Nyx : https://wowhead.com/forever/npc=274855/nyx
            [npcKeys.name] = "Nyx",
            [npcKeys.spawns] = {[1497] = {{76.8, 43.4}, {76.8, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [274856] = { -- Poe : https://wowhead.com/forever/npc=274856/poe
            [npcKeys.name] = "Poe",
            [npcKeys.spawns] = {[1497] = {{76.8, 43.4}, {76.8, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.UNDERCITY,
        },
        [274861] = { -- Relogrim Goreaxe : https://wowhead.com/forever/npc=274861/relogrim-goreaxe
            [npcKeys.name] = "Relogrim Goreaxe",
            [npcKeys.spawns] = {[1637] = {{68.6, 15.8}}},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [274864] = { -- Kihea Ragetotem : https://wowhead.com/forever/npc=274864/kihea-ragetotem
            [npcKeys.name] = "Kihea Ragetotem",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1638] = {{56, 80.4}, {56.4, 78.6}, {56.4, 80.8}, {56.8, 79.4}, {56.8, 79.8}, {57.6, 79.8}}},
            [npcKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274868] = { -- Gabbel Shattergale : https://wowhead.com/forever/npc=274868/gabbel-shattergale
            [npcKeys.name] = "Gabbel Shattergale",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{52.2, 74.6}, {52.4, 74.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [274872] = { -- Rosie : https://wowhead.com/forever/npc=274872/rosie
            [npcKeys.name] = "Rosie",
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [274873] = { -- Battlesmith Vaelgrim : https://wowhead.com/forever/npc=274873/battlesmith-vaelgrim
            [npcKeys.name] = "Battlesmith Vaelgrim",
            [npcKeys.minLevel] = 53,
            [npcKeys.maxLevel] = 53,
            [npcKeys.spawns] = {[1537] = {{49.8, 44.4}, {50, 44.8}, {51, 44.2}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
            [npcKeys.friendlyToFaction] = "A",
        },
        [274876] = { -- Erenayeth Mossbrook : https://wowhead.com/forever/npc=274876/erenayeth-mossbrook
            [npcKeys.name] = "Erenayeth Mossbrook",
        },
        [274883] = { -- Deluxe Banker : https://wowhead.com/forever/npc=274883/deluxe-banker
            [npcKeys.name] = "Deluxe Banker",
        },
        [274902] = { -- Stormwind City Defender : https://wowhead.com/forever/npc=274902/stormwind-city-defender
            [npcKeys.name] = "Stormwind City Defender",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
        },
        [274903] = { -- Stormwind Harbor Defender : https://wowhead.com/forever/npc=274903/stormwind-harbor-defender
            [npcKeys.name] = "Stormwind Harbor Defender",
        },
        [274904] = { -- Larkin Smokethorn : https://wowhead.com/forever/npc=274904/larkin-smokethorn
            [npcKeys.name] = "Larkin Smokethorn",
            [npcKeys.spawns] = {[1657] = {{36.2, 24}, {36.6, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [274905] = { -- Seajay the Oar-Fetcher : https://wowhead.com/forever/npc=274905/seajay-the-oar-fetcher
            [npcKeys.name] = "Seajay the Oar-Fetcher",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [274906] = { -- Elyquen Starwatch : https://wowhead.com/forever/npc=274906/elyquen-starwatch
            [npcKeys.name] = "Elyquen Starwatch",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [274907] = { -- Belarysa Moonveil : https://wowhead.com/forever/npc=274907/belarysa-moonveil
            [npcKeys.name] = "Belarysa Moonveil",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{59.6, 73}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [274909] = { -- Eviatar Achitov : https://wowhead.com/forever/npc=274909/eviatar-achitov
            [npcKeys.name] = "Eviatar Achitov",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.spawns] = {[12] = {{49.2, 42}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
            [npcKeys.friendlyToFaction] = "A",
        },
        [274911] = { -- Eshka P'ari : https://wowhead.com/forever/npc=274911/eshka-pari
            [npcKeys.name] = "Eshka P'ari",
            [npcKeys.spawns] = {[33] = {{30.6, 28.2}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [274912] = { -- Relreo Emberlight : https://wowhead.com/forever/npc=274912/relreo-emberlight
            [npcKeys.name] = "Relreo Emberlight",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{21.4, 53.4}, {21.4, 54.2}, {21.6, 47.8}, {21.6, 52.2}, {21.6, 53.2}, {21.6, 54.4}, {21.8, 50.2}, {21.8, 51.2}, {22, 49.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274913] = { -- Max : https://wowhead.com/forever/npc=274913/max
            [npcKeys.name] = "Max",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.spawns] = {[85] = {{20.8, 47.2}, {21.2, 47.8}, {21.2, 54.2}, {21.4, 53.2}, {21.8, 49.4}, {21.8, 51.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274914] = { -- Aendaril Brookshot : https://wowhead.com/forever/npc=274914/aendaril-brookshot
            [npcKeys.name] = "Aendaril Brookshot",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [274916] = { -- Vigilant Deathguard : https://wowhead.com/forever/npc=274916/vigilant-deathguard
            [npcKeys.name] = "Vigilant Deathguard",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{60.8, 59.4}, {61, 58.2}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [274917] = { -- Boborus Overvolt : https://wowhead.com/forever/npc=274917/boborus-overvolt
            [npcKeys.name] = "Boborus Overvolt",
            [npcKeys.spawns] = {[1537] = {{69.6, 54}, {70.2, 53.4}}},
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [274921] = { -- Caretaker Kalvan : https://wowhead.com/forever/npc=274921/caretaker-kalvan
            [npcKeys.name] = "Caretaker Kalvan",
        },
        [274926] = { -- Buddy : https://wowhead.com/forever/npc=274926/buddy
            [npcKeys.name] = "Buddy",
        },
        [274927] = { -- Faluris : https://wowhead.com/forever/npc=274927/faluris
            [npcKeys.name] = "Faluris",
            [npcKeys.spawns] = {[1657] = {{55.8, 44.8}, {56.6, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [274930] = { -- Lyvia Stormsinger : https://wowhead.com/forever/npc=274930/lyvia-stormsinger
            [npcKeys.name] = "Lyvia Stormsinger",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{59.4, 81}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [274931] = { -- Elril Everlight : https://wowhead.com/forever/npc=274931/elril-everlight
            [npcKeys.name] = "Elril Everlight",
            [npcKeys.spawns] = {[33] = {{27, 77.6}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [274934] = { -- Amandriel : https://wowhead.com/forever/npc=274934/amandriel
            [npcKeys.name] = "Amandriel",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[16593] = {{59.4, 78}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [274935] = { -- Ironforge Protector : https://wowhead.com/forever/npc=274935/ironforge-protector
            [npcKeys.name] = "Ironforge Protector",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[1] = {{52.6, 36.8}}, [1537] = {{43.8, 47.2}, {46.4, 54}, {62.8, 67}, {74.6, 12}, {75.8, 10.4}}},
        },
        [274938] = { -- Waylaid Supply Guy : https://wowhead.com/forever/npc=274938/waylaid-supply-guy
            [npcKeys.name] = "Waylaid Supply Guy",
        },
        [274940] = { -- Annabella Junelight : https://wowhead.com/forever/npc=274940/annabella-junelight
            [npcKeys.name] = "Annabella Junelight",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [274941] = { -- Rayla : https://wowhead.com/forever/npc=274941/rayla
            [npcKeys.name] = "Rayla",
            [npcKeys.spawns] = {[17] = {{61.8, 39.2}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [274942] = { -- Bob McNaught : https://wowhead.com/forever/npc=274942/bob-mcnaught
            [npcKeys.name] = "Bob McNaught",
            [npcKeys.spawns] = {[267] = {{50.8, 57.4}, {50.8, 57.6}}},
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [274944] = { -- Zeth Darkleaf : https://wowhead.com/forever/npc=274944/zeth-darkleaf
            [npcKeys.name] = "Zeth Darkleaf",
            [npcKeys.spawns] = {[33] = {{28.4, 76.8}}},
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [274947] = { -- Minimule : https://wowhead.com/forever/npc=274947/minimule
            [npcKeys.name] = "Minimule",
        },
        [274960] = { -- Cordy : https://wowhead.com/forever/npc=274960/cordy
            [npcKeys.name] = "Cordy",
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [274961] = { -- Sammi : https://wowhead.com/forever/npc=274961/sammi
            [npcKeys.name] = "Sammi",
        },
        [274962] = { -- Xaya : https://wowhead.com/forever/npc=274962/xaya
            [npcKeys.name] = "Xaya",
            [npcKeys.zoneID] = zoneIDs.MOONGLADE,
        },
        [274963] = { -- Roach : https://wowhead.com/forever/npc=274963/roach
            [npcKeys.name] = "Roach",
        },
        [274965] = { -- Elderwild Alliance Defender : https://wowhead.com/forever/npc=274965/elderwild-alliance-defender
            [npcKeys.name] = "Elderwild Alliance Defender",
            [npcKeys.spawns] = {[616] = {{15.2, 55.8}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [274966] = { -- Elderwild Horde Grunt : https://wowhead.com/forever/npc=274966/elderwild-horde-grunt
            [npcKeys.name] = "Elderwild Horde Grunt",
        },
        [274974] = { -- Enraged Orgrimmar Grunt : https://wowhead.com/forever/npc=274974/enraged-orgrimmar-grunt
            [npcKeys.name] = "Enraged Orgrimmar Grunt",
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
        },
        [274978] = { -- Vengeful Guard : https://wowhead.com/forever/npc=274978/vengeful-guard
            [npcKeys.name] = "Vengeful Guard",
            [npcKeys.spawns] = {[17] = {{52, 28.6}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [274983] = { -- Mist Howler's Packmate : https://wowhead.com/forever/npc=274983/mist-howlers-packmate
            [npcKeys.name] = "Mist Howler's Packmate",
        },
        [274985] = { -- Trula Verpon : https://wowhead.com/forever/npc=274985/trula-verpon
            [npcKeys.name] = "Trula Verpon",
        },
        [274990] = { -- Ysa'bel Brightwind : https://wowhead.com/forever/npc=274990/ysabel-brightwind
            [npcKeys.name] = "Ysa'bel Brightwind",
            [npcKeys.spawns] = {[36] = {{10.8, 62.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274991] = { -- La'tanja Brightgale : https://wowhead.com/forever/npc=274991/latanja-brightgale
            [npcKeys.name] = "La'tanja Brightgale",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274992] = { -- Kae'la Brightsong : https://wowhead.com/forever/npc=274992/kaela-brightsong
            [npcKeys.name] = "Kae'la Brightsong",
            [npcKeys.spawns] = {[36] = {{10.4, 62.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [274999] = { -- Argent Champion : https://wowhead.com/forever/npc=274999/argent-champion
            [npcKeys.name] = "Argent Champion",
        },
        [275013] = { -- Archivist Helm Anvilhand : https://wowhead.com/forever/npc=275013/archivist-helm-anvilhand
            [npcKeys.name] = "Archivist Helm Anvilhand",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{23, 71}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275017] = { -- Magus Fansy Goodbringer : https://wowhead.com/forever/npc=275017/magus-fansy-goodbringer
            [npcKeys.name] = "Magus Fansy Goodbringer",
            [npcKeys.spawns] = {[36] = {{16, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275018] = { -- Bitty Frostflinger : https://wowhead.com/forever/npc=275018/bitty-frostflinger
            [npcKeys.name] = "Bitty Frostflinger",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{16.6, 67.2}, {16.8, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275022] = { -- Furious Astraanar Sentinel : https://wowhead.com/forever/npc=275022/furious-astraanar-sentinel
            [npcKeys.name] = "Furious Astraanar Sentinel",
        },
        [275023] = { -- Furious Auberdine Sentinel : https://wowhead.com/forever/npc=275023/furious-auberdine-sentinel
            [npcKeys.name] = "Furious Auberdine Sentinel",
            [npcKeys.spawns] = {[148] = {{36.8, 44.6}}},
            [npcKeys.zoneID] = zoneIDs.DARKSHORE,
        },
        [275027] = { -- Furious Darnassus Sentinel : https://wowhead.com/forever/npc=275027/furious-darnassus-sentinel
            [npcKeys.name] = "Furious Darnassus Sentinel",
        },
        [275030] = { -- Archivist Delv Fortuz : https://wowhead.com/forever/npc=275030/archivist-delv-fortuz
            [npcKeys.name] = "Archivist Delv Fortuz",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{23.4, 68.2}, {23.6, 68.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275031] = { -- Dalaran Adept : https://wowhead.com/forever/npc=275031/dalaran-adept
            [npcKeys.name] = "Dalaran Adept",
            [npcKeys.spawns] = {[36] = {{22.8, 67.8}, {23.6, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275033] = { -- Bluffbruiser : https://wowhead.com/forever/npc=275033/bluffbruiser
            [npcKeys.name] = "Bluffbruiser",
        },
        [275035] = { -- Booty Bay Enforcer : https://wowhead.com/forever/npc=275035/booty-bay-enforcer
            [npcKeys.name] = "Booty Bay Enforcer",
            [npcKeys.zoneID] = zoneIDs.STRANGLETHORN_VALE,
        },
        [275038] = { -- Brackenwall Smasher : https://wowhead.com/forever/npc=275038/brackenwall-smasher
            [npcKeys.name] = "Brackenwall Smasher",
        },
        [275042] = { -- Furious Brave : https://wowhead.com/forever/npc=275042/furious-brave
            [npcKeys.name] = "Furious Brave",
        },
        [275044] = { -- Dragonmaw Warder : https://wowhead.com/forever/npc=275044/dragonmaw-warder
            [npcKeys.name] = "Dragonmaw Warder",
        },
        [275045] = { -- Dragonmaw Saboteur : https://wowhead.com/forever/npc=275045/dragonmaw-saboteur
            [npcKeys.name] = "Dragonmaw Saboteur",
        },
        [275046] = { -- Dragonmaw Thaumaturgist : https://wowhead.com/forever/npc=275046/dragonmaw-thaumaturgist
            [npcKeys.name] = "Dragonmaw Thaumaturgist",
        },
        [275047] = { -- Furious Dolanaar Sentinel : https://wowhead.com/forever/npc=275047/furious-dolanaar-sentinel
            [npcKeys.name] = "Furious Dolanaar Sentinel",
        },
        [275048] = { -- Furious Feathermoon Sentinel : https://wowhead.com/forever/npc=275048/furious-feathermoon-sentinel
            [npcKeys.name] = "Furious Feathermoon Sentinel",
        },
        [275049] = { -- Captive Fire Elemental : https://wowhead.com/forever/npc=275049/captive-fire-elemental
            [npcKeys.name] = "Captive Fire Elemental",
        },
        [275052] = { -- Furious Moonglade Warden : https://wowhead.com/forever/npc=275052/furious-moonglade-warden
            [npcKeys.name] = "Furious Moonglade Warden",
        },
        [275055] = { -- Everlook Enforcer : https://wowhead.com/forever/npc=275055/everlook-enforcer
            [npcKeys.name] = "Everlook Enforcer",
        },
        [275062] = { -- Freewind Enforcer : https://wowhead.com/forever/npc=275062/freewind-enforcer
            [npcKeys.name] = "Freewind Enforcer",
        },
        [275067] = { -- Gadgetzan Enforcer : https://wowhead.com/forever/npc=275067/gadgetzan-enforcer
            [npcKeys.name] = "Gadgetzan Enforcer",
        },
        [275073] = { -- Grom'gol Ravager : https://wowhead.com/forever/npc=275073/gromgol-ravager
            [npcKeys.name] = "Grom'gol Ravager",
        },
        [275074] = { -- Enraged Kargath Grunt : https://wowhead.com/forever/npc=275074/enraged-kargath-grunt
            [npcKeys.name] = "Enraged Kargath Grunt",
        },
        [275075] = { -- Lakeshire Protector : https://wowhead.com/forever/npc=275075/lakeshire-protector
            [npcKeys.name] = "Lakeshire Protector",
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [275076] = { -- Powderfuse Enforcer : https://wowhead.com/forever/npc=275076/powderfuse-enforcer
            [npcKeys.name] = "Powderfuse Enforcer",
        },
        [275077] = { -- Ratchet Enforcer : https://wowhead.com/forever/npc=275077/ratchet-enforcer
            [npcKeys.name] = "Ratchet Enforcer",
        },
        [275078] = { -- Rallied Defender : https://wowhead.com/forever/npc=275078/rallied-defender
            [npcKeys.name] = "Rallied Defender",
        },
        [275079] = { -- Revantusk Hunter : https://wowhead.com/forever/npc=275079/revantusk-hunter
            [npcKeys.name] = "Revantusk Hunter",
        },
        [275080] = { -- Enraged Rog'mar Grunt : https://wowhead.com/forever/npc=275080/enraged-rogmar-grunt
            [npcKeys.name] = "Enraged Rog'mar Grunt",
        },
        [275086] = { -- Southshore Defender : https://wowhead.com/forever/npc=275086/southshore-defender
            [npcKeys.name] = "Southshore Defender",
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [275087] = { -- Steamwheedle Enforcer : https://wowhead.com/forever/npc=275087/steamwheedle-enforcer
            [npcKeys.name] = "Steamwheedle Enforcer",
        },
        [275088] = { -- Enraged Stonard Grunt : https://wowhead.com/forever/npc=275088/enraged-stonard-grunt
            [npcKeys.name] = "Enraged Stonard Grunt",
        },
        [275089] = { -- Tarren Mill Elite : https://wowhead.com/forever/npc=275089/tarren-mill-elite
            [npcKeys.name] = "Tarren Mill Elite",
        },
        [275090] = { -- Theramore Defender : https://wowhead.com/forever/npc=275090/theramore-defender
            [npcKeys.name] = "Theramore Defender",
        },
        [275095] = { -- Tavern Regular : https://wowhead.com/forever/npc=275095/tavern-regular
            [npcKeys.name] = "Tavern Regular",
        },
        [275097] = { -- Vigilant Deathguard : https://wowhead.com/forever/npc=275097/vigilant-deathguard
            [npcKeys.name] = "Vigilant Deathguard",
        },
        [275098] = { -- Deathguard Elite : https://wowhead.com/forever/npc=275098/deathguard-elite
            [npcKeys.name] = "Deathguard Elite",
        },
        [275100] = { -- Wildhammer Avenger : https://wowhead.com/forever/npc=275100/wildhammer-avenger
            [npcKeys.name] = "Wildhammer Avenger",
        },
        [275101] = { -- Den Grunt : https://wowhead.com/forever/npc=275101/den-grunt
            [npcKeys.name] = "Den Grunt",
        },
        [275102] = { -- Mesa Brave : https://wowhead.com/forever/npc=275102/mesa-brave
            [npcKeys.name] = "Mesa Brave",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [275103] = { -- Deathguard Veteran : https://wowhead.com/forever/npc=275103/deathguard-veteran
            [npcKeys.name] = "Deathguard Veteran",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{38.2, 55.8}, {39, 55.4}, {39.2, 55.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [275107] = { -- Horde Legionnaire : https://wowhead.com/forever/npc=275107/horde-legionnaire
            [npcKeys.name] = "Horde Legionnaire",
        },
        [275116] = { -- Alliance Knight-Captain : https://wowhead.com/forever/npc=275116/alliance-knight-captain
            [npcKeys.name] = "Alliance Knight-Captain",
        },
        [275164] = { -- Arcane Sentry : https://wowhead.com/forever/npc=275164/arcane-sentry
            [npcKeys.name] = "Arcane Sentry",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[36] = {{12.4, 69}, {13, 69.4}, {14.4, 63.8}, {14.6, 53.2}, {14.8, 64.2}, {15.2, 60.4}, {18, 63.8}, {18.6, 71.4}, {18.6, 72.2}, {18.8, 60.4}, {19.4, 66}, {19.6, 66}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275173] = { -- Blackthorne Outrunner : https://wowhead.com/forever/npc=275173/blackthorne-outrunner
            [npcKeys.name] = "Blackthorne Outrunner",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
        },
        [275174] = { -- Blackthorne Priest : https://wowhead.com/forever/npc=275174/blackthorne-priest
            [npcKeys.name] = "Blackthorne Priest",
            [npcKeys.spawns] = {[616] = {{73.2, 41.4}, {73.4, 42}}},
            [npcKeys.zoneID] = zoneIDs.MOUNT_HYJAL,
        },
        [275186] = { -- Galestrider : https://wowhead.com/forever/npc=275186/galestrider
            [npcKeys.name] = "Galestrider",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[36] = {{18.8, 70}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275188] = { -- Credit : https://wowhead.com/forever/npc=275188/credit
            [npcKeys.name] = "Credit",
        },
        [275210] = { -- Teller Rames : https://wowhead.com/forever/npc=275210/teller-rames
            [npcKeys.name] = "Teller Rames",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[36] = {{22.8, 64.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275212] = { -- Teller Hanners : https://wowhead.com/forever/npc=275212/teller-hanners
            [npcKeys.name] = "Teller Hanners",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[36] = {{23, 65}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275214] = { -- Teller Althiellis : https://wowhead.com/forever/npc=275214/teller-althiellis
            [npcKeys.name] = "Teller Althiellis",
            [npcKeys.spawns] = {[36] = {{22.2, 65.4}, {22.4, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275216] = { -- Paymaster Alstein : https://wowhead.com/forever/npc=275216/paymaster-alstein
            [npcKeys.name] = "Paymaster Alstein",
        },
        [275240] = { -- Teller Almeida : https://wowhead.com/forever/npc=275240/teller-almeida
            [npcKeys.name] = "Teller Almeida",
            [npcKeys.spawns] = {[36] = {{11, 68.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275243] = { -- Teller Gee : https://wowhead.com/forever/npc=275243/teller-gee
            [npcKeys.name] = "Teller Gee",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.spawns] = {[36] = {{10.4, 68.4}, {10.4, 68.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275251] = { -- Paymaster Chang : https://wowhead.com/forever/npc=275251/paymaster-chang
            [npcKeys.name] = "Paymaster Chang",
            [npcKeys.spawns] = {[36] = {{10.8, 68}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275252] = { -- Paymaster Amadi : https://wowhead.com/forever/npc=275252/paymaster-amadi
            [npcKeys.name] = "Paymaster Amadi",
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275253] = { -- Teller Plushner : https://wowhead.com/forever/npc=275253/teller-plushner
            [npcKeys.name] = "Teller Plushner",
            [npcKeys.spawns] = {[36] = {{10.4, 69}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275258] = { -- KC Creature : https://wowhead.com/forever/npc=275258/kc-creature
            [npcKeys.name] = "KC Creature",
        },
        [275269] = { -- High Order Dockmaster : https://wowhead.com/forever/npc=275269/high-order-dockmaster
            [npcKeys.name] = "High Order Dockmaster",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{65.6, 83.2}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "AH",
        },
        [275270] = { -- Windshapers Dockmaster : https://wowhead.com/forever/npc=275270/windshapers-dockmaster
            [npcKeys.name] = "Windshapers Dockmaster",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[16593] = {{58, 80.4}}},
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
            [npcKeys.friendlyToFaction] = "H",
        },
        [275272] = { -- [DNT] : https://wowhead.com/forever/npc=275272/dnt
            [npcKeys.name] = "[DNT]",
        },
        [275273] = { -- Brelinda McFarry : https://wowhead.com/forever/npc=275273/brelinda-mcfarry
            [npcKeys.name] = "Brelinda McFarry",
        },
        [275276] = { -- Nizook Boof : https://wowhead.com/forever/npc=275276/nizook-boof
            [npcKeys.name] = "Nizook Boof",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[17] = {{65, 35}}},
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
        },
        [275283] = { -- Breanni : https://wowhead.com/forever/npc=275283/breanni
            [npcKeys.name] = "Breanni",
            [npcKeys.minLevel] = 27,
            [npcKeys.maxLevel] = 27,
            [npcKeys.spawns] = {[36] = {{19.4, 70}, {19.6, 69.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275321] = { -- Edward Egan : https://wowhead.com/forever/npc=275321/edward-egan
            [npcKeys.name] = "Edward Egan",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{18.4, 63.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275322] = { -- Patricia Egan : https://wowhead.com/forever/npc=275322/patricia-egan
            [npcKeys.name] = "Patricia Egan",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{18.4, 62.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275350] = { -- Timothy Jones : https://wowhead.com/forever/npc=275350/timothy-jones
            [npcKeys.name] = "Timothy Jones",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{18, 62}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275351] = { -- Adorean Lew : https://wowhead.com/forever/npc=275351/adorean-lew
            [npcKeys.name] = "Adorean Lew",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{16.8, 67.2}, {17.4, 67.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275352] = { -- Grezla the Hag : https://wowhead.com/forever/npc=275352/grezla-the-hag
            [npcKeys.name] = "Grezla the Hag",
            [npcKeys.spawns] = {[36] = {{13.8, 68}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275353] = { -- Merleaux : https://wowhead.com/forever/npc=275353/merleaux
            [npcKeys.name] = "Merleaux",
            [npcKeys.minLevel] = 28,
            [npcKeys.maxLevel] = 28,
            [npcKeys.spawns] = {[36] = {{15.4, 63.4}, {15.8, 63.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275354] = { -- Tomas Riogain : https://wowhead.com/forever/npc=275354/tomas-riogain
            [npcKeys.name] = "Tomas Riogain",
            [npcKeys.spawns] = {[36] = {{13.8, 68.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275355] = { -- Dorothy Egan : https://wowhead.com/forever/npc=275355/dorothy-egan
            [npcKeys.name] = "Dorothy Egan",
            [npcKeys.spawns] = {[36] = {{18.4, 63.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275356] = { -- Arcane Familiar : https://wowhead.com/forever/npc=275356/arcane-familiar
            [npcKeys.name] = "Arcane Familiar",
            [npcKeys.minLevel] = 26,
            [npcKeys.maxLevel] = 26,
            [npcKeys.spawns] = {[36] = {{17.8, 70.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275364] = { -- Compact Critter Carrier : https://wowhead.com/forever/npc=275364/compact-critter-carrier
            [npcKeys.name] = "Compact Critter Carrier",
        },
        [275398] = { -- Arcanist Braedin : https://wowhead.com/forever/npc=275398/arcanist-braedin
            [npcKeys.name] = "Arcanist Braedin",
            [npcKeys.spawns] = {[36] = {{13.6, 65.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275403] = { -- DNT : https://wowhead.com/forever/npc=275403/dnt
            [npcKeys.name] = "DNT",
        },
        [275404] = { -- Shadow Operative : https://wowhead.com/forever/npc=275404/shadow-operative
            [npcKeys.name] = "Shadow Operative",
        },
        [275430] = { -- Investigator Kath'leen : https://wowhead.com/forever/npc=275430/investigator-kathleen
            [npcKeys.name] = "Investigator Kath'leen",
            [npcKeys.spawns] = {[36] = {{20.2, 71.4}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275432] = { -- Investigator Silva : https://wowhead.com/forever/npc=275432/investigator-silva
            [npcKeys.name] = "Investigator Silva",
            [npcKeys.spawns] = {[36] = {{20.2, 71.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275437] = { -- Dark Enforcer : https://wowhead.com/forever/npc=275437/dark-enforcer
            [npcKeys.name] = "Dark Enforcer",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[85] = {{66.2, 63.4}, {66.4, 63.6}, {66.6, 65.4}, {67, 63.4}, {67.2, 64.4}, {67.4, 65.6}, {67.4, 67}, {67.6, 66.8}, {67.8, 66.2}, {68.2, 64.2}, {68.2, 64.8}, {68.6, 63}, {69, 63.8}, {69, 65.6}, {69.4, 64.8}, {69.6, 64.6}, {69.8, 64.4}, {70.2, 65.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [275491] = { -- Randal Emerson : https://wowhead.com/forever/npc=275491/randal-emerson
            [npcKeys.name] = "Randal Emerson",
            [npcKeys.minLevel] = 40,
            [npcKeys.maxLevel] = 40,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275596] = { -- Rafael Langrom : https://wowhead.com/forever/npc=275596/rafael-langrom
            [npcKeys.name] = "Rafael Langrom",
            [npcKeys.spawns] = {[36] = {{12.6, 71}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275598] = { -- Valerie Langrom : https://wowhead.com/forever/npc=275598/valerie-langrom
            [npcKeys.name] = "Valerie Langrom",
            [npcKeys.spawns] = {[36] = {{12.6, 71}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275603] = { -- Bragund Brightlink : https://wowhead.com/forever/npc=275603/bragund-brightlink
            [npcKeys.name] = "Bragund Brightlink",
            [npcKeys.spawns] = {[36] = {{12.4, 71}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275609] = { -- Elder Mossheart : https://wowhead.com/forever/npc=275609/elder-mossheart
            [npcKeys.name] = "Elder Mossheart",
        },
        [275613] = { -- Elder Frostleaf : https://wowhead.com/forever/npc=275613/elder-frostleaf
            [npcKeys.name] = "Elder Frostleaf",
        },
        [275622] = { -- Kerta the Bold : https://wowhead.com/forever/npc=275622/kerta-the-bold
            [npcKeys.name] = "Kerta the Bold",
            [npcKeys.spawns] = {[36] = {{14.6, 70.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275623] = { -- Valaden Silverblade : https://wowhead.com/forever/npc=275623/valaden-silverblade
            [npcKeys.name] = "Valaden Silverblade",
            [npcKeys.spawns] = {[36] = {{14.6, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275625] = { -- Bartram Haller : https://wowhead.com/forever/npc=275625/bartram-haller
            [npcKeys.name] = "Bartram Haller",
            [npcKeys.spawns] = {[36] = {{14.6, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275626] = { -- Walther Whiteford : https://wowhead.com/forever/npc=275626/walther-whiteford
            [npcKeys.name] = "Walther Whiteford",
            [npcKeys.spawns] = {[36] = {{14.4, 71.4}, {14.4, 71.6}, {14.6, 71.2}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
        },
        [275657] = { -- Heglan Shadeeye : https://wowhead.com/forever/npc=275657/heglan-shadeeye
            [npcKeys.name] = "Heglan Shadeeye",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[14] = {{58.6, 45.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.questStarts] = {99049},
            [npcKeys.questEnds] = {99048},
            [npcKeys.friendlyToFaction] = "H",
        },
        [275662] = { -- Spitelash Scout : https://wowhead.com/forever/npc=275662/spitelash-scout
            [npcKeys.name] = "Spitelash Scout",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[14] = {{56.6, 31}, {56.8, 26.2}, {57, 28}, {57, 29.4}, {57.2, 27.2}, {58, 21.8}, {58.2, 25.2}, {58.2, 28.2}, {58.2, 29.6}, {58.4, 23}, {58.4, 24}, {58.4, 26}, {58.4, 27.2}, {58.4, 28.6}, {58.6, 28.2}, {58.6, 29.6}, {58.8, 27}, {58.8, 29.2}, {59, 23.8}, {59, 26.2}, {59.2, 25.2}, {59.4, 22.4}, {59.4, 23}, {59.6, 22.2}, {59.6, 23}, {59.6, 24}, {59.6, 24.6}, {59.8, 25.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [275663] = { -- Spitelash Attendant : https://wowhead.com/forever/npc=275663/spitelash-attendant
            [npcKeys.name] = "Spitelash Attendant",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[14] = {{57, 21.6}, {57.4, 27.4}, {57.4, 29.2}, {57.8, 25.4}, {58, 22.2}, {58, 23.8}, {58.2, 25.6}, {58.2, 26.8}, {58.2, 29.8}, {58.4, 23.2}, {58.4, 28}, {58.4, 29.2}, {58.6, 28}, {58.8, 26.8}, {58.8, 29.2}, {58.8, 29.6}, {59, 23.2}, {59.2, 25.2}, {59.2, 25.6}, {59.4, 22.4}, {59.4, 24.2}, {59.6, 22.4}, {59.6, 22.6}, {59.6, 24.6}, {59.6, 26.8}, {59.8, 24.2}, {59.8, 28}, {60.6, 23.4}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [275666] = { -- Aggor the Young : https://wowhead.com/forever/npc=275666/aggor-the-young
            [npcKeys.name] = "Aggor the Young",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[14] = {{55.6, 14.2}, {56.6, 18.2}, {57.4, 15.2}, {57.4, 16.6}, {58, 16.2}, {58.6, 16.2}, {59, 17.4}, {59.2, 17.6}, {59.6, 17.6}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [275683] = { -- Sentinel Eralya Leafshadow : https://wowhead.com/forever/npc=275683/sentinel-eralya-leafshadow
            [npcKeys.name] = "Sentinel Eralya Leafshadow",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[141] = {{37.4, 36.8}, {37.6, 36.4}, {37.6, 36.8}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.questStarts] = {99047},
            [npcKeys.questEnds] = {99046, 99073},
            [npcKeys.friendlyToFaction] = "A",
        },
        [275703] = { -- Lasher Sproutling : https://wowhead.com/forever/npc=275703/lasher-sproutling
            [npcKeys.name] = "Lasher Sproutling",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[141] = {{49.4, 71.8}, {49.8, 71.6}, {50, 73.2}, {50.4, 71}, {50.4, 73.6}, {50.6, 70.8}, {51, 70.4}, {51.4, 73}, {51.4, 73.8}, {51.6, 73}, {51.6, 74.4}, {52, 69.4}, {52, 69.6}, {52.6, 70.4}, {52.6, 73}, {52.8, 71.8}, {52.8, 74.4}, {52.8, 74.6}, {53, 70.8}, {53.4, 67.4}, {53.4, 68}, {53.4, 69}, {53.6, 67.2}, {53.6, 67.6}, {53.6, 68.6}, {54.2, 69.8}, {54.4, 65.4}, {54.4, 65.6}, {54.6, 65.6}, {54.8, 67.4}, {54.8, 67.6}, {55, 64.8}, {55, 70.8}, {55.2, 69.4}, {55.2, 69.6}, {55.6, 66.8}, {55.6, 70}, {55.6, 70.8}, {56.4, 66.2}, {56.4, 67.6}, {56.6, 66}, {57, 63.2}, {57, 69.4}, {57.2, 69.8}, {57.2, 70.6}, {57.4, 63.8}, {57.4, 65}, {57.6, 69.2}, {57.8, 64}, {57.8, 70.6}, {57.8, 73.2}, {58, 65.4}, {58, 65.6}, {58, 70.2}, {58, 72.2}, {58.6, 71}, {58.6, 72.2}, {58.6, 72.6}, {59, 64}, {59.4, 64.8}, {59.6, 65}, {59.6, 65.6}, {59.8, 64}, {59.8, 71}, {60.2, 72.4}, {60.2, 72.6}, {60.4, 66.6}, {60.4, 68.2}, {60.4, 69.4}, {60.4, 69.6}, {60.6, 65.2}, {60.6, 65.8}, {60.6, 70.6}, {61, 66.6}, {61.2, 69.4}, {61.2, 70.4}, {61.4, 67.6}, {61.6, 66.6}, {61.6, 67.6}, {61.8, 65.4}, {61.8, 65.6}, {61.8, 69.2}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275708] = { -- Blooming Lasher : https://wowhead.com/forever/npc=275708/blooming-lasher
            [npcKeys.name] = "Blooming Lasher",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[141] = {{40.4, 39.2}, {40.8, 37.2}, {40.8, 40.4}, {41, 34.4}, {41, 34.6}, {41, 37.8}, {41, 40.6}, {41, 42}, {41.4, 39}, {41.6, 38.8}, {41.6, 41.2}, {41.8, 33.2}, {42, 28.6}, {42, 37}, {42, 37.8}, {42, 42.2}, {42.2, 35}, {42.2, 42.6}, {42.4, 32.2}, {42.4, 43.6}, {42.6, 37.4}, {42.6, 38.4}, {42.6, 43.8}, {42.8, 25.8}, {42.8, 38.6}, {43, 29.2}, {43, 30.4}, {43, 30.6}, {43, 35}, {43, 42.4}, {43, 42.8}, {43.2, 32.2}, {43.2, 32.6}, {43.4, 26.8}, {43.4, 34.2}, {43.4, 41.2}, {43.6, 26.2}, {43.6, 30.6}, {43.6, 33.2}, {43.6, 34.4}, {43.6, 35.2}, {43.6, 40.6}, {43.6, 43}, {43.8, 28.8}, {44, 28}, {44, 30.4}, {44, 39.8}, {44.2, 26.6}, {44.2, 43.6}, {44.4, 38.8}, {44.6, 27.2}, {44.6, 43}, {45.2, 26.2}, {45.2, 42.4}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [275744] = { -- Sentinel Lynessa Duskblossom : https://wowhead.com/forever/npc=275744/sentinel-lynessa-duskblossom
            [npcKeys.name] = "Sentinel Lynessa Duskblossom",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[141] = {{43, 51.8}, {43, 59.2}, {43.8, 61.6}, {44, 59.4}, {44, 59.8}, {44, 61.2}, {44.4, 57.4}, {44.4, 57.6}, {44.6, 58.8}, {45.4, 59.8}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.questStarts] = {99053},
            [npcKeys.friendlyToFaction] = "A",
        },
        [275767] = { -- Herak the Pillager : https://wowhead.com/forever/npc=275767/herak-the-pillager
            [npcKeys.name] = "Herak the Pillager",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [275789] = { -- Malah Longwind : https://wowhead.com/forever/npc=275789/malah-longwind
            [npcKeys.name] = "Malah Longwind",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {99081},
            [npcKeys.questEnds] = {99079},
            [npcKeys.friendlyToFaction] = "H",
        },
        [275798] = { -- Writhing Flame : https://wowhead.com/forever/npc=275798/writhing-flame
            [npcKeys.name] = "Writhing Flame",
        },
        [275811] = { -- Pal'juh : https://wowhead.com/forever/npc=275811/paljuh
            [npcKeys.name] = "Pal'juh",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 7,
            [npcKeys.spawns] = {[14] = {{46.2, 78.6}, {46.4, 80.2}, {46.6, 80.2}, {47.2, 80.6}, {47.8, 80.4}, {48.6, 79.6}, {49.4, 79.2}, {50.4, 79.2}, {51.4, 79.4}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
            [npcKeys.questStarts] = {99123},
            [npcKeys.friendlyToFaction] = "H",
        },
        [275847] = { -- Loren Ravenlock : https://wowhead.com/forever/npc=275847/loren-ravenlock
            [npcKeys.name] = "Loren Ravenlock",
        },
        [275929] = { -- Treant : https://wowhead.com/forever/npc=275929/treant
            [npcKeys.name] = "Treant",
        },
        [275954] = { -- Bareth Dawnstone : https://wowhead.com/forever/npc=275954/bareth-dawnstone
            [npcKeys.name] = "Bareth Dawnstone",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[85] = {{32, 46.2}, {32.2, 47.2}, {32.4, 47.6}, {33.2, 47.6}, {33.8, 47.8}, {34.6, 48}, {36.2, 48.2}, {37, 48.2}, {37.8, 48.2}, {38.6, 48.4}, {39, 48.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.questStarts] = {99144},
            [npcKeys.friendlyToFaction] = "H",
        },
        [275980] = { -- Farholde Miner : https://wowhead.com/forever/npc=275980/farholde-miner
            [npcKeys.name] = "Farholde Miner",
            [npcKeys.spawns] = {[16591] = {{62.4, 69}}},
            [npcKeys.zoneID] = zoneIDs.RIVERGLADES,
        },
        [276003] = { -- Minor Ice Elemental : https://wowhead.com/forever/npc=276003/minor-ice-elemental
            [npcKeys.name] = "Minor Ice Elemental",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{49.4, 45}, {51.6, 42.2}, {52, 44}, {52.2, 43.4}, {52.4, 44.8}, {53.2, 43.2}, {53.2, 43.8}, {53.2, 44.8}, {53.6, 43}, {53.6, 47.4}, {53.8, 44.4}, {53.8, 44.6}, {53.8, 47.8}, {54, 45.8}, {54.8, 44.6}, {55.2, 43.4}, {55.2, 45.8}, {55.2, 46.6}, {55.4, 44.4}, {55.6, 44.6}, {55.8, 44.2}, {56, 43.4}, {56.2, 46.2}, {56.2, 46.6}, {56.4, 47.6}, {56.4, 49.4}, {56.6, 46.6}, {56.8, 44.4}, {57, 45.2}, {57, 45.6}, {57, 49.6}, {57.2, 49}, {57.4, 43.4}, {57.4, 47.8}, {57.6, 43.2}, {57.6, 44.8}, {57.6, 45.8}, {57.8, 42.2}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276009] = { -- Avala : https://wowhead.com/forever/npc=276009/avala
            [npcKeys.name] = "Avala",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[1] = {{57.2, 43.6}, {57.4, 42.2}, {57.4, 42.8}, {58, 42.8}, {58.2, 42}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276020] = { -- Riptear : https://wowhead.com/forever/npc=276020/riptear
            [npcKeys.name] = "Riptear",
            [npcKeys.minLevel] = 13,
            [npcKeys.maxLevel] = 13,
            [npcKeys.spawns] = {[85] = {{80, 45.8}, {80.2, 48.6}, {80.8, 43.8}, {81, 45}, {81.2, 42.6}, {81.2, 46.2}, {81.4, 41}, {82, 43.8}, {82, 45.6}, {82.2, 45.4}, {82.4, 42.2}, {82.4, 43}, {82.8, 44.2}, {82.8, 45.4}, {83, 46.4}, {83.2, 42.6}, {83.2, 46.8}, {83.4, 42.2}, {83.6, 42.4}, {83.8, 44.6}, {83.8, 46.8}, {84, 42.8}, {84.4, 43.6}, {84.4, 45.6}, {84.6, 42.2}, {84.6, 43.4}, {85, 43.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [276061] = { -- Decrepit Harvester : https://wowhead.com/forever/npc=276061/decrepit-harvester
            [npcKeys.name] = "Decrepit Harvester",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[85] = {{52, 55}, {52.2, 55.6}, {52.8, 56.4}, {53, 57.2}, {53.2, 57.6}, {53.6, 58}, {53.8, 56.2}, {54, 57.4}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [276067] = { -- Angus Hammerhand : https://wowhead.com/forever/npc=276067/angus-hammerhand
            [npcKeys.name] = "Angus Hammerhand",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[85] = {{21.2, 45.8}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [276078] = { -- Twilight Laborer : https://wowhead.com/forever/npc=276078/twilight-laborer
            [npcKeys.name] = "Twilight Laborer",
        },
        [276080] = { -- Mountaineer Coalbeard : https://wowhead.com/forever/npc=276080/mountaineer-coalbeard
            [npcKeys.name] = "Mountaineer Coalbeard",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1] = {{52, 44}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276082] = { -- Mountaineer Sunhammer : https://wowhead.com/forever/npc=276082/mountaineer-sunhammer
            [npcKeys.name] = "Mountaineer Sunhammer",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1] = {{59.8, 50}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276083] = { -- Mountaineer Stoneanvil : https://wowhead.com/forever/npc=276083/mountaineer-stoneanvil
            [npcKeys.name] = "Mountaineer Stoneanvil",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
            [npcKeys.spawns] = {[1] = {{53.2, 58.6}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276089] = { -- The Condemned One : https://wowhead.com/forever/npc=276089/the-condemned-one
            [npcKeys.name] = "The Condemned One",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[85] = {{64.8, 45.8}, {65.2, 41.8}, {65.2, 43.6}, {65.6, 43}, {65.8, 44.6}, {66, 46}, {66, 46.8}, {66.4, 41.6}, {67, 43}, {67.2, 41.8}, {67.2, 48.8}, {67.4, 40}, {67.4, 48.2}, {67.6, 48}, {68, 40}, {69.6, 47.2}, {70, 39}, {70.2, 44.2}, {71, 39.4}, {71.8, 37.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [276099] = { -- Wrathvine : https://wowhead.com/forever/npc=276099/wrathvine
            [npcKeys.name] = "Wrathvine",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 8,
            [npcKeys.spawns] = {[141] = {{53.2, 70.6}, {53.4, 70.4}, {56, 67.6}, {56.2, 66.6}, {59.8, 71.8}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276101] = { -- Nightscreech : https://wowhead.com/forever/npc=276101/nightscreech
            [npcKeys.name] = "Nightscreech",
            [npcKeys.spawns] = {[141] = {{38.2, 28.2}, {40, 55.6}, {40.2, 54.8}, {46.4, 33.6}, {46.8, 32}}},
            [npcKeys.zoneID] = zoneIDs.TELDRASSIL,
        },
        [276105] = { -- Stormherald Ukta : https://wowhead.com/forever/npc=276105/stormherald-ukta
            [npcKeys.name] = "Stormherald Ukta",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [276108] = { -- Thornstarter Igleg : https://wowhead.com/forever/npc=276108/thornstarter-igleg
            [npcKeys.name] = "Thornstarter Igleg",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [276109] = { -- Snarlsnout : https://wowhead.com/forever/npc=276109/snarlsnout
            [npcKeys.name] = "Snarlsnout",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
        },
        [276110] = { -- Knight of Mourning : https://wowhead.com/forever/npc=276110/knight-of-mourning
            [npcKeys.name] = "Knight of Mourning",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[85] = {{17.4, 67.4}, {17.4, 67.6}, {17.6, 67.4}, {17.6, 67.6}}},
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
            [npcKeys.friendlyToFaction] = "H",
        },
        [276111] = { -- Ghostfang : https://wowhead.com/forever/npc=276111/ghostfang
            [npcKeys.name] = "Ghostfang",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[1] = {{74.2, 63.2}, {74.8, 63.4}, {75.2, 61.6}, {79.2, 42.8}, {79.8, 43}, {80.4, 45.8}, {80.4, 46.6}, {80.6, 46.8}, {81.2, 45.4}, {81.4, 46}, {81.4, 55.2}, {81.6, 55.4}, {82, 55.8}}},
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276138] = { -- Subjugated Assistant : https://wowhead.com/forever/npc=276138/subjugated-assistant
            [npcKeys.name] = "Subjugated Assistant",
        },
        [276151] = { -- Tim's Test Creature : https://wowhead.com/forever/npc=276151/tims-test-creature
            [npcKeys.name] = "Tim's Test Creature",
        },
        [276170] = { -- Belanaa Windveil : https://wowhead.com/forever/npc=276170/belanaa-windveil
            [npcKeys.name] = "Belanaa Windveil",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[36] = {{11.6, 57.4}, {11.6, 57.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276171] = { -- Oura Stormspinner : https://wowhead.com/forever/npc=276171/oura-stormspinner
            [npcKeys.name] = "Oura Stormspinner",
            [npcKeys.minLevel] = 35,
            [npcKeys.maxLevel] = 35,
            [npcKeys.zoneID] = zoneIDs.MULGORE,
            [npcKeys.questStarts] = {99196},
            [npcKeys.questEnds] = {99196},
            [npcKeys.friendlyToFaction] = "H",
        },
        [276178] = { -- Blizzcon Guide : https://wowhead.com/forever/npc=276178/blizzcon-guide
            [npcKeys.name] = "Blizzcon Guide",
        },
        [276180] = { -- Elder Finseer : https://wowhead.com/forever/npc=276180/elder-finseer
            [npcKeys.name] = "Elder Finseer",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 11,
            [npcKeys.spawns] = {[12] = {{78.6, 56.2}, {78.6, 57.2}, {79, 46.6}, {79.2, 53}, {79.4, 49.2}, {79.6, 46.8}, {79.6, 54.8}, {80, 54.2}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [276189] = { -- Matriarch Bristlefur : https://wowhead.com/forever/npc=276189/matriarch-bristlefur
            [npcKeys.name] = "Matriarch Bristlefur",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.spawns] = {[12] = {{51, 80.6}, {51.4, 78.2}, {51.6, 77.8}, {51.8, 79.2}, {52, 80.6}, {59, 80.6}, {59.6, 79.2}, {59.6, 80.8}, {59.8, 80.2}, {63.2, 77}, {64.4, 77}, {64.8, 77}, {65.2, 76.4}, {65.2, 77.8}, {65.6, 76.4}, {67.4, 76.8}}},
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [276194] = { -- Dustwind Eggtender : https://wowhead.com/forever/npc=276194/dustwind-eggtender
            [npcKeys.name] = "Dustwind Eggtender",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 12,
            [npcKeys.spawns] = {[14] = {{51.2, 20.6}, {51.2, 23.8}, {51.4, 19}, {51.4, 19.8}, {51.6, 20}, {52.2, 24}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [276198] = { -- Shal'ma : https://wowhead.com/forever/npc=276198/shalma
            [npcKeys.name] = "Shal'ma",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 9,
            [npcKeys.spawns] = {[14] = {{59.8, 89.2}, {59.8, 91}, {60.4, 89.6}, {60.4, 91.8}, {60.8, 89.8}, {61, 88.2}, {61.4, 90.6}, {61.8, 89.8}, {62.8, 96.8}, {63, 96.2}, {63.6, 95.6}, {68.4, 71.2}, {69, 71.6}, {69.2, 71.4}, {69.6, 71.8}, {69.8, 71.4}}},
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [276215] = { -- Kirin Tor Enforcer : https://wowhead.com/forever/npc=276215/kirin-tor-enforcer
            [npcKeys.name] = "Kirin Tor Enforcer",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 55,
            [npcKeys.spawns] = {[36] = {{12.6, 56.2}, {13, 54.2}, {13.6, 55.8}, {14.4, 59.8}, {14.6, 61}, {17.2, 68}, {19.2, 73}, {19.6, 73.4}, {19.6, 75}, {19.8, 73.8}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276235] = { -- Archmage Modera : https://wowhead.com/forever/npc=276235/archmage-modera
            [npcKeys.name] = "Archmage Modera",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[36] = {{14.2, 59.4}, {14.2, 59.6}}},
            [npcKeys.zoneID] = zoneIDs.ALTERAC_MOUNTAINS,
            [npcKeys.friendlyToFaction] = "A",
        },
        [276246] = { -- Mistmantle Prowler : https://wowhead.com/forever/npc=276246/mistmantle-prowler
            [npcKeys.name] = "Mistmantle Prowler",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.spawns] = {[10] = {{43.8, 86}, {74.8, 45.4}, {75.6, 44}, {77, 46.2}, {77.5, 44.2}, {79.8, 43.8}, {81.8, 71.8}, {89.4, 16.4}}, [12] = {{76.2, 84.6}}},
        },
        [276247] = { -- Lightning : https://wowhead.com/forever/npc=276247/lightning
            [npcKeys.name] = "Lightning",
        },
        [276249] = { -- Credit : https://wowhead.com/forever/npc=276249/credit
            [npcKeys.name] = "Credit",
        },
        [276250] = { -- Credit : https://wowhead.com/forever/npc=276250/credit
            [npcKeys.name] = "Credit",
        },
        [276316] = { -- Raul Sweete : https://wowhead.com/forever/npc=276316/raul-sweete
            [npcKeys.name] = "Raul Sweete",
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [276318] = { -- Idrieth Mossgrove : https://wowhead.com/forever/npc=276318/idrieth-mossgrove
            [npcKeys.name] = "Idrieth Mossgrove",
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
        },
        [276331] = { -- Spawn of Grubthor : https://wowhead.com/forever/npc=276331/spawn-of-grubthor
            [npcKeys.name] = "Spawn of Grubthor",
        },
        [276401] = { -- Nascent Pylon Protector : https://wowhead.com/forever/npc=276401/nascent-pylon-protector
            [npcKeys.name] = "Nascent Pylon Protector",
        },
        [276415] = { -- Windshaper Guardian : https://wowhead.com/forever/npc=276415/windshaper-guardian
            [npcKeys.name] = "Windshaper Guardian",
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [276416] = { -- Windshaper Elementalist : https://wowhead.com/forever/npc=276416/windshaper-elementalist
            [npcKeys.name] = "Windshaper Elementalist",
            [npcKeys.zoneID] = zoneIDs.ZEPHRAS_ISLE,
        },
        [276530] = { -- Spirit Wolf : https://wowhead.com/forever/npc=276530/spirit-wolf
            [npcKeys.name] = "Spirit Wolf",
        },
        [276591] = { -- Spoogledorf : https://wowhead.com/forever/npc=276591/spoogledorf
            [npcKeys.name] = "Spoogledorf",
        },
        [276595] = { -- Dominik Eno : https://wowhead.com/forever/npc=276595/dominik-eno
            [npcKeys.name] = "Dominik Eno",
        },
        [276730] = { -- Swift Stormsaber : https://wowhead.com/forever/npc=276730/swift-stormsaber
            [npcKeys.name] = "Swift Stormsaber",
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [276731] = { -- Swift Mistsaber : https://wowhead.com/forever/npc=276731/swift-mistsaber
            [npcKeys.name] = "Swift Mistsaber",
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [276732] = { -- Swift Frostsaber : https://wowhead.com/forever/npc=276732/swift-frostsaber
            [npcKeys.name] = "Swift Frostsaber",
            [npcKeys.zoneID] = zoneIDs.DARNASSUS,
        },
        [276734] = { -- Swift White Mechanostrider : https://wowhead.com/forever/npc=276734/swift-white-mechanostrider
            [npcKeys.name] = "Swift White Mechanostrider",
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276735] = { -- Swift Yellow Mechanostrider : https://wowhead.com/forever/npc=276735/swift-yellow-mechanostrider
            [npcKeys.name] = "Swift Yellow Mechanostrider",
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276736] = { -- Swift Green Mechanostrider : https://wowhead.com/forever/npc=276736/swift-green-mechanostrider
            [npcKeys.name] = "Swift Green Mechanostrider",
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276737] = { -- Swift Gray Ram : https://wowhead.com/forever/npc=276737/swift-gray-ram
            [npcKeys.name] = "Swift Gray Ram",
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276740] = { -- Cedrik Stonequest : https://wowhead.com/forever/npc=276740/cedrik-stonequest
            [npcKeys.name] = "Cedrik Stonequest",
            [npcKeys.zoneID] = zoneIDs.IRONFORGE,
        },
        [276752] = { -- Animated Hammer : https://wowhead.com/forever/npc=276752/animated-hammer
            [npcKeys.name] = "Animated Hammer",
        },
        [276756] = { -- Solluna : https://wowhead.com/forever/npc=276756/solluna
            [npcKeys.name] = "Solluna",
        },
        [276779] = { -- Swift Brown Ram : https://wowhead.com/forever/npc=276779/swift-brown-ram
            [npcKeys.name] = "Swift Brown Ram",
            [npcKeys.zoneID] = zoneIDs.DUN_MOROGH,
        },
        [276781] = { -- Abomination : https://wowhead.com/forever/npc=276781/abomination
            [npcKeys.name] = "Abomination",
        },
        [276783] = { -- Swift White Ram : https://wowhead.com/forever/npc=276783/swift-white-ram
            [npcKeys.name] = "Swift White Ram",
        },
        [276784] = { -- Gargoyle : https://wowhead.com/forever/npc=276784/gargoyle
            [npcKeys.name] = "Gargoyle",
        },
        [276785] = { -- Swift Brown Steed : https://wowhead.com/forever/npc=276785/swift-brown-steed
            [npcKeys.name] = "Swift Brown Steed",
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [276786] = { -- Swift Palomino : https://wowhead.com/forever/npc=276786/swift-palomino
            [npcKeys.name] = "Swift Palomino",
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [276787] = { -- Swift White Steed : https://wowhead.com/forever/npc=276787/swift-white-steed
            [npcKeys.name] = "Swift White Steed",
            [npcKeys.zoneID] = zoneIDs.ELWYNN_FOREST,
        },
        [276788] = { -- Brown Horse : https://wowhead.com/forever/npc=276788/brown-horse
            [npcKeys.name] = "Brown Horse",
        },
        [276789] = { -- Pinto : https://wowhead.com/forever/npc=276789/pinto
            [npcKeys.name] = "Pinto",
        },
        [276790] = { -- Chestnut Mare : https://wowhead.com/forever/npc=276790/chestnut-mare
            [npcKeys.name] = "Chestnut Mare",
            [npcKeys.zoneID] = zoneIDs.HILLSBRAD_FOOTHILLS,
        },
        [276793] = { -- Ochre Skeletal Warhorse : https://wowhead.com/forever/npc=276793/ochre-skeletal-warhorse
            [npcKeys.name] = "Ochre Skeletal Warhorse",
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [276795] = { -- Anya Rince : https://wowhead.com/forever/npc=276795/anya-rince
            [npcKeys.name] = "Anya Rince",
        },
        [276796] = { -- Green Skeletal Warhorse : https://wowhead.com/forever/npc=276796/green-skeletal-warhorse
            [npcKeys.name] = "Green Skeletal Warhorse",
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [276797] = { -- Purple Skeletal Warhorse : https://wowhead.com/forever/npc=276797/purple-skeletal-warhorse
            [npcKeys.name] = "Purple Skeletal Warhorse",
            [npcKeys.zoneID] = zoneIDs.TIRISFAL_GLADES,
        },
        [276798] = { -- Malus : https://wowhead.com/forever/npc=276798/malus
            [npcKeys.name] = "Malus",
        },
        [276799] = { -- Gabrandal Matters : https://wowhead.com/forever/npc=276799/gabrandal-matters
            [npcKeys.name] = "Gabrandal Matters",
        },
        [276800] = { -- Swift Olive Raptor : https://wowhead.com/forever/npc=276800/swift-olive-raptor
            [npcKeys.name] = "Swift Olive Raptor",
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [276801] = { -- Swift Orange Raptor : https://wowhead.com/forever/npc=276801/swift-orange-raptor
            [npcKeys.name] = "Swift Orange Raptor",
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [276802] = { -- Shiro Hobblespark : https://wowhead.com/forever/npc=276802/shiro-hobblespark
            [npcKeys.name] = "Shiro Hobblespark",
        },
        [276803] = { -- Swift Blue Raptor : https://wowhead.com/forever/npc=276803/swift-blue-raptor
            [npcKeys.name] = "Swift Blue Raptor",
            [npcKeys.zoneID] = zoneIDs.DUROTAR,
        },
        [276804] = { -- Deelio : https://wowhead.com/forever/npc=276804/deelio
            [npcKeys.name] = "Deelio",
        },
        [276805] = { -- Swift Gray Wolf : https://wowhead.com/forever/npc=276805/swift-gray-wolf
            [npcKeys.name] = "Swift Gray Wolf",
        },
        [276806] = { -- Giant Infernal : https://wowhead.com/forever/npc=276806/giant-infernal
            [npcKeys.name] = "Giant Infernal",
        },
        [276807] = { -- Giant Infernal : https://wowhead.com/forever/npc=276807/giant-infernal
            [npcKeys.name] = "Giant Infernal",
        },
        [276808] = { -- Traveling Adventurer : https://wowhead.com/forever/npc=276808/traveling-adventurer
            [npcKeys.name] = "Traveling Adventurer",
        },
        [276809] = { -- Red Crystal : https://wowhead.com/forever/npc=276809/red-crystal
            [npcKeys.name] = "Red Crystal",
        },
        [276810] = { -- Hungry Patron : https://wowhead.com/forever/npc=276810/hungry-patron
            [npcKeys.name] = "Hungry Patron",
        },
    }
end
return ForeverBaseNpc
