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


