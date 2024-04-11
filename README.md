# Fetch Rewards Coding Exercise

## Overview

This repo contains the requirements enumerated in the Fetch Coding Exercise:

1. [Relational Model](https://github.com/connorpheraty/fetch_rewards_takehome_ch/tree/main/1_relational_model)
2. [Stakeholder Questions](https://github.com/connorpheraty/fetch_rewards_takehome_ch/tree/main/2_stakeholder_questions)
3. [Data Quality Issues](https://github.com/connorpheraty/fetch_rewards_takehome_ch/tree/main/3_data_quality_issues)
4. [Email to Business Stakeholder](https://github.com/connorpheraty/fetch_rewards_takehome_ch/tree/main/4_email_to_business_stakeholder)

In order to answer these questions, I have created some python tooling to ingest the data into a Snowflake database
and a lightweight deployment script to deploy each model.


## Setup

To run the code in this repo, you'll need:

1. Python 3.9 or higher
2. [Poetry](https://python-poetry.org/docs/#installation) for managing dependencies
3. A working Snowflake account with the following environment variables set in your shell or in a `.env` file in the root of this repo
    - `SNOWFLAKE_ACCOUNT`
    - `SNOWFLAKE_USER`
    - `SNOWFLAKE_PASSWORD`
    - `SNOWFLAKE_WAREHOUSE`

## Data Ingestion & Model Deployment

Please run the following python executable files in the order specified below:
1. `ingestion/ingestion.py`
2. `snowflake_models/deploy_models.py`

**Note**: I am assuming that you will have a role attached to your Snowflake user that has the necessary permissions
to create databases, schemas, objects, and stages and also select from said objects.
