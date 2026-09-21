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
The original Titan function in `lookupOverrides.lua` is not invoked by Generation. Titan Dynamic Translation Corrections already live
in `src/l10n/Titan/zhCN.lua` and remain selected by the runtime flavor/season gate.

## Ownership

These files were originally imported from Questie's entity lookups. Their current revision is
identified by the producing QuestieDB commit. Edit them directly; no external checkout, pin,
or upstream fidelity baseline is required. [PROVENANCE.md](../PROVENANCE.md) records the historical
Questie source reference and paths. The [migration checkpoint](../docs/adr/0014-owned-data-after-migration.md)
preserves the original import evidence.

## Validation

```sh
# Local Generation/Reconstruction and missing-input protection.
uv run --no-project python tools/validation/localization-inputs.test.py
lua5.1 test.lua localization-overrides translation-corrections titan-translations
```

Shared behavior fixtures cover locale precedence, replacement, and withdrawal. Generate the
affected flavor and run its [artifact tests](../README.md#independent-test-scopes) to exercise
Baked reads. Source mode does not load ordinary Base translations.
