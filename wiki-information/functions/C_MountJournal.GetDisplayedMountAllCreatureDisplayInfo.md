## Title: C_MountJournal.GetMountAllCreatureDisplayInfoByID

**Content:**
Returns the display IDs for a mount.
`allDisplayInfo = C_MountJournal.GetMountAllCreatureDisplayInfoByID(mountID)`
`allDisplayInfo = C_MountJournal.GetDisplayedMountAllCreatureDisplayInfo(mountIndex)`

**Parameters:**
- `GetMountAllCreatureDisplayInfoByID:`
  - `mountID`
    - *number* - MountID

- `GetDisplayedMountAllCreatureDisplayInfo:`
  - `mountIndex`
    - *number* - the index of the displayed mount, i.e. mount in list that matches current search query and filters, in the range of 1 to `C_MountJournal.GetNumDisplayedMounts`

**Values:**
Note: This list is up to date as of patch 8.1.5 (29737) Mar 14 2019
- `ID`
- `Name`
- `DisplayIDs`
  - `17`
    - `Felsteed`
      - `2346, 51651`
  - `83`
    - `Dreadsteed`
      - `14554, 51652`
  - `422`
    - `Vicious War Steed`
      - `38668, 91643`
  - `435`
    - `Mountain Horse`
      - `39096, 91641`
  - `436`
    - `Swift Mountain Horse`
      - `39095, 91642`
  - `860`
    - `Archmage's Prismatic Disc`
      - `73770, 73768, 73769`
  - `861`
    - `High Priest's Lightsworn Seeker`
      - `73774, 73775, 73773`
  - `866`
    - `Deathlord's Vilebrood Vanquisher`
      - `73785, 75313, 75314`
  - `867`
    - `Battlelord's Bloodthirsty War Wyrm`
      - `73778, 75994, 75995`
  - `888`
    - `Farseer's Raging Tempest`
      - `76024, 74144, 76025`
  - `925`
    - `Onyx War Hyena`
      - `75322, 91593`
  - `926`
    - `Alabaster Hyena`
      - `75323, 91592`
  - `928`
    - `Dune Scavenger`
      - `75324, 91591`
  - `996`
    - `Seabraid Stallion`
      - `80357, 91599`
  - `997`
    - `Gilded Ravasaur`
      - `80358, 91594`
  - `1010`
    - `Admiralty Stallion`
      - `82148, 91600`
  - `1011`
    - `Shu-Zen, the Divine Sentinel`
      - `81772, 84570, 84571, 84570, 81772`
  - `1015`
    - `Dapple Gray`
      - `81693, 91601`
  - `1016`
    - `Smoky Charger`
      - `82161, 91602`
  - `1018`
    - `Terrified Pack Mule`
      - `81694, 91603`
  - `1019`
    - `Goldenmane`
      - `81690, 91604`
  - `1038`
    - `Zandalari Direhorn`
      - `83525, 91595`
  - `1173`
    - `Broken Highland Mustang`
      - `87773, 91606`
  - `1174`
    - `Highland Mustang`
      - `87774, 91607`
  - `1182`
    - `Lil' Donkey`
      - `85581, 91608`
  - `1198`
    - `Kul Tiran Charger`
      - `88974, 91640`
  - `1220`
    - `Bruce`
      - `90419, 90420`
  - `1221`
    - `Hogrus, Swine of Good Fortune`
      - `90398, 91597`
  - `1222`
    - `Vulpine Familiar`
      - `90397, 91598`
  - `1225`
    - `Crusader's Direhorn`
      - `90501, 91596`
  - `1245`
    - `Bloodflank Charger`
      - `91388, 91609`

**Returns:**
- `allDisplayInfo`
  - *structure* - MountCreatureDisplayInfo
    - `MountCreatureDisplayInfo`
      - `Field`
      - `Type`
      - `Description`
      - `creatureDisplayID`
        - *number* - CreatureDisplayID
      - `isVisible`
        - *boolean*