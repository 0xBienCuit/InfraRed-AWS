resource "null_resource" "ansible_provisioner" {

  triggers = {
    policy_sha1 = sha1(file(var.playbook))
  }

  provisioner "local-exec" {
        command = "sleep 60; ansible-playbook ${join(" ", compact(var.arguments))} --user=${var.user} --private-key='${local.ssh-keys-path}/ec2_key.pem' -i ${var.ip},${join(" -e ", compact(var.envs))} --extra-vars 'ansible_python_interpreter=/usr/bin/python3' ${var.playbook}"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}