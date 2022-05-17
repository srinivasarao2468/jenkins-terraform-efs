resource "random_string" "random" {
  length           = 5
  special          = true
  override_special = "/@£$"
}
resource "aws_launch_configuration" "lc" {
  name_prefix = "${var.name_prefix}-${var.name}"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = data.template_file.userdata.rendered
  security_groups = local.security_groups
    lifecycle {
    create_before_destroy = true
  }

  root_block_device {
      volume_type = "standard"
      volume_size = 30
      encrypted = "false"
  }

}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata/userdata.sh")}"
  vars = {
    file_system_id = var.file_system_id
    region = var.region
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}