# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

This is a **single-context** repo: one `CONTEXT.md` and one `docs/adr/` at the root.

## Before exploring, read these

- **`CONTEXT.md`** at the repo root — the glossary.
- **`DESIGN.md`** at the repo root — the architecture as designed and its rejected alternatives. The implementation exists; later accepted ADRs supersede the original design where they differ.
- **`docs/storage-format.md`** — the on-disk TOC contract, including the nil/empty rules. Read this before writing anything that encodes or decodes entity data.
- **`docs/adr/`** — read ADRs that touch the area you're about to work in.

If any of these files don't exist, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The `/domain-modeling` skill (reached via `/grill-with-docs` and `/improve-codebase-architecture`) creates them lazily when terms or decisions actually get resolved.

## File structure

```
/
├── CONTEXT.md
├── DESIGN.md
├── docs/
│   ├── adr/
│   │   ├── 0001-toc-metadata-as-entity-storage.md
│   │   └── 0002-source-and-baked-modes.md
│   └── table.freeze.md
└── ...
```

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term as defined in `CONTEXT.md`. Don't drift to synonyms the glossary explicitly avoids.

Some avoided terms matter more than others here, because they name things that were deliberately retired: prefer **Correction Overlay** over "runtime override", **Generation** over "compilation", and **Static / Dynamic Correction** over "baked" or "conditional" fix.

If the concept you need isn't in the glossary yet, reconsider whether it needs a new name.
For a genuine domain concept, use the `domain-modeling` skill to record a concise definition.
Keep the glossary free of file paths, commands, migration status, and implementation decisions;
those belong in operational docs or, when the trade-off warrants one, an ADR.

## Check the rejected alternatives before proposing a change

`DESIGN.md` has a **Rejected alternatives** section recording designs that were seriously considered and turned down, with the reason. Read it before proposing an architectural change — several of the rejected options are attractive enough to be re-derived independently.

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradicts ADR-0002 (source and baked modes) — but worth reopening because…_

## Relationship to Questie

QuestieDB is a separate project from Questie, tightly coupled but independently released. Storage vocabulary stops at the boundary: Questie has no terms for metadata fields, chunked values, or Generation.

The governing rule, from `CONTEXT.md`:

> **QuestieDB owns what is true about game entities. Questie owns what to do with that truth.**
