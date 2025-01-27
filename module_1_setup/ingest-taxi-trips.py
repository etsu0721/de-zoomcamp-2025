import pandas as pd
from sqlalchemy import create_engine
from time import time
import argparse, os


def main(params):
    user = params.user
    pw = params.pw
    host = params.host
    port = params.port
    db = params.db
    table = params.table
    url = params.url

    # Download CSV
    csv_name = f'{table}.csv.gz'
    os.system(f'curl -L {url} -o {csv_name}')

    # Connect to database
    engine = create_engine(f'postgresql://{user}:{pw}@{host}:{port}/{db}')

    # Process data in chunks
    df_iter = pd.read_csv(csv_name, compression='gzip', iterator=True, chunksize=100000)
    while True:
        try:
            df = next(df_iter)
            t_start = time()
            
            # Convert data type of datetime columns
            try:
                df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
                df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
            except AttributeError:
                df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
                df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

            # Insert into database
            df.to_sql(name=f'{table}', con=engine, if_exists='append')

            print(f'Inserted chunk in {time() - t_start} seconds')
        except StopIteration:
            print("All chunks processed.")
            break

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Load data in CSV files to Postgres.')

    parser.add_argument('--user', help='Postgres database username')
    parser.add_argument('--pw', help='Postgres database user password')
    parser.add_argument('--host', help='Postgres database host')
    parser.add_argument('--port', help='Postgres database port')
    parser.add_argument('--db', help='Postgres database name')
    parser.add_argument('--table', help='Postgres database table name')
    parser.add_argument('--url', help='URL of CSV file')

    args = parser.parse_args()

    main(args)