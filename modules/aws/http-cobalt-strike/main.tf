data "aws_region" "current" {}

resource "random_id" "server" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_key_pair" "http-c2" {
  key_name = "http-c2-key-${random_id.server.hex}"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "http-c2" {
  tags = {
    Name = "http-c2-${random_id.server.hex}"
  }

  ami = var.ami-ubuntu
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids = [aws_security_group.teamserver_sg.id]
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  #this provisioner exists for 2 reasons:
    # 1. To support custom scripts, which ideally should be included in an ansible role/task rather than invoked inline like this.
    # 2. To ensure that SSH is open before Ansible local-exec provisioner attempts its execution
  provisioner "remote-exec" {
inline = ["echo 'Hello, World!'"]
    connection {
        type = "ssh"
        user = var.user
        private_key = file("./data/ssh_keys/ec2_key.pem")
	      host = self.public_ip
    }
  }

   provisioner "local-exec" {
    command ="echo \"${tls_private_key.ssh.private_key_pem}\" > ${local.ssh-keys-path}/${self.private_ip} && echo \"${tls_private_key.ssh.public_key_openssh}\" > ${local.ssh-keys-path}/${self.private_ip}.pub && chmod 600 ${local.ssh-keys-path}/*"
   }

  # provisioner "local-exec" {
  #   when = destroy
  #   command = "rm ${path.root}/data/ssh_keys/${self.private_ip}"
  # }

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

  # provisioner "local-exec" {
  #   when = destroy
  #   command = "rm ${path.root}/data/ssh_configs/${self.triggers.serverIp}_config"
  # }

}
module "http-cs-config-ansible"{
  source = "../../../nb_modules/ansible"
  depends_on = [aws_instance.http-c2, null_resource.gen_ssh_config]

  user = var.user
  playbook = local.ansible-playbook
  ip = aws_instance.http-c2.public_ip
}

module "http-cs-ansible"{
  source = "../../../nb_modules/ansible"
  

  user = var.user
  playbook = local.cs-ansible-playbook
  ip = aws_instance.http-c2.public_ip
}




