# Entity localization sources

QuestieDB owns these Generation inputs. Generation and Reconstruction read this directory
without checking out Questie. Release packages contain the generated Localization blocks,
not these raw files. Source mode still omits Base translations.

## Layout

Each of `Classic`, `TBC`, `Wotlk`, `Cata`, and `MoP` contains:

- `lookupQuests/`: quest names and objective text.
- `lookupNpcs/`: NPC names and subnames.
- `lookupItems/`: item names.
- `lookupObjects/`: object names.

Each entity directory has nine locale files: `deDE`, `esES`, `esMX`, `frFR`, `koKR`, `ptBR`,
`ruRU`, `zhCN`, and `zhTW`. English comes from the base entity data.

`lookupOverrides.lua` supplies Static Translation Corrections for Quest and Item lookups on
TBC, Wrath, Cata, and Mists. It does not apply on Vanilla. Its rows replace whole lookup rows:
a name-only quest override clears any old translated objectives. The input adapter in
`generator/l10n-inputs.lua` preserves that behavior with explicit field clearing.

The files retain their executable Questie format, including locale guards and loader calls.
The adapter executes them in a private environment; they are not runtime-loaded through a TOC.
The original Titan function in `lookupOverrides.lua` is retained as part of the byte-identical
import, but is not invoked by Generation. Titan Dynamic Translation Corrections already live
in `src/l10n/Titan/zhCN.lua` and remain selected by the runtime flavor/season gate.

## Import provenance

The initial 181 Lua files were copied byte-for-byte from `Questie/Questie` commit
`215b0c757e2cefdffc11414b2c70456e37573cc2`:

- 180 files from `Localization/lookups/<Expansion>/lookup<Type>/<locale>.lua`.
- `Localization/lookups/lookupOverrides.lua`.

Only the directory prefix changed. No UI translations, zone/category names, or upstream test
files were imported. Future local revisions are identified by the producing QuestieDB commit.
The retained `QUESTIE_COMMIT` and artifact `questieCommit` stamp identify the remaining legacy
import/schema baseline, not an external localization checkout used during Generation.

## Validation during migration

The migration fidelity test still compares these local inputs with independent pinned Questie
lookups, across all five flavors, four entity types, and nine locales. It will reject semantic
translation changes until the migration checks are deliberately updated or retired. Advancing
`QUESTIE_COMMIT` does not overwrite or refresh this directory.

```sh
# No Questie checkout needed. Exercises local Generation/Reconstruction and missing inputs.
lua5.1 tools/localization-inputs.test.lua

# Requires an isolated Questie checkout at QUESTIE_COMMIT for the migration oracle.
QUESTIE_PATH=/path/to/pinned/Questie lua5.1 test.lua localization-overrides translation-corrections titan-translations
```
