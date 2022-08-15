# dockerized-ingestion

### dockerized data ingestion to a database with: 
- docker 
- python and 
- linux shell scripts

# Steps for running files in the repository

- First install docker using the ```sh snap install docker ``` command from terminal.

- Check if docker installed properly using ```sh sudo docker run hello-world ```. This should give you a positive response (no daemon error) signifying that docker installed properly.

- Create a docker network that will be used to connect a database (localhost or cloud) to the docker container (images in the container) using the ```network create``` command. For this project, the command will look like this <br>
```sh sudo docker network create pg-network ```

- Start docker postgres image and map it to a memory space locally. Here I am using a virtualbox image from osboxes.org for this project. <br>
```sh sudo docker run -it   -e POSTGRES_USER="user"   -e POSTGRES_PASSWORD="your_password"   -e POSTGRES_DB="your_db_name"   -v /location of local db:/var/lib/postgresql/data   -p 5432:5432   --network=pg-network   --name=pg-database postgres:13 ```

- Start pgadmin image with the command below (locally). For an instance in any cloud service, the details for the cloud account will be used in place localhost and default port numbers. <br>
```sh sudo docker run -it   -e PGADMIN_DEFAULT_EMAIL="admin@admin.com"   -e PGADMIN_DEFAULT_PASSWORD="your_password  -p 8080:80  --network=pg-network  --name=pg-database dpage/pgadmin4 ```

- Build the docker container set up in the dockerfile using <br>
 ```sh sudo docker build -t container_name:version_name . ```

- Ingest data from docker image to localhost within a network <br>
```sh sudo docker run -it --network=pg-network container_name:version_name   --user=user   --password=your_password   --host=pgadmin4   --port=5432    --db=ny_taxi   --table_name=ny_taxi   --url="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-01.parquet" ```

- Within your browser, open a new tab and type the url ``` localhost:8080 ```. This will open the PgAdmin4 login page for you.

- Put in the username and password you specified in the shell command used for setting up the PgAdmin page. Click login to open the PgAdmin interface

- Right click on the server and select ``` Register``` to create a new server instance. Give your instance a name.

- Under the ```connections``` tab, type in the username and password you used in creating the Postgres Service and click on ```save``` or ```connect``` as the case may be.

- Expanding the server should reveal the database instance you chose while filling out the details of your instance. Expanding further ``` Schemas >> public >>  Table ``` will reveal the table we have specified in our shell commands used in the creation.

- Our table is set for further querying.
