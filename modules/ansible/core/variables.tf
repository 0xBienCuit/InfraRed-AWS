locals{
    data-path = "${path.root}/data"
    ssh-keys-path = "${local.data-path}/ssh_keys"
}

variable "playbook" {
  description = "Playbook to run"
  type = string
}

variable "ip" {
  description = "Host to run playbook on"
  type = string
}

variable "user" {
  default = "admin"
  description = "User to authenticate as"
  type = string
}

variable "arguments" {
  default = []
  type    = list(string)
  description = "Arguments"
}

variable "envs" {
  default = []
  type    = list(string)
  description = "Environment variables"
}
