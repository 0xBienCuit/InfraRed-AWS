output "record" {
  value = [  "c2 http a1 ${cloudflare_record.c2-http-a1.name}.${var.domain-c2} - ${var.host}",
  ""]
}