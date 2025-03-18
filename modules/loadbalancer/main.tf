locals {
  # Replace underscores with hyphens for AWS resource naming requirements
  formatted_project_name = replace(var.project, "_", "-")
}

resource "aws_security_group" "alb" {
  name_prefix = "${local.formatted_project_name}-alb-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${local.formatted_project_name}-alb-sg" })
}

resource "aws_lb" "web" {
  name               = "${local.formatted_project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets           = var.subnet_ids

  tags = var.common_tags
}

resource "aws_lb_target_group" "web" {
  name     = "${local.formatted_project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval           = 15
    matcher            = "200"
    path               = "/"
    timeout            = 5
    unhealthy_threshold = 2
  }

  tags = var.common_tags
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = var.instance_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "another_instance" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = var.another_instance_id
  port             = 80
}
