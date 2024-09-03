resource "oci_core_virtual_network" "red-vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "redvcn"
  dns_label      = "redvcn"
}

# Stap 2: Creëer een subnet binnen het VCN voor specifieke IP-adressen.
resource "oci_core_subnet" "red-subnet" {
  cidr_block        = "10.1.20.0/24"
  display_name      = "redsubnet"
  dns_label         = "redsubnet"
  security_list_ids = [oci_core_security_list.red-sl.id, oci_core_security_list.https_redirector_sg.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.red-vcn.id
  route_table_id    = oci_core_route_table.red-rt.id
  dhcp_options_id   = oci_core_virtual_network.red-vcn.default_dhcp_options_id
}

# Stap 3: Maak een internetgateway aan om het verkeer tussen het VCN en het internet mogelijk te maken.
resource "oci_core_internet_gateway" "red-ig" {
  compartment_id = var.compartment_ocid
  display_name   = "redig"
  vcn_id         = oci_core_virtual_network.red-vcn.id
}

# Stap 4: Definieer een route table om het verkeer te routeren, inclusief het verkeer naar het internet.
resource "oci_core_route_table" "red-rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.red-vcn.id
  display_name   = "redrt"
  route_rules {
    destination       = "0.0.0.0/0"  # Alle verkeer (0.0.0.0/0) wordt naar de internetgateway gestuurd.
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.red-ig.id
  }
}