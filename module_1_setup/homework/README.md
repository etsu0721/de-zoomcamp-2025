# Module 1 Homework

[Course GitHub - Module 1 Homework](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2025/01-docker-terraform/homework.md)

## Question 1. Understanding docker first run

```bash
docker run -it --entrypoint=bash python:3.12.8
root@2938c3009041:/# pip --version
pip 24.3.1 from /usr/local/lib/python3.12/site-packages/pip (python 3.12)
```

## Question 2. Understanding Docker networking and docker-compose

`db:5432`


## Question 3. Trip Segmentation Count

See `Dockerfile` for image specifications. See `ingest-taxi-trips.py` for details of ingestion script.

Ingest October, 2019 Green Taxi Trip data into Postgres:
```bash
docker run -it \
    --network=module_1_setup_default \
    ingest-taxi-trips:v001 \
        --user=root \
        --pw=root \
        --host=pgdatabase \
        --port=5432 \
        --db=ny_taxi \
        --table=green_taxi_trips \
        --url="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz"
```

SQL to answer question 3:

```sql
SELECT 
    CASE
        WHEN trip_distance <= 1 THEN '0-1 miles'
        WHEN trip_distance > 1
            AND trip_distance <= 3 THEN '1-3 miles'
        WHEN trip_distance > 3
            AND trip_distance <= 7 THEN '3-7 miles'
        WHEN trip_distance > 7
            AND trip_distance <= 10 THEN '7-10 miles'
        WHEN trip_distance > 10 THEN '10+ miles'
    END AS distance_range,
    COUNT(*) AS trips_count
FROM 
    green_taxi_trips
WHERE 
    lpep_pickup_datetime >= '2019-10-01'
       AND lpep_pickup_datetime < '2019-11-01'
GROUP BY 
    distance_range; 
```

- "0-1 miles"	    104,802
- "1-3 miles"	    198,924
- "3-7 miles"	    109,603
- "7-10 miles"	    27,678
- "10+ miles"	    35,189


## Question 4. Longest trip for each day

SQL to answer question 4:

```sql
SELECT 
    Date(lpep_pickup_datetime) AS pickup_date,
    Max(trip_distance) AS max_trip_distance
FROM
    green_taxi_trips
WHERE
    Date(lpep_pickup_datetime) IN ( '2019-10-11', '2019-10-24', '2019-10-26', '2019-10-31' )
GROUP BY 
    pickup_date
ORDER BY 
    max_trip_distance DESC; 
```

- "2019-10-31"	515.89
- "2019-10-11"	95.78
- "2019-10-26"	91.56
- "2019-10-24"	90.75


## Question 5. Three biggest pickup zones

SQL to answer question 5:

```sql
SELECT 
    z."Zone",
    SUM(t.total_amount) AS total_amount_sum
FROM
    green_taxi_trips t
    INNER JOIN zones z
        ON t."PULocationID" = z."LocationID"
WHERE 
    Date(t.lpep_pickup_datetime) = '2019-10-18'
GROUP BY 
    z."Zone"
ORDER  BY total_amount_sum DESC
LIMIT  3; 
```

- "East Harlem North"	    18686.680000000073
- "East Harlem South"	    16797.260000000068
- "Morningside Heights"	    13029.790000000034


## Question 6. Largest tip

SQL to answer question 6:

```sql
SELECT 
	z."Zone" AS dropoff_location,
	MAX(t.tip_amount) AS max_tip_amount
FROM 
	green_taxi_trips t 
	INNER JOIN zones z
		ON 	t."DOLocationID" = z."LocationID"
WHERE lpep_pickup_datetime >= '2019-10-01'
       AND lpep_pickup_datetime < '2019-11-01'
	   AND t."PULocationID" = 74    -- "East Harlem North" z.LocationID 
GROUP BY 
	dropoff_location
ORDER BY 
	max_tip_amount DESC
LIMIT 3;
```

- "JFK Airport"	        87.3
- "Yorkville West"	    80.88
- "East Harlem North"	40

## Question 7. Terraform Workflow

terraform init, terraform apply -auto-approve, terraform destroy
