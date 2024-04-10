import os

import snowflake.connector as sf_connector
from dotenv import load_dotenv

load_dotenv()


def init_cursor(db_name: str, schema_name: str):
    return sf_connector.connect(
        user=os.environ.get("SF_USER", ""),
        password=os.environ.get("SF_PASSWORD", ""),
        account=os.environ.get("SF_ACCOUNT", ""),
        warehouse=os.environ.get("SF_WAREHOUSE", ""),
        database=db_name,
        schema=schema_name
    ).cursor()
