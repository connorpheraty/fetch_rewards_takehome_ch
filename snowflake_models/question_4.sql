-- Question 4: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- Answer: We are going to carry over the same assumptions as the previous question to answer this one.
-- Therefore, the correct answer is FINISHED with a total of 5918 items purchased.

select
    count(*) total_items, -- Using count(*) since there are no other columns at the items grain that are fully populated
    rewards_receipt_status
from FETCH_CH_TAKEHOME.REPORTING.RECEIPT_ITEMS
where rewards_receipt_status in ('REJECTED', 'FINISHED')
group by rewards_receipt_status
order by total_items desc
;