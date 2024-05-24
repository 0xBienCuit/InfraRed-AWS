# Terraform Module: ansible

an ansible playbook on a specific resource

## Usage

```hcl
module "ansible" {
  source = "./ansible"

  # Add required variables here if applicable
}
```
## Argument Reference

| Name      | Required | Value Type   | Description                                     |
|-----------|----------|--------------|-------------------------------------------------|
| playbook  | Yes      | string       | Playbook to run                                 |
| user      | Yes      | string       | The User to authenticate as                     |
| ip        | Yes      | string       | The host IP to run the playbook on              |
| arguments | No       | list(string) | Any additional Ansible arguments to pass in     |
| envs      | no       | list(string) | Environment variables to pass in (-e delimited) |


## Requirements

- Terraform version X.X or newer
- Ansible (if applicable)
