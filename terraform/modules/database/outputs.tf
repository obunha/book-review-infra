output "mysql_fqdn" {
  value = aws_db_instance.mysql.endpoint
}

output "mysql_port" {
  value = aws_db_instance.mysql.port
}
