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
    pi_network {
      network_id          = ibm_pi_network.pvs_workspace_a_network.network_id
      ip_address          = var.workspace_a_system_ip_address
    }
    provider              = ibm.pvs_a
    depends_on = [ ibm_pi_key.ssh_key_a ]
}