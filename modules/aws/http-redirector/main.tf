data "aws_region" "current" {}

resource "random_id" "server" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_key_pair" "http-rdir" {
  key_name   = "http-rdir-key-${random_id.server.hex}"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "http-rdir" {
  tags = {
    Name = "http-rdir-${random_id.server.hex}"
  }

  ami                         = var.ami-ubuntu
  instance_type               = "t2.micro"
  key_name                    = var.private_key
  vpc_security_group_ids      = [aws_security_group.https_redirector_sg.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = ["echo 'Hello, World!'"]
    connection {
      type        = "ssh"
      user        = var.user
      private_key = file("./data/ssh_keys/ec2_key.pem")
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.ssh.private_key_pem}\" > ${local.ssh-keys-path}/${self.private_ip} && echo \"${tls_private_key.ssh.public_key_openssh}\" > ${local.ssh-keys-path}/${self.private_ip}.pub && chmod 600 ${local.ssh-keys-path}/*"
  }
}

data "template_file" "ssh_config" {
  depends_on = [aws_instance.http-rdir]

  template = file("${local.templates-path}/ssh_config.tpl")
  vars = {
    name         = "http_rdir_${aws_instance.http-rdir.private_ip}"
    hostname     = aws_instance.http-rdir.private_ip
    user         = var.user
    identityfile = "${local.ssh-keys-path}/${aws_instance.http-rdir.private_ip}"
  }

}

resource "null_resource" "gen_ssh_config" {
  depends_on = [data.template_file.ssh_config]

  triggers = {
    template_rendered = data.template_file.ssh_config.rendered
    serverId          = random_id.server.hex
    serverIp          = aws_instance.http-rdir.private_ip
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.ssh_config.rendered}' > ${local.ssh-configs-path}/${self.triggers.serverIp}_config"
  }

}


module "http-rdir-config-ansible" {
  source     = "../../../nb_modules/ansible"
  depends_on = [aws_instance.http-rdir, null_resource.gen_ssh_config]

  user     = var.user
  playbook = local.ansible-playbook
  ip       = aws_instance.http-rdir.public_ip
}

module "http-rdir-ansible" {
  source     = "../../../nb_modules/ansible"
  depends_on = [module.http-rdir-config-ansible]

  user      = var.user
  playbook  = local.ansible-rdir-playbook
  arguments = ["--extra-vars 'redirect_to=${var.redirect_to} redirector_type=http'"]
  ip        = aws_instance.http-rdir.public_ip
}

