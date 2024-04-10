-- Question 5: Which brand has the most spend among users who were created within the past 6 months?
-- Answer: BEN AND JERRY'S with $2,149.45

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
-- Find total spend for each brand among users created within the last 6 months
SELECT
  ri.brand_code,
  SUM(ri.final_price) AS total_spend_past_six_months
FROM fetch_ch_takehome.reporting.receipt_items ri
LEFT JOIN cte_users_created_last_six_months u ON u.user_id = ri.user_id
WHERE ri.brand_code IS NOT NULL
GROUP BY 1
ORDER BY total_spend_past_six_months DESC
;