## Question 2: How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

Similar to the previous problem, we are going to segregate the records in the most recent month and the month previous to
the most recent month. Then we will rank the results in each group. 

Please see the underlying SQL query [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/blob/main/snowflake_models/question_2.sql)


```sql

SELECT * FROM FETCH_CH_TAKEHOME.REPORTING.QUESTION_2;
```

According to the results, the top three brands from the most recent month are different from the top 5 brands in the 
previous month. These results appear to imply that there was a large decrease in receipts scanned between the most 
recent two months. 

| BRAND_CODE     | RECEIPT_MONTH      | RECEIPTS_SCANNED |
|----------------|--------------------|------------------|
| BEN AND JERRYS | Previous Month     | 32               |
| FOLGERS        | Previous Month     | 23               |
| PEPSI          | Previous Month     | 23               |
| KELLOGG'S      | Previous Month     | 22               |
| KRAFT          | Previous Month     | 22               |
| BRAND          | Most Recent Month  | 3                |
| MISSION        | Most Recent Month  | 2                |
| VIVA           | Most Recent Month  | 1                |


After tweaking the underlying query slightly, I can confirm that this is true:

| COUNT(RECEIPT_ID) | RECEIPT_MONTH     |
|-------------------|-------------------|
| 451               | Most Recent Month |
| 1856              | Previous Month    |

