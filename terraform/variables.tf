variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "prefix" {
  description = "Prefix used when naming resources"
  type        = string
  default     = "webtext"
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
  default     = "Denmark East"
}

variable "vm_size" {
  description = "Size of the Azure VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the local SSH public key used to log into the VM"
  type        = string
  default     = "~/.ssh/id_rsa_azure.pub"
}
