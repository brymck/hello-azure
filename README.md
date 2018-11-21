hello-azure
===========

Hello on Azure

Dependencies
------------

If you haven't already installed and set up Go and the Azure CLI, run this:

```sh
DEPENDENCIES=(
  azure-cli
  cmake
  go
)
brew update
brew install $DEPENDENCIES || (brew update $DEPENDENCIES && brew cleanup $DEPENDENCIES)
```

You should also make sure you can log in to Azure with the CLI:

```sh
az login
```

If you want to build a Docker image locally, I'll also assume you have a [desktop
installation][install_docker], your username is set in the `DOCKER_USERNAME` environment variable,
and you've managed to log in at the command line:

```sh
docker login --username "$DOCKER_USERNAME"
```

Build everything
----------------

Just run `make`


Deployment
----------

Create a resource group:

```sh
az group create \
  --location japaneast \
  --name HelloAzureResourceGroup
```

Create a Linux app service:

```sh
az appservice plan create --name HelloAzurePlan --resource-group HelloAzureResourceGroup --is-linux
```

Azure requires web app names to be globally unique, so let's create our app suffixed with a UUID:

```sh
uid="$(uuidgen)"
az webapp create --name "HelloAzureWebApp$uid" --plan HelloAzurePlan --resource-group \
  HelloAzureResourceGroup --deployment-container-image-name brymck/hello-azure
```

Enable continuous deployment, which defaults to being off:

```sh
az webapp deployment container config --enable-cd true --name "HelloAzureWebApp$uid" \
  --resource-group HelloAzureResourceGroup
```

Listen on port 80 for web traffic:

```sh
az webapp config appsettings set --settings WEBSITES_PORT=80 --name "HelloAzureWebApp$uid" \
  --resource-group HelloAzureResourceGroup
```

Get the URL:

```sh
az webapp show --name "HelloAzureWebApp$uid" --resource-group HelloAzureResourceGroup --output tsv \
  --query 'defaultHostName' | xargs -I {} echo 'https://{}'
```

Create a container registry

```sh
az acr create --name HelloAzureRegistry --resource-group HelloAzureResourceGroup --sku Basic
```

Deleting everything
-------------------

```sh
az webapp delete --name "HelloAzureWebApp$uid" --resource-group HelloAzureResourceGroup

az group delete --name HelloAzureResourceGroup
```


[install_docker]: https://www.docker.com/products/docker-desktop
[token]: https://github.com/settings/tokens/new
