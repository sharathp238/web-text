variable "resource_group_name" {
  type        = string
  default     = "webtext-rg"
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region for resource deployment"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key string for VM authentication"
  default     = ""
}

#variable "ssh_public_key_path" {
  #type        = string
  #default     = "~/.ssh/id_rsa.pub"
  #description = "Path to local SSH public key file if key string is not provided directly"
#}
