data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_resource_instance" "pvs_workspace" {
  name              = var.pvs_workspace_name
  service           = "power-iaas"
  location          = var.dr_pvs_region
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_pi_key" "key" {
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace.guid
  pi_key_name          = var.ssh_key_name
  pi_ssh_key           = var.ssh_key_rsa
}

resource "ibm_pi_network" "pvs_private_network" {
  pi_network_name      = var.pvs_private_subnet_name
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace.guid
  pi_network_type      = "vlan"
  pi_cidr              = var.pvs_private_subnet_cidr
  pi_dns               = ["127.0.0.1"]
  pi_gateway           = var.pvs_private_subnet_gateway
  pi_network_mtu       = var.pvs_private_subnet_mtu
  pi_ipaddress_range {
    pi_starting_ip_address  = var.pvs_private_subnet_start_address
    pi_ending_ip_address    = var.pvs_private_subnet_end_address
  }
}

resource "ibm_pi_network" "pvs_public_network" {
  pi_network_name      = var.pvs_public_subnet_name
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace.guid
  pi_network_type      = "pub-vlan"
  pi_network_mtu       = var.pvs_private_subnet_mtu
}

resource "ibm_pi_image" "aix_image" {
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace.guid
  pi_image_id          = var.pvs_aix_image_id
  pi_image_name        = var.pvs_aix_image_name
  timeouts {
    create = "9m"
  }
}

resource "ibm_pi_instance" "dr_instance" {
    pi_memory             = var.pvs_dr_instance_memory
    pi_processors         = var.pvs_dr_instance_cores
    pi_instance_name      = var.pvs_dr_instance_name
    pi_proc_type          = "shared"
    pi_image_id           = ibm_pi_image.aix_image.image_id
    pi_key_pair_name      = ibm_pi_key.key.pi_key_name
    pi_sys_type           = "s922"
    pi_cloud_instance_id  = ibm_resource_instance.pvs_workspace.guid
    pi_pin_policy         = "none"
    pi_health_status      = "WARNING"
    pi_network { network_id = ibm_pi_network.pvs_public_network.network_id }
    pi_network { network_id = ibm_pi_network.pvs_private_network.network_id }
    pi_storage_type = "tier1"
}