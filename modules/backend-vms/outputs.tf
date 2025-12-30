output "vm_names" {
  value = azurerm_virtual_machine.app_vm[*].name
}
