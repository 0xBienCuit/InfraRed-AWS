locals {
  ansible-config-playbook = "${local.playbook-path}/core_config.yml"
  ansible-cs-playbook = "${local.playbook-path}/CS.yml"
}

variable "user-ansible" {
  description = "User to run the Ansible playbook"
  type = string
}

variable "ip" {
  description = "IP of the host to run the playbook on"
  type = string
}

variable "bind-address" {
  description = "IP to bind the Cobalt Strike team server to"
  type = string
}

variable "domain" {
  description = "C2 Domain to host from"
  type = string
}

variable "teamserver-passglob" {
  description = "Password for the Cobalt Strike team server"
  type = string
}

variable "c2-profile" {
  description = "C2 profile to use"
  type = string
}

variable "arguments" {
  description = "Any additional Ansible arguments to pass in"
  type = list(string)
  default = []
}

variable "envs" {
  description = "Environment variables to pass in. Will be delimited by -e automatically"
  type = list(string)
  default = []
}