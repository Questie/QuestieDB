"""Reader-facing release notes and Questie-style opt-in commit changelogs."""
from __future__ import annotations

from pathlib import Path
import re
import subprocess


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


def changelog(root: Path, version: str, commit: str, repository_url: str) -> str:
    """Collect marked subjects since the highest reachable stable version, without fetching.

    Full releases exclude their own tag so an override retains the release's changes.
    Preview and legacy build tags never define a changelog boundary. Local packages with
    missing or shallow history explicitly report that no complete changelog is available.
    """
    if commit == "0" * 40:
        return "Changelog unavailable: this package was built without Git history.\n"

    def git(*args: str) -> str:
        return subprocess.run(["git", "-C", str(root), *args], check=True,
                              capture_output=True, text=True, encoding="utf-8").stdout.strip()

    history_link = f"[Commit history]({repository_url}/commits/{commit})"
    if git("rev-parse", "--is-shallow-repository") == "true":
        return f"Changelog unavailable: this checkout has shallow Git history.\n\n{history_link}\n"

    tags = [tag for tag in git("tag", "--merged", commit).splitlines()
            if STABLE_TAG.fullmatch(tag) and tag != f"v{version}"]
    baseline = max(tags, key=lambda tag: tuple(map(int, tag[1:].split("."))), default=None)
    revision = f"{baseline}..{commit}" if baseline else commit
    subjects = git("log", "--format=%s", revision, "--").splitlines()
    groups: dict[str, list[str]] = {key: [] for key in CATEGORIES}
    for subject in subjects:
        match = re.match(r"^\[([^]]+)\]\s*(.+)$", subject)
        if match and match[1].lower() in groups and match[2].strip():
            groups[match[1].lower()].append(match[2].strip())

    sections = []
    for category, heading in CATEGORIES.items():
        if groups[category]:
            entries = "\n".join(f"- {entry}" for entry in sorted(groups[category]))
            sections.append(f"### {heading}\n\n{entries}")
    if not sections:
        sections.append("No changelog entries were marked for this release.")
    if baseline:
        sections.append(f"[All changes since {baseline}]({repository_url}/compare/{revision})")
    else:
        sections.append(history_link)
    return "\n\n".join(sections) + "\n"


def render(version: str, commit: str, questie_commit: str, minimum_contract: int,
           contract: int, files: list[str], changes: str, repository_url: str) -> str:
    """Render notes for the actual packaged assets, with preview warnings bracketing the body."""
    preview = "-dev." in version
    tag = "preview" if preview else f"v{version}"
    download_url = f"{repository_url}/releases/download/{tag}"
    warning = (
        "> [!WARNING]\n"
        "> **Unstable Pre-Release Build. For testing only.**\n"
        "> This rolling development build may contain bugs or breaking changes. "
        "Its downloads are replaced as development continues.\n"
        f"> For normal use, download the [latest stable release]({repository_url}/releases/latest).\n"
    )
    title = "Unstable Pre-Release Build" if preview else f"QuestieDB {version}"
    sections = [f"# {title}"]
    if preview:
        sections.append(warning.rstrip())
    sections.extend([
        "QuestieDB provides quest, NPC, item, and object data for addons such as Questie. "
        "It is a database addon, not a standalone quest tracker.",
        "## What's new\n\n" + changes.rstrip(),
    ])

    downloads = ["## Download"]
    if "QuestieDB-all.zip" in files:
        downloads.append(
            f"**Recommended: [QuestieDB-all.zip]({download_url}/QuestieDB-all.zip)**\n\n"
            "Includes all five game flavors. Your client automatically loads the matching database."
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
    downloads.append("Use one addon ZIP. GitHub's **Source code** archives are not the packaged addon.")
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
    producer = f"[`{commit[:7]}`]({repository_url}/commit/{commit})" if commit != "0" * 40 else "Unavailable"
    baseline = (f"[`{questie_commit[:7]}`](https://github.com/Questie/Questie/commit/{questie_commit})"
                if questie_commit != "0" * 40 else "Unavailable")
    sections.append(
        "<details>\n<summary>Build details and checksums</summary>\n\n"
        f"- Addon version: `{version}`\n"
        f"- Producing commit: {producer}\n"
        f"- Legacy Questie baseline: {baseline}\n"
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
