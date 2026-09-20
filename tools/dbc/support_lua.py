"""Read owned numeric ZoneDB support literals without executing Lua providers."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from rewrite import Tables, _lex


@dataclass
class SupportTable:
    """Values, original long-string payload and source-preserving insertion offsets."""

    values: dict[int, int]
    literal: str
    closing: int
    missing_comma_at: Optional[int]


def read_support_tables(source: str, name: str) -> tuple[SupportTable, SupportTable]:
    """Read one base/override pair; reject computed values and extra module-side writes.

    Accept the owned ZoneDB module shape only. Preserve long-string comments and
    delimiters for candidates; callers validate the field-specific ID semantics.
    """
    tokens = _lex(source)
    header = ['local', 'ZoneDB', '=', 'QuestieLoader', ':', 'ImportModule', '(', '"ZoneDB"', ')']
    if [t.text for t in tokens[:len(header)]] != header:
        raise ValueError("Unsupported ZoneDB support module header")
    tables = {}
    index = len(header)
    while index < len(tokens):
        group = tokens[index:index + 7]
        if (len(group) != 7 or [t.text for t in group[:4]] != ['ZoneDB', '.', 'private', '.']
                or group[5].text != '=' or group[6].kind != 'long'):
            raise ValueError("ZoneDB support must contain only two literal deferred tables")
        field, payload = group[4].text, group[6]
        if field not in (name, name + "Override") or field in tables:
            raise ValueError("Unexpected or duplicate ZoneDB support table: " + field)
        inner = _lex(source[payload.content_start:payload.content_end], payload.content_start)
        if not inner or inner[0].text != 'return' or inner[-1].text != '}':
            raise ValueError("ZoneDB support payload must return one literal table")
        parsed = Tables(source, inner)
        fields = parsed.fields((1, len(inner)))
        values = {}
        for entry in fields:
            if entry.position is not None:
                raise ValueError("ZoneDB support needs explicit integer keys")
            key, value = parsed.integer(entry.key), parsed.integer(entry.value)
            if key < 0 or key in values:
                raise ValueError("Invalid or duplicate ZoneDB support entry")
            values[key] = value
        comma = None
        if fields and inner[-2].text not in (',', ';'):
            comma = inner[fields[-1].value[1] - 1].end
        tables[field] = SupportTable(values, payload.text, inner[-1].start, comma)
        index += 7
    if len(tables) != 2:
        raise ValueError("ZoneDB support requires both base and override tables")
    return tables[name], tables[name + "Override"]
