<p align="center">
  <img src="https://raw.githubusercontent.com/PKief/vscode-material-icon-theme/ec559a9f6bfd399b82bb44393651661b08aaf7ba/icons/folder-markdown-open.svg" width="100" alt="project-logo">
</p>
<p align="center">
    <h1 align="center">INFRARED-AWS</h1>
</p>
<p align="center">
    <em>Secure Connectivity, Simplified"**This phrase emphasizes the project's focus on establishing secure connectivity between nodes while streamlining infrastructure setup and management through automation. The slogan is concise, memorable, and within the 8-word limit.Let me know if youd like me to make any adjustments or explore alternative options!</em>
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/0xBienCuit/InfraRed-AWS?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/0xBienCuit/InfraRed-AWS?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/0xBienCuit/InfraRed-AWS?style=default&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/0xBienCuit/InfraRed-AWS?style=default&color=0080ff" alt="repo-language-count">
<p>
<p align="center">
	<!-- default option, no dependency badges. -->
</p>

<br><!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary><br>

- [ Overview](#-overview)
- [ Features](#-features)
- [ Repository Structure](#-repository-structure)
- [ Modules](#-modules)
- [ Getting Started](#-getting-started)
  - [ Installation](#-installation)
  - [ Usage](#-usage)
  - [ Tests](#-tests)
- [ Project Roadmap](#-project-roadmap)
- [ Contributing](#-contributing)
- [ License](#-license)
- [ Acknowledgments](#-acknowledgments)
</details>
<hr>

##  Overview

InfraRed-AWS is an open-source software project that provides a cloud-based infrastructure for secure connectivity, command-and-control (C2), and DNS record updates. The project offers Terraform modules for establishing a robust AWS infrastructure, including VPC creation, instance provisioning, and Ansible playbook execution. InfraRed-AWS enables teams to set up and manage secure communication channels, automate C2 profile deployments, and bind domains for seamless coordination and data exchange. By leveraging open-source technologies and automation tools, this project streamlines infrastructure management and facilitates remote access capabilities for security operations and incident response teams.

---

##  Features



---

##  Repository Structure

```sh
└── InfraRed-AWS/
    ├── README.md
    ├── base_variables.tf
    ├── data
    │   ├── playbooks
    │   ├── ssh_configs
    │   ├── ssh_keys
    │   └── templates
    ├── main.tf
    ├── modules
    │   ├── ansible
    │   └── aws
    └── nb_modules
        ├── ansible
        └── cobalt-strike
```

---

##  Modules

<details closed><summary>.</summary>

| File                                                                                          | Summary                                                                                                                                                                                                                                                                                                         |
| ---                                                                                           | ---                                                                                                                                                                                                                                                                                                             |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/main.tf)                     | Establishes a cloud infrastructure on AWS, providing secure connectivity through a Cobalt Strike server, HTTP redirector, and DNS record updates, all managed by Terraform modules.                                                                                                                             |
| [base_variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/base_variables.tf) | Defining Infrastructure Parameters, this file establishes crucial variables for an AWS infrastructure setup. It specifies data paths, playbook directories, SSH configuration files, and template locations, as well as other critical values such as AWS access keys, instance types, and Cloudflare zone IDs. |

</details>

<details closed><summary>modules.ansible.core</summary>

| File                                                                                                     | Summary                                                                                                                                                                                                                                                          |
| ---                                                                                                      | ---                                                                                                                                                                                                                                                              |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/ansible/core/main.tf)           | Automates Ansible playbook provisioning for AWS infrastructure. Orchestrates playbooks based on policy hashes, executing with specified user, SSH key, and environments.                                                                                         |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/ansible/core/variables.tf) | Configuring Ansible playbook variables for AWS infrastructure deployment. Defines paths for data storage and SSH keys, and sets up parameters for playbook execution, including IP address, user authentication, and custom arguments and environment variables. |

</details>

<details closed><summary>modules.aws.http-redirector</summary>

| File                                                                                                                      | Summary                                                                                                                                                                                                                                                                                                                                           |
| ---                                                                                                                       | ---                                                                                                                                                                                                                                                                                                                                               |
| [outputs.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-redirector/outputs.tf)               | Unveiling critical infrastructure details, this AWS modules outputs disclose vital IP addresses: private and public IPs assigned to an instance designated for HTTP redirection, empowering robust resource utilization and seamless communication.                                                                                               |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-redirector/main.tf)                     | Configures AWS infrastructure for HTTP redirector deployment, generating SSH key-pair, and provisioning EC2 instance with Ansible playbooks for configuration management and automated redirects. The code creates and associates the necessary security group and generates SSH configuration files for secure access to the instance.           |
| [base_variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-redirector/base_variables.tf) | Establishes foundational variables for InfraRed-AWSs AWS module. Provides critical file paths and credentials location. Sets up essential AWS identifiers such as subnet ID, Ubuntu AMI, and VPC ID, enabling infrastructure provisioning within the repositorys scope.                                                                           |
| [security_group.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-redirector/security_group.tf) | Security group infrastructure is configured for HTTPS redirector allowing inbound HTTP(S) traffic and outgoing access to all ports.                                                                                                                                                                                                               |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-redirector/variables.tf)           | Governance ConfigurerThe code file configures critical variables for an AWS infrastructure deployment, providing essential details such as user authentication credentials, security group settings, and private key information. This enables secure provisioning and management of EC2 instances and related resources in the eu-west-1 region. |

</details>

<details closed><summary>modules.aws.http-c2</summary>

| File                                                                                                              | Summary                                                                                                                                                                                                                                                                                                                                                                 |
| ---                                                                                                               | ---                                                                                                                                                                                                                                                                                                                                                                     |
| [outputs.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-c2/outputs.tf)               | Providing HTTP C2 private IP addresses. Within InfraRed-AWS, this output module crucially offers the private IPs for instances in the http-c2' scope, fostering efficient communication and data exchange between nodes within the architecture.                                                                                                                        |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-c2/main.tf)                     | Architects AWS infrastructure by generating random ID for server creation, managing SSH keys, and configuring AWS instance with associated VPC, subnet, and security group. Provides Ansible provisioning for custom scripts execution and local-exec execution for creating SSH configurations.                                                                        |
| [base_variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-c2/base_variables.tf) | Establishing fundamental building blocks for AWS infrastructure configuration within the InfraRed-AWS repository, this code file sets up crucial variables and locals to define paths and credentials. It also introduces key infrastructure parameters like VPC ID, AMIs, and instance types, laying the groundwork for subsequent module and playbook configurations. |
| [security_group.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-c2/security_group.tf) | Securely enables inbound HTTP communication on ports 80 and 443 for the red teams infrastructure, while permitting outbound connections to any IP address on various ports, including DNS (53), HTTPS (443), and custom port 50050.                                                                                                                                     |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-c2/variables.tf)           | Architecturally, this file enables configuration of Ansible playbooks for AWS-based infrastructure setup, specifying variables for user authentication, subnet ID, security groups, and installation requirements.                                                                                                                                                      |

</details>

<details closed><summary>modules.aws.create-vpc</summary>

| File                                                                                                       | Summary                                                                                                                                                                                                                                                                                                     |
| ---                                                                                                        | ---                                                                                                                                                                                                                                                                                                         |
| [outputs.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/create-vpc/outputs.tf)     | VPC configuration is enabled through this file, which provides critical output values for vpc_id, subnet_id, and internet_gateway_id, allowing for infrastructure discovery and automation within the InfraRed-AWS repository.                                                                              |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/create-vpc/main.tf)           | Establishing foundational network infrastructure for Amazon Web Services (AWS) cloud environments, this module creates a VPC with its Internet Gateway, main Subnet, and associated Route Table, allowing public traffic routing and connectivity.                                                          |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/create-vpc/variables.tf) | Configure key settings for AWS VPC creation.Establishes parameters for VPC, subnet, and availability zone setup, ensuring correct infrastructure configuration. Critical features include defining CIDR blocks, naming conventions, and geographic placement options to ensure seamless AWS VPC deployment. |

</details>

<details closed><summary>modules.aws.create-dns-record</summary>

| File                                                                                                              | Summary                                                                                                                                                                                                                                                                                                                                                                                                |
| ---                                                                                                               | ---                                                                                                                                                                                                                                                                                                                                                                                                    |
| [outputs.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/create-dns-record/outputs.tf)     | Creates a DNS record for Cloudflares HTTP/2-enabled proxy, c2'. Generates a named entity representing the CNAME record for the specified domain and host. Essential feature within the Infrastructure module's AWS section, enabling seamless proxy setup within the broader InfraRed-AWS repository framework.                                                                                        |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/create-dns-record/main.tf)           | Creating a DNS record within CloudFlares infrastructure, this Terraform file ensures accurate domain name mapping by establishing an A' record with custom TTL and zone ID specifications, utilizing the `cloudflare` provider for seamless integration.                                                                                                                                               |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/create-dns-record/variables.tf) | Establishing crucial infrastructure components for secure communication, this file defines variables that enable creation of DNS records and zone configurations for cloud-based security operations. Key features include domain-c2 naming, TTL settings, host specification, Cloudflare authentication, and subdomain definition, all integral to the InfraRed-AWS repositorys overall architecture. |

</details>

<details closed><summary>modules.aws.http-cobalt-strike</summary>

| File                                                                                                                         | Summary                                                                                                                                                                                                                                                                                                                                                              |
| ---                                                                                                                          | ---                                                                                                                                                                                                                                                                                                                                                                  |
| [outputs.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-cobalt-strike/outputs.tf)               | Enabling Secure CommunicationsThis code outputs the public IP address of an AWS instance, facilitating secure Cobalt Strike HTTP-based command-and-control (C2) communication for infrastructure setup and management in InfraRed-AWS.                                                                                                                               |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-cobalt-strike/main.tf)                     | Generate an Amazon Machine Image (AMI) and provision an instance using Terraform. The file configures an EC2 instance with SSH access, provisions the instance to execute a custom script and generates a SSH configuration file. It also deploys Ansible playbooks for both HTTP-COBALT-STRIKE configurations.                                                      |
| [base_variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-cobalt-strike/base_variables.tf) | Configuring infrastructure parameters for an AWS environment, base_variables.tf establishes critical paths and variables for playbook, ssh config, ssh key, template, and credentials directories, while also defining essential variables like subnet ID, Ubuntu AMI ID, and VPC ID.                                                                                |
| [security_group.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-cobalt-strike/security_group.tf) | Security Group defines firewall rules for teamserver_sg, allowing inbound HTTP, SSH, and specific ports while restricting access from unknown sources. It also enables egress to the entire internet.                                                                                                                                                                |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/modules/aws/http-cobalt-strike/variables.tf)           | Establishes core infrastructure variables for AWS-based C2 servers, including user credentials, security groups, instance configurations, and SSH key management. Variables define playbooks, security groups, and installation packages for various instances, ensuring seamless provisioning and control of Cobalt Strike HTTP C2 servers in the eu-west-1 region. |

</details>

<details closed><summary>nb_modules.ansible</summary>

| File                                                                                                   | Summary                                                                                                                                                                                                                                                                                                                                   |
| ---                                                                                                    | ---                                                                                                                                                                                                                                                                                                                                       |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/nb_modules/ansible/main.tf)           | Orchestrates Ansible provisioning on AWS infrastructure. Automates playbook execution with dynamic triggers, leveraging SHA-1 hashes to ensure reproducibility. Integrates Ansible-playbook command with local-exec provisioner, enabling user-defined parameters and custom environment variables for flexible configuration management. |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/nb_modules/ansible/variables.tf) | Determining Ansible playbooks for execution. This module defines essential variables for configuring playbook runs, including data storage paths, target IP addresses, user credentials, and optional arguments and environment variables to be passed during execution.                                                                  |

