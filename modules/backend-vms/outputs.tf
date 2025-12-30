output "vm_names" {
  value = azurerm_linux_virtual_machine.app_vm[*].name
}

output "public_ips" {
  value = azurerm_linux_virtual_machine.app_vm[*].public_ip_address
}

output "private_ips" {
  value = azurerm_linux_virtual_machine.app_vm[*].private_ip_address
}
