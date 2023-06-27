# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "ithc" {
  name     = var.resource_group_name
  location = var.azure_region
}