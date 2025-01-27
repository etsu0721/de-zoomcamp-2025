FROM python:3.9
RUN pip install pandas sqlalchemy psycopg2
WORKDIR /app
COPY load-data.py load-data.py
ENTRYPOINT [ "python", "load-data.py" ]