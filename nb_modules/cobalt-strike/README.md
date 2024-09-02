# Cobalt Strike Module

This module sets up a Cobalt Strike team server using Ansible.

## Inputs

| Name                | Description                              | Type         | Default | Required |
|---------------------|------------------------------------------|--------------|---------|----------|
| user-ansible        | User to run the Ansible playbook         | string       | n/a     | yes      |
| ip                  | IP of the host to run the playbook on    | string       | n/a     | yes      |
| bind-address        | IP to bind the Cobalt Strike server to   | string       | n/a     | yes      |
| domain              | C2 Domain to host from                   | string       | n/a     | yes      |
| teamserver-passglob | Password for the Cobalt Strike server    | string       | n/a     | yes      |
| c2-profile          | C2 profile to use                        | string       | n/a     | yes      |
| arguments           | Additional Ansible arguments             | list(string) | []      | no       |
| envs                | Environment variables to pass in         | list(string) | []      | no       |

## Usage

```hcl
module "cobalt-strike" {
  source = "../nb_modules/cobalt-strike"

  user-ansible        = "admin"
  ip                  = "192.168.1.1"
  bind-address        = "0.0.0.0"
  domain              = "example.com"
  teamserver-passglob = "password"
  c2-profile          = "default"
  arguments           = ["--extra-vars 'key=value'"]
  envs                = ["VAR1=value1", "VAR2=value2"]
}