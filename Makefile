h2_install:
	docker run -d -p 1521:1521 -p 81:81 -v /opt/h2-data:/opt/h2-data -e H2_OPTIONS='-ifNotExists' --name=MyH2Instance oscarfonts/h2

h2_delete:
	docker rm MyH2Instance

.PHONY: h2_install_db h2_delete