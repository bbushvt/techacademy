data "ibm_resource_group" "default" {
  name = "Default"
}
resource "ibm_resource_instance" "pvs_workspace_a" {
  name              = var.workspace_a_name
  service           = "power-iaas"
  location          = var.pvs_data_center
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.default.id
  provider          = ibm.pvs_a
}

# Create a network in the workspace a
resource "ibm_pi_network" "pvs_workspace_a_network" {
  pi_network_name      = var.workspace_a_subnet_name
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace_a.guid
  pi_network_type      = "vlan"
  pi_cidr              = var.workspace_a_subnet
  provider             = ibm.pvs_a
}

# Create an SSH key 
resource  "ibm_pi_key" "ssh_key_a" {
  pi_key_name          = var.ssh_key_name
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace_a.guid
  pi_ssh_key           = var.ssh_public_key
  provider             = ibm.pvs_a
}

# Create an instance in workspace A
resource "ibm_pi_instance" "pvs_workspace_a_aix_lpar" {
    pi_memory             = "4"
    pi_processors         = "2"
    pi_instance_name      = var.workspace_a_instance_name
    pi_proc_type          = "shared"
    pi_image_id           = var.workspace_a_aix_image_id
    pi_key_pair_name      = ibm_pi_key.ssh_key_a.name
    pi_sys_type           = var.workspace_a_system_type
    pi_cloud_instance_id  = ibm_resource_instance.pvs_workspace_a.guid
    pi_pin_policy         = "none"
    pi_health_status      = "WARNING"
    pi_storage_type       = var.workspace_a_storage_tier
    pi_network {
      network_id          = ibm_pi_network.pvs_workspace_a_network.network_id
      ip_address          = var.workspace_a_system_ip_address
    }
    provider              = ibm.pvs_a
    depends_on = [ ibm_pi_key.ssh_key_a ]
}

# Create the VPC
resource "ibm_is_vpc" "mgmt_vpc" {
  name                        = var.mgmt_vpc_name
  resource_group              = data.ibm_resource_group.default.id
  address_prefix_management   = "manual"
  provider                    = ibm.mgmt_vpc
}

# Create a prefix in the VPC
resource "ibm_is_vpc_address_prefix" "mgmt_vpc_prefix" {
  name = "${var.mgmt_vpc_name}-${var.mgmt_vpc_zone}-prefix"
  vpc  = ibm_is_vpc.mgmt_vpc.id
  zone = var.mgmt_vpc_zone
  cidr = var.vpc_mgmt_prefix
  provider = ibm.mgmt_vpc
}

# Create the network ACL for the management vpc
resource "ibm_is_network_acl" "mgmt_vpc_main_acl" {
  name           = "mgmt-vpc-main-acl"
  vpc            = ibm_is_vpc.mgmt_vpc.id
  resource_group = data.ibm_resource_group.default.id
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
  provider = ibm.mgmt_vpc
}

# Create a subnet from the prefix and using the ACL we created
resource "ibm_is_subnet" "mgmt_vpc_sn" {
  vpc             = ibm_is_vpc.mgmt_vpc.id
  name            = "${var.mgmt_vpc_name}-${var.mgmt_vpc_zone}-sn"
  zone            = var.mgmt_vpc_zone
  resource_group  = data.ibm_resource_group.default.id
  network_acl     = ibm_is_network_acl.mgmt_vpc_main_acl.id
  ipv4_cidr_block = var.vpc_mgmt_sn
  tags = []
  depends_on = [
    ibm_is_vpc_address_prefix.mgmt_vpc_prefix
  ]
  provider = ibm.mgmt_vpc
}

# add SSH rule to defualt security group
resource "ibm_is_security_group_rule" "sg_ssh_rule" {
  group     = ibm_is_vpc.mgmt_vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
  depends_on = [ibm_is_vpc.mgmt_vpc]
  provider = ibm.mgmt_vpc
}

# Create the SSH key in the vpc
resource "ibm_is_ssh_key" "jumpserver_ssh_key" {
  name          = var.ssh_key_name
  public_key    = var.ssh_public_key
  type          = "rsa"
  provider      = ibm.mgmt_vpc
}

# Create jumpserver VSI in the management VPC
resource "ibm_is_instance" "jumpserver" {
  name                = var.jumpserver_name
  image               = var.jumpserver_image_id
  profile             = var.jumpserver_profile
  primary_network_interface {
    subnet            = ibm_is_subnet.mgmt_vpc_sn.id
  }
  vpc                 = ibm_is_vpc.mgmt_vpc.id
  zone                = var.mgmt_vpc_zone
  keys                = [ibm_is_ssh_key.jumpserver_ssh_key.id]
  resource_group      = data.ibm_resource_group.default.id
  provider            = ibm.mgmt_vpc

}

# Create the FIP for the VSI
resource "ibm_is_floating_ip" "vis_fip" {
  name                = "mgmt-vsi-fip"
  target              = ibm_is_instance.jumpserver.primary_network_interface[0].id
  provider            = ibm.mgmt_vpc
}

# Create the Transit Gateway
resource "ibm_tg_gateway" "main_tgw" {
  name                = "main-tgw"
  location            = var.mgmt_vpc_region
  resource_group      = data.ibm_resource_group.default.id
  global              = false
  provider            = ibm.mgmt_vpc
}

resource "ibm_tg_connection" "pvs_workspace_a" {
  gateway             = ibm_tg_gateway.main_tgw.id
  name                = "powervs_workspace_a"
  network_type        = "power_virtual_server"
  network_id          = ibm_resource_instance.pvs_workspace_a.id
  provider            = ibm.mgmt_vpc
}

# Connection for VPC
resource "ibm_tg_connection" "vpc" {
  gateway             = ibm_tg_gateway.main_tgw.id
  name                = "vpc"
  network_type        = "vpc"
  network_id          = ibm_is_vpc.mgmt_vpc.crn
  provider            = ibm.mgmt_vpc
}