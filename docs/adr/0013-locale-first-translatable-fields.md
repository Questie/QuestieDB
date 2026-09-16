# 13. Locale-first reads for translatable fields

Date: 2026-09-05. Status: accepted and implemented.

Entity Corrections are authored in English. Letting a Dynamic Correction outrank localization
therefore replaces an available non-English translation with English, while the same Correction
made Static and folded into base data does not. This category-dependent result is wrong.

For a translatable field, the first available value in this stack wins:

1. When the effective locale is not `enUS`:
   1. an active Dynamic Translation Correction;
   2. the active base translation, with Static Translation Corrections folded in;
2. the corrected entity value;
3. the base entity value.

`enUS` bypasses both translation layers. A missing non-English value falls through to normal
entity resolution: the corrected English value, then the base English value when no Correction
supplies the field. An explicit entity Correction deletion remains authoritative. Entity
Correction owner ordering stays unchanged within the corrected entity layer.

This applies only to Quest `name` and `objectivesText`, Npc `name` and `subName`, and Item and
Object `name`. Other fields, including `requiredRaces`, never enter localization. A translation
cannot make an absent entity exist.

QuestieDB models localization as Base translations, Static Translation Corrections folded into
the generated Localization blocks, and locale-aware Dynamic Translation Corrections. Dynamic
sets are data-shaped slots identified by owner, locale, entity type, and name. They accept any
non-empty locale string other than `enUS`. This leaves the generated Base locale inventory and
`localeIndex` at the existing nine entries while allowing a custom locale to translate registered
fields through the same slots. Locale selection chooses only the active locale's composed rows;
it does not reapply entity Corrections. Titan Reforged zhCN text is a Dynamic Translation
Correction, not an exception to entity Correction precedence. Locale changes invalidate affected
reads and Name indexes, and provenance reports the layer that supplied the returned value.

Questie's pinned localization sources remain migration inputs that QuestieDB can resynchronize;
physically transferring the authored lookup tree is deferred. This decision does not add
ordinary Base translations to Source mode; Dynamic Translation Corrections remain available
there. Moving English text out of entity data and through localization is possible in principle,
but is also deferred.

This supersedes ADR 0003 Decision 8 and the Correction-priority statement in ADR 0011 Decision 3.
