resource "aws_security_group" "http-c2" {
  name = "red-team-http-c2-${random_id.server.hex}"
  description = "Red Team Infra - HTTP C2"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "red-team-http-c2-${random_id.server.hex}"
  }
}