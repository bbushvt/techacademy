# Set the resource group
data "ibm_resource_group" "group" {
  name = var.resource_group_name
}



########################################################
# NAT Gateway VPC
########################################################

# Create the NAT Gateway VPC
resource "ibm_is_vpc" "nat_gateway_vpc" {
  name                        = "${var.base_name}-vpc"
  resource_group              = data.ibm_resource_group.group.id
  address_prefix_management   = "manual"
}

# Create a prefix in the VPC
resource "ibm_is_vpc_address_prefix" "nat_gateway_prefix" {
  name = "${var.base_name}-prefix-zone-${var.zone}"
  vpc  = ibm_is_vpc.nat_gateway_vpc.id
  zone = "${var.nat_gateway_region}-${var.one}"
  cidr = var.cidr_block
}

# Create the network ACL
resource "ibm_is_network_acl" "nat_gateway_acl" {
  name           = "${var.base_name}-main-acl"
  vpc            = ibm_is_vpc.nat_gateway_vpc.id
  resource_group = data.ibm_resource_group.group.id
  rules {
    action      = "allow"
    destination = "0.0.0.0/0"
    direction   = "inbound"
    name        = "inbound"
    source      = "0.0.0.0/0"
  }
  rules {
    action      = "allow"
    destination = "0.0.0.0/0"
    direction   = "outbound"
    name        = "outbound"
    source      = "0.0.0.0/0"
  }
}

# Create a subnet from the prefix and using the ACL we created
resource "ibm_is_subnet" "nat_gateway_sn" {
  vpc             = ibm_is_vpc.nat_gateway_vpc.id
  name            = "${var.base_name}-main-sn"
  zone            = "${var.nat_gateway_region}-${var.zone}"
  resource_group  = data.ibm_resource_group.group.id
  network_acl     = ibm_is_network_acl.nat_gateway_acl.id
  ipv4_cidr_block = var.cidr_block
  tags = []
  depends_on = [
    ibm_is_vpc_address_prefix.nat_gateway_prefix
  ]
}

# Create the ingress routing table
resource "ibm_is_vpc_routing_table" "nat_gateway_vpc_ingress_routing_table" {
  vpc                           = ibm_is_vpc.nat_gateway_vpc.id
  name                          = "${var.base_name}-ingress-routing-table"
  route_transit_gateway_ingress = true
  advertise_routes_to = ["transit_gateway"]
}

# add SSH rule to defualt security group
resource "ibm_is_security_group_rule" "sg1_tcp_rule_22" {
  group     = ibm_is_vpc.nat_gateway_vpc.default_security_group
  direction = "inbound"
  remote    = var.ssh_ingress_cidr
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

# Create the SSH key in the vpc
resource "ibm_is_ssh_key" "vpc_ssh_key" {
  name          = "${var.base_name}-ssh-key"
  public_key    = var.ssh_key
  type          = "rsa"
}

# Create a VSI
resource "ibm_is_instance" "nat_gateway_vsi" {
  name                = "${var.base_name}-vsi"
  image               = var.vsi_image_id == "" ? lookup(local.image_id_by_region, var.nat_gateway_region, "") : var.vsi_image_id
  profile             = var.vsi_profile
  primary_network_interface {
    subnet            = ibm_is_subnet.nat_gateway_sn.id
  }
  vpc                 = ibm_is_vpc.nat_gateway_vpc.id
  zone                = "${var.nat_gateway_region}-${var.zone}"
  keys                = [ibm_is_ssh_key.vpc_ssh_key.id]
  resource_group      = data.ibm_resource_group.group.id
  user_data           = var.user_data
}

# Create the FIP for the NAT Gateway
resource "ibm_is_floating_ip" "nat_gateway_fip" {
  name                = "${var.base_name}-fip"
  target              = ibm_is_instance.nat_gateway_vsi.primary_network_interface[0].id
}







