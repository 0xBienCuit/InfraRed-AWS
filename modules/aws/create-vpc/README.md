# AWS VPC Module

This module creates a VPC along with a public subnet, internet gateway, and route table.

## Inputs

| Name               | Description                        | Type   | Default | Required |
|--------------------|------------------------------------|--------|---------|----------|
| vpc_cidr           | CIDR block for the VPC             | string | n/a     | yes      |
| vpc_name           | Name of the VPC                    | string | n/a     | yes      |
| subnet_cidr        | CIDR block for the subnet          | string | n/a     | yes      |
| availability_zone  | Availability zone for the subnet   | string | n/a     | yes      |

## Outputs

| Name      | Description           |
|-----------|-----------------------|
| vpc_id    | The ID of the VPC     |
| subnet_id | The ID of the subnet  |