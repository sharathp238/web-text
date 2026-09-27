output "public_ip_address" {
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
  description = "The Public IP address of the deployed Linux Virtual Machine"
}

output "ssh_connection_command" {
  value       = "ssh ${var.admin_username}@${azurerm_linux_virtual_machine.vm.public_ip_address}"
  description = "SSH Command to connect to the VM"
}
