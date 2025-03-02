{{ config(materialized='table') }}

-- For each record in dim_fhv_trips.sql, compute the timestamp_diff in seconds between dropoff_datetime and pickup_datetime - we'll call it trip_duration for this exercise
with dim_fhv_trips as (
    select *
    from {{ ref('dim_fhv_trips') }}
)
select *,
    timestamp_diff(
        dropoff_datetime,
        pickup_datetime,
        SECOND
    ) as trip_duration
from dim_fhv_trips