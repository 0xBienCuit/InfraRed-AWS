module "cs-ansible-config" {
  source = "../ansible"

  # managed
  user = var.user-ansible
  playbook = local.ansible-cs-playbook
  ip = var.ip

}

module "ansible-cs" {
  source = "../ansible"
  depends_on = [ module.cs-ansible-config ]

  user = var.user-ansible
  playbook = local.ansible-cs-playbook
  ip = var.ip
  arguments = concat(["--extra-vars 'bind_address=${var.bind-address} teamserver_password=${var.teamserver-passglob} c2_profile=${var.c2-profile} domain=${var.domain}'"], var.arguments)
  envs = var.envs
}