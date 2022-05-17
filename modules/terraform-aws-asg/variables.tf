variable "launch_configuration" {
    default = ""
}

variable "subnet_ids" {
  default = []
}

variable "mount_target_dns_names" { 
}

variable "tags" {
  default = [{
    key = "Name"
    value = "jenkins-asg"
    propagate_at_launch = true
  }]
}
variable "asg_name" { 
}
