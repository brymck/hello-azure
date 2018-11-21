.PHONY: build clean run

default: build

clean:
	rm helloazure
	rm -rf target

build:
	mkdir target
	env CGO_ENABLED=0 GOOS=linux go build -a -o target/hello-azure-linux .
	go build -o target/hello-azure .
	docker build --no-cache --rm --tag docker.io/${DOCKER_USERNAME}/hello-azure .

run: build
	target/hello-azure
