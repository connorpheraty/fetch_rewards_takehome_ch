select
    raw_json:_id:"$oid"::string brand_id -- pk
    ,raw_json:barcode::string barcode
    ,raw_json:category::string category
    ,raw_json:categoryCode::string category_code
    ,raw_json:cpg:"$id":"$oid"::string cpg_id
    ,raw_json:cpg:"$ref"::string cpg_ref
    ,raw_json:name::string name
    ,raw_json:brandCode::string brand_code
from fetch_ch_takehome.ingestion.brands
qualify row_number() over (partition by raw_json:_id:"$oid" order by _load_time desc) = 1
;