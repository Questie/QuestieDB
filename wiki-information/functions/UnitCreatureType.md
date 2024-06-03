## Title: UnitCreatureType

**Content:**
Returns the creature classification type of the unit (e.g. Beast).
`creatureType = UnitCreatureType(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to query creature type of.

**Returns:**
- `creatureType`
  - *string* - the localized creature type of the unit, or nil if the unit does not exist, or if the unit's creature type isn't available.

**Description:**
The default Blizzard UI displays an empty string instead of "Not specified" for units with that creature type. Warcraft Wiki refers to these units as "Uncategorized".

Known return values include:
- enUS
- deDE
- esES
- esMX
- frFR
- itIT
- ptBR
- ruRU
- koKR
- zhCN
- zhTW

| enUS         | deDE            | esES         | esMX         | frFR           | itIT         | ptBR         | ruRU                | koKR       | zhCN       | zhTW       |
|--------------|-----------------|--------------|--------------|----------------|--------------|--------------|---------------------|------------|------------|------------|
| Aberration   | Wildtier        | Bestia       | Bestia       | Bête           | Bestia       | Fera         | Животное            | 야수        | 野兽        | 野兽        |
| Critter      | Kleintier       | Alma         | Alma         | Bestiole       | Animale      | Bicho        | Существо            | 동물        | 小动物      | 小动物      |
| Demon        | Dämon           | Demonio      | Demonio      | Démon          | Demone       | Demônio      | Демон               | 악마        | 恶魔        | 恶魔        |
| Dragonkin    | Drachkin        | Dragon       | Dragón       | Draconien      | Dragoide     | Dracônico    | Дракон              | 용족        | 龙类        | 龙类        |
| Elemental    | Elementar       | Elemental    | Elemental    | Élémentaire    | Elementale   | Elemental    | Элементаль          | 정령        | 元素生物    | 元素生物    |
| Gas Cloud    | Gaswolke        | Nube de Gas  | Nube de Gas  | Nuage de gaz   | Nube di Gas  | Gasoso       | Газовое облако      | 가스        | 气体云      | 气体云      |
| Giant        | Riese           | Gigante      | Gigante      | Géant          | Gigante      | Gigante      | Великан             | 거인        | 巨人        | 巨人        |
| Humanoid     | Humanoid        | Humanoide    | Humanoide    | Humanoïde      | Umanoide     | Humanoide    | Гуманоид            | 인간형      | 人型生物    | 人型生物    |
| Mechanical   | Mechanisch      | Mecánico     | Mecánico     | Machine        | Meccanico    | Mecânico     | Механизм            | 기계        | 机械        | 机械        |
| Non-combat Pet | Haustier      | Mascota no combatiente | Mascota mansa | Familier pacifique | Animale Non combattente | Mascote não-combatente | Спутник | 애완동물    | 非战斗宠物  | 非战斗宠物  |
| Not specified | Nicht spezifiziert | No especificado | Sin especificar | Non spécifié | Non Specificato | Não especificado | Не указано | 기타        | 未指定      | 不明        |
| Totem        | Totem           | Tótem        | Totém        | Totem          | Totem        | Totem        | Тотем               | 토템        | 图腾        | 图腾        |
| Undead       | Untoter         | No-muerto    | No-muerto    | Mort-vivant    | Non Morto    | Renegado     | Нежить              | 언데드      | 亡灵        | 不死族      |
| Wild Pet     | Ungezähmtes Tier | Mascotte sauvage |              |                |              |              |                     |            |            |            |

**Reference:**
[LibBabble-CreatureType-3.0](https://www.wowace.com/projects/libbabble-creaturetype-3-0)