data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_resource_instance" "pvs_workspace" {
  name              = var.workspace_name
  service           = "power-iaas"
  location          = var.pvs_region
  plan              = "power-virtual-server-group"
  resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_pi_image" "aix_image" {
  pi_image_name             = var.image_name
  pi_cloud_instance_id      = ibm_resource_instance.pvs_workspace.guid
  pi_image_bucket_name      = var.bucket_name
  pi_image_bucket_access    = "public"
  pi_image_bucket_region    = var.bucket_region
  pi_image_bucket_file_name = var.bucket_file_name
  pi_image_storage_type     = var.storage_type
  timeouts {
    create = "120m"
  }
}
