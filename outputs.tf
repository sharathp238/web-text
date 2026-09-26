output "resource_group_name" {
  description = "The name of the resource group in which resources were created."
  value       = azurerm_resource_group.rg.name
}

output "vm_id" {
  description = "The ID of the provisioned Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_private_ip" {
  description = "The private IP address of the Virtual Machine."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "virtual_network_name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}
