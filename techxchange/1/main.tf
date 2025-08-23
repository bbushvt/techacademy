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


