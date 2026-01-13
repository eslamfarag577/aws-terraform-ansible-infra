resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "terraform_vpc"
  }
}

#===============[publice subnet]=======================
resource "aws_subnet" "publice_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_publice_subnet"
  }
}

#===============[private subnet]=======================
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "terraform_private_subnet"
  }
}

#===============[internet_gateway]=======================
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "terrafrom_internet_gateway"
  }
}

#===============[nat_gateway]=======================
resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.publice_subnet.id

  tags = {
    Name = "terraform_NAT_Gateway"
  }

  depends_on = [aws_internet_gateway.gateway]
}

#===============[publice_route_table]=======================
resource "aws_route_table" "publice_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }


  tags = {
    Name = "terrafrom_publice_route_table"
  }
}

resource "aws_route_table_association" "publice_route_table_rule" {
  subnet_id      = aws_subnet.publice_subnet.id
  route_table_id = aws_route_table.publice_route_table.id
}

#===============[private_route_table]=======================
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }


  tags = {
    Name = "terrafrom_private_route_table"
  }
}

resource "aws_route_table_association" "private_route_table_rule" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}