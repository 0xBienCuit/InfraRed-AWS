variable "instance_shape" {
  description = "The shape of the compute instance"
  type        = string
}

variable "instance_arm_shape" {
  description = "The shape of the ARM instance"
  type        = string
}

variable "instance_ocpus" {
  description = "Number of OCPUs"
  type        = number
}

variable "instance_shape_config_memory_in_gbs" {
  description = "Memory (GB) for the instance shape config"
  type        = number
}

variable "instance_ocpus_arm" {
  description = "Number of OCPUs for the ARM instance"
  type        = number
}

variable "instance_shape_arm_config_memory_in_gbs" {
  description = "Memory (GB) for the ARM instance shape config"
  type        = number
}

variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
}

// data for the ubuntu image
data "oci_core_images" "red-image" {
  compartment_id           = var.compartment_ocid
  operating_system         = "CentOS"
  operating_system_version = "8"
  shape                    = var.instance_shape
}

variable "ubuntu_image_id" {
  description = "The OCID of the Ubuntu 20.04 image"
  type        = string
}

variable "ubuntu_arm_image_id" {
  description = "The OCID of the Ubuntu 20.04 ARM image"
  type        = string
}

variable "centos_image_id" {
  description = "The OCID of the CentOS 8 image"
  type        = string
}

variable "ssh_private_key" {
  description = "Path to the SSH private key"
  type        = string
}

variable "instance0_private_ip" {
  description = "Private IP address for instance 0"
  type        = string
}

variable "instance1_private_ip" {
  description = "Private IP address for instance 1"
  type        = string
}

variable "https_redirector_hostname" {
  description = "The hostname for the HTTPS redirector"
  type        = string
}

variable "https_redirector_domain_host" {
  description = "The FQDN for the HTTPS redirector"
  type        = string
}

variable "https_redirector_domain" {
  description = "The domain for the HTTPS redirector"
  type        = string
}

variable "user_agent" {
  description = "User-agent used by the client (i.e Grunt, Beacon, etcé)"
  type        = string
}

variable "ssh_priv_key_local" {
  description = "The filename in your local ~/.ssh/ folder of the private SSH key that can connect to the AWS hosts for provisioning."
  type        = string
  validation {
    condition     = fileexists("./${var.ssh_priv_key_local}")
    error_message = "The file containing the private SSH key for provisioning was not found in the folder: ~/.ssh/."
  }
}

variable "cloudflare_email" {
  description = "The email address used to login to Cloudflare"
  type        = string
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API token"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID"
  type        = string
}
