resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_name                = "terraform"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "eslam"
  password               = "asd@123"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [ var.rds_security_group ]
}