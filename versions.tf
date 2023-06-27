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