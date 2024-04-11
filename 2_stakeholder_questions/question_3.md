## Question 3: When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

According to the dataset, there are five possible values for rewardsReceiptStatus: `SUBMITTED`, `FLAGGED`, `FINISHED`, `PENDING`, `REJECTED`.
To answer this question, we will assume that the `Accepted` status is `FINISHED` and the `Rejected` status is `REJECTED`.

Please see the underlying SQL query [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/blob/main/snowflake_models/question_3.sql)

```sql

SELECT * FROM FETCH_CH_TAKEHOME.REPORTING.QUESTION_3;
```

The correct answer is `FINISHED` with an average spend of 80.85.

| AVG_SPEND_RECEIPT_STATUS | REWARDS_RECEIPT_STATUS |
|--------------------------|------------------------|
| 80.85                    | FINISHED               |
| 23.33                    | REJECTED               |