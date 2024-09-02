resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name} Internet Gateway"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "${var.vpc_name} Public Subnet"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.vpc_name} Public Route Table"
  }
}

resource "aws_route_table_association" "route_table_as_public" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.route_table_public.id
}