# create a Resoureces Group 

```sh  
    az account list-locations -o table
    RG=AZB45-HUB-RG
    az group create --name ${RG} --location uksouth 
    az group list
```
AzureBastionSubnet
### create VNet azure and subnetes in EAST US

```sh
    RG1=AZB45-HUB-RG
    az network vnet create --name HUB-VNet-1 --resource-group ${RG1} --address-prefix 10.45.0.0/16 --location uksouth 
    az network vnet subnet create --name AzureFirewallSubnet --resource-group ${RG1} --vnet-name HUB-VNet-1 --address-prefix 10.45.10.0/24
    az network vnet subnet create --name AzureBastionSubnet --resource-group ${RG1} --vnet-name HUB-VNet-1 --address-prefix 10.45.20.0/24
    az network vnet subnet create --name GatewaySubnet --resource-group ${RG1} --vnet-name HUB-VNet-1 --address-prefix 10.45.30.0/24
    az network vnet subnet create --name PvtEndPointSubnnet --resource-group ${RG1} --vnet-name HUB-VNet-1 --address-prefix 10.45.40.0/24
    az network vnet subnet create --name JumpServerSubnet --resource-group ${RG1} --vnet-name HUB-VNet-1 --address-prefix 10.45.1.0/24


    echo "Creating NSG and NSG Rule"
    RG=AZB45-HUB-RG
    az network nsg create -g ${RG} -n ${RG}_NSG1 --location uksouth 
    az network nsg rule create -g ${RG} --nsg-name ${RG}_NSG1 -n ${RG}_NSG1_RULE1 --priority 100 \
    --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' \
    --destination-port-ranges '*' --access Allow --protocol Tcp --description "Allowing All Traffic For Now"
    az network nsg rule create -g ${RG} --nsg-name ${RG}_NSG1 -n ${RG}_NSG1_RULE2 --priority 101 \
    --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' \
    --destination-port-ranges '*' --access Allow --protocol Icmp --description "Allowing ICMP Traffic For Now"

### create a vm in azure 
IMAGE='Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest'
RG=AZB45-HUB-RG
echo "Creating Virtual Machines"
az vm create --resource-group ${RG} --name HUBLINUXVM01 --image $IMAGE --vnet-name ${RG}-vNET1 \
    --subnet JumpServersSubnet --admin-username adminsree --admin-password "India@123456" --size Standard_B1s \
    --nsg ${RG}_NSG1 --storage-sku StandardSSD_LRS --private-ip-address 10.45.1.10 \
    --zone 1 --os-disk-delete-option Delete --nic-delete-option Delete --security-type Standard

```
### create a vm in azure 




* create a another resouce group and vnet

```sh
    RG2=AZB45-SP1-RG
    az group create --name ${RG2} --location centralindia
    az network vnet create --name AZB45-SP1-VNet  --resource-group ${RG2} --address-prefix 172.16.0.0/16 --location centralindia
    az network vnet subnet create --name AZB45-SP1-Subnet1 --resource-group ${RG2} --vnet-name AZB45-SP1-VNet --address-prefix 172.16.10.0/24
    # create pvt subnet

```


```sh
    RG3=AZB45-SP2-RG
    az group create --name ${RG3} --location westus
    az network vnet create --name AZB45-SP2-VNet  --resource-group AZB45-SP2-RG --address-prefix 172.17.0.0/16 --location westus
    az network vnet subnet create --name AZB45-SP2-Subnet1 --resource-group AZB45-SP2-RG --vnet-name AZB45-SP2-VNet --address-prefix 172.17.10.0/24
    # create pvt subnet
```