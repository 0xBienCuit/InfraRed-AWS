output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main_subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}
