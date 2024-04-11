SELECT
    raw_json:_id:"$oid"::STRING AS brand_id, -- pk
    raw_json:barcode::STRING AS barcode,
    raw_json:category::STRING AS category,
    raw_json:categoryCode::STRING AS category_code,
    raw_json:cpg:"$id":"$oid"::STRING AS cpg_id,
    raw_json:cpg:"$ref"::STRING AS cpg_ref,
    raw_json:name::STRING AS name,
    raw_json:brandCode::STRING AS brand_code
FROM fetch_ch_takehome.ingestion.brands
QUALIFY ROW_NUMBER() OVER (PARTITION BY raw_json:_id:"$oid" ORDER BY _load_time DESC) = 1
;