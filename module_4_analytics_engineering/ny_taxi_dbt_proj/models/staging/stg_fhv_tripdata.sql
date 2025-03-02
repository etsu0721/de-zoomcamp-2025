{{ config(materialized="view") }}

with
    source as (
        select *
        from {{ source("dezc25_bq", "fhv_tripdata") }}
        where dispatching_base_num is not null
    )
select 
    -- identifiers
    {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("DOlocationID", api.Column.translate_type("integer")) }} as dropoff_locationid,

    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,

    -- trip info
    dispatching_base_num,
    Affiliated_base_number,
    SR_Flag
from source

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}