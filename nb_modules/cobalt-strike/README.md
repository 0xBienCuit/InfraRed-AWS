# Terraform Module: cobalt-strike

a Cobalt Strike Instance using Ansible

## Usage

```hcl
module "cobalt-strike" {
  source = "./cobalt-strike"

  # Add required variables here if applicable
}
```
## Argument Reference

| Name                | Required | Value Type   | Description                                     |
|---------------------|----------|--------------|-------------------------------------------------|
| ansible-user        | Yes      | string       | The User to authenticate as                     |
| ip                  | Yes      | string       | The host IP to run the playbook on              |
| cs-license          | Yes      | string       | Cobalt Strike License Key                       |
| bind-address        | Yes      | string       | The address to bind the CS listener to          |
| teamserver-password | Yes      | string       | The password for the CS teamserver              |
| c2-profile          | Yes      | string       | The name of the C2 profile file                 |
| domain              | Yes      | string       | The domain name to deploy on                    |
| arguments           | No       | list(string) | Any additional Ansible arguments to pass in     |
| envs                | no       | list(string) | Environment variables to pass in (-e delimited) |


## Requirements

- Terraform version X.X or newer
- Ansible (if applicable)
