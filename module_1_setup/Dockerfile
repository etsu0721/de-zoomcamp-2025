FROM python:3.9
RUN pip install pandas sqlalchemy psycopg2
WORKDIR /app
COPY ingest-taxi-trips.py ingest-taxi-trips.py
ENTRYPOINT [ "python", "ingest-taxi-trips.py" ]