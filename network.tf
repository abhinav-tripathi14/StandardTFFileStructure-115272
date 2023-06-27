# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "ithc" {
  name                = "${var.common_resource_name}-public-ip"
  resource_group_name = azurerm_resource_group.ithc.name
  location            = azurerm_resource_group.ithc.location
  allocation_method   = "Static"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "ithc" {
  name                = "${var.common_resource_name}-nic"
  location            = azurerm_resource_group.ithc.location
  resource_group_name = azurerm_resource_group.ithc.name

  ip_configuration {
    name                          = "${var.common_resource_name}-ip-cfg"
    subnet_id                     = data.azurerm_subnet.ithc.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ithc.id
  }
}