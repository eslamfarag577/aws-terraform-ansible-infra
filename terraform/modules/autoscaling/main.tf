#===============[template]=======================
resource "aws_launch_template" "template" {
  name_prefix            = "terraform_template"
  image_id               = "ami-0ecb62995f68bb549"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.ec2_security_group]
  user_data = <<-EOF
  #!/bin/bash
  apt update
  apt install -y ansible git

  sudo ansible-pull \
    -U https://github.com/yourname/ansible-repo.git \
    -i localhost, \
    site.yml
  EOF
}

#===============[autoscaling_group]=======================
resource "aws_autoscaling_group" "autoscaling" {
  desired_capacity    = 1
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = [ var.private_subnet_id ]
  target_group_arns   = [var.lb_target_group]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}
