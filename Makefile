.PHONY: all build docker-image docker-push

all: build docker-image docker-push

build:
	go get -v -d
	env CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-s' -o main

docker-image:
	docker build --tag brymck/hello-azure .

docker-push:
	echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin
	docker push brymck/hello-azure
