variable "pvs_region_a" {
  description = "Where to deploy the Power VS Workspace A"
  default = "wdc06"
}

variable "pvs_region_b" {
  description = "Where to deploy the Power VS Workspace B"
  default = "dal14"
}

variable "workspace_name_a" {
  description = "The name of the workspace to create in region a"
  default = "pvs_workspace_a"
}

variable "workspace_name_b" {
  description = "The name of the workspace to create in region b"
  default = "pvs_workspace_b"
}

variable "storage_type_a" {
  description = "This is the Power VS storage type to use for the server deployed in workspace a"
  default = "tier3"
}

variable "ssh_key_name" {
  description = "Name of the ssh key to be used"
  type        = string
  default     = "mysshkey"
}

variable "ssh_key_rsa" {
  description = "Public ssh key"
  type        = string
  default     = ""
}

variable "vpc_region" {
  description = "IBM Cloud Region where resources will be provisioned"
  type        = string
  default     = "us-south"
  validation {
    error_message = "Region must be in a supported IBM VPC region."
    condition     = contains(["us-south", "us-east", "br-sao", "ca-tor", "eu-gb", "eu-de", "jp-tok", "jp-osa", "au-syd"], var.vpc_region)
  }
}

variable "vpc_name" {
  description = "The name of the VPC"
  type = string
  default = "myvpc"
}


