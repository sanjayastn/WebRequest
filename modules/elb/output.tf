output "dns_name" {
  value = aws_lb.elb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.targets.arn
}
