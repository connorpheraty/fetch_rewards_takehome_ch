select
    raw_json:_id:"$oid"::string user_id
    ,raw_json:state::string state
    ,(raw_json:createdDate:"$date"::int / 1000)::timestamp created_date
    ,(raw_json:lastLogin:"$date"::int / 1000)::timestamp last_login
    ,raw_json:role::string role
    ,raw_json:active::boolean is_active
    ,raw_json
from fetch_ch_takehome.ingestion.users,
-- Remove duplicate users by id and only keep the most recent record
qualify row_number() over (partition by raw_json:_id:"$oid" order by _load_time desc) = 1
;