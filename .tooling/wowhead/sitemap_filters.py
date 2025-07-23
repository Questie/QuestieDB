#
#
#
from sitemap_types import WowheadEntity
from sitemap_helpers import contains_any_scripts


def filter_unused_entities(entities: tuple[WowheadEntity, ...]) -> tuple[tuple[WowheadEntity, ...], tuple[WowheadEntity, ...]]:
  """
  Returns a tuple of (filtered_entities, removed_entities).

  The first list contains entities without unused or deprecated entities.
  The second list contains the entities that were filtered out.

  filters:
    - nyi- (not yet implemented)
    - deprecated- (no longer used)
    - ph- (placeholder)
    - unused- (unused entities)
    - unused (unused entities without prefix)
  """

  def _is_filtered_entity(entity: WowheadEntity) -> bool:
    """Check if an entity should be filtered out."""
    if not entity.name_slug:
      return False

    return (
      entity.name_slug.startswith("deprecated-")
      or entity.name_slug.startswith("nyi-")
      or entity.name_slug.startswith("ph-")
      or entity.name_slug.startswith("unused-")
      or entity.name_slug.startswith("unused")
    )

  filtered_entities: list[WowheadEntity] = []
  removed_entities: list[WowheadEntity] = []

  for entity in entities:
    if _is_filtered_entity(entity):
      removed_entities.append(entity)
    else:
      filtered_entities.append(entity)

  return tuple(sorted(filtered_entities, key=lambda e: e.entity_id)), tuple(sorted(removed_entities, key=lambda e: e.entity_id))


# added_entities = tuple(sorted([entity for entity in added_entities if not contains_any_scripts(entity.generate_url())], key=lambda e: e.entity_id))
def filter_entities_without_scripts(entities: tuple[WowheadEntity, ...]) -> tuple[tuple[WowheadEntity, ...], tuple[WowheadEntity, ...]]:
  """
  Returns a tuple of (filtered_entities, removed_entities).

  The first list contains entities that contain koKR, zhCN, zhTW, ruRU type scripts.
  The second list contains the entities that were filtered out (without scripts).
  """
  filtered_entities: list[WowheadEntity] = []
  removed_entities: list[WowheadEntity] = []

  for entity in entities:
    if contains_any_scripts(entity.generate_url()):
      filtered_entities.append(entity)
    else:
      removed_entities.append(entity)

  return tuple(sorted(filtered_entities, key=lambda e: e.entity_id)), tuple(sorted(removed_entities, key=lambda e: e.entity_id))
