
locals {
  ansible-playbook = "${local.playbook-path}/core_config.yml"
  ansible-rdir-playbook = "${local.playbook-path}/redirector.yml"

}

variable "user" {
  description = "User to authenticate as"
}
variable "security_groups"{
  type = list(string)
  default=[""]
}

variable "security_groups_inbound_http"{
  type = list(string)
  default=[""]
}

variable "install" {
  type = list(string)
  default = []
}

variable "ami-centos" {
  type        = string
  description = "The centos image to use for the C2 server"
  default     = "ami-08e592fbb0f535224"
}

variable "ami-ubuntu" {
  type        = string
  description = "The Ubuntu image for the webserver"
  default     = "ami-0c1c30571d2dae5c9"
}



variable "private_key" {
  type        = string
  description = "The private key to use for the SSH connection"
  default     = "ec2-key"
}

variable "region" {
  type        = string
  description = "The region to deploy the infrastructure"
  default     = "eu-west-1"
}





variable "aws_access_key" {
  description = "The AWS access key"
  type        = string
}



variable "ssh_ipv4_cidr_blocks" {
  description = "The IPv4 CIDR blocks that will be allowed to SSH into the servers"
  type        = list(string)
}

variable "rdr_instance_names" {
  default = "longhorn"

}

variable "teamserver_names" {
  default = {
    "0" = "MasterPuppet"
  }

}

variable "https_redirector_domain" {
  description = "The domain for the HTTPS redirector"
  type        = string
}

variable "https_redirector_hostname" {
  description = "The hostname for the HTTPS redirector"
  type        = string
}

variable "https_redirector_domain_host" {
  description = "The fqdn for the HTTPS redirector"
  type = string
}

variable "ssh_pub_key_aws" {
  description = "The name of the public SSH key configured in AWS used when creating the EC2 instances."
  type = string
}

variable "ssh_priv_key_name" {
  description = "The filename in your local ~/.ssh/ folder of the private SSH key that can connect to the AWS hosts for provisioning."
  type = string
  validation {
    condition = fileexists("./data/ssh_keys/${var.ssh_priv_key_name}")
    error_message = "The file containing the private SSH key for provisioning is was not found in the folder: ~/.ssh/."
  }
}



variable "user_agent" {
  description = "User-agent used by the client (i.e. Grunt, Beacon, etc)"
  type        = string
  default     = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
}


variable "redirect_to" {
  description = "The back-end C2 server to redirect to"
  type = string
}


