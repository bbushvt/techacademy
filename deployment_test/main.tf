data "ibm_resource_group" "default" {
  name = "Default"
}

resource "ibm_resource_instance" "pvs_workspace_a" {
  name              = var.workspace_name_a
  service           = "power-iaas"
  location          = var.pvs_region_a
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.default.id
  provider          = ibm.a
}

resource "ibm_resource_instance" "pvs_workspace_b" {
  name              = var.workspace_name_b
  service           = "power-iaas"
  location          = var.pvs_region_b
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.default.id
  provider          = ibm.b
}

resource "ibm_pi_key" "key" {
  pi_cloud_instance_id  = ibm_resource_instance.pvs_workspace_a.guid
  pi_key_name           = var.ssh_key_name
  pi_ssh_key            = var.ssh_key_rsa
  provider              = ibm.a
}

resource "ibm_is_vpc" "test_vpc_vpc" {
  name                        = var.vpc_name
  resource_group              = data.ibm_resource_group.default.id
  address_prefix_management   = "manual"
  provider                    = ibm.vpc
}

resource "ibm_is_vpc_address_prefix" "test_vpc_test_vpc_zone_1_prefix" {
  name = "${var.vpc_name}-test-vpc-test-vpc-zone-1"
  vpc  = ibm_is_vpc.test_vpc_vpc.id
  zone = "${var.vpc_region}-1"
  cidr = "10.241.0.0/18"
  provider = ibm.vpc
}

resource "ibm_is_vpc_address_prefix" "test_vpc_test_vpc_zone_2_prefix" {
  name = "${var.vpc_name}-test-vpc-test-vpc-zone-2"
  vpc  = ibm_is_vpc.test_vpc_vpc.id
  zone = "${var.vpc_region}-2"
  cidr = "10.241.64.0/18"
  provider = ibm.vpc
}

resource "ibm_is_vpc_address_prefix" "test_vpc_test_vpc_zone_3_prefix" {
  name = "${var.vpc_name}-test-vpc-test-vpc-zone-3"
  vpc  = ibm_is_vpc.test_vpc_vpc.id
  zone = "${var.vpc_region}-3"
  cidr = "10.241.128.0/18"
  provider = ibm.vpc
}

resource "ibm_is_network_acl" "test_vpc_main_acl_acl" {
  name           = "test-vpc-main-acl-acl"
  vpc            = ibm_is_vpc.test_vpc_vpc.id
  resource_group = data.ibm_resource_group.default.id
  provider = ibm.vpc
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

resource "ibm_is_subnet" "test_vpc_main_zone_1" {
  vpc             = ibm_is_vpc.test_vpc_vpc.id
  name            = "test-vpc-main-zone-1"
  zone            = "${var.vpc_region}-1"
  resource_group  = data.ibm_resource_group.default.id
  network_acl     = ibm_is_network_acl.test_vpc_main_acl_acl.id
  ipv4_cidr_block = "10.241.0.0/28"
  tags = []
  depends_on = [
    ibm_is_vpc_address_prefix.test_vpc_test_vpc_zone_1_prefix
  ]
  provider = ibm.vpc
}

##############################################################################
# Custom Dns DNS Service
##############################################################################

resource "ibm_resource_instance" "custom_dns_dns_instance" {
  name              = "custom-dns-dns-instance"
  resource_group_id = data.ibm_resource_group.default.id
  location          = "global"
  service           = "dns-svcs"
  plan              = "standard-dns"
  provider          = ibm.vpc
}

##############################################################################

##############################################################################
# Custom Dns DNS Custom Resolvers
##############################################################################

resource "ibm_dns_custom_resolver" "custom_dns_dns_instance_resolver_myresolver" {
  name              = "myresolver"
  instance_id       = ibm_resource_instance.custom_dns_dns_instance.guid
  description       = ""
  high_availability = false
  enabled           = true
  provider          = ibm.vpc
  locations {
    subnet_crn = ibm_is_subnet.test_vpc_main_zone_1.crn
    enabled    = true
  }
}