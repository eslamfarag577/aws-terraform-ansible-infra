module "global" {
  source = "/home/eslam/project/terraform/global"
}

module "networking" {
  source = "/home/eslam/project/terraform/modules/networking"
}

module "compute" {
  source             = "/home/eslam/project/terraform/modules/autoscaling"
  private_subnet_id  = module.networking.private_subnet_id
  region             = module.global.my_region
  lb_target_group = module.loadbalancer.target_group_arn
  ec2_security_group = module.security.ec2_security_group

}

module "loadbalancer" {
  source = "/home/eslam/project/terraform/modules/loadbalancer"  
  public_subnet_id  = module.networking.public_subnet_id
  vpc_id            = module.networking.vpc_id
  lb_security_group = module.security.lb_security_group
}

module "security" {
  source = "/home/eslam/project/terraform/modules/security_group"
  my_vpc = module.networking.vpc_id
}

module "database" {
  source             = "/home/eslam/project/terraform/modules/database"
  rds_security_group = module.security.rds_security_group
}


