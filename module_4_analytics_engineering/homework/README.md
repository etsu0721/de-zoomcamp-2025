# My solutions to Module 4 Homework on Analytics Engineering

## Question 1: Understanding dbt model resolution

```sql
select * 
from {{ source('raw_nyc_tripdata', 'ext_green_taxi' ) }}
```

Would complile to...

**Answer:** `select * from dtc_zoomcamp_2025.raw_nyc_tripdata.ext_green_taxi`


## Question 2: dbt Variables & Dynamic Models

With the solution below, AEs can use `--vars '{days_back: <num_days>}'` to specify date range from CLI. If not specified using CLI, the default environment variable value, 30, is used unless the environment variable value overrided elsewhere in the project.

**Asnwer:** Update the `WHERE` clause to `pickup_datetime >= CURRENT_DATE - INTERVAL '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY`


## Question 3: dbt Data Lineage and Execution

The solution below will run the core models and everything upstream but nothing downstream, including `fct_taxi_monthly_zone_revenue.sql`.

**Asnwer:** `dbt run --select +models/core/`


## Question 4: dbt Macros and Jinja

**Asnwer:** The following are true
- When using core, it materializes in the dataset defined in `DBT_BIGQUERY_TARGET_DATASET`
- When using stg, it materializes in the dataset defined in `DBT_BIGQUERY_STAGING_DATASET`, or defaults to `DBT_BIGQUERY_TARGET_DATASET`
- When using staging, it materializes in the dataset defined in `DBT_BIGQUERY_STAGING_DATASET`, or defaults to `DBT_BIGQUERY_TARGET_DATASET`


## Question 5: Taxi Quarterly Revenue Growth

Not sure what I did wrong. My answer does not match any of the options.

**Asnwer:** green: {best: 2020/Q3, worst: 2020/Q2}, yellow: {best: 2020/Q3, worst: 2020/Q2}


## Question 6: P97/P95/P90 Taxi Monthly Fare

Created three metrics in Looker Studio, one for each percentile of interest: `fare_amount_p97/p95/p50`. 
Add the three metrics to a report as Scorecards.
Added filters specified in question to the report: fare amount > 0, trip distance > 0, payment type description is Cash or Credit Card, and year/month is 2020/April.

**Asnwer:** green: {p97: 55.0, p95: 45.0, p90: 26.5}, yellow: {p97: 31.5, p95: 25.5, p90: 19.0}


## Question 7: Top #Nth longest P90 travel time Location for FHV

**Asnwer:** LaGuardia Airport, Chinatown, Garment District
