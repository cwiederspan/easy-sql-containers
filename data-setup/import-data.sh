# wait for the SQL Server to come up
sleep 30s

# run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P dUmmyP@ssw0rd -d master -i setup.sql