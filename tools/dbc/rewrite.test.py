"""Coordinate rewriting tests, with source text serving as the preservation oracle."""
import unittest

from rewrite import read_zone_ids, rewrite


class RewriteTest(unittest.TestCase):
    def convert(self, source, entity='Npc', raw=False, callback=None):
        return rewrite(source, entity=entity, raw=raw, zone_ids={'MULGORE': 215},
                       transform=callback or (lambda point: (point.x + 1, point.y + 2)))

    def test_faction_branches_comments_and_phase_expressions_survive(self):
        source = '''-- [npcKeys.spawns] = {[215]={{99,99}}}
local text = "[npcKeys.spawns] = { brace }"
--[=[ arbitrary { [ unmatched delimiters ]=]
if faction == "Horde" then
    return { [npcKeys.spawns] = {[zoneIDs.MULGORE]={{10,20,phases.FOO}}} }
else
    return { [npcKeys.spawns] = {[215]={{30,40}}} }
end
'''
        result, count = self.convert(source)
        expected = source.replace('{{10,20,phases.FOO}}', '{{11.0,22.0,phases.FOO}}').replace('{{30,40}}', '{{31.0,42.0}}')
        self.assertEqual(result, expected)
        self.assertEqual(count, 2)

    def test_raw_payload_schema_nil_holes_and_unrelated_numeric_pairs(self):
        source = '''QuestieDB.npcKeys = {['spawns']=7,['waypoints']=8}
QuestieDB.npcData = [=[return {
[2981] = {'Chief Hawkwind',1,2,3,4,5,{[215]={{44.18,76.06}}},nil,215,{12,34}}
}]=]
'''
        seen = []
        def transform(point):
            seen.append(point)
            return point.x + 1, point.y + 2
        result, count = self.convert(source, raw=True, callback=transform)
        self.assertEqual(result, source.replace('44.18,76.06', '45.18,78.06'))
        self.assertEqual(count, 1)
        self.assertEqual(seen[0].entity_id, 2981)
        self.assertEqual(seen[0].line, 3)
        with self.assertRaisesRegex(ValueError, 'schema differs'):
            self.convert(source.replace("['spawns']=7", "['spawns']=6"), raw=True)

    def test_quest_coordinates_do_not_touch_icons_references_or_reputation(self):
        source = '''return {
[questKeys.triggerEnd] = {l10n("hello, {world}"), {[215]={{1,2}}}},
[questKeys.extraObjectives] = {
 {nil, 1, l10n('text'), 0, {{'monster', 2981}}},
 {{[zoneIDs.MULGORE]={{3,4}}}, 2, nil, 1, {{'object', 123}}}
},
[questKeys.reputationReward] = {{81,250}}
}'''
        result, count = self.convert(source, entity='Quest')
        self.assertEqual(result, source.replace('{{1,2}}', '{{2.0,4.0}}').replace('{{3,4}}', '{{4.0,6.0}}'))
        self.assertEqual(count, 2)

    def test_nested_and_flat_waypoints_are_supported(self):
        nested = 'return {[npcKeys.waypoints]={[215]={{{1,2},{3,4}}}}}'
        flat = 'return {[npcKeys.waypoints]={[215]={{1,2},{3,4}}}}'
        self.assertEqual(self.convert(nested), (nested.replace('{1,2}', '{2.0,4.0}').replace('{3,4}', '{4.0,6.0}'), 2))
        self.assertEqual(self.convert(flat), (flat.replace('{1,2}', '{2.0,4.0}').replace('{3,4}', '{4.0,6.0}'), 2))

    def test_identity_preserves_every_byte_and_sentinels_reach_callback(self):
        source = 'return {[npcKeys.spawns]={[215]={{-1,-1},{0,0},{1e1,0x14}}}, [npcKeys.waypoints]={}}'
        seen = []
        def identity(point):
            seen.append((point.x, point.y))
            return point.x, point.y
        self.assertEqual(self.convert(source, callback=identity), (source, 3))
        self.assertEqual(seen, [(-1, -1), (0, 0), (10, 20)])

    def test_numeric_token_edits_preserve_comments_inside_negative_literal(self):
        source = 'return {[npcKeys.spawns]={[215]={{- -- keep\n 3, 4}}}}'
        result, count = self.convert(source)
        self.assertEqual(result, 'return {[npcKeys.spawns]={[215]={{ -- keep\n -2.0, 6.0}}}}')
        self.assertEqual(count, 1)

    def test_unsupported_expressions_and_unknown_symbols_fail(self):
        sources = [
            ('return {[npcKeys.spawns]={[215]={{1+2,4}}}}', 'numeric coordinate'),
            ('return {[npcKeys.spawns]=getSpawns()}', 'Computed coordinate'),
            ('return {[npcKeys.spawns]={[zoneIDs.UNKNOWN]={{1,2}}}}', 'Unknown zone'),
            ('return {[npcKeys.spawns]={[215]={{1}}}}', 'Malformed coordinate'),
            ('local key = npcKeys.spawns', 'alias/access'),
            ('return {[npcKeys["spawns"]]={[215]={{1,2}}}}', 'Bracketed coordinate'),
            ('fix.spawns = {}', 'Named coordinate'),
        ]
        for source, message in sources:
            with self.subTest(source=source), self.assertRaisesRegex(ValueError, message):
                self.convert(source)

    def test_symbol_reader_ignores_comments_and_rejects_duplicate_names(self):
        source = 'ZoneDB.zoneIDs = {MULGORE=215, -- MISTAKE=99\n TEST=10000}'
        self.assertEqual(read_zone_ids(source), {'MULGORE': 215, 'TEST': 10000})
        with self.assertRaisesRegex(ValueError, 'duplicate'):
            read_zone_ids('ZoneDB.zoneIDs={MULGORE=215,MULGORE=216}')

    def test_item_inputs_are_untouched(self):
        source = 'return {[itemKeys.vendors]={1,2}} -- no coordinates'
        self.assertEqual(self.convert(source, entity='Item'), (source, 0))


if __name__ == '__main__':
    unittest.main()
