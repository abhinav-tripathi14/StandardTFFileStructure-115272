# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "ithc" {
  name                = "${var.common_resource_name}-boomerang"
  resource_group_name = azurerm_resource_group.ithc.name
  location            = azurerm_resource_group.ithc.location
  size                = "Standard_D4as_v5"
  admin_username      = "kaliuser"
  network_interface_ids = [
    azurerm_network_interface.ithc.id
  ]

  admin_ssh_key {
    username   = "kaliuser"
    public_key = var.admin_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.hcp_packer_image.kali.cloud_image_id

  plan {
    name      = "kali-2023-2"
    publisher = "kali-linux"
    product   = "kali"
  }
}