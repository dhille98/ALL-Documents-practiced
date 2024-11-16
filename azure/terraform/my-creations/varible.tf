variable "address_block" {
    type = list(string)
    default = [ "10.45.0.0/16" ]
   
  
}

variable "sub_cidr" {
    type = list(string)
    default = [ "10.45.10.0/24", "10.45.20.0/24", "10.45.30.0/24", "10.45.40.0/24", "10.45.1.0/24"  ]
  
}

variable "subnet_name" {
    type = list(string)
    default = [ "AzureFirewallSubnet", "AzureBastionSubnet", "GatewaySubnet", "PvtEndpointSubnet", "JumpServerSubnet" ]
  
}