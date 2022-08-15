FROM python:3.9

RUN apt-get install wget
RUN pip install pandas numpy SQLAlchemy pyarrow requests psycopg2

WORKDIR /app

COPY main_ingest.py main_ingest.py

ENTRYPOINT [ "python", "main_ingest.py" ]