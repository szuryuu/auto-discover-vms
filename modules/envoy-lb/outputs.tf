output "name" {
  value = azurerm_linux_virtual_machine.envoy-lb.name
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.envoy-lb.public_ip_address
}

output "private_ip" {
  value = azurerm_linux_virtual_machine.envoy-lb.private_ip_address
}
