locals {
  data-path        = "${path.root}/data"
  playbook-path    = "${local.data-path}/playbooks"
  ssh-configs-path = "${local.data-path}/ssh_configs"
  ssh-keys-path    = "${local.data-path}/ssh_keys"
  templates-path   = "${local.data-path}/templates"
  credentials-path = "${local.data-path}/credentials"
}

variable "subnet_id" {
  description = "ID of the subnet where the network interface should be created"
}

variable "ami_ubuntu" {
  description = "AMI ID for Ubuntu instance"
}

variable "vpc_id" {
  description = "ID of the VPC where the network interface should be created"
}
