# http-c2

Creates a HTTP C2 server in AWS. SSH keys for each instance will be outputted to the ssh_keys folder.

## Example

```hcl
module "http-c2" {
  source = "../http-c2"

  #managed
  user = var.cs-http-c2-user
  subnet_id = var.private_subnet_id
  instance_type = var.instance_type
  security_groups = var.base-internal-security_groups
  security_groups_inbound_http = var.base-public-security_groups

  #base
  vpc_id = var.vpc_id
  amis = var.amis
}
```

## Arguments

| Name                         | Required | Value Type   | Description                                                 |
|------------------------------|----------|--------------|-------------------------------------------------------------|
| user                         | Yes      | string       | The User to authenticate as                                 |
| subnet_id                    | Yes      | string       | Subnet ID to create instance in                             |
| security_groups              | No       | list(string) | Security groups to add                                      |
| security_groups_inbound_http | No       | list(string) | Security groups to allow inbound port 80/443TCP(HTTP) from. |
| install                      | No       | list(string) | Scripts to install inline. Not recommended.                 |

## Outputs

| Name                       | Description
|----------------------------|-----------
|`http-c2-private-ip`        | IP of created instance.
