# Question 1: What are the top 5 brands by receipts scanned for most recent month?

I approached this problem by first identifying the latest record in the receipts dataset and filtering the data to only
include receipts scanned in the month prior to this latest record. Please see the SQL query [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/blob/main/snowflake_models/question_1.sql).

```sql

SELECT * FROM FETCH_CH_TAKEHOME.REPORTING.QUESTION_1;
```

The majority of results in this dataset have `null` values for brand. After filtering out the `null` brand records,
the following is the top brands by receipts scanned for the most recent month:

| RECEIPTS_SCANNED | BRAND_CODE |
|------------------|------------|
| 3                | BRAND      |
| 2                | MISSION    |
| 1                | VIVA       |