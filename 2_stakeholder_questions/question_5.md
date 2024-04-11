## Question 5: Which brand has the most spend among users who were created within the past 6 months?

Please see the underlying SQL query [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/blob/main/snowflake_models/question_5.sql)

```sql

SELECT * FROM FETCH_CH_TAKEHOME.REPORTING.QUESTION_5;
```

The correct answer is `BEN AND JERRYS` with a total spend of $2,149.45.

| BRAND_CODE       | TOTAL_SPEND_PAST_SIX_MONTHS |
|------------------|-----------------------------|
| BEN AND JERRYS   | 2149.45                     |
| HEMPLER'S        | 1102.3                      |
| CRACKER BARREL   | 1069.32                     |