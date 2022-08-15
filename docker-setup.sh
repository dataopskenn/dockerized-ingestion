sudo docker build -t test:pycontainer # build the container of images in the docker container

sudo docker run -it test:pycontainer  # run the container to create and execute commands in the images

python main_ingest.py # run data engineering pipeline

#start docker postgres image and map it to a memory space locally
sudo docker run -it   -e POSTGRES_USER="osboxes"   -e POSTGRES_PASSWORD="osboxes.org"   -e POSTGRES_DB="ny_taxi"   -v /home/Projects/docker-container/postgres_db:/var/lib/postgresql/data   -p 5432:5432   --network=pg-network   --name=pg-database postgres:13 

# setup PostgreSQL-14 database locally
sudo apt-get install -y postgresql-14

# set up pgcli and psycopg2
sudo apt-get install libpq-dev
sudo pip install psycopg2
sudo pip install pgcli

# start postgresql pgcli client in terminal
sudo pgcli   -h 0.0.0.0   -u osboxes   -p 5432   -d ny_taxi

# download ny taxi trips data
sudo wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-04.parquet

# start pgadmin image
sudo docker run -it   -e PGADMIN_DEFAULT_EMAIL="admin@admin.com"   -e PGADMIN_DEFAULT_PASSWORD="osboxes.org"  -p 8080:80  --network=pg-network  --name=pg-database dpage/pgadmin4 

URL = "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-04.parquet"

# Locally ingest data into Postgres database
sudo docker run -it   --user=osboxes   --password=osboxes.org   --host=0.0.0.0   --port=5432    --db=ny_taxi   --table_name=ny_taxi   --url="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-01.parquet"

# Ingest data from docker image to localhost within a network
sudo docker run -it --network=pg-network taxi_ingest:v001   --user=osboxes   --password=osboxes.org   --host=pg-database   --port=5432    --db=ny_taxi   --table_name=ny_taxi   --url="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-01.parquet"

