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

.PHONY: h2_install_db h2_delete h2_open postgres_install