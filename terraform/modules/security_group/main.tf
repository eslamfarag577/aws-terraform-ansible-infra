#===============[NLB security group (public)]=======================
resource "aws_security_group" "sg_elb" {
  name   = "terraform_sg_elb"
  vpc_id = var.my_vpc

  tags = { Name = "loadbalancer" }
}
resource "aws_security_group_rule" "nlb_ingress_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_elb.id
}
resource "aws_security_group_rule" "nlb_ingress_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_elb.id
}
resource "aws_security_group_rule" "nlb_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_elb.id
}

#===============[EC2 / ASG security group (private)]=======================
resource "aws_security_group" "sg_ec2" {
  name   = "terraform_sg_ec2"
  vpc_id = var.my_vpc

  tags = { Name = "web_ec2" }
}
resource "aws_security_group_rule" "ec2_ingress_80_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_ec2.id
  source_security_group_id = aws_security_group.sg_elb.id
}
resource "aws_security_group_rule" "ec2_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}

#===============[RDS security group (private)]=======================
resource "aws_security_group" "sg_rds" {
  name   = "terraform_sg_rds"
  vpc_id = var.my_vpc

  tags = { Name = "rds" }
}
resource "aws_security_group_rule" "rds_ingress_mysql_from_ec2" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_rds.id
  source_security_group_id = aws_security_group.sg_ec2.id
}
resource "aws_security_group_rule" "rds_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_rds.id
}
