"""Rewrite coordinate number tokens without executing or reformatting Lua sources."""
from __future__ import annotations

from dataclasses import dataclass
from bisect import bisect_right
import math
import re
from typing import Callable, Dict, List, Optional, Tuple


@dataclass(frozen=True)
class Coordinate:
    """One authored point; phase values remain outside the conversion interface."""
    area_id: int
    x: float
    y: float
    line: int
    field: str
    entity_id: Optional[int]


@dataclass(frozen=True)
class Token:
    kind: str
    text: str
    start: int
    end: int
    content_start: Optional[int] = None
    content_end: Optional[int] = None


@dataclass(frozen=True)
class Field:
    key: Tuple[int, int]
    value: Tuple[int, int]
    position: Optional[int]


_NUMBER = re.compile(r'(?:0[xX][0-9a-fA-F]+|(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?)')
_NAME = re.compile(r'[A-Za-z_][A-Za-z_0-9]*')
_LONG = re.compile(r'\[(=*)\[')
_SCHEMA = {
    "Npc": ("npc", {"spawns": 7, "waypoints": 8}),
    "Object": ("object", {"spawns": 4, "waypoints": 7}),
    "Quest": ("quest", {"triggerEnd": 9, "extraObjectives": 29}),
    "Item": ("item", {}),
}


def _lex(source: str, offset: int = 0) -> List[Token]:
    tokens = []
    i = 0
    while i < len(source):
        if source[i].isspace():
            i += 1
            continue
        comment = source.startswith('--', i)
        opening = _LONG.match(source, i + 2 if comment else i)
        if opening:
            closing = ']' + opening[1] + ']'
            end = source.find(closing, opening.end())
            if end < 0:
                raise ValueError('Unterminated Lua long string/comment')
            stop = end + len(closing)
            if not comment:
                tokens.append(Token('long', source[i:stop], offset + i, offset + stop,
                                    offset + opening.end(), offset + end))
            i = stop
            continue
        if comment:
            end = source.find('\n', i)
            i = len(source) if end < 0 else end
            continue
        start = i
        if source[i] in ('"', "'"):
            quote = source[i]
            i += 1
            while i < len(source) and source[i] != quote:
                if source[i] == '\\':
                    i += 1
                i += 1
            if i == len(source):
                raise ValueError('Unterminated Lua quoted string')
            i += 1
            kind = 'string'
        else:
            match = _NUMBER.match(source, i) or _NAME.match(source, i)
            if match:
                i = match.end()
                kind = 'number' if _NUMBER.fullmatch(match[0]) else 'name'
            else:
                i += 1
                kind = 'symbol'
        tokens.append(Token(kind, source[start:i], offset + start, offset + i))
    return tokens


