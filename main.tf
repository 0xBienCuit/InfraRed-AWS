module "create-vpc" {
  source = "./modules/aws/create-vpc"

  vpc_cidr          = "10.0.0.0/16"
  vpc_name          = "infrared-vpc"
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "eu-west-1a"


}



module "http-cobalt-strike" {
  source                       = "./modules/aws/http-cobalt-strike" # Replace with the actual path to your module
  ssh_ipv4_cidr_blocks         = var.ssh_ipv4_cidr_blocks
  vpc_id                       = module.create-vpc.vpc_id
  ami_ubuntu                   = var.ami_ubuntu
  region                       = var.region
  private_key                  = var.private_key
  user_agent                   = var.user_agent
  rdr_instance_names           = var.rdr_instance_names
  ssh_priv_key_name            = var.ssh_priv_key_name
  subnet_id                    = module.create-vpc.subnet_id

  user = "ubuntu"
  
}
module "http-redirector" {
  source                       = "./modules/aws/http-redirector" # Replace with the actual path to your module
  redirect_to                  = module.http-cobalt-strike.cs-http-c2-public # replace with the actual IP address of the cobalt strike server
  vpc_id                       = module.create-vpc.vpc_id
  ami_ubuntu                   = var.ami_ubuntu
  region                       = var.region
  private_key                  = var.private_key
  ssh_pub_key_aws              = var.ssh_pub_key_aws
  user_agent                   = var.user_agent
  rdr_instance_names           = var.rdr_instance_names
  ssh_priv_key_name            = var.ssh_priv_key_name
  subnet_id                    = module.create-vpc.subnet_id
  ssh_ipv4_cidr_blocks         = var.ssh_ipv4_cidr_blocks
  https_redirector_hostname    = var.https_redirector_hostname
  https_redirector_domain      = var.https_redirector_domain
  https_redirector_domain_host = var.https_redirector_domain_host
  aws_access_key               = var.aws_access_key
  user                         = "ubuntu"
}

module "create-dns" {
  source = "./modules/aws/create-dns-record"

  cf-email = var.cf-email
  cf-token = var.cf-token
  domain-c2   = "mlcrosoft-online.site"
  zone_id  = var.cloudflare_zone_id
  sub1 = "infrared-c2"
  host     = module.http-cobalt-strike.cs-http-c2-public
   
}