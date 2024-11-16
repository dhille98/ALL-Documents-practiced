resource "azurerm_resource_group" "my-resouces" {
  name     = "AZB45-HUB-RG"
  location = "centeralindia"
}

resource "azurerm_virtual_network" "my-net" {
  name = "AZB45-HUB-RG-VNET-1"
  address_space = var.address_block
  resource_group_name = azurerm_resource_group.my-resouces.name
  location = azurerm_resource_group.my-resouces.location
  

}



