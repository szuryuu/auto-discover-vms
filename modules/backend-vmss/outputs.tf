output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_linux_virtual_machine_scale_set.backend.name
}

output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_linux_virtual_machine_scale_set.backend.id
}

output "instances" {
  description = "The number of instances in the virtual machine scale set"
  value       = azurerm_linux_virtual_machine_scale_set.backend.instances
}
