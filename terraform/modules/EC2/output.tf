output "" {
  value = aws_instance.host.ipv6_addresses
}

output "name" {
  value = aws_instance.database.ipv6_addresses
}