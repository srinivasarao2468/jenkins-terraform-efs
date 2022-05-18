provider "aws" {
  region = var.region
}

module "efs" {
    source = "../../modules/terraform-aws-efs"
    app_name = var.app_name
    subnet_ids = var.subnet_ids
    vpc_id = var.vpc_id
}

module "lc" {
    source = "../../modules/terraform-aws-lc"
    app_name = var.app_name
    name_prefix = "blue"
    region = var.region
    file_system_id = module.efs.id
    vpc_id = var.vpc_id
}

module "asg" {
    source = "../../modules/terraform-aws-asg"
    app_name = var.app_name
    launch_configuration = module.lc.name
    subnet_ids = var.subnet_ids
    mount_target_dns_names = module.efs.mount_target_dns_names
}

module "alb" {
    source = "../../modules/terraform-aws-alb"
    app_name = var.app_name
    subnet_ids = var.subnet_ids
    vpc_id = var.vpc_id
    asg_id = module.asg.id
}

