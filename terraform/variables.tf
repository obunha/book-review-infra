variable "application_name" {
  description = "Application name prefix"
  type        = string
}

variable "environment" {
  description = "Deployment environment like dev, uat, prod"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  description = "Password for admin user on virtual machines"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  type = string
}

variable "mysql_admin_username" {
  description = "Username for MySQL RDS admin"
  type        = string
}

variable "mysql_admin_password" {
  description = "Password for MySQL RDS admin"
  type        = string
  sensitive   = true
}

variable "mysql_database_name" {
  description = "Database name for Book Review App"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
}
