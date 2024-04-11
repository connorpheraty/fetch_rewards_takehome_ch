SELECT
    raw_json:_id:"$oid"::STRING AS user_id, -- pk, but use corrected field accessor
    raw_json:state::STRING AS state,
    (raw_json:createdDate:"$date"::INT / 1000)::TIMESTAMP_NTZ AS created_date,
    (raw_json:lastLogin:"$date"::INT / 1000)::TIMESTAMP_NTZ AS last_login,
    raw_json:role::STRING AS role,
    raw_json:active::BOOLEAN AS is_active
FROM fetch_ch_takehome.ingestion.users
-- Remove duplicate users by id ordered by the most recent record
QUALIFY ROW_NUMBER() OVER (PARTITION BY raw_json:_id:"$oid" ORDER BY _load_time DESC) = 1;