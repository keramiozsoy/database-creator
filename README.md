# database-creator

Create Docker Container Of Database What You Choose via Makefile


# supported dbs

- h2
- postgres
- mysql
- mssql
- mongo
- couchbase


# commands

- h2
~~~
make h2_install
make h2_remove
make h2_open
~~~

- postgres
~~~
make postgres_install 
make postgres_createdb 
make postgres_dropdb
~~~

- mysql
~~~
make mysql_install 
make mysql_showdbs 
make mysql_createdb 
make mysql_dropdb
~~~

- mssql
~~~
make mssql_install 
make mssql_showdbs 
make mssql_createdb 
make mssql_dropdb
~~~


- mongo
~~~
make mongo_install 
make mongo_remove
make mongo_showdbs 
make mongo_createdb 
make mongo_dropdb
~~~

- couchbase
~~~
make couchbase_install
make couchbase_open
~~~


