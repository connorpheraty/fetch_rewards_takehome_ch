# Data Issue 1: Duplicates

During my initial analysis of the raw data from the `users` raw json source, I identified a pretty sizeable amount of duplicates.
I discovered this by using the window function below against the raw json data.

```sql
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
qualify row_number() over (partition by raw_json:_id:"$oid" order by _load_time desc) > 1
;
```

The results of this query revealed 282 duplicate `user_id` records. My solution was to apply a window function
to `reporting.users` to rank rows based off the `_load_time` column to keep the most recently loaded record.