"""Reader-facing release notes and Questie-style opt-in commit changelogs."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import re
import subprocess
from typing import TypedDict
import unicodedata


CATEGORIES = {
    "feature": "New features",
    "fix": "General fixes",
    "quest": "Quest fixes",
    "db": "Database fixes",
    "locale": "Localization fixes",
}
FLAVOR_LABELS = {
    "Vanilla": "Classic Era / Season of Discovery",
    "TBC": "The Burning Crusade Classic / Anniversary",
    "Wrath": "Wrath of the Lich King Classic / Titan Reforged",
    "Cata": "Cataclysm Classic",
    "Mists": "Mists of Pandaria Classic",
}
STABLE_TAG = re.compile(r"v(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)")


class ChangelogEntry(TypedDict):
    category: str
    text: str
    commit: str
    author: str
    coAuthors: list[str]


@dataclass(frozen=True)
class Changelog:
    """One release's entries and Markdown, collected from the same Git history."""

    entries: list[ChangelogEntry]
    markdown: str


def public_credit_name(name: str) -> str | None:
    """Accept plain display names, rejecting suspicious metadata rather than redacting fragments.

    Git names may contain emails. Restrict credits to Unicode letters, marks, numbers,
    ASCII spaces, and limited name punctuation; reject address/encoding syntax and controls.
    This is not a filter for deliberately authored changelog subjects.
    """
    name = name.strip(" ")

    if any(character.isalnum() for character in name) and all(
        unicodedata.category(character)[0] in "LMN" or character in " ._-'’[],()"
        for character in name
    ):
        return name

    return None


def changelog(root: Path, version: str, commit: str, repository_url: str) -> Changelog:
    """Collect marked subjects since the highest reachable stable version, without fetching.

    Full releases exclude their own tag so an override retains the release's changes.
    Preview and legacy build tags never define a changelog boundary. Local packages with
    missing or shallow history explicitly report that no complete changelog is available.
    """
    if commit == "0" * 40:
        return Changelog([], "Changelog unavailable: this package was built without Git history.\n")

    def git(*args: str) -> str:
        # Preserve CR and other embedded controls for credit validation, not newline conversion.
        return (
            subprocess.run(["git", "-C", str(root), *args], check=True, capture_output=True)
            .stdout.decode("utf-8")
            .strip()
        )

    history_link = f"[Commit history]({repository_url}/commits/{commit})"
    if git("rev-parse", "--is-shallow-repository") == "true":
        return Changelog(
            [], f"Changelog unavailable: this checkout has shallow Git history.\n\n{history_link}\n"
        )

    # Select this release's history before collecting any user-facing text.
    tags = [
        tag
        for tag in git("tag", "--merged", commit).splitlines()
        if STABLE_TAG.fullmatch(tag) and tag != f"v{version}"
    ]
    baseline = max(tags, key=lambda tag: tuple(map(int, tag[1:].split("."))), default=None)
    revision = f"{baseline}..{commit}" if baseline else commit

    # Git parses the trailer block so mentions elsewhere in the body are not credited.
    # NUL boundaries keep multi-line trailers separate from subjects and adjacent commits.
    # Signature diagnostics can include signer emails and must never enter these records.
    fields = git(
        "log",
        "--no-show-signature",
        "--no-color",
        "-z",
        "--format=%H%x00%an%x00%s%x00"
        "%(trailers:key=Co-authored-by,valueonly,unfold=true,separator=%x0a)",
        revision,
        "--",
    ).split("\0")
    if fields[-1] != "" or (len(fields) - 1) % 4:
        raise ValueError("Unexpected Git changelog record format")

    # Select marked subjects and filter credits before either output can see them.
    groups: dict[str, dict[str, ChangelogEntry]] = {key: {} for key in CATEGORIES}
    for offset in range(0, len(fields) - 1, 4):
        sha, author, subject, trailers = fields[offset : offset + 4]
        if not re.fullmatch(r"[0-9a-f]{40}", sha):
            raise ValueError("Invalid commit SHA in Git changelog")

        match = re.match(r"^\[([^]]+)\]\s*(.+)$", subject)
        if not match or match[1].lower() not in groups or not match[2].strip():
            continue

        author = public_credit_name(author) or "Contributor"
        co_authors = []
        seen = {author.casefold()}

        for trailer in trailers.split("\n"):
            identity = re.fullmatch(r"([^<>]+?)[ \t]*<[^<>\r\n]+>", trailer.strip(" \t"))
            if identity:
                name = public_credit_name(identity[1])
                if name and name.casefold() not in seen:
                    co_authors.append(name)
                    seen.add(name.casefold())

        category, text = match[1].lower(), match[2].strip()
        entry = groups[category].get(text)
        if entry is None:
            groups[category][text] = {
                "category": category,
                "text": text,
                "commit": sha,
                "author": author,
                "coAuthors": co_authors,
            }
        else:
            # Git visits newest first. Keep that commit link, but credit every contributor
            # to the exact same category/text without merging merely similar wording.
            credited = {name.casefold() for name in [entry["author"], *entry["coAuthors"]]}
            for name in [author, *co_authors]:
                if name.casefold() not in credited:
                    entry["coAuthors"].append(name)
                    credited.add(name.casefold())

    # Both the manifest and Markdown use the same category and entry order.
    entries: list[ChangelogEntry] = []
    sections = []
    for category, heading in CATEGORIES.items():
        if groups[category]:
            group = sorted(groups[category].values(), key=lambda entry: entry["text"])
            entries.extend(group)

            bullets = []
            for entry in group:
                url = f"{repository_url}/commit/{entry['commit']}"
                names = [entry["author"], *entry["coAuthors"]]
                labels = [re.sub(r"([\\`*_{}\[\]()<>!])", r"\\\1", name) for name in names]
                credits = ", ".join(f"[{label}]({url})" for label in labels)
                bullets.append(f"- {entry['text']} ({credits})")

            sections.append(f"### {heading}\n\n" + "\n".join(bullets))
    if not sections:
        sections.append("No changelog entries were marked for this release.")

    if baseline:
        sections.append(f"[All changes since {baseline}]({repository_url}/compare/{revision})")
    else:
        sections.append(history_link)

    return Changelog(entries, "\n\n".join(sections) + "\n")


def render(
    version: str,
    commit: str,
    minimum_contract: int,
    contract: int,
    files: list[str],
    changes: str,
    repository_url: str,
) -> str:
    """Render notes for the actual packaged assets, with preview warnings bracketing the body."""
    preview = "-dev." in version
    tag = "preview" if preview else f"v{version}"
    download_url = f"{repository_url}/releases/download/{tag}"

    # Introduction and changes: previews are unmistakable before the download links.
    warning = (
        "> [!WARNING]\n"
        "> **Unstable Pre-Release Build. For testing only.**\n"
        "> This rolling development build may contain bugs or breaking changes. "
        "Its downloads are replaced as development continues.\n"
        f"> For normal use, download the [latest stable release]({repository_url}/releases/latest).\n"
    )
    title = f"Unstable Pre-Release Build (v{version})" if preview else f"QuestieDB {version}"
    sections = [f"# {title}"]
    if preview:
        sections.append(warning.rstrip())
    sections.extend(
        [
            "**Looking for the Questie quest helper? "
            "[Download Questie here](https://github.com/Questie/Questie/releases/latest).**",
            "QuestieDB is the standalone database used by Questie. "
            "It does not provide quest tracking or map markers on its own. "
            "Install it alongside Questie or another addon that uses its data.",
            "## What's new\n\n" + changes.rstrip(),
        ]
    )

    # Offer only the archives this packaging run actually produced.
    downloads = ["## Download"]
    if "QuestieDB-all.zip" in files:
        downloads.append(
            f"**Recommended: [QuestieDB-all.zip]({download_url}/QuestieDB-all.zip)**\n\n"
            "Includes all game flavors. Your client automatically loads the matching database."
        )
        downloads.append("For a smaller download, choose just your game flavor:")
    else:
        downloads.append("Download the ZIP for your game flavor:")

    rows = ["| Game flavor | Download |", "| --- | --- |"]
    for flavor, label in FLAVOR_LABELS.items():
        filename = f"QuestieDB-{flavor}.zip"
        if filename in files:
            rows.append(f"| {label} | [{filename}]({download_url}/{filename}) |")

    downloads.append("\n".join(rows))
    downloads.append(
        "Use one addon ZIP. GitHub's **Source code** archives are not the packaged addon."
    )
    sections.append("\n\n".join(downloads))

    sections.append(
        "## Installation\n\n"
        "1. Close World of Warcraft.\n"
        "2. If updating, back up any local edits and remove the old `QuestieDB` addon folder.\n"
        "3. Extract the ZIP into your game client's `Interface/AddOns/` directory. "
        "The result should be `Interface/AddOns/QuestieDB/QuestieDB_<Flavor>.toc`, "
        "not a second nested `QuestieDB` folder.\n"
        "4. Start the game and enable **QuestieDB** in the character-selection AddOns list. "
        "Keep Questie or your other consuming addon installed alongside it.\n\n"
        f"**Addon developers:** see the [integration and API documentation]({repository_url}/blob/"
        f"{commit if commit != '0' * 40 else 'HEAD'}/docs/api.md). "
        "LuaLS declarations are included in `QuestieDB/Types/`."
    )

    # Keep provenance and verification instructions out of the user-facing changelog.
    producer = (
        f"[`{commit[:7]}`]({repository_url}/commit/{commit})"
        if commit != "0" * 40
        else "Unavailable"
    )
    sections.append(
        "<details>\n<summary>Build details and checksums</summary>\n\n"
        f"- Addon version: `{version}`\n"
        f"- Producing commit: {producer}\n"
        f"- Supported API contracts: `{minimum_contract}` to `{contract}`\n\n"
        "The attached `release.json` records full commit hashes and each ZIP's SHA-256 checksum. "
        "Compare your download's hash with its entry before installing:\n\n"
        "```sh\nsha256sum QuestieDB-*.zip       # Linux\n"
        "shasum -a 256 QuestieDB-*.zip   # macOS\n```\n\n"
        "```powershell\nGet-FileHash QuestieDB-*.zip -Algorithm SHA256\n```\n\n"
        "</details>"
    )

    # Keep this last so the warning remains visible directly above GitHub's asset list.
    if preview:
        sections.extend(["## Unstable Pre-Release Build", warning.rstrip()])

    return "\n\n".join(sections) + "\n"
