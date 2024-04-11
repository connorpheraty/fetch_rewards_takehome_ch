WITH cte_grouped AS (
  SELECT
    COUNT(*) AS count,
    SUM(total_spent) AS total_spent,
    rewards_receipt_status
  FROM FETCH_CH_TAKEHOME.REPORTING.RECEIPTS
  WHERE rewards_receipt_status IN ('REJECTED', 'FINISHED')
  GROUP BY rewards_receipt_status
)
SELECT
  DIV0(total_spent, count)::DECIMAL(10, 2) AS avg_spend_receipt_status,
  rewards_receipt_status
FROM cte_grouped
ORDER BY avg_spend_receipt_status DESC;