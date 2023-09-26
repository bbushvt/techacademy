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

resource "ibm_pi_image" "aix_image_a" {
  pi_image_name             = var.image_name_a
  pi_cloud_instance_id      = ibm_resource_instance.pvs_workspace_a.guid
  pi_image_bucket_name      = var.bucket_name
  pi_image_bucket_access    = "public"
  pi_image_bucket_region    = var.bucket_region
  pi_image_bucket_file_name = var.bucket_file_name
  pi_image_storage_type     = var.storage_type_a
  provider                  = ibm.a
}

resource "ibm_resource_instance" "pvs_workspace_b" {
  name              = var.workspace_name_b
  service           = "power-iaas"
  location          = var.pvs_region_b
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.group.id
  provider          = ibm.b
}

resource "ibm_pi_image" "aix_image_b" {
  pi_image_name             = var.image_name_b
  pi_cloud_instance_id      = ibm_resource_instance.pvs_workspace_b.guid
  pi_image_bucket_name      = var.bucket_name
  pi_image_bucket_access    = "public"
  pi_image_bucket_region    = var.bucket_region
  pi_image_bucket_file_name = var.bucket_file_name
  pi_image_storage_type     = var.storage_type_b
  provider                  = ibm.b
}