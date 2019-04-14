# Easy SQL Containers

A container-based approach to using SQL Server for non-production uses such as testing, demos, etc.

## Inspiration

Inspired by [this great article](http://tattoocoder.com/open-source-tools-for-sql-server-on-linux-2/) from Shayne Boyer!

To get started, clone this repository to your machine so you have the **Dockerfile** that is included with this repo.

## Local Option

```bash

# Build the image locally
docker build -t microsoft/mssql-server-linux:2017-latest-cli .

# Run the image locally before pushing to Docker Hub
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=dUmmyP@ssw0rd' -p 1433:1433 --name sql_server -d microsoft/mssql-server-linux:2017-latest-cli

# Prove it works by connecting to it and running some mssql-cli commands
docker exec -it sql_server mssql-cli

# BONUS: Instead of the Azure Cloud Option below, you can also just push this image to the registry

# Push it to Docker Hub
docker tag microsoft/mssql-server-linux:2017-latest-cli cdwms.azurecr.io/microsoft/mssql-server-linux:2017-latest-cli

# Log into the Azure Container Registry
az acr login --name cdwms

# Push the image up to the Azure container registry
docker push cdwms.azurecr.io/microsoft/mssql-server-linux:2017-latest-cli
```

## Azure Cloud Option

```bash

# Build the image directly within the Azure Container Registry
az acr build -r cdwms -t microsoft/mssql-server-linux:2017-latest-cli .

# Create a resource group, if needed
az group create -n cdw-sqlserver-20190413 -l westus

# Create an Azure Container Instance (ACI) to test the container in the cloud
az container create \
    --name cdw-sqlserver-20190413 \
    --resource-group cdw-sqlserver-20190413 \
    --location westus \
    --image cdwms.azurecr.io/microsoft/mssql-server-linux:2017-latest-cli \
    --registry-username cdwms \
    --registry-password YOUR_PASSWORD_HERE \
    --ports 1433 \
    --vnet cdw-sqlvnet-20190413 \
    --vnet-address-prefix 10.0.0.0/16 \
    --subnet aci_sql_subnet_01 \
    --subnet-address-prefix 10.0.0.0/24 \
    --environment-variables ACCEPT_EULA=Y SA_PASSWORD=dUmmyP@ssw0rd

# Connect to the container and run some SQL commands
az container exec -g cdw-sqlserver-20190413 -n cdw-sqlserver-20190413 --exec-command mssql-cli  
```