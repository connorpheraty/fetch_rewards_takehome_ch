-- Question 1: What are the top 5 brands by receipts scanned for most recent month?
-- Answer: 1. Brand (test data?), 2. Mission, 3. VIVA
-- The vast majority of receipts scanned in the month prior to the latest record in the dataset are NULL.

-- Get latest scanned date in the dataset
WITH cte_max_date AS (
    SELECT MAX(date_scanned) AS max_date_scanned
    FROM FETCH_CH_TAKEHOME.REPORTING.RECEIPTS
),
-- Since the brand code exists on the receipt items table, we can join the receipts and receipt items tables to get the brand code
-- I am assuming that we want to tally the top 5 brands by receipts and not by the number of items scanned
cte_receipts AS (
    SELECT
        r.receipt_id,
        r.date_scanned,
        ri.brand_code
    FROM FETCH_CH_TAKEHOME.REPORTING.RECEIPTS r
    INNER JOIN cte_max_date m
        ON r.date_scanned >= ADD_MONTHS(m.max_date_scanned, -1)
       AND r.date_scanned < m.max_date_scanned
    LEFT JOIN FETCH_CH_TAKEHOME.REPORTING.RECEIPT_ITEMS ri
        ON r.receipt_id = ri.receipt_id
    GROUP BY 1, 2, 3
)
SELECT
    COUNT(*) AS receipts_scanned,
    brand_code
FROM cte_receipts
WHERE brand_code is not null
GROUP BY brand_code
ORDER BY receipts_scanned DESC
LIMIT 5
;