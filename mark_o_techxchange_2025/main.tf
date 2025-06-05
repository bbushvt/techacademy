data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_resource_instance" "pvs_workspace_a" {
  name              = var.workspace_name_a
  service           = "power-iaas"
  location          = var.pvs_region_a
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.group.id
  provider          = ibm.a
}

resource "ibm_pi_network" "pvs_network_workspace_a" {
  count                = 1
  pi_network_name      = "main"
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace_a.guid
  pi_network_type      = "vlan"
  pi_cidr              = "192.168.0.0/24"
  pi_dns               = ["8.8.8.8"]
  pi_gateway           = "192.168.0.1"
  pi_ipaddress_range {
    pi_starting_ip_address  = "192.168.0.2"
    pi_ending_ip_address    = "192.168.0.254"
  }
  provider             = ibm.a
}

resource "ibm_pi_instance" "test-instance" {
    pi_memory             = "4"
    pi_processors         = "2"
    pi_instance_name      = "test-vm"
    pi_proc_type          = "shared"
    pi_image_id           = "91e60650-3aa2-4d1c-afee-e649b53e170a"
    pi_key_pair_name      = ibm_pi_key.key.key_id
    pi_sys_type           = "s1022"
    pi_cloud_instance_id  = ibm_resource_instance.pvs_workspace_a.guid
    pi_pin_policy         = "none"
    pi_health_status      = "WARNING"
    pi_network {
      network_id          = ibm_pi_network.pvs_network_workspace_a.id
      ip_address          = "192.168.0.10"
    }
    provider              = ibm.a
}





# resource "ibm_resource_instance" "pvs_workspace_b" {
#   name              = var.workspace_name_b
#   service           = "power-iaas"
#   location          = var.pvs_region_b
#   plan              = "power-virtual-server-group"
#   resource_group_id = data.ibm_resource_group.group.id
#   provider          = ibm.b
# }

