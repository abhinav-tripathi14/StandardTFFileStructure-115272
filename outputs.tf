output "assigned_static_public_ip" {
  description = "the static public ip address assigned to the compute resource"
  value       = azurerm_public_ip.ithc.ip_address
}

output "assigned_admin_user" {
  description = "the admin user assigned to the compute resource"
  value       = azurerm_linux_virtual_machine.ithc.admin_username
}