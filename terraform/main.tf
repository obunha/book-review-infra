module "network" {
  source           = "./modules/network"
  region           = var.region
  application_name = var.application_name
  environment      = var.environment
  vpc_cidr_block   = var.vpc_cidr_block
  subnet_cidr      = var.subnet_cidr
}

module "compute" {
  source            = "./modules/compute"
  region            = var.region
  admin_username    = var.admin_username
  admin_password    = var.admin_password
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.security_group_id
  application_name  = var.application_name
  environment       = var.environment
  instance_type     = var.instance_type
  ssh_key_name      = var.ssh_key_name
}

module "database" {
  source                    = "./modules/database"
  region                    = var.region
  mysql_admin_username      = var.mysql_admin_username
  mysql_admin_password      = var.mysql_admin_password
  mysql_database_name       = var.mysql_database_name
  subnet_ids                = [module.network.public_subnet_id]
  vpc_id                    = module.network.vpc_id
  backend_security_group_id = module.network.security_group_id
}
