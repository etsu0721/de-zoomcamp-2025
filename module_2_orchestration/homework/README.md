# My solutions to Module 2 Homework on Orchestration

## Q1: Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (i.e. the output file `yellow_tripdata_2020-12.csv` of the extract task)?

1. Commented out `purge_files` task.
2. Executed `ext_taxi_to_gcp_scheduled` Flow in backfill mode for 2020-12-01 through 2020-12-31.
3. Executions -> *particular execution* -> Outputs -> extract -> outputFiles -> yellow_tripdata_2020-12.csv

**Answer:** 128.3 MB


## Q2: What is the rendered value of the variable file when the inputs taxi is set to green, year is set to 2020, and month is set to 04 during execution?

**Answer:** `green_tripdata_2020-04.csv`


## Q3: How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?

```sql
SELECT 
  COUNT(1) as row_cnt
FROM 
  `data-engineering-zoomcamp-25.dezc25_bq_dataset_qbmxo8y742f8pm.yellow_tripdata` 
WHERE 
  filename LIKE '%2020%';
```

**Answer:** 24,648,499


## Q4: How many rows are there for the Green Taxi data for all CSV files in the year 2020?

```sql
SELECT 
  COUNT(1) as row_cnt
FROM 
  `data-engineering-zoomcamp-25.dezc25_bq_dataset_qbmxo8y742f8pm.green_tripdata` 
WHERE 
  filename LIKE '%2020%';
```

**Answer:** 1,734,051


## Q5: How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

```sql
SELECT 
  COUNT(1) as row_cnt
FROM 
  `data-engineering-zoomcamp-25.dezc25_bq_dataset_qbmxo8y742f8pm.yellow_tripdata` 
WHERE 
  filename LIKE '%2021-03%';
```

**Answer:** 1,925,152


## Q6: How would you configure the timezone to New York in a Schedule trigger?

**Answer:** Per [Kestra documentation](https://kestra.io/docs/workflow-components/triggers/schedule-trigger), I would add a timezone property set to America/New_York in the Schedule trigger configuration.
