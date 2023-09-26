variable "pvs_region" {
  description = "Where to deploy the Power VS Workspace"
  default = "tor01"
}

variable "workspace_name" {
  description = "The name of the workspace to create"
  default = "pvs_workspace"
}

variable "image_name" {
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

variable "storage_type" {
  description = "This is the Power VS storage type to use for this image"
  default = "tier3"
}