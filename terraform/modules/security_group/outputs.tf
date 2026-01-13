output "lb_security_group" {
  value = aws_security_group.sg_elb.id
}

output "ec2_security_group" {
  value = aws_security_group.sg_ec2.id
}

output "rds_security_group" {
  value = aws_security_group.sg_rds.id
}