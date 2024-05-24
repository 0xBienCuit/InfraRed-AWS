output "http-rdr-private-ip" {
  value = tostring(aws_instance.http-rdir.private_ip)
}

output "http-rdr-public-ip" {
  value = tostring(aws_instance.http-rdir.public_ip)
}