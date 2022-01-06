.PHONY: h2_install_db h2_delete h2_open
.PHONY: postgres_install postgres_createdb postgres_dropdb 
.PHONY: mysql_install mysql_showdbs mysql_createdb mysql_dropdb
.PHONY: mssql_install mssql_showdbs mssql_createdb mssql_dropdb

h2_install:
	docker run -d -p 1521:1521 -p 81:81 -v /opt/h2-data:/opt/h2-data -e H2_OPTIONS='-ifNotExists' --name=MyH2Instance oscarfonts/h2

h2_delete:
	docker rm MyH2Instance

h2_open:
	open http://localhost:81

postgres_install:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

postgres_createdb:
	docker exec -it postgres12 createdb --username=root --owner=root test_db

postgres_dropdb:
	docker exec -it postgres12 dropdb test_db

mysql_install:
	docker run --name mysql8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

mysql_showdbs:
	docker exec -it mysql8 mysql --user=root --password=secret sys -e "SHOW DATABASES;"

mysql_createdb: 
	docker exec -it mysql8 mysql --user=root --password=secret sys -e "CREATE DATABASE test_db;"
	
mysql_dropdb: 
	docker exec -it mysql8 mysql --user=root --password=secret sys -e "DROP DATABASE test_db;"

mssql_install:
	docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=super_duper_secret" -p 1433:1433 --name=sqlserver2019 -d mcr.microsoft.com/mssql/server:2019-latest

mssql_showdbs:
	docker exec -it sqlserver2019 /opt/mssql-tools/bin/sqlcmd -s localhost -U SA -P super_duper_secret -q "SELECT name FROM sys.databases;" 

mssql_createdb:
	docker exec -it sqlserver2019  /opt/mssql-tools/bin/sqlcmd -s localhost -U SA -P super_duper_secret -q "CREATE DATABASE test_db;"

mssql_dropdb:
	docker exec -it sqlserver2019  /opt/mssql-tools/bin/sqlcmd -s localhost -U SA -P super_duper_secret -q "DROP DATABASE test_db;" 	