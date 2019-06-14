# Setup

Based on this [GitHub repo](https://github.com/twright-msft/mssql-node-docker-demo-app).

## Build

```bash

# Build the container image
docker build -t cdwms.azurecr.io/microsoft/mssql-server-linux:2017-latest-cli-with-data .

# Spin up the container with data
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=dUmmyP@ssw0rd' -p 1433:1433 --name sql_server_test -d cdwms.azurecr.io/microsoft/mssql-server-linux:2017-latest-cli-with-data

# View the log files
docker logs <CONTAINER_ID>

# Prove it works by connecting to it and running some mssql-cli commands
docker exec -it sql_server_test mssql-cli

# Push the image up to the Azure container registry
docker push cdwms.azurecr.io/microsoft/mssql-server-linux:2017-latest-cli-with-data
```