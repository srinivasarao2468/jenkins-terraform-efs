resource "aws_efs_file_system" "efs_file_system" {
  creation_token = var.creation_token
  encrypted = var.is_encrypted
  performance_mode  = var.performance_mode 
  tags = var.tags
}


resource "aws_efs_mount_target" "efs_mount_target" {
  count = length(var.subnet_ids)
  file_system_id = aws_efs_file_system.efs_file_system.id
  subnet_id      = var.subnet_ids[count.index]
  security_groups = local.security_groups
}

#resource "aws_efs_backup_policy" "efs_backup_policy" {
#  file_system_id = aws_efs_file_system.efs_file_system.id
#
# backup_policy {
#    status = var.is_backup_policy_status
#  }
#}

resource "aws_security_group" "jenkins_efs_sg" {
  name        = "jenkins-efs-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
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