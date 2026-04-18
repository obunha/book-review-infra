variable "region" {}
variable "mysql_admin_username" {}
variable "mysql_admin_password" {
  sensitive = true
}
variable "mysql_database_name" {}
variable "application_name" {}
variable "environment" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "backend_security_group_id" {}
