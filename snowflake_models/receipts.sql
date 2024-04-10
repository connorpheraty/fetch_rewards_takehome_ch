SELECT
    -- Receipt and User Identifiers
    raw_json:_id:"$oid"::string AS receipt_id,
    raw_json:userId::string AS user_id,

    -- Receipt Status
    raw_json:rewardsReceiptStatus::string AS rewards_receipt_status,

    -- Receipt Timestamps
    (raw_json:createDate:"$date"::int / 1000)::timestamp AS create_date,
    (raw_json:dateScanned:"$date"::int / 1000)::timestamp AS date_scanned,
    (raw_json:purchaseDate:"$date"::int / 1000)::timestamp AS purchase_date,
    (raw_json:finishedDate:"$date"::int / 1000)::timestamp AS finished_date,
    (raw_json:modifyDate:"$date"::int / 1000)::timestamp AS modify_date,
    (raw_json:pointsAwardedDate:"$date"::int / 1000)::timestamp AS points_awarded_date,

    -- Receipt Details
    raw_json:purchasedItemCount::int AS purchased_item_count,
    raw_json:totalSpent::decimal(10,2) AS total_spent,
    raw_json:pointsEarned::float AS points_earned,
    raw_json:bonusPointsEarned::int AS bonus_points_earned,
    raw_json:bonusPointsEarnedReason::string AS bonus_points_earned_reason,

    -- Receipt Items
    raw_json:rewardsReceiptItemList AS rewards_receipt_item_list,

    -- Raw Receipt Data (JSON)
    raw_json
FROM
    fetch_ch_takehome.ingestion.receipts
QUALIFY
    row_number() OVER (PARTITION BY raw_json:_id:"$oid" ORDER BY _load_time DESC) = 1;