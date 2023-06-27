# https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/packer_image
data "hcp_packer_image" "kali" {
  bucket_name    = "kali"
  channel        = "release"
  cloud_provider = "azure"
  region         = "uksouth"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network
data "azurerm_virtual_network" "ithc" {
  name                = var.vnet_name
  resource_group_name = var.network_resource_group
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
data "azurerm_subnet" "ithc" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.network_resource_group
}
