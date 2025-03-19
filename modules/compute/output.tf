output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.main.ip_address
}
output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_virtual_machine.vm.id
}