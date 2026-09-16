# .retired

Prototypes QuestieDB was mined from. **Reference material only — never a build input.**

Everything worth keeping has been ported into QuestieDB. These folders are kept because
retiring should be reversible and because they are the only other place some of this reasoning
is written down; they are not kept because anything still needs them.

Copy this file to `.retired/README.md` when running the runbook in
`QuestieDB/docs/retiring-the-prototypes.md`.

## Do not build on `Getters/data/*.lua-table`

That is `GetterDB`'s intermediate output, and **corrections are already applied to it** by the
pipeline QuestieDB replaces. Consuming it would double-apply corrections from the wrong
system. QuestieDB goes raw data → corrections → TOC in one pass, reading Questie's tracked
source files directly.

QuestieDB's test suite fails the build if any of its inputs so much as names a path in here —
see the `no-prototype-inputs` suite in `QuestieDB/test.lua`.

## `Getters/GetterDB` has no remote

It is a nested git repository that exists only on the machine it was written on, and it holds
the serializer and the corrections registry QuestieDB was built from. Being in `.retired`
protects it from a cleanup; it does not protect it from machine loss.

**Push it somewhere off-machine.**

## What was taken from each

| | |
| --- | --- |
| `Getters/GetterDB` | the serializer (`Meta/DumpFunctions.lua`), the corrections registry (`Corrections/Corrections.lua`), and the constant tables the correction files reference |
| `toc-database` | the config-driven pipeline shape, chunked TOC emission (`src/lib.lua`), round-trip verification, and the decoder test |

The full accounting, including what was deliberately rejected and why, is in
`QuestieDB/docs/retiring-the-prototypes.md`.
