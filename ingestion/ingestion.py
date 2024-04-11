import os

import ingestion_cache
import sql_commands as ssql
from util import init_cursor

RAW_DATA_DIR = "../raw_data"
TARGET_DB = "FETCH_CH_TAKEHOME"
TARGET_SCHEMA = "INGESTION"


def ingest_local_files(db_name: str, schema_name: str, table_name: str):
    """Ingest local json files from local store."""
    cur = init_cursor(db_name, schema_name)
    try:
        # This cache check is overkill for this coding assignment but you get the idea
        if not ingestion_cache.check(schema_name):
            cur.execute(ssql.create_schema(db_name, schema_name))
            ingestion_cache.add(schema_name)
            print(f"Created schema {db_name}.{schema_name}")

        if not ingestion_cache.check(schema_name, table_name):
            cur.execute(ssql.create_table(db_name, schema_name, table_name))
            ingestion_cache.add(schema_name, table_name)
            print(f"Created table {db_name}.{schema_name}.{table_name}")

        stage_name = f"{schema_name}_STAGE"
        if not ingestion_cache.check(stage_name):
            cur.execute(ssql.create_stage(db_name, schema_name, stage_name))
            ingestion_cache.add(stage_name)
            print(f"Created stage {db_name}.{schema_name}.{stage_name}")

        cur.execute(ssql.put_file(RAW_DATA_DIR, stage_name, table_name))
        cur.execute(ssql.copy_into(db_name, schema_name, table_name, stage_name))
        print(f"Data ingested into {db_name}.{schema_name}.{table_name}")

    except Exception as e:
        print(f"Error ingesting data into {db_name}.{schema_name}.{table_name}: {e}")


if __name__ == "__main__":
    # Iterate through raw data directory for files
    for file in os.listdir(RAW_DATA_DIR):
        table_name = file.split(".")[0].upper()
        ingest_local_files(TARGET_DB, TARGET_SCHEMA, table_name)
