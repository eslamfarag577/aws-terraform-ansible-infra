output "target_group_arn" {
  value = aws_lb_target_group.targer_group.arn
}

output "lb_arn" {
  value = aws_lb.loadbalancer.arn
}

output "lb_dns_name" {
  value = aws_lb.loadbalancer.dns_name
}
