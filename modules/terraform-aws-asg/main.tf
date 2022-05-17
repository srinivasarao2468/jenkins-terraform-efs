resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = var.asg_name
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = var.launch_configuration
  vpc_zone_identifier       = var.subnet_ids
  depends_on = [var.launch_configuration, var.mount_target_dns_names]
  dynamic "tag" {
    for_each = var.tags
    content {
    key                 = tag.value["key"]
    value               = tag.value["value"]
    propagate_at_launch = tag.value["propagate_at_launch"]
    }
  }
}