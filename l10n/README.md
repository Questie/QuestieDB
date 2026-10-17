# Entity localization sources

QuestieDB owns these Generation inputs. Generation and Reconstruction read this directory
without checking out Questie. Baked release packages contain the generated Localization blocks,
not these raw files. Source mode loads them directly for the client locale.

## Layout

Each of `Classic`, `TBC`, `Wotlk`, `Cata`, `MoP`, and `Forever` contains:

- `lookupQuests/`: quest names and objective text.
- `lookupNpcs/`: NPC names and subnames.
- `lookupItems/`: item names.
- `lookupObjects/`: object names.

Each entity directory has nine locale files: `deDE`, `esES`, `esMX`, `frFR`, `koKR`, `ptBR`,
`ruRU`, `zhCN`, and `zhTW`. English comes from the base entity data.

`lookupOverrides.lua` supplies Static Translation Corrections for Quest and Item lookups on
TBC, Wrath, Cata, and Mists. It does not apply on Vanilla or Forever. Its rows replace whole
lookup rows: a name-only quest override clears any old translated objectives. The input adapter in
`generator/l10n-inputs.lua` preserves that behavior with explicit field clearing.

`Forever/traces/` holds trace-generated lookups in the same layout as the base directories
(`lookupQuests/<locale>.lua`, and so on). Generation applies them on top of the `Forever` base
files, merging per field. Trace entries win over base entries, and base entries missing from the
traces stay. Every trace file is optional. Replace the whole `traces/` directory when new trace
data is generated.

The files retain their executable Questie format, including locale guards and loader calls.
Generation executes them in a private environment. Source mode lists them in `QuestieDB.toc`
between `src/l10n/source/_begin.lua` and `_end.lua`, which apply the same layering at runtime;
their locale guards keep only the client locale. Run `lua5.1 generate.lua toc` after adding or
removing a trace file.
The original Titan function in `lookupOverrides.lua` is not invoked by Generation. Titan Dynamic Translation Corrections already live
in `src/l10n/Titan/zhCN.lua` and remain selected by the runtime flavor/season gate.

## Ownership

These files were originally imported from Questie's entity lookups. Their current revision is
identified by the producing QuestieDB commit. Edit them directly; no external checkout, pin,
or upstream fidelity baseline is required. [PROVENANCE.md](../PROVENANCE.md) records the historical
Questie source reference and paths. The [migration checkpoint](../docs/adr/0014-owned-data-after-migration.md)
preserves the original import evidence.

Forever's 36 locale files were seeded from clean `l10n/Classic`. They are independent owned
files, not aliases: future Classic translation changes do not automatically update Forever.
[Forever data provenance](../docs/forever-data.md) records the seed revision and adoption limits.

## Validation

```sh
# Local Generation/Reconstruction and missing-input protection.
uv run --no-project python tools/validation/localization-inputs.test.py
lua5.1 test.lua localization-overrides translation-corrections titan-translations
```

Shared behavior fixtures cover locale precedence, replacement, and withdrawal. Generate the
affected flavor and run its [artifact tests](../README.md#independent-test-scopes) to exercise
Baked reads. `lua5.1 test.lua source-lookups` covers Source-mode lookups.