class Tables:
    """Balanced table-constructor reader; unrelated Lua expressions remain opaque."""
    def __init__(self, source: str, tokens: List[Token]):
        self.source, self.tokens = source, tokens
        self.matches = {}
        stack = []
        for index, token in enumerate(tokens):
            if token.kind != 'symbol':
                continue
            if token.text in ('(', '[', '{'):
                stack.append(index)
            elif token.text in (')', ']', '}'):
                if not stack or tokens[stack[-1]].text != {')': '(', ']': '[', '}': '{'}[token.text]:
                    self.fail(index, 'Unbalanced Lua delimiters')
                opening = stack.pop()
                self.matches[opening] = index
        if stack:
            self.fail(stack[-1], 'Unclosed Lua delimiter')

    def fail(self, index: int, message: str) -> None:
        """Attach original file line numbers, including nested long-string payloads."""
        position = self.tokens[index].start if index < len(self.tokens) else len(self.source)
        raise ValueError('line %d: %s' % (self.source.count('\n', 0, position) + 1, message))

    def text(self, span: Tuple[int, int]) -> str:
        """Ignore inter-token whitespace/comments for simple symbolic expressions."""
        return ''.join(t.text for t in self.tokens[span[0]:span[1]])

    def fields(self, span: Tuple[int, int]) -> List[Field]:
        """Read one literal table; reject expressions that modify or replace it."""
        start, stop = span
        if start >= stop or self.tokens[start].text != '{' or self.matches.get(start) != stop - 1:
            self.fail(start, 'Expected a literal coordinate table, got ' + self.text(span)[:80])
        fields = []
        index, position = start + 1, 0
        while index < stop - 1:
            key = (index, index)
            implicit = None
            if self.tokens[index].text == '[':
                key_end = self.matches[index]
                if self.tokens[key_end + 1].text != '=':
                    self.fail(index, 'Expected table key assignment')
                key = (index + 1, key_end)
                index = key_end + 2
            elif index + 1 < stop and self.tokens[index].kind == 'name' and self.tokens[index + 1].text == '=':
                key = (index, index + 1)
                index += 2
            else:
                position += 1
                implicit = position
            value_start = index
            while index < stop - 1 and self.tokens[index].text not in (',', ';'):
                index = self.matches[index] + 1 if index in self.matches else index + 1
            if value_start == index:
                self.fail(index, 'Missing table value')
            fields.append(Field(key, (value_start, index), implicit))
            index += 1
        return fields

    def positional(self, span: Tuple[int, int]) -> Dict[int, Tuple[int, int]]:
        """Resolve Lua sequence slots including nil holes and explicit numeric keys."""
        result = {}
        for field in self.fields(span):
            key = field.position if field.position is not None else self.integer(field.key)
            if key <= 0 or key in result:
                self.fail(field.value[0], 'Duplicate or invalid sequence slot')
            result[key] = field.value
        return result

    def number(self, span: Tuple[int, int]) -> float:
        """Accept only a numeric literal, optionally preceded by unary minus."""
        text = self.text(span)
        literal = self.tokens[span[0]:span[1]]
        if len(literal) == 2 and literal[0].text == '-':
            literal = literal[1:]
        unsigned = text[1:] if text.startswith('-') else text
        if len(literal) != 1 or literal[0].kind != 'number' or not _NUMBER.fullmatch(unsigned):
            self.fail(span[0], 'Expected numeric coordinate literal, got ' + text[:80])
        value = float(int(unsigned, 16)) if unsigned.lower().startswith('0x') else float(unsigned)
        if text.startswith('-'):
            value = -value
        if not math.isfinite(value):
            self.fail(span[0], 'Nonfinite numeric literal')
        return value

    def integer(self, span: Tuple[int, int]) -> int:
        """Read exact integer keys, not arbitrary numeric expressions."""
        value = self.number(span)
        if not value.is_integer():
            self.fail(span[0], 'Expected integer table key')
        return int(value)

    def assigned(self, name: str) -> Tuple[int, int]:
        """Find exactly one qualified assignment, without inspecting strings/comments."""
        found = []
        for index in range(len(self.tokens) - 4):
            if self.text((index, index + 3)) == name and self.tokens[index + 3].text == '=':
                start = index + 4
                found.append((start, self.matches.get(start, start) + 1))
        if len(found) != 1:
            raise ValueError('Expected exactly one assignment to ' + name)
        return found[0]


def read_zone_ids(source: str) -> Dict[str, int]:
    """Read owned symbolic AreaID constants; duplicate symbols and expressions fail."""
    parsed = Tables(source, _lex(source))
    result = {}
    for field in parsed.fields(parsed.assigned('ZoneDB.zoneIDs')):
        name = parsed.text(field.key)
        if not _NAME.fullmatch(name) or name in result:
            parsed.fail(field.value[0], 'Invalid or duplicate zone symbol ' + name)
        result[name] = parsed.integer(field.value)
    return result


