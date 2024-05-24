locals {
  ansible-config-playbook = "${local.playbook-path}/core_config.yml"
  ansible-cs-playbook = "${local.playbook-path}/CS.yml"
}

variable "user-ansible" {
  type = string
}

variable "ip" {
  type = string
  description = "IP of the host to run the playbook on"
}

variable "bind-address" {
  type = string
  description = "IP of the host to bind the Cobalt Strike team server to"
}

variable "domain" {
  description = "C2 Domain to host from"
  type = string
}

variable "teamserver-passglob" {
  type = string
  description = "Password for the Cobalt Strike team server"
}

variable "c2-profile" {
  type = string
  description = "C2 profile to use"
}

variable "arguments" {
  default = []
  type    = list(string)
  description = "Any additional Ansible arguments to pass in."
}

variable "envs" {
  default = []
  type    = list(string)
  description = "Environment variables to pass in. Will be delimited by -e automatically."
}
