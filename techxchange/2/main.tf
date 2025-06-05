data "ibm_resource_group" "default" {
  name = "Default"
}

data "ibm_resource_group" "cloud_techsales" {
  name = "cloud-techsales"
}

resource "ibm_resource_instance" "pvs_workspace_a" {
  name              = var.workspace_name_a
  service           = "power-iaas"
  location          = var.pvs_region_a
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.cloud_techsales.id
  provider          = ibm.a
}

resource "ibm_pi_network" "power_networks" {
  count                = 1
  pi_network_name      = "main"
  pi_cloud_instance_id = ibm_resource_instance.pvs_workspace_a.guid
  pi_network_type      = "vlan"
  pi_cidr              = "172.16.0.0/24"
  provider             = ibm.a
}