def rewrite(source: str, *, entity: str, raw: bool, zone_ids: Dict[str, int],
            transform: Callable[[Coordinate], Tuple[float, float]]) -> Tuple[str, int]:
    """Replace only recognized X/Y literals; preserve source code and invoke no Lua.

    The callback owns map resolution, sentinel handling and conversion policy.
    Unsupported coordinate expressions fail with their original line number.
    """
    prefix, schema = _SCHEMA[entity]
    if entity == 'Item':
        return source, 0
    tokens = _lex(source)
    parsed = Tables(source, tokens)
    coordinate_fields = []
    if raw:
        # Validate the file-owned schema before interpreting positional entity rows.
        keys = {}
        for field in parsed.fields(parsed.assigned('QuestieDB.' + prefix + 'Keys')):
            name = parsed.text(field.key).strip('\'"')
            keys[name] = parsed.integer(field.value)
        if any(keys.get(name) != index for name, index in schema.items()):
            raise ValueError('Coordinate schema differs from supported ' + entity + ' keys')
        payload_span = parsed.assigned('QuestieDB.' + prefix + 'Data')
        payload = tokens[payload_span[0]]
        if payload.kind != 'long':
            parsed.fail(payload_span[0], 'Entity data must be a Lua long-string payload')
        tokens = _lex(source[payload.content_start:payload.content_end], payload.content_start)
        parsed = Tables(source, tokens)
        if not tokens or tokens[0].text != 'return' or tokens[-1].text != '}':
            raise ValueError('Entity payload must return one literal table')
        for row in parsed.fields((1, len(tokens))):
            entity_id = parsed.integer(row.key)
            fields = parsed.positional(row.value)
            for name, index in schema.items():
                if index in fields:
                    coordinate_fields.append((name, fields[index], entity_id))
    else:
        # Scan every branch without executing faction/class selection or l10n calls.
        recognized = set()
        for index, token in enumerate(tokens):
            if token.text != '[' or index not in parsed.matches:
                continue
            end = parsed.matches[index]
            key = parsed.text((index + 1, end))
            key_prefix = prefix + 'Keys.'
            name = key[len(key_prefix):] if key.startswith(key_prefix) else ''
            if name not in schema:
                continue
            recognized.update(range(index + 1, end))
            if end + 1 >= len(tokens) or tokens[end + 1].text != '=':
                parsed.fail(index, 'Coordinate field access outside a literal assignment')
            start = end + 2
            if start >= len(tokens):
                parsed.fail(start, 'Missing coordinate field value')
            stop = parsed.matches.get(start, start) + 1
            if stop < len(tokens) and tokens[stop].text not in (',', ';', '}', 'end', 'else', 'elseif'):
                parsed.fail(start, 'Computed coordinate field value is unsupported')
            coordinate_fields.append((name, (start, stop), None))
        for index in range(len(tokens) - 2):
            if tokens[index].text == prefix + 'Keys' and tokens[index + 1].text == '[':
                end = parsed.matches[index + 1]
                key = parsed.text((index + 2, end)).strip('\'"')
                if key in schema:
                    parsed.fail(index, 'Bracketed coordinate field alias is unsupported; use dot-form field keys')
            if tokens[index].text == prefix + 'Keys' and tokens[index + 1].text == '.' and tokens[index + 2].text in schema and index not in recognized:
                parsed.fail(index, 'Coordinate field alias/access cannot be rewritten safely')
            if tokens[index].text == '.' and tokens[index + 1].text in schema and tokens[index + 2].text == '=':
                parsed.fail(index, 'Named coordinate assignment is unsupported; use field-key tables')

    edits = []
    count = 0
    line_starts = [0] + [match.end() for match in re.finditer('\n', source)]

    def point(span, area_id, field_name, entity_id, waypoint=False):
        nonlocal count
        slots = parsed.positional(span)
        if 1 not in slots or 2 not in slots or any(k > (2 if waypoint else 3) for k in slots):
            parsed.fail(span[0], 'Malformed coordinate tuple')
        x, y = parsed.number(slots[1]), parsed.number(slots[2])
        location = Coordinate(area_id, x, y, bisect_right(line_starts, tokens[span[0]].start), field_name, entity_id)
        converted = transform(location)
        if len(converted) != 2 or any(type(v) not in (int, float) or not math.isfinite(v) for v in converted):
            parsed.fail(span[0], 'Transform returned invalid coordinates')
        count += 1
        for index, old, new in ((1, x, converted[0]), (2, y, converted[1])):
            if old != new:
                start, stop = slots[index]
                # Keep comments/spacing between unary minus and its numeric token.
                number_index = stop - 1
                for token_index in range(start, stop):
                    token = tokens[token_index]
                    replacement = repr(float(new)) if token_index == number_index else ''
                    edits.append((token.start, token.end, replacement))

    def spawnlist(span, field_name, entity_id, waypoint=False):
        for area in parsed.fields(span):
            key = parsed.text(area.key)
            if key.startswith('zoneIDs.'):
                symbol = key[len('zoneIDs.'):]
                if symbol not in zone_ids:
                    parsed.fail(area.key[0], 'Unknown zone symbol ' + symbol)
                area_id = zone_ids[symbol]
            else:
                area_id = parsed.integer(area.key)
            groups = parsed.positional(area.value)
            if groups and sorted(groups) != list(range(1, len(groups) + 1)):
                parsed.fail(area.value[0], 'Sparse coordinate/path list')
            for group in groups.values():
                if waypoint:
                    slots = parsed.positional(group)
                    first = slots.get(1)
                    if first is not None and tokens[first[0]].text != '{':
                        point(group, area_id, field_name, entity_id, True)
                    else:
                        if slots and sorted(slots) != list(range(1, len(slots) + 1)):
                            parsed.fail(group[0], 'Sparse waypoint path')
                        for pair in slots.values():
                            point(pair, area_id, field_name, entity_id, True)
                else:
                    point(group, area_id, field_name, entity_id)

    for name, span, entity_id in coordinate_fields:
        if parsed.text(span) == 'nil':
            continue
        if name in ('spawns', 'waypoints'):
            spawnlist(span, name, entity_id, name == 'waypoints')
        elif name == 'triggerEnd':
            slots = parsed.positional(span)
            if slots:
                if 2 not in slots:
                    parsed.fail(span[0], 'triggerEnd is missing its spawn list')
                if parsed.text(slots[2]) != 'nil':
                    spawnlist(slots[2], name, entity_id)
        else:
            for row in parsed.positional(span).values():
                slots = parsed.positional(row)
                if 1 in slots and parsed.text(slots[1]) != 'nil':
                    spawnlist(slots[1], name, entity_id)

    edits.sort()
    for previous, current in zip(edits, edits[1:]):
        if previous[1] > current[0]:
            raise ValueError('Overlapping coordinate edits')
    parts, end = [], 0
    for start, stop, replacement in edits:
        parts.extend((source[end:start], replacement))
        end = stop
    parts.append(source[end:])
    return ''.join(parts), count
