variable "azure_region" {
  type        = string
  description = "The region in which to create the ithc resources"
  default     = "uksouth"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the ithc infrastructure"
  default     = "ithc-preprod"
}

variable "network_resource_group" {
  type        = string
  description = "The name of the existing resource group in which the network infrastructure is hosted. This is used for the vnet and subnet lookups."
  default     = "benh-azure-infra"
}

variable "vnet_name" {
  type        = string
  description = "The name of the existing vnet that will be used by the ithc infrastructure"
  default     = "benh-azure-infra-network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the existing subnet that will be used by the ithc infrastructure"
  default     = "benh-azure-infra-subnet"
}
variable "common_resource_name" {
  type        = string
  description = "The common resource to be used as a prefix for all resources created within the ithc resource group"
default = "testabhinav"
}
