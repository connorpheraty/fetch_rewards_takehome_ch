# Data Issue 3: Data Sparsity

While the receipts table is largely dense, the receipt items table is relatively sparse.

Densely populated receipt table (where rewards_receipt_status = 'FINISHED'):
```sql
select * from fetch_ch_takehome.reporting.receipt_items
where rewards_receipt_status = 'FINISHED'
;
```

Sparsely populated receipt items table:
```sql
select * from fetch_ch_takehome.reporting.receipt_items
where rewards_receipt_status = 'FINISHED'
;
```

This is particularly concerning in areas where the `brand_code` is null. Not being able to roll up data to the brand level
would be a significant limitation in any downstream analytical effort. I would recommend investigating the root cause of this immediately.