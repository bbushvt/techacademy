data "ibm_resource_group" "rg" {
  name = var.resource_group
}

resource "ibm_is_ssh_key" "sshkey1" {
  name = var.ssh_key_name
  public_key = var.ssh_public_key
  type = "rsa"
}

resource "ibm_is_vpc" "vpc1" {
  name = var.vpc_name
  address_prefix_management = "manual"
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_vpc_address_prefix" "vpc-ap1" {
  name = "vpc-ap1"
  zone = var.zone1
  vpc  = ibm_is_vpc.vpc1.id
  cidr = var.zone1_cidr
}

resource "ibm_is_vpc_address_prefix" "vpc-ap2" {
  name = "vpc-ap2"
  zone = var.zone2
  vpc  = ibm_is_vpc.vpc1.id
  cidr = var.zone2_cidr
}

resource "ibm_is_subnet" "subnet1" {
  name            = "subnet1"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone1
  ipv4_cidr_block = var.zone1_cidr
  depends_on      = [ibm_is_vpc_address_prefix.vpc-ap1]
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_subnet" "subnet2" {
  name            = "subnet2"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone2
  ipv4_cidr_block = var.zone2_cidr
  depends_on      = [ibm_is_vpc_address_prefix.vpc-ap2]
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_instance" "instance1" {
  name    = "instance1"
  image   = var.image
  profile = var.profile
  primary_network_interface {
    subnet = ibm_is_subnet.subnet1.id
  }
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
  keys = [ibm_is_ssh_key.sshkey1.id]
  user_data = data.template_cloudinit_config.cloud-init-apptier.rendered
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_floating_ip" "instance1-fip" {
  name   = "instance1"
  target = ibm_is_instance.instance1.primary_network_interface[0].id
}

resource "ibm_is_instance" "instance2" {
  name    = "instance2"
  image   = var.image
  profile = var.profile
  primary_network_interface {
    subnet = ibm_is_subnet.subnet2.id
  }
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone2
  keys = [ibm_is_ssh_key.sshkey1.id]
  user_data = data.template_cloudinit_config.cloud-init-apptier.rendered

  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_floating_ip" "instance2-fip" {
  name   = "instance2"
  target = ibm_is_instance.instance2.primary_network_interface[0].id
}

resource "ibm_is_security_group_rule" "sg1_tcp_rule_22" {
  group     = ibm_is_vpc.vpc1.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

resource "ibm_is_security_group_rule" "sg1_tcp_rule_80" {
  group     = ibm_is_vpc.vpc1.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "80"
    port_max = "80"
  }
}

resource "ibm_is_security_group_rule" "sg1_icmp_rule" {
  group     = ibm_is_vpc.vpc1.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
  }
}



##############################################################################
# VPN Gateways
##############################################################################

resource "ibm_is_vpn_gateway" "ibm_aws_vpn_gw_zone_1" {
  name           = "ibm-aws-vpn-gw-1"
  subnet         = ibm_is_subnet.subnet1.id
  resource_group = data.ibm_resource_group.rg.id
  mode           = "route"
  tags = []
  timeouts {
    delete = "1h"
  }
}

resource "ibm_is_vpn_gateway_connection" "ibm_aws_vpn_gw_zone_1_conn_1" {
  name          = "ibm-aws-conn-1"
  vpn_gateway   = ibm_is_vpn_gateway.ibm_aws_vpn_gw_zone_1.id
  peer_address  = aws_vpn_connection.ibm_cloud_zone1_a.tunnel1_address
  preshared_key = var.preshared_key
  ike_policy    = ibm_is_ike_policy.ibm_aws_ike_policy.id
  ipsec_policy  = ibm_is_ipsec_policy.ibm_aws_ipsec_policy.id
  admin_state_up = true
}

