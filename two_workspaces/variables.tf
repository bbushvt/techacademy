variable "pvs_region_a" {
  description = "Where to deploy the Power VS Workspace"
  default = "tor01"
}

variable "pvs_region_b" {
  description = "Where to deploy the Power VS Workspace"
  default = "osa21"
}

variable "workspace_name_a" {
  description = "The name of the workspace to create"
  default = "pvs_workspace_a"
}

variable "workspace_name_b" {
  description = "The name of the workspace to create"
  default = "pvs_workspace_b"
}

variable "image_name_a" {
  description = "The name of the image to be created"
  default = "aix_imported_image"
}

variable "image_name_b" {
  description = "The name of the image to be created"
  default = "aix_imported_image"
}

variable "bucket_name" {
  description = "The name of the bucket to import the image from"
  default = "aix73archive"  
}

variable "bucket_region" {
  description = "The region where the image is being imported from"
  default = "us-south" 
}

variable "bucket_file_name" {
  description = "The name of the image to import"
  default = "aix73tecx.ova.gz"  
}

variable "storage_type_a" {
  description = "This is the Power VS storage type to use for this image"
  default = "tier3"
}

variable "storage_type_b" {
  description = "This is the Power VS storage type to use for this image"
  default = "tier3"
}