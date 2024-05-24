terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
provider "cloudflare" {
  api_token = var.cf-token
}

resource "cloudflare_record" "c2-http-a1" {
    
    name   = "${var.sub1}"
    value  = "${var.host}"
    type   = "A"
    zone_id = var.zone_id
    ttl    = 6020
}
