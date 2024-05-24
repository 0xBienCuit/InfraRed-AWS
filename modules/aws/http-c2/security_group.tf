resource "aws_security_group" "http-c2" {
  tags = {
    Name = "red-team-http-c2-${random_id.server.hex}"
  }
  name = "red-team-http-c2-${random_id.server.hex}"
  description = "Red Team Infra - HTTP C2"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = var.security_groups_inbound_http
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = var.security_groups_inbound_http
  }

  egress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow port 50050
  egress {
    from_port = 50050
    to_port = 50050
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
