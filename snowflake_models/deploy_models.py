"""
This is a bare-bones model deployment system that creates a DAG of models and their dependencies.
It is a simple way to deploy models in order. A system as basic as this would have loads of problems in a large-scale
production environment (for starters it is single-threaded: SLOW), but it will suffice for a low-complexity coding assignment.
"""

import yaml

from ingestion import ingestion_cache
from util import init_cursor

TARGET_DB = "FETCH_CH_TAKEHOME"
TARGET_SCHEMA = "REPORTING"
DAG_YML = "dag.yml"


def sort_dependencies(data: dict):
    """Perform a topological sort of snowflake objects and their dependencies."""
    sorted_objects = []
    dependencies = {k: v.get('depends_on', []) for k, v in data.items()}
    while dependencies:
        for obj, deps in list(dependencies.items()):
            for dep in deps:
                if dep not in dependencies:
                    dependencies[obj].remove(dep)
            if not deps:
                sorted_objects.append(obj)
                del dependencies[obj]
    return sorted_objects


def create_snowflake_object(db_name: str, schema_name: str, obj_name: str, obj_details: dict, sql: str):
    """Create snowflake object from SQL model."""
    cur = init_cursor(db_name, schema_name)

    # Reuse cache check from ingestion
    if not ingestion_cache.check(schema_name):
        cur.execute(f"CREATE SCHEMA IF NOT EXISTS {db_name}.{schema_name};")
        ingestion_cache.add(schema_name)
        print(f"Created schema {db_name}.{schema_name}")

    materialization = obj_details['materialization'].upper()
    cur.execute(f"""
        CREATE OR REPLACE {materialization} {TARGET_DB}.{TARGET_SCHEMA}.{obj_name} AS
        {sql}
    """)
    print(f"Creating {obj_details['materialization']} {obj_name.upper()}")


def deploy_models(sorted_objects, data):
    for obj_name in sorted_objects:
        obj_sql_file = f"{obj_name}.sql"
        with open(obj_sql_file, 'r') as file:
            sql = file.read()
        create_snowflake_object(TARGET_DB, TARGET_SCHEMA, obj_name, data[obj_name], sql)


if __name__ == "__main__":
    with open(DAG_YML, 'r') as file:
        models = yaml.safe_load(file)

    deploy_models(sort_dependencies(models), models)
