## Question 6: Which brand has the most transactions among users who were created within the past 6 months?

Please see the underlying SQL query [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/blob/main/snowflake_models/question_5.sql)

```sql

SELECT * FROM FETCH_CH_TAKEHOME.REPORTING.QUESTION_6;
```

The correct answer is `HY-VEE` with a total of 291 transactions.

| BRAND_CODE       | TOTAL_TRANSACTIONS_PAST_SIX_MONTHS |
|------------------|------------------------------------|
| HY-VEE           | 291                                |
| BEN AND JERRYS   | 180                                |
| PEPSI            | 93                                 |