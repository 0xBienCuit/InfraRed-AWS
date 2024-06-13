# Overview

This project automates the setup of a Command and Control (C2) infrastructure using Terraform and Ansible. It aims to streamline the deployment and configuration of infrastructure components required for managing and controlling systems efficiently.

This diagram outlines the concept of the scenario used for this project:

![](https://i.imgur.com/db2dIIz.png)

# Folder Structure
The project follows a structured layout to organize its files and resources effectively:

```
├── data
│   ├── playbooks
│   ├── ssh_configs
│   ├── ssh_keys
│   └── templates
├── modules
│   ├── ansible
│   │   └── core
│   └── aws
│       ├── create-dns-record
│       ├── create-vpc
│       ├── http-c2
│       ├── http-cobalt-strike
│       └── http-redirector
├── nb_modules
│   ├── ansible
│   └── cobalt-strike
```

# Prerequisites
To use this project, ensure you have the following prerequisites:
- Terraform installed on your local machine ([Download Terraform](https://www.terraform.io/downloads.html))
- Ansible installed on your local machine ([Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html))
- OCI (Oracle Cloud Infrastructure) Account with necessary permissions and credentials
- CloudFlare Account for DNS management and HTTPS configuration
- A registered Domain Name for your infrastructure
- SSH Key Pair for secure access to servers
- ...

# Getting Started
1. Clone this repository to your local machine.
2. Set up your Terraform variables in the `terraform.tfvars` file based on `terraform.tfvars.example`.
3. Review and update the necessary configurations in Terraform files (`main.tf`, `variables.tf`, etc.) according to your requirements.
4. Run `terraform init` to initialize Terraform and download required plugins.
5. Run `terraform plan` to review the execution plan.
6. Run `terraform apply` to provision the infrastructure as defined in the Terraform configuration.

# Usage
- Use `terraform output` to get information about the provisioned resources.
- Use Ansible playbooks in the `data/playbooks` directory to manage and configure servers post-provisioning.

# References
- [The DevOps Approach to Automating C2 Infrastructure (Part One)](https://versprite.com/blog/the-devops-approach-to-automating-c2-infrastructure-part-one/)
- [The DevOps Approach to Automating C2 Infrastructure (Part Two)](https://versprite.com/blog/the-devops-approach-to-automating-c2-infrastructure-part-two/)
- [Applying Security Lists (OCI)](https://abeerm171.medium.com/part-2-applying-security-list-to-subnets-in-oracle-cloud-using-terraform-82bd0c087eac)
- [Building Simple Infra in Oracle Cloud using Terraform](https://ibinsabbar.medium.com/part-1-building-simple-infra-in-oracle-cloud-using-terraform-4dd2dbb96229)

# Credits
- [RedIra](https://github.com/joeminicucci/RedIra) 