</details>

<details closed><summary>nb_modules.cobalt-strike</summary>

| File                                                                                                                   | Summary                                                                                                                                                                                                                                                                                         |
| ---                                                                                                                    | ---                                                                                                                                                                                                                                                                                             |
| [main.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/nb_modules/cobalt-strike/main.tf)                     | Orchestrates Cobalt Strike configuration using Ansible playbooks, establishing a managed infrastructure for C2 profile deployment and domain binding, ensuring secure execution with customizable arguments and environments.(Can fit within the 50-word limit)                                 |
| [base_variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/nb_modules/cobalt-strike/base_variables.tf) | Establishing foundational configuration variables for Cobalt Strike module within the InfraRed-AWS repository, this file defines locals data-path and playbook-path, referencing the root directorys data and playbooks subfolders respectively.                                                |
| [variables.tf](https://github.com/0xBienCuit/InfraRed-AWS/blob/master/nb_modules/cobalt-strike/variables.tf)           | Establishes core variables for Cobalt Strike playbook configuration and execution within InfraRed-AWS repository. Defines Ansible playbooks, IP addresses, domain, team server passwords, C2 profiles, and arguments for playbook runs, streamlining automation and remote access capabilities. |

</details>

---

##  Getting Started

**System Requirements:**

* **Terraform**: `version x.y.z`

###  Installation

<h4>From <code>source</code></h4>

> 1. Clone the InfraRed-AWS repository:
>
> ```console
> $ git clone https://github.com/0xBienCuit/InfraRed-AWS
> ```
>
> 2. Change to the project directory:
> ```console
> $ cd InfraRed-AWS
> ```
>
> 3. Install the dependencies:
> ```console
> $ terraform init
> ```

###  Usage

<h4>From <code>source</code></h4>

> Run InfraRed-AWS using the command below:
> ```console
> $ terraform apply
> ```

###  Tests

> Run the test suite using the command below:
> ```console
> $ Insert test command.
> ```

---

##  Project Roadmap

- [X] `► INSERT-TASK-1`
- [ ] `► INSERT-TASK-2`
- [ ] `► ...`

---

##  Contributing

Contributions are welcome! Here are several ways you can contribute:

- **[Report Issues](https://github.com/0xBienCuit/InfraRed-AWS/issues)**: Submit bugs found or log feature requests for the `InfraRed-AWS` project.
- **[Submit Pull Requests](https://github.com/0xBienCuit/InfraRed-AWS/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.
- **[Join the Discussions](https://github.com/0xBienCuit/InfraRed-AWS/discussions)**: Share your insights, provide feedback, or ask questions.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/0xBienCuit/InfraRed-AWS
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="center">
   <a href="https://github.com{/0xBienCuit/InfraRed-AWS/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=0xBienCuit/InfraRed-AWS">
   </a>
</p>
</details>

---

##  License

This project is protected under the [SELECT-A-LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

##  Acknowledgments

- List any resources, contributors, inspiration, etc. here.

[**Return**](#-overview)

---
