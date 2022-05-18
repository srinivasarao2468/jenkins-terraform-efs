variable "region" {
    default = "us-east-1"
}

variable "app_name" {
  default = "jenkins"
}
variable "subnet_ids" {
  default = ["subnet-0d0ee9af02f44ded3", "subnet-05c63a6ab0a59de20"]
}

variable "vpc_id" {
  default = "vpc-0e189db93e233fdc7"
}