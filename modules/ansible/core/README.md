# ansible

Runs an ansible playbook on a specific resource

## Example

```hcl
module "ansible"{
  source = "../core"
  depends_on = [module.cs-config-ansible]

  user = var.ansible-user
  playbook = local.ansible-cs-playbook
  arguments = concat(["--extra-vars 'license_key=${var.cs-license} bind_address=${var.bind-address} teamserver_password=${var.teamserver-password} c2_profile=${var.c2-profile} domain=${var.domain}'"], var.arguments)
  ip = var.ip
  envs = var.envs
}
```

## Arguments

| Name      | Required | Value Type   | Description                                     |
|-----------|----------|--------------|-------------------------------------------------|
| playbook  | Yes      | string       | Playbook to run                                 |
| user      | Yes      | string       | The User to authenticate as                     |
| ip        | Yes      | string       | The host IP to run the playbook on              |
| arguments | No       | list(string) | Any additional Ansible arguments to pass in     |
| envs      | no       | list(string) | Environment variables to pass in (-e delimited) |
