resource "aws_lb" "alb" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jenkins_alb_sg.id]
  subnets            = var.subnet_ids

  tags = {
    Name = "${var.app_name}-alb"
  }
}

resource "aws_security_group" "jenkins_alb_sg" {
  name        = "${var.app_name}-alb-sg"
  description = "Allow all inbound traffic on specfied ports"
  vpc_id      = var.vpc_id
  
  ingress {
    description      = "all traffic on port 8080"
    from_port        = 80
    to_port          = 80
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
    Name = "${var.app_name}-alb-sg"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.app_name}-lb-tg"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 30
    path = "/login"
    port = 8080
    unhealthy_threshold = 2
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.asg_id
  alb_target_group_arn    = aws_lb_target_group.lb_target_group.arn
}