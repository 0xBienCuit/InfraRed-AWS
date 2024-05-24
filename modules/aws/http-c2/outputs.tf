output "http-c2-private-ip"{
  value = tostring(aws_instance.http-c2.private_ip)
}
