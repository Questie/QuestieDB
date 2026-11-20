# Native TOC flavor selection

Historical research snapshot. The recommendations and parser questions below predate the
implementation. See [Forever](forever.md) for the current legacy-exclusion selection, underscore
filenames, Anniversary's all-unknown allow-list failure and remaining acceptance checks.

Research date: 2026-09-18. Recommendation: use explicit file-line game-type conditions in the
Source TOC, after a small client acceptance check. Keep Baked TOCs flavor-specific and their
metadata unconditional. Do not rename owned source directories merely to use `[Game]`.

## Evidence and scope

Gethe mirrors Blizzard UI source, not the native TOC parser. All four refreshes reported
`FetchStatus: current`; commits were rechecked before citation. No live client was available.
These are source identities, not verified identities of the user's running clients.

| Branch | Commit | Commit subject |
| --- | --- | --- |
| `classic_era` | `33e177d9bf38d76d5c6c6e05d5da78db1899659a` | `1.15.9 (69722)` |
| `forever` | `70ef1b2fd78061a73f886c4a1e79dc5b5cff6d5e` | `1.60.1 (69913)` |
| `classic` | `ecadf9d3326fa87828cacca7f13c0ab5f41840a6` | `5.5.4 (69585)` |
| `classic_titan` | `84ef503f0d2617494db84cc9c7e7b530e976f6e7` | `3.80.2 (69874)` |

### What Blizzard's files establish

- Era's [Classic UI panels TOC][era-panels] declares `AllowLoadGameType: classic`, then selects
  Vanilla versus TBC/Wrath/Cata/Mists merchant files with per-line `AllowLoadGameType` conditions.
  This is a concrete Classic load path, not an unrelated Mainline file found in the checkout.
- Era's [Classic tradeskill TOC][era-tradeskill] combines `[Game]` with explicit conditions.
  Its Wrath/Cata paths remain explicit where two game types share an implementation.
- Mists' [Classic minimap TOC][mists-minimap] both allows individual Classic game types and
  excludes Vanilla from two tracking files. `ExcludeLoadGameType` is not only a Mainline example.
- Titan's [Classic UI panels TOC][titan-panels] uses the same Classic conditions. Its
  [Wrath constants][titan-constants] assign `WOW_PROJECT_ID = WOW_PROJECT_WRATH_CLASSIC` (`11`);
  Titan is not a separate expansion identity in that code.
- Forever's [Token UI TOC][forever-token] and [FrameXML base TOC][forever-base] select
  Forever-only files with a game-type allow list and exclude them from the alternate files.
- Forever also contains a [conditional metadata directive][forever-metadata]. That does not
  establish availability on older Classic clients. The user's quoted version notes distinguish
  file support from later metadata support; do not adopt conditional entity metadata implicitly.

These implementation examples are not a live test of third-party addon loading. Unknown tokens,
duplicate-path handling and future renaming remain native-parser questions.

## Proposed QuestieDB shape

```toc
data\Classic\classicQuestDB.lua [AllowLoadGameType vanilla]
data\Forever\foreverQuestDB.lua [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]
```

Generate conditions from explicit flavor applicability, not folder names.

- Filter raw entity and support payloads before Lua execution. This should avoid parsing and
  allocating other flavors' large Lua payloads; the amount saved requires measurement.
- Native-selected small initialization files could establish the active Source flavor before
  the backend loads, replacing numeric Interface checks. Preserve loader setup/teardown order.
- Replace redundant cross-flavor discard logic once selection is proven, rather than adding a
  second permanent flavor policy. Keep normalization, lazy materialization and the loader shim.
- Preserve **cumulative legacy Corrections**: Era providers apply to Vanilla, TBC, Wrath, Cata
  and Mists, while Forever's owned providers apply only to Forever. An `Era` folder does
  not mean `[AllowLoadGameType vanilla]`. SoD/Titan season and faction gates still belong in Lua.
- Prefer explicit conditions over `[Game]` paths: owned directories use `Classic`, `Wotlk`,
  `MoP` and `Forever`, while native names include `Vanilla`, `Wrath` and `Mists`.
  `[Family]` is also not a substitute for QuestieDB's data-flavor mapping.
- Keep Baked metadata and filenames unchanged. Already-specialized Baked file lists need no
  extra condition just because Source mode benefits from it.
- Do not locale-filter stored translations, `l10n/lookupOverrides.lua` (one file for every
  locale) or Dynamic Translation Correction files such as `src/l10n/Titan/zhCN.lua`.
  `LibQuestieDB.l10n.SetLocale()` may select a locale different from the client's text locale;
  loading only `[TextLocale]` would change that public contract.
- Source mode's raw lookup files are the exception. Each one's `GetLocale()` guard already
  discards it on any other locale, and Source mode never serves another locale's Base
  translations. Their lines therefore add `[AllowLoadTextLocale <locale>]`, which only spares
  the client from parsing them. See [Text-locale conditions](#text-locale-conditions).

## Tooling and acceptance

`emulator/metadata.lua:loadAddon` currently treats the whole file-reference line as a path.
The emulator must evaluate the supported condition subset against an explicit game-type persona.
TOC-list tests and config-based file discovery must distinguish paths from conditions too.
`tools/distribution/package.py:read_source` also treats the line as a literal path: teach it the
same supported semantics if conditions reach packaged TOCs, or keep Baked output resolved to
plain paths. Do not silently strip a condition while including an inapplicable file.

Before replacing existing gates, use a disposable addon on the relevant clients to check
positive/negative selection, ordering and Forever identity. Probe mixed known/unknown tokens
before rename-forward compatibility. Compare loaded files with the emulator. No live probe ran here.

## Text-locale conditions

Research date: 2026-11-19. Blizzard source and wiki evidence only; no live client was available.

Source-mode raw lookups combine both conditions, for example:

```toc
l10n\Forever\lookupQuests\deDE.lua [ExcludeLoadGameType vanilla, tbc, wrath, cata, mists] [AllowLoadTextLocale deDE]
```

- **Several conditions per line, combined with AND.** The [TOC format][toc-format] page says
  multiple inline directives can be used per line. Blizzard's Era 1.15.9 TOCs combine them
  ([fonts][era-fonts-multi], [Edit Mode][era-editmode-multi]); Anniversary, Mists and Titan
  carry the same lines. Forever's [Blizzard_Game][forever-startup] loads one of two
  `Startup.lua` files with `[AllowLoadGameType classic, mainline] [ExcludeLoadGameType vanilla, camelot]`,
  which is coherent only as AND.
- **`AllowLoadTextLocale` on Classic.** Its values are those `GetLocale()` returns. The wiki adds
  it in Mainline 11.2.0 and records that Era 1.15.8, Anniversary 2.5.5, Titan 3.80.0, Mists 5.5.1
  and Forever 1.60.1 include that change. The wiki records `ExcludeLoadGameType`, which the Source
  TOC already needs on legacy clients, as later (12.0.0). Forever's
  [declension frame][forever-declension] uses `[AllowLoadTextLocale ruRU]` with game-type conditions.
  No suffix-form use exists in the Era, Anniversary, Mists or Titan sources.
- **Unknown directives are undocumented.** A client that does not recognize the directive could
  ignore it or treat the file as missing. Ignoring it loads every locale's lookups, which their
  guards then discard. Treating it as missing loses Source Base translations on that client.
  The wiki's last Cata Classic entry, 4.4.1, includes Modern changes only up to 11.0.0, before
  inline file conditions (11.1.5), and it lists no Wrath 3.4 (Interface 30405) entry. Source
  selection on those clients already depends on unverified behavior.
- **The guards and the condition read different things.** A guard calls the global `GetLocale()`;
  the condition uses the client's text locale. An addon that replaces `GetLocale` before
  QuestieDB loads no longer selects another locale's Source lookups.

Live acceptance should confirm, per supported client, that only the client locale's lookups load
and that Source Base translations still appear on a non-English client.

## Interface values are a separate maintenance question

`src/config.lua` lists Wrath as `38000, 38001`; the user's table lists Wrath `30405` and Titan
`38002`. The refreshed Titan source identifies build **3.80.2**, consistent with the latter but
not a live Interface read. [GetBuildInfo][build-api] returns `interfaceVersion` fourth. Verify
supported installations and update the list separately: Interface does not define the game-type
token. No historical Wrath client was inspected; this does not justify adding Mainline support.

[era-panels]: https://github.com/Gethe/wow-ui-source/blob/33e177d9bf38d76d5c6c6e05d5da78db1899659a/Interface/AddOns/Blizzard_UIPanels_Game/Blizzard_UIPanels_Game_Classic.toc#L1-L62
[era-tradeskill]: https://github.com/Gethe/wow-ui-source/blob/33e177d9bf38d76d5c6c6e05d5da78db1899659a/Interface/AddOns/Blizzard_TradeSkillUI/Blizzard_TradeSkillUI_Classic.toc#L1-L8
[mists-minimap]: https://github.com/Gethe/wow-ui-source/blob/ecadf9d3326fa87828cacca7f13c0ab5f41840a6/Interface/AddOns/Blizzard_Minimap/Blizzard_Minimap_Classic.toc#L1-L18
[titan-panels]: https://github.com/Gethe/wow-ui-source/blob/84ef503f0d2617494db84cc9c7e7b530e976f6e7/Interface/AddOns/Blizzard_UIPanels_Game/Blizzard_UIPanels_Game_Classic.toc#L1-L62
[titan-constants]: https://github.com/Gethe/wow-ui-source/blob/84ef503f0d2617494db84cc9c7e7b530e976f6e7/Interface/AddOns/Blizzard_FrameXMLBase/Wrath/Constants.lua#L118-L124
[forever-token]: https://github.com/Gethe/wow-ui-source/blob/70ef1b2fd78061a73f886c4a1e79dc5b5cff6d5e/Interface/AddOns/Blizzard_TokenUI/Blizzard_TokenUI.toc#L1-L8
[forever-base]: https://github.com/Gethe/wow-ui-source/blob/70ef1b2fd78061a73f886c4a1e79dc5b5cff6d5e/Interface/AddOns/Blizzard_FrameXMLBase/Blizzard_FrameXMLBase.toc#L15-L26
[forever-metadata]: https://github.com/Gethe/wow-ui-source/blob/70ef1b2fd78061a73f886c4a1e79dc5b5cff6d5e/Interface/AddOns/Blizzard_MainMenuBarBagButtons/Blizzard_MainMenuBarBagButtons.toc#L1-L6
[build-api]: https://github.com/Gethe/wow-ui-source/blob/70ef1b2fd78061a73f886c4a1e79dc5b5cff6d5e/Interface/AddOns/Blizzard_APIDocumentationGenerated/BuildDocumentation.lua#L10-L20
[toc-format]: https://warcraft.wiki.gg/wiki/TOC_format
[era-fonts-multi]: https://github.com/Gethe/wow-ui-source/blob/4192ac60067fc55566182291bc67c85dd9b6794d/Interface/AddOns/Blizzard_Fonts_Shared/Blizzard_Fonts_Shared.toc#L6-L7
[era-editmode-multi]: https://github.com/Gethe/wow-ui-source/blob/4192ac60067fc55566182291bc67c85dd9b6794d/Interface/AddOns/Blizzard_EditMode/Blizzard_EditMode.toc#L5-L9
[forever-startup]: https://github.com/Gethe/wow-ui-source/blob/3d8abb1da73acd38e412e24fb3f99454a6392346/Interface/AddOns/Blizzard_Game/Blizzard_Game.toc#L45-L46
[forever-declension]: https://github.com/Gethe/wow-ui-source/blob/3d8abb1da73acd38e412e24fb3f99454a6392346/Interface/AddOns/Blizzard_DeclensionFrame/Blizzard_DeclensionFrame.toc#L4-L9
