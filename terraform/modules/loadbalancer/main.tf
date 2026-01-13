#===============[targer_group]=======================
resource "aws_lb_target_group" "targer_group" {
  name        = "terraform-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}

#===============[loadbalancer]=======================
resource "aws_lb" "loadbalancer" {
  name                       = "terraform-loadbalancer"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = [var.public_subnet_id]
  enable_deletion_protection = true
  security_groups            = [var.lb_security_group]

  tags = {
    Environment = "production"
  }
}