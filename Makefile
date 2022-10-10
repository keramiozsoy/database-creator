.PHONY: h2_install_db h2_remove h2_open couchbase_open
.PHONY: postgres_install postgres_createdb postgres_dropdb couchbase_install
.PHONY: mysql_install mysql_showdbs mysql_createdb mysql_dropdb
.PHONY: mssql_install mssql_showdbs mssql_createdb mssql_dropdb
.PHONY: mongo_install mongo_remove mongo_showdbs mongo_createdb

h2_install:
	docker run -d -p 1521:1521 -p 81:81 -v /opt/h2-data:/opt/h2-data -e H2_OPTIONS='-ifNotExists' --name=MyH2Instance oscarfonts/h2

h2_remove:
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

mongo_remove:
	docker rm mymongo

mongo_install:
	docker run -e "MONGO_INITDB_ROOT_USERNAME=root" -e "MONGO_INITDB_ROOT_PASSWORD=secret" -p 27017:27017 --name=mymongo -d mongo:latest

mongo_showdbs:
	docker exec -it mymongo /usr/bin/mongosh -u root -p secret --eval "show databases"

mongo_createdb:
	docker exec -it mymongo /usr/bin/mongosh -u root -p secret --eval "use testdb"

mongo_dropdb: 
	docker exec -it mymongo /usr/bin/mongosh -u root -p secret --eval "db.dropDatabase()"

couchbase_install:
	docker run -d --name couchbase-db -p 8091-8096:8091-8096 -p 11210-11211:11210-11211 couchbase:community

couchbase_open:
	open http://localhost:8091

