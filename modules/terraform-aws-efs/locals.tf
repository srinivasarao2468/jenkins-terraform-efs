locals {
  security_groups = concat(var.security_groups, [aws_security_group.jenkins_efs_sg.id])
}