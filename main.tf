module "networks" {
  source = "./modules/networks"
  cidr_range = "10.0.0.0/16"
  vpc_name = "iot_vpc"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  private_subnets = ["10.0.7.0/24","10.0.8.0/24","10.0.9.0/24"]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networks.vpc_id
}

module "servers" {
  source = "./modules/servers"
  public_subnets = module.networks.public_subnets
  security_group_id = module.security.server_security_group_id
}

module "load_balancer" {
  source = "./modules/loadbalancers"
  vpc_id = module.networks.vpc_id
  instance_ids = module.servers.instance_ids
  security_groups = [module.security.lb_security_group_id]
  subnet_ids = module.networks.public_subnets
  instance_ips = module.servers.public_ips
}