resource "ibm_is_vpn_gateway_connection" "ibm_aws_vpn_gw_zone_1_conn_2" {
  name          = "ibm-aws-conn-2"
  vpn_gateway   = ibm_is_vpn_gateway.ibm_aws_vpn_gw_zone_1.id
  peer_address  = aws_vpn_connection.ibm_cloud_zone1_a.tunnel2_address
  preshared_key = var.preshared_key
  ike_policy    = ibm_is_ike_policy.ibm_aws_ike_policy.id
  ipsec_policy  = ibm_is_ipsec_policy.ibm_aws_ipsec_policy.id
  admin_state_up = true
}

resource "ibm_is_vpn_gateway_connection" "ibm_aws_vpn_gw_zone_1_conn_3" {
  name          = "ibm-aws-conn-3"
  vpn_gateway   = ibm_is_vpn_gateway.ibm_aws_vpn_gw_zone_1.id
  peer_address  = aws_vpn_connection.ibm_cloud_zone1_b.tunnel1_address
  preshared_key = var.preshared_key
  ike_policy    = ibm_is_ike_policy.ibm_aws_ike_policy.id
  ipsec_policy  = ibm_is_ipsec_policy.ibm_aws_ipsec_policy.id
  admin_state_up = true
}

resource "ibm_is_vpn_gateway_connection" "ibm_aws_vpn_gw_zone_1_conn_4" {
  name          = "ibm-aws-conn-4"
  vpn_gateway   = ibm_is_vpn_gateway.ibm_aws_vpn_gw_zone_1.id
  peer_address  = aws_vpn_connection.ibm_cloud_zone1_b.tunnel2_address
  preshared_key = var.preshared_key
  ike_policy    = ibm_is_ike_policy.ibm_aws_ike_policy.id
  ipsec_policy  = ibm_is_ipsec_policy.ibm_aws_ipsec_policy.id
  admin_state_up = true
}

resource "ibm_is_ipsec_policy" "ibm_aws_ipsec_policy" {
  name                     = "ibm-aws-ipsec-policy"
  authentication_algorithm = "sha256"
  encryption_algorithm     = "aes256"
  pfs                      = "group_14"
}

resource "ibm_is_ike_policy" "ibm_aws_ike_policy" {
  name                     = "ibm-aws-ike-policy"
  authentication_algorithm = "sha256"
  encryption_algorithm     = "aes256"
  dh_group                 = 14
  ike_version              = 2
}

resource "ibm_is_vpc_routing_table_route" "zone1_1_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-1"
  name          = "zone1-1-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_1.gateway_connection // Example value "10.0.0.4"
  priority      = 0
}

resource "ibm_is_vpc_routing_table_route" "zone1_2_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-1"
  name          = "zone1-2-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_2.gateway_connection // Example value "10.0.0.4"
  priority      = 1
}

resource "ibm_is_vpc_routing_table_route" "zone1_3_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-1"
  name          = "zone1-3-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_3.gateway_connection // Example value "10.0.0.4"
  priority      = 2
}

resource "ibm_is_vpc_routing_table_route" "zone1_4_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-1"
  name          = "zone1-4-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_4.gateway_connection // Example value "10.0.0.4"
  priority      = 3
}

resource "ibm_is_vpc_routing_table_route" "zone2_1_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-2"
  name          = "zone2-1-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_1.gateway_connection // Example value "10.0.0.4"
  priority      = 0
}

resource "ibm_is_vpc_routing_table_route" "zone2_2_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-2"
  name          = "zone2-2-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_2.gateway_connection // Example value "10.0.0.4"
  priority      = 1
}

resource "ibm_is_vpc_routing_table_route" "zone2_3_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-2"
  name          = "zone2-3-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_3.gateway_connection // Example value "10.0.0.4"
  priority      = 2
}

resource "ibm_is_vpc_routing_table_route" "zone2_4_to_aws" {
  vpc           = ibm_is_vpc.vpc1.id
  routing_table = ibm_is_vpc.vpc1.default_routing_table
  zone          = "us-south-2"
  name          = "zone2-4-to-aws"
  destination   = var.aws_cidr
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.ibm_aws_vpn_gw_zone_1_conn_4.gateway_connection // Example value "10.0.0.4"
  priority      = 3
}



##############################################################################

