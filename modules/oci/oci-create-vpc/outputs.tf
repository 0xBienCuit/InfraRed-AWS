output "outputs" {
  value = [
    // display domain, ip, username and key file
    "IP: ${oci_core_instance.red-instance0.public_ip}",
    "Username: opc",
    "Key file: ${var.ssh_public_key}"
  ]
}

output "outputs_ubuntu" {
  value = [
    // display domain, ip, username and key file
    "IP: ${oci_core_instance.red-instance1.public_ip}",
    "Username: ubuntu",
    "Key file: ${var.ssh_public_key}"
  ]
}