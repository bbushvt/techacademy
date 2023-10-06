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

variable "ssh_key_name" {
  description = "Name of the ssh key to be used"
  type        = string
  default     = "mysshkey"
}

variable "ssh_key_rsa" {
  description = "Public ssh key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC81/IS6vSLOvl8Jdbo/cY4w9WHz7bmEggdY0grNMPkDRowEKXy9QgfOopymvhBdwipDDKJBGTw8k3lxoL2Iz9kIfD2LMn5EVC5utMvbQrIDwnD3mYaxFhGxHqCDiB7PvIi2d0H0MGYjdCmEhv8rtjmD+q5rfUC5Ficjtgok34WzdphAndY7ckrBr3wOL/O3Jjz3lgyEFCx7c+SK38ZM7u9BWuNhhUXTssfAwlzmKbwTrDBSwCbXV02JqkNja+LzHangGVSIMiZwRnPbMiybiS36C2wvxmlEFgI3v03vE5610a8nKeh5+CPW+onA7kwxHnppVJxD7LLm/2RLpTOVPdA5e/bZtt6hLGs/cZaCIgNC/e7krqjEy4Iw5ZRPBrUibRWcpxewk0fI9Ue5R7zCN/DYO9pY+48wHeX65V1mnggOGoJtqDyLORSmIr5AWvIKpIIyhj7wwELkYPeCBjypxVkhq10GJL3IpKgR/gh3cITwLF8Uq7mkBsK86c2MfhqyM7Z7/I2OCQokjvXgvyN1HN2Lt5HKkNTsN1Al9+VfUj36BRzeNANmT17pNPutmjPWOTzAIAoBCr0q+ctcZpqfK05hC28AUFgyDxaLiiJLaCRMtkKG62xbdEWauJHYRXWTbax/oAwLZ4uMGN6dt11yJdzauHGUXeRFwxWHuzqzntVmw== Tech Academy"
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