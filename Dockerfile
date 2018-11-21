FROM iron/base

RUN mkdir /app
COPY target/hello-azure-linux /app/hello-azure
WORKDIR /app

ENTRYPOINT ["./hello-azure"]
