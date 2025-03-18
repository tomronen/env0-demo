module "networking" {
  source = "./modules/networking"
  
  vpc_cidr     = var.vpc_cidr
  project      = var.project
  common_tags  = local.common_tags
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  
  project      = var.project
  vpc_id       = module.networking.vpc_id
  subnet_ids   = module.networking.public_subnet_ids
  instance_id  = module.compute.instance_id
  common_tags  = local.common_tags
}

module "compute" {
  source = "./modules/compute"
  
  project               = var.project
  vpc_id               = module.networking.vpc_id
  subnet_id            = module.networking.public_subnet_ids[0]
  instance_type        = var.instance_type
  alb_security_group_id = module.loadbalancer.alb_security_group_id
  common_tags          = local.common_tags
}

output "another_instance_public_ip" {
  description = "Public IP of the another EC2 instance"
  value       = module.compute.another_instance_public_ip
}
