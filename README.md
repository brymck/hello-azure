hello-azure
===========

Hello on Azure

Dependencies
-------------

If you haven't already installed and set up Go and the Azure CLI, run this:

```sh
brew update
brew install azure-cli go || (brew update azure-cli go && brew cleanup azure-cli go)
az login
```

If you're behind a corporate proxy that does something dumb like using a self-signed cert, you may
need to have that proxy on and with the `HTTP_PROXY` and `HTTPS_PROXY` variables set correctly.

Manual stuff
------------

```sh
docker login --username <YOUR_USERNAME>
```

Blah
----

```sh
# Create a resource group
az group create --location japaneast --name HelloAzureResourceGroup

# Create a Linux app service
az appservice plan create --name HelloAzurePlan --resource-group HelloAzureResourceGroup --is-linux

# Azure requires web app names to be globally unique, so let's create our app suffixed with a UUID
uid="$(uuidgen)"
az webapp create --name "HelloAzureWebApp$uid" --plan HelloAzurePlan --resource-group \
  HelloAzureResourceGroup --deployment-container-image-name brymck/hello-azure

# Enable continuous deployment
az webapp deployment container config --enable-cd true --name "HelloAzureWebApp$uid" \
  --resource-group HelloAzureResourceGroup
```


[token]: https://github.com/settings/tokens/new
