variable "domain-c2" {
  type = string
}


variable "ttl" {
  type = number
  default = 300
}

variable "host" {
  type = string
}

variable "cf-token" {
  description = "value of the cloudflare token"
  type = string
}

variable "cf-email" {
  description = "value of the cloudflare email"
  type = string
  
}

variable "sub1" {
    type = string
    description = "infrared-c2"

    
    }

variable "zone_id" {
  type = string
}