variable "name" {
    default = "jenkins-launch-config"
}

variable "name_prefix" {
  default = ""
}
variable "image_id" {
    default = "ami-0ff8a91507f77f867"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_name" {
    default = "jenkins-test"
}

#variable "user_data" {
#    default = "ls"
#}

variable "file_system_id" {
    default = ""
}

variable "region" {
    default = ""
}

variable "security_groups" {
  default = []
}

variable "vpc_id" {
  default = "vpc-0e189db93e233fdc7"
}