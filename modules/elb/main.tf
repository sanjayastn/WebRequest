# Defining the load balancer
resource "aws_lb" "elb" {
  name            = var.name
  internal        = var.internal
  security_groups = [var.security_group_id]
  subnets         = var.elb_subnets

}

# Defining the target group needed for the load balancer
resource "aws_lb_target_group" "targets" {
  name     = var.tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.tg_hc_path
    interval            = var.tg_hc_interval
    timeout             = var.tg_hc_timeout
    healthy_threshold   = var.tg_hc_healthy_threshold
    unhealthy_threshold = var.tg_hc_unhealthy_threshold
    protocol            = var.tg_hc_protocol
  }
}

# Defining the listner to forward traffic
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.elb.arn
  port              = var.lis_port
  protocol          = var.lis_protocol

  default_action {
    type             = var.lis_type
    target_group_arn = aws_lb_target_group.targets.arn
  }
}

