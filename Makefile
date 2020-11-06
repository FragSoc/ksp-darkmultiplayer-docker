.PHONY: docker

docker: DMPServer
	docker build -t kspserver .

DMPServer.zip:
	wget "https://d-mp.org/builds/release/v0.3.6.0/DMPServer.zip"

DMPServer: DMPServer.zip
	unzip DMPServer.zip
