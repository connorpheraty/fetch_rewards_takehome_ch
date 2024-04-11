SELECT
    COUNT(*) AS total_items, -- Using count(*) since there are no other columns at the items grain that are fully populated
    rewards_receipt_status
FROM FETCH_CH_TAKEHOME.REPORTING.RECEIPT_ITEMS
WHERE rewards_receipt_status IN ('REJECTED', 'FINISHED')
GROUP BY rewards_receipt_status
ORDER BY total_items DESC;