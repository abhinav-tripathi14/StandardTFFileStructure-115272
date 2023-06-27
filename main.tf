terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.61.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.61.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest
provider "azurerm" {
  features {}
}


# https://registry.terraform.io/providers/hashicorp/hcp/latest
provider "hcp" {
}

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

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "ithc" {
  name     = var.resource_group_name
  location = var.azure_region
}

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