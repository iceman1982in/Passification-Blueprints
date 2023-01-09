output "id" {
  description = "The ID of the private dns"
  value       = data.azurerm_private_dns_zone.priv-dns.id
}
