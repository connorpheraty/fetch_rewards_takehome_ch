-- Find latest created_date in user table
WITH cte_max_date AS (
  SELECT MAX(created_date) AS max_created_date
  FROM fetch_ch_takehome.reporting.users
),
-- Collect all users created within the last 6 months
cte_users_created_last_six_months AS (
  SELECT
    u.user_id,
    u.created_date
  FROM fetch_ch_takehome.reporting.users u
  INNER JOIN cte_max_date m ON u.created_date >= ADD_MONTHS(m.max_created_date, -6)
)
-- Using receipt id as a proxy for transaction
SELECT
  ri.brand_code,
  count(receipt_id) total_transactions_past_six_months
FROM fetch_ch_takehome.reporting.receipt_items ri
LEFT JOIN cte_users_created_last_six_months u ON u.user_id = ri.user_id
WHERE ri.brand_code IS NOT NULL
GROUP BY 1
ORDER BY total_transactions_past_six_months DESC
;