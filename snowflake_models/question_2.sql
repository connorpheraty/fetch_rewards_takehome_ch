-- Question 2: How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
-- Answer:
    -- Recent Month: 1. BRAND, 2. MISSION, 3. VIVA
    -- Previous Month: 1. BEN AND JERRYS, 2. FOLGERS, 3. PEPSI, 4. KELLOGG'S, 5. KRAFT

WITH cte_max_date AS (
    SELECT MAX(date_scanned) AS max_date_scanned
    FROM FETCH_CH_TAKEHOME.REPORTING.RECEIPTS
),
cte_receipts AS (
    SELECT
        r.receipt_id,
        r.date_scanned,
        ri.brand_code,
        CASE
            WHEN r.date_scanned >= ADD_MONTHS(m.max_date_scanned, -1) THEN 'Most Recent Month'
            WHEN r.date_scanned >= ADD_MONTHS(m.max_date_scanned, -2) THEN 'Previous Month'
        END AS receipt_month
    FROM FETCH_CH_TAKEHOME.REPORTING.RECEIPTS r
    INNER JOIN cte_max_date m
        ON r.date_scanned >= ADD_MONTHS(m.max_date_scanned, -2)
       AND r.date_scanned < m.max_date_scanned
    LEFT JOIN FETCH_CH_TAKEHOME.REPORTING.RECEIPT_ITEMS ri
        ON r.receipt_id = ri.receipt_id
    WHERE ri.brand_code is not null
    GROUP BY 1, 2, 3, 4
)
, cte_receipts_agg as (
SELECT
    brand_code,
    receipt_month,
    COUNT(*) AS receipts_scanned
FROM cte_receipts
WHERE receipt_month IS NOT NULL
GROUP BY brand_code, receipt_month
)
SELECT
    brand_code,
    receipt_month,
    receipts_scanned
FROM (
    SELECT
        -- Adding window function to rank the brands by receipts scanned and limit output to 5
        ROW_NUMBER() OVER (PARTITION BY receipt_month ORDER BY receipts_scanned DESC) AS rnk,
        brand_code,
        receipt_month,
        receipts_scanned
    FROM cte_receipts_agg
) ranked_receipts
WHERE rnk <= 5
ORDER BY receipt_month DESC, receipts_scanned DESC
;