

def create_schema(db_name: str, schema_name: str):
    return f"CREATE SCHEMA IF NOT EXISTS {db_name}.{schema_name};"


def create_table(db_name: str, schema_name: str, table_name: str):
    """Create ingestion table with timestamp column."""
    return f"""CREATE TABLE IF NOT EXISTS {db_name}.{schema_name}.{table_name} (
        raw_json VARIANT,
        _load_time TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP
    );"""


def create_stage(db_name: str, schema_name: str, stage_name: str):
    return f"CREATE OR REPLACE STAGE {db_name}.{schema_name}.{stage_name};"


def put_file(raw_data_dir: str, stage_name: str, table_name: str):
    return f"PUT file://{raw_data_dir}/{table_name}.json.gz @{stage_name}"


def copy_into(db_name: str, schema_name: str, table_name: str, stage_name: str):
    return f"""
        COPY INTO {db_name}.{schema_name}.{table_name} (raw_json)
        FROM @{stage_name}/{table_name}.json.gz
        FILE_FORMAT = (TYPE = 'JSON' STRIP_OUTER_ARRAY = TRUE)
        ON_ERROR = 'CONTINUE';
    """
