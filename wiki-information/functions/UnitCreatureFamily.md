## Title: UnitCreatureFamily

**Content:**
Returns the creature type of the unit (e.g. Crab).
`creatureFamily = UnitCreatureFamily(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - unit you wish to query.

**Returns:**
- `creatureFamily`
  - *string* - localized name of the creature family (e.g., "Crab" or "Wolf"). Known return values include:
    - **enUS**
    - **deDE**
    - **Creature Type**
    - Aqiri
      - Aqir
    - Beast
      - Basilisk
      - Bat
      - Bear
      - Beetle
      - Bird of Prey
      - Blood Beast
      - Boar
      - Camel
      - Carapid
      - Carrion Bird
      - Cat
      - Chimaera
      - Clefthoof
      - Core Hound
      - Courser
      - Crab
      - Crocolisk
      - Devilsaur
      - Direhorn
      - Dragonhawk
      - Feathermane
      - Fox
      - Gorilla
      - Gruffhorn
      - Hound
      - Hydra
      - Hyena
      - Lesser Dragonkin
      - Lizard
      - Mammoth
      - Mechanical
      - Monkey
      - Moth
      - Oxen
      - Pterrordax
      - Raptor
      - Ravager
      - Ray
      - Riverbeast
      - Rodent
      - Scalehide
      - Scorpid
      - Serpent
      - Shale Beast
      - Spider
      - Spirit Beast
      - Sporebat
      - Stag
      - Stone Hound
      - Tallstrider
      - Toad
      - Turtle
      - Warp Stalker
      - Wasp
      - Water Strider
      - Waterfowl
      - Wind Serpent
      - Wolf
      - Worm
    - Demon
      - Fel Imp
      - Felguard
      - Felhunter
      - Imp
      - Incubus
      - Observer
      - Shivarra
      - Succubus
      - Void Lord
      - Voidwalker
      - Wrathguard
    - Elemental
      - Fire Elemental
      - Storm Elemental
      - Water Elemental
    - Undead
      - Abomination
      - Ghoul
    - Mechanical
      - Remote Control

**Description:**
Does not work on all creatures, since the family's primary function is to determine what abilities the unit will have if a player is able to control it. However, it does work on almost all Beasts, even if they are not tameable by Hunters.
Returns nil if the creature doesn't belong to a family that includes a tameable creature.

**Usage:**
Displays a message if the target is a type of bear.
```lua
if ( UnitCreatureFamily("target") == "Bear" ) then
    message("It's a godless killing machine! Run for your lives!");
end
```