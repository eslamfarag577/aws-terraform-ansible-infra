output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

output "public_subnet_id" {
  value = aws_subnet.publice_subnet.id
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}