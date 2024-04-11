## Question 4: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

We are going to carry over the same assumptions as the previous question to answer this one.

Please see the underlying SQL query [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/blob/main/snowflake_models/question_4.sql)


```sql

SELECT * FROM FETCH_CH_TAKEHOME.REPORTING.QUESTION_4;
```

The correct answer is `FINISHED` with a total of 5918 items purchased.

| TOTAL_ITEMS | REWARDS_RECEIT_STATUS |
|-------------|-----------------------|
| 5918        | FINISHED              |
| 164         | REJECTED              |