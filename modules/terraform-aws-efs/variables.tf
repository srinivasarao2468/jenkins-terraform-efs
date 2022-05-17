variable "creation_token" {
    default = "my-token"
}

variable "is_encrypted" {
    default = false
}

variable "performance_mode" {
    default = "generalPurpose"
}

variable "is_backup_policy_status" {
    default = "DISABLED"
}

variable "tags" {
    default = {
        "Name" = "jenkins-file-system"
        }
}

variable "subnet_ids" {
  default =[]
}

variable "vpc_id" {
  default = "vpc-0e189db93e233fdc7"
}

variable "security_groups" {
    default = []
}