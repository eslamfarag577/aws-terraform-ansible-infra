variable "private_subnet_id" {
  type = string
}

variable "region" {
  type = string
}

variable "lb_target_group" {
  type = string
}

variable "private_ip" {
  type    = list(string)
  default = ["172.16.10.100"]
}

variable "ec2_security_group" {
  type = string
}