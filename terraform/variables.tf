variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
  default     = "rg-webtext"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "East US"
}

variable "prefix" {
  type        = string
  description = "Prefix appended to resource names"
  default     = "webtext"
}

variable "vm_size" {
  type        = string
  description = "Size/SKU of the Azure Virtual Machine"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Administrator username for the VM"
  default     = "azureadmin"
}

variable "admin_password" {
  type        = string
  description = "Administrator password for the VM"
  sensitive   = true
}
