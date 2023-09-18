data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_resource_instance" "pvs_test" {
  name              = "pvs_test_1"
  service           = "power-iaas"
  location          = var.dr_pvs_region
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_pi_key" "key" {
  pi_cloud_instance_id = ibm_resource_instance.pvs_test.guid
  pi_key_name          = var.ssh_key_name
  pi_ssh_key           = var.ssh_key_rsa
}

output "cid" {
    value = ibm_resource_instance.pvs_test.guid
}