.PHONY: all build docker-image docker-push

all: build docker-image docker-push

build:
	go get -v -d
	env CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-s' -o main

docker-image:
	docker build --tag brymck/hello-azure .

docker-push:
	@[ -f ${HOME}/.dockercfg ] || docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}"
	docker push brymck/hello-azure
