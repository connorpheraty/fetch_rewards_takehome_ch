from threading import RLock
from collections import defaultdict

_lock = RLock()
_local_cache = defaultdict(set)


def add(schema: str, table: str = None):
    """Add schema and a table (that belongs to the schema) to the cache."""
    if table is None:
        _local_cache[schema.upper()]
    else:
        _local_cache[schema.upper()].add(table.upper())


def check(schema: str, table: str = None) -> bool:
    """Check if a schema or a schema/table pair exists in the cache. Case is handled."""
    # Obviously this is not necessary for single-thread execution but it's a good habit
    with _lock:
        if table is None:
            return schema.upper() in _local_cache.keys()
        else:
            return table.upper() in _local_cache.get(schema.upper(), {})
