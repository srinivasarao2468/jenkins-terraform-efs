resource "aws_launch_configuration" "lc" {
  name_prefix = "${var.app_name}-${var.name_prefix}-lc"
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
  name        = "${var.app_name}-lc-sg"
  description = "Allow all inbound traffic on specfied ports"
  vpc_id      = var.vpc_id
  
  ingress {
    description      = "all traffic on port 8080"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "all traffic on port 22"
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
    Name = "${var.app_name}-lc-sg"
  }
}