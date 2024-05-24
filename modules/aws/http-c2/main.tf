data "aws_region" "current" {}

resource "random_id" "server" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "http-c2" {
  key_name = "http-c2-key-${random_id.server.hex}"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "http-c2" {

  tags = {
    Name = "http-c2-${random_id.server.hex}"
  }

  ami = var.amis[data.aws_region.current.name]
  instance_type = var.instance_type
  key_name = aws_key_pair.http-c2.key_name
  vpc_security_group_ids = concat(var.security_groups,[aws_security_group.http-c2.id])
  subnet_id = var.subnet_id
  associate_public_ip_address = false

  #this provisioner exists for 2 reasons:
  # 1. To support custom scripts, which ideally should be included in an ansible role/task rather than invoked inline like this.
  # 2. To ensure that SSH is open before Ansible local-exec provisioner attempts its execution
  provisioner "remote-exec" {
    scripts = var.install

    connection {
        host = self.private_ip
        type = "ssh"
        user = var.user
        private_key = tls_private_key.ssh.private_key_pem
    }
  }

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.ssh.private_key_pem}\" > ${local.ssh-keys-path}/${self.private_ip} && echo \"${tls_private_key.ssh.public_key_openssh}\" > ${local.ssh-keys-path}/${self.private_ip}.pub && chmod 600 ${local.ssh-keys-path}/*"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ${path.root}/data/ssh_keys/${self.private_ip}"
  }

}

data "template_file" "ssh_config" {
  depends_on = [aws_instance.http-c2]

  template = file("${local.templates-path}/ssh_config.tpl")
  vars = {
    name = "http_c2_${aws_instance.http-c2.private_ip}"
    hostname = aws_instance.http-c2.private_ip
    user = var.user
    identityfile = "${local.ssh-keys-path}/${aws_instance.http-c2.private_ip}"
  }
}

resource "null_resource" "gen_ssh_config" {
  depends_on = [data.template_file.ssh_config]

  triggers = {
    template_rendered = data.template_file.ssh_config.rendered
    serverId = random_id.server.hex
    serverIp = aws_instance.http-c2.private_ip
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.ssh_config.rendered}' > ${local.ssh-configs-path}/${self.triggers.serverIp}_config"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ${path.root}/data/ssh_configs/${self.triggers.serverIp}_config"
  }
}
