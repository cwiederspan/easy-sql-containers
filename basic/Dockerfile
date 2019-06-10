FROM mcr.microsoft.com/mssql/server:2017-latest

# Import the public repository GPG keys
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc |  apt-key add -

# Update the list of products
RUN apt-get update

# install curl
RUN apt-get install curl -y

# Register the Microsoft Ubuntu repository
RUN curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list

# Update the list of products
RUN apt-get update

# Install mssql-cli
RUN apt-get install mssql-cli  