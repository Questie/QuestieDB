# Packaging and releases

This directory owns release ZIPs, changelogs, and verified release installation.
Run commands from the repository root. For setup and platform requirements, see
[local packaging](../../README.md#local-packages-on-linux-macos-and-windows).

| File | Responsibility |
| --- | --- |
| [`package.py`](package.py) | Validate generated inputs, stage and hash ZIPs, write `release.json` and `RELEASE_NOTES.md` |
| [`release_notes.py`](release_notes.py) | Collect changelog entries and render release notes |
| [`release_artifacts.py`](release_artifacts.py) | Verify the release handoff and return the approved archives for reporting or publication |
| [`release.py`](release.py) | Select tags, check GitHub release state, and publish verified artifacts |
| [`preview.py`](preview.py) | Render verified archive contents and the packaged release description |
| [`strip-static.lua`](strip-static.lua) | Strip Static Correction bodies from staged copies and verify behavior parity |
| [`bootstrap.py`](bootstrap.py) | Download, verify, and install the combined release archive |

## Release manifest

See the [shared release metadata format](../../docs/release-format.md) for project-neutral
composition rules. The details below describe QuestieDB's packaging.

`release.json` separates addon-manager downloads from provider metadata:

- Root `releases` lists the ZIPs actually packaged. Each entry has `filename`, `nolib`, and
  `metadata`, with one `{ "flavor": "classic", "interface": 11508 }` pair per declared
  interface version in its packaged TOCs. Per-flavor ZIPs list only their own declarations;
  the combined ZIP lists all included flavors. Interface values are integers, not strings.
- `questiedb` contains the entire provider manifest: `repository`, `producerCommit`,
  `version`, `contractVersion`, `minSupportedContract`, `builtAt`, `nolib`, `artifacts`, and
  `changelog`. All fields are wrapped unchanged, including additional fields rather than a
  fixed subset.

Addon-manager flavor identifiers follow Questie's release conventions: `Vanilla` → `classic`,
`TBC` → `bcc`, `Wrath` → `wrath`, `Cata` → `cata`, and `Mists` → `mists`. Internal labels in
`questiedb.artifacts` stay unchanged. Each artifact still includes its `file`, `flavor`,
`sha256`, `bytes`, and `rawBytes`; the manager-facing entries do not replace that information.

`questiedb.repository` is the HTTPS source repository URL without a trailing slash. It comes
from `GITHUB_REPOSITORY` (default `Questie/QuestieDB`) and is also used for release-note links.

`questiedb.producerCommit` identifies this QuestieDB build and its owned inputs. New manifests
do not contain the retired `questieCommit` migration stamp.
A combined Questie release can supply its own root `releases` and `questie` metadata while
copying the selected provider's complete `questiedb` object unchanged, including unknown fields.
It can then use `questiedb.artifacts` to verify the provider ZIP and `questiedb.changelog` to
render its changes without reconstructing provider metadata.

Bootstrap and the shared release verifier read the nested `questiedb` object only. The former
flat manifest format is not accepted; update consumers alongside this format change before
publishing. ZIP names, contents, and release-selection policies are unchanged.

## Changelog entries

Use Questie's bracketed commit-subject prefixes to opt user-facing changes into the changelog:

| Prefix | Release section |
| --- | --- |
| `[feature]` | New features |
| `[fix]` | General fixes |
| `[quest]` | Quest fixes |
| `[db]` | Database fixes |
| `[locale]` | Localization fixes |

For example: `[db] Corrected spawn locations for …`. Prefixes are case-insensitive and must
start the subject. Entries retain their authored wording and sort alphabetically within each
section. Untagged subjects, commit bodies, and conventional subjects such as `fix: …` are omitted.
When squash-merging, put the prefix in the final squash commit's subject.

Use these prefixes only for changes users should know about. Leave internal refactoring,
tests, CI, release tooling, and documentation maintenance untagged.

### Selecting the release history

Both stable and preview changelogs start after the highest reachable stable `vX.Y.Z` tag.
Previews include the upcoming release's cumulative changes, not just changes since the previous
preview. For an upcoming version without its own stable tag, the same commit produces identical
stable and preview changelog entries.
Full releases exclude their own version tag so an override still includes that release's changes.
The first release uses all history. Preview, beta, and legacy `build-*` tags never form a boundary.
An empty selection says that no entries were marked, not that nothing changed; the notes also link
to the full comparison or commit history. Release packaging fetches complete history and tags.
Local packages without Git or with shallow history explicitly report an unavailable changelog.

### Packaged and structured changelogs

The same collected entries produce the GitHub release notes, `QuestieDB/CHANGELOG.md` inside
every ZIP, and the `questiedb.changelog` array in `release.json`. This is the current release's
changelog, not a cumulative history or a flavor-specific subset. Within `questiedb`, the array
is the last field so build metadata and ZIP checksums remain visible first:

```json
"changelog": [
  {
    "category": "db",
    "text": "Correct quest prerequisites.",
    "commit": "0123456789abcdef0123456789abcdef01234567",
    "author": "Muehe",
    "coAuthors": ["Logonz"]
  }
]
```

Categories are `feature`, `fix`, `quest`, `db`, and `locale`, in that order, with entries sorted
alphabetically within each category. `text` retains the authored subject without its prefix.
An empty selection or unavailable Git history produces `[]`; the Markdown explains which
case occurred. No build metadata or checksums are mixed into these entries.

Consumers can append a separate QuestieDB section after their own changelog without parsing
Markdown. JSON readers should use field names, not rely on key order.

### Author credits and privacy

Each entry's `commit` is its full commit SHA. `author` is the primary Git author, not the
committer. `coAuthors` contains names from valid `Co-authored-by: Name <email>` trailers,
in trailer order, or `[]` when absent. Repeated names and the primary author's name are
omitted from that list, ignoring case. Identity email fields are never exported.

Display names are untrusted too. Credits accept Unicode letters, marks, numbers, ASCII spaces,
and limited name punctuation (periods, underscores, hyphens, apostrophes, commas, brackets,
and parentheses). Address syntax, encoded-address syntax, and control characters are rejected
rather than partially stripped. An unsafe primary name becomes `Contributor`; unsafe co-author
names are omitted. This conservative policy can omit unusual legitimate aliases. The filter
applies before both JSON and Markdown rendering. It is not a general redactor for arbitrary
obfuscations or emails deliberately written in changelog subjects; review those as user-facing text.

The Markdown credits each accepted name with a link to the commit; names are not assumed to be
GitHub usernames, and no API lookup is needed. Simple consumers can use only `author`; others
can include `coAuthors`.

Git signature diagnostics are explicitly disabled when collecting entries because they can
contain signer emails. Parsed record boundaries and commit SHAs are validated before export.

## Dry runs

Manual **Actions → Release → Run workflow** runs default to all checkboxes unchecked. Select
the default branch and use `--release-build` to choose stable rather than development versioning.
Leave `--publish` unchecked to inspect the build without modifying tags or GitHub releases.
Automatic default-branch pushes still publish the development preview.

| `--release-build` | `--publish` | Result |
| --- | --- | --- |
| Unchecked | Unchecked | Build and preview a development build |
| Checked | Unchecked | Build and preview a stable release |
| Unchecked | Checked | Publish the development preview |
| Checked | Checked | Publish a stable release |

`--replace` additionally permits overwriting an existing stable version when publishing.
The checkbox labels are `--release-build`, `--publish`, and `--replace`; their workflow input IDs
are `release`, `publish`, and `override`, respectively. These labels are not CLI options.
The former `dry_run` input is removed.

A dry run executes the same generation, validation, and packaging
pipeline. It then verifies the downloaded release handoff and displays ZIP paths, file sizes,
checksums, and the packaged release description in the **Preview dry-run release** job summary.
No tags or GitHub releases are created or changed. Existing version tags/releases are allowed,
so inspecting an already-published version does not require `--replace` or a version bump.

Download these Actions artifacts from the run page (retained for seven days):

- **release-dist**: the actual per-flavor and combined ZIPs, `release.json`, and `RELEASE_NOTES.md`.
- **release-dry-run-preview**: `DRY_RUN.md`, including ZIP listings and the rendered description.

The description's release download links are not links to the dry-run artifacts. They may not
exist yet or may point to an older published release. If the report exceeds GitHub's 1 MiB
summary limit, the summary points to the complete downloadable report instead of truncating it.

You can inspect existing local packages without generation, installation, or network access:

```sh
uv run tools/distribution/preview.py .out/dist
```

Dry runs do not test GitHub publication permissions, tag rules, or release replacement. To
publish, start a new manual run with `--publish` checked. This rebuilds from the current
default-branch commit; it does not promote the previous run's artifacts. Rerunning a dry run
retains its original inputs and will not publish.

## Publishing

To publish a stable release:

1. Set `## Version: X.X.X` in `QuestieDB.toc` and commit it to the default branch. Use three
   numeric components without leading zeros. TOC regeneration preserves this maintained value.
2. Open **Actions → Release → Run workflow**, select the default branch, and check `--release-build`.
3. Check `--publish` to enable publication. Leave it unchecked if you only want to inspect the build.
4. Leave `--replace` unchecked. For publication, an existing `vX.X.X` tag or release fails before
   building, and publication checks again after all quality gates pass.

`--replace` explicitly replaces that version's assets and moves its tag to the selected commit.
Use it only to repair a release; normally bump the version instead. GitHub-immutable releases
cannot be overridden. Repository-wide release immutability is incompatible with rolling preview.

Baked addon versions are `X.X.X` for stable releases and `X.X.X-dev.<short SHA>` otherwise.
Local Generation follows the same rule; `QUESTIEDB_RELEASE=true` selects the stable-release form.
The manifest's `questiedb` object and TOCs record the producing QuestieDB commit. It identifies
the owned data, localization, and implementation sources.

### Validation and publication order

The release flow lives in [`.github/workflows/release.yml`](../../.github/workflows/release.yml).
The workflow owns triggers, inputs, permissions, concurrency, quality gates, and artifact transfers.
It invokes `release.py preflight` and `release.py publish` from the checkout root with the
GitHub Actions environment. Both commands check that the GitHub CLI (`gh`) is available on
`PATH` before starting work, including preflight dry runs. They use the same draft-aware
collision check; publication repeats it under the workflow's lock. Source-version parsing remains in `generator/version.lua`.
Use the workflow to publish, rather than invoking the publisher outside its gates and lock.

After choosing the tag, shared checks and the five
[flavor pipelines](../../README.md#independent-test-scopes) run independently. Each flavor runs
Generation, Determinism, scoped tests, Reconstruction, Verification, Equivalence, and validators.
Release reconstructs every flavor; CI reconstructs Vanilla and Mists.
Both verify ownership under freezing on Vanilla and Mists.

Release checks each TOC's checksum before uploading it and again after collecting all five.
Packaging waits for the shared and flavor checks, creates per-flavor and combined ZIPs from
those exact verified TOCs, and never regenerates them. Publication requires successful shared
and flavor checks followed by successful packaging. Only GitHub publication is configured.
Publication jobs queue without cancelling active or pending releases. The publisher checks the
handoff's commit and ZIP checksums before any mutation, then rejects stale preview builds.

Dry-run reporting and publication both use `release_artifacts.verify` to check the nested
`questiedb` metadata: producing commit, complete unique ZIP inventory, SHA-256 checksums, ZIP
readability, and release-note availability. Supported flavors come from the packager. The verifier returns approved ZIPs only
after every check passes; `release.py` uploads that list rather than maintaining a second one.
The verifier's standalone CLI also exposes those paths for other tooling. `preview.py` formats
the verified result and adds no release validation rules.

**Preview publication recreates the GitHub release record.** After artifact, immutability, and
ancestry checks pass, the publisher deletes the existing `preview` release without deleting
its tag, then creates a new draft. ZIPs and notes upload first, the tag moves to the verified
commit, and `release.json` uploads last before the draft becomes public. This gives each preview
a fresh GitHub publication date while retaining the moving `preview` tag and its download URLs.

Recreation removes the old release's reactions, asset IDs, and manually attached assets. Preview
downloads are unavailable between deletion and publication; a failed replacement can leave no
public preview until the same workflow is rerun successfully.

**Stable overrides remain non-atomic in-place updates.** The existing stable release stays
public while ZIPs are replaced by name. Its tag moves after the ZIP uploads; `release.json`
uploads last. Downloads during an update may fail, and interruption can leave mixed assets or
a tag ahead of the manifest. Bootstrap rejects checksum mismatches before installing; direct
ZIP downloads do not have that protection. First publication uses a draft until every asset
is uploaded. Build/check failures never touch an existing release.

### Failure recovery and permissions

After a preview publication failure, rerun the failed workflow at the same commit. Do not rerun
an older preview to repair a newer one. For a stable release, dispatch again with `--release-build`,
`--publish`, and `--replace` checked: GitHub reruns retain the original inputs, so they
cannot enable override or turn a dry run into publication.
Review the current default-branch commit and TOC version first; a new dispatch builds that
commit, not necessarily the failed run's commit. Resolve tag-rule or permission errors before
retrying. Divergent preview history (for example after a force-push) requires deliberate tag
repair; the workflow will not guess which history to keep. Existing `build-*` releases are
left alone. Stable overrides also retain unrelated manually attached assets; preview recreation
does not.

Repository tag rules must allow the workflow token to create release tags and move `preview`
(and version tags only when overriding). The preflight job needs Contents write permission to
see drafts, but only reads GitHub state. No live publication is covered by the offline tests;
GitHub permissions and replacement behavior should first be exercised in a disposable repository,
not against an installed development or production channel.

## Tests

Run from the repository root:

```sh
uv run tools/distribution/package.test.py
uv run tools/distribution/bootstrap.test.py
uv run tools/distribution/release_artifacts.test.py
uv run tools/distribution/release.test.py
uv run tools/validation/version.test.py
```

Tests use disposable fixtures, not live releases or installed addons. `release.test.py` tests
preflight, collision races, preview ordering, immutable releases, and interrupted publication
with a fake GitHub CLI; it never invokes the real `gh` command. The packaging suite
requires Lua 5.1; Git-history tests need Git. The signed-commit fixture additionally needs
`ssh-keygen` and Git with SSH signing support; it creates a temporary key, not a personal one.

Adversarial credit cases live in [`fixtures/author-credits.json`](fixtures/author-credits.json).
The tests exercise real Git parsing and check the manifest, release notes, and ZIP changelogs,
as well as individual name validation. Signature diagnostics and malformed Git output have
separate tests in [`package.test.py`](package.test.py).
