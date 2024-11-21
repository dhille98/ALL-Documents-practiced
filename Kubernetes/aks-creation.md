# create AKS cluster
* create aks cluster in commandline
* create `App registrations` in **azure EntraID** 
* give the subcreation leval permissions
* create `acess-key`
* install `azure cli` on OS
* install `kubectl ` command line tool
```bash
# Bash Shell
export ARM_CLIENT_ID="************"
export ARM_CLIENT_SECRET="*****"
export ARM_TENANT_ID="********"
export ARM_SUBSCRIPTION_ID="********"

```
* power shell
```ps1
$env:ARM_CLIENT_ID = "*********"
$env:ARM_CLIENT_SECRET = "*********"
$env:ARM_TENANT_ID = "*****************"
$env:ARM_SUBSCRIPTION_ID = "************"
```
* create aks cluster 
```sh
az provider register --namespace Microsoft.ContainerService # frist time

az provider show --namespace Microsoft.ContainerService --query "registrationState" # frist time 

az group create --name myaks-RG --location westus

az aks create --resource-group myaks-RG --name myaks --node-count 2 --generate-ssh-keys

az aks get-credentials --resource-group myaks-RG --name myaks --overwrite-existing

```