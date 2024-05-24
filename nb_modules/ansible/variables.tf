locals{
    data-path = "${path.root}/data"
    ssh-keys-path = "${local.data-path}/ssh_keys"
}

variable playbook {
    description = "Ansible playbook to run"
    type = string
}

variable "ip" {
    description = "IP address of the target host"
    type = string
}

variable "user" {
    description = "User to connect to the target host"
    type = string
    default="admin"
}

variable "arguments" {
    default = []
    type = list(string)
    description = "List of arguments to pass to the playbook"
}

variable "envs" {
    default = []
    type = list(string)
    description = "List of environment variables  to pass to the playbook"
}