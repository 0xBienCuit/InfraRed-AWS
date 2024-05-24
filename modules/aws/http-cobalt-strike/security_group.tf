resource "aws_security_group" "teamserver_sg" {
  name   = "teamserver_security-group"
  vpc_id = var.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description     = "TCP 443"
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
  }

  ingress {
    description     = "TCP 31337"
    from_port       = 50050
    to_port         = 50050
    protocol        = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  #Restricted access to the management services from our allowed source IPS.
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.ssh_ipv4_cidr_blocks
  }

  # The team server has unlimited access to the internet
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 

  tags = {
    Name = "teamserver_sg"
  }
}