-- Question 3: When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- Answer: According to the dataset, there are five possible values for rewardsReceiptStatus: 'SUBMITTED', 'FLAGGED', 'FINISHED', 'PENDING', 'REJECTED'.
-- To answer this question we are going to assume that the 'Accepted' status is 'FINISHED' and 'Rejected' status is 'REJECTED'.
-- Therefore, the correct answer is FINISHED with an average spend of 80.85.

with cte_grouped as (
    select
        count(*) count,
        sum(total_spent) total_spent,
        rewards_receipt_status
    from FETCH_CH_TAKEHOME.REPORTING.RECEIPTS
    -- Filter out statuses that are not 'Finished' or 'Rejected'
    where rewards_receipt_status in ('REJECTED', 'FINISHED')
    group by rewards_receipt_status
)
select
    DIV0(total_spent, count)::decimal(10,2) avg_spend_receipt_status,
    rewards_receipt_status
from cte_grouped
order by avg_spend_receipt_status desc
;