output "name" {
  value = azurerm_linux_virtual_machine.monitor.name
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.monitor.public_ip_address
}

output "private_ip" {
  value = azurerm_linux_virtual_machine.monitor.private_ip_address
}
