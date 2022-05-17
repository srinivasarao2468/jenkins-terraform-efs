provider "aws" {
  region = var.region
}

module "efs" {
    source = "../../modules/terraform-aws-efs"
    subnet_ids = var.subnet_ids
    vpc_id = var.vpc_id
}

module "lc" {
    source = "../../modules/terraform-aws-lc"
    name_prefix = "blue"
    region = var.region
    file_system_id = module.efs.id
    vpc_id = var.vpc_id
}

module "asg" {
    source = "../../modules/terraform-aws-asg"
    asg_name =  "jenkins-asg"
    launch_configuration = module.lc.name
    subnet_ids = var.subnet_ids
    mount_target_dns_names = module.efs.mount_target_dns_names
}


output "userdata" {
  value = module.lc.userdata
}
output "file_system_id" {
  value = module.efs.id
}
