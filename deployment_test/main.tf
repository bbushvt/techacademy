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
  default_network_acl_name    = null
  default_security_group_name = null
  default_routing_table_name  = null
  provider = ibm.vpc
}

resource "ibm_is_vpc_address_prefix" "test_vpc_test_vpc_zone_1_prefix" {
  name = "${var.vpc_name}-test-vpc-test-vpc-zone-1"
  vpc  = ibm_is_vpc.test_vpc_vpc.id
  zone = "${var.vpc_region}-1"
  cidr = "10.10.0.0/22"
  provider = ibm.vpc
}

resource "ibm_is_vpc_address_prefix" "test_vpc_test_vpc_zone_2_prefix" {
  name = "${var.vpc_name}-test-vpc-test-vpc-zone-2"
  vpc  = ibm_is_vpc.test_vpc_vpc.id
  zone = "${var.vpc_region}-2"
  cidr = "10.20.0.0/22"
  provider = ibm.vpc
}

resource "ibm_is_vpc_address_prefix" "test_vpc_test_vpc_zone_3_prefix" {
  name = "${var.vpc_name}-test-vpc-test-vpc-zone-3"
  vpc  = ibm_is_vpc.test_vpc_vpc.id
  zone = "${var.vpc_region}-3"
  cidr = "10.30.0.0/22"
  provider = ibm.vpc
}

