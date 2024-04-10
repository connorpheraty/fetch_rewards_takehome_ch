# Data Issue 2: Test Data

During my analysis of the brands data source, I quickly noticed test data was interspersed with the actual brand data:

```sql
SELECT *
FROM fetch_ch_takehome.reporting.brands
WHERE LOWER(name) ILIKE '%test brand%' AND LOWER(brand_code) ILIKE '%test brandcode%';
```
