variable "pvs_region_a" {
  description = "Where to deploy the Power VS Workspace A"
  default = "dal10"
}

variable "workspace_name_a" {
  description = "The name of the workspace to create in region a"
  default = "bcbush-qbr-pvs"
}

variable "workspace_a_aix_image_id" {
  default = "42e479c8-7433-4c6f-8733-635298f9a9d5"
}

variable "powervs_workspace_a_instance_name" {
  default = "bcbush-qbr-aix"
}

variable "storage_type_a" {
  description = "This is the Power VS storage type to use for the server deployed in workspace a"
  default = "tier3"
}

variable "ssh_key_name" {
  description = "Name of the ssh key to be used"
  type        = string
  default     = "bcbush-qbr-ssh"
}

variable "ssh_key_rsa" {
  description = "Public ssh key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDK0BHNL2ct5XpfQtY4vMEfON7ac2H3+X6p885vFEPSKyJwLCqflrRE2bi+R7YBRwM54VZKFQ+K9t3GjZXnRmZ7Ob+c9E5viE778X9bZMx7Yk3yZ8/j/peJpLYrw8ya+PqlExhNc4IBGBkSdhyRZ0f52SyreYhMA5wYspYyN+qSlp1PrDZl5ih5USzlXmfUebaG4r3/ADORUOkHuIUlopBr+mxE4D/cMS+I5en4Epzi8u0VdR7IjOZ4YzsqJYIDKtGsg7cyif/vvQct9F1GpLsUyXnrS/iL90cDgfSvUuI9dkMfRD+hsLIRLMMUDrLHSBbpeJJ1SHuQpfVOmnzcyEIHTLfqd1W+EslKFpThkeQ4I7gn+N4CD7ZkdqYp65IWy7fkkQaHjVhFOMNrV8epje2aY80pQc1/6BsQwzUn9rewV+MQnMfG96gtL29/osE2QWoAtO2WEf3rONBmllqLugJZqd0JHd3CgjIkPKFg6aHPzZp8711GEKIdLhaOCni7j7y5u8Pqv/M7sDl9nlg8UZ9CMRWuINM39lpEu0S9PF1OLNca3ECC4A6cfi+BcEjzpGbi/AtzkelfIeB5aGPZllclikI9UDel2s+MRGNipWDGTzBnPr1PVzHFPmEnT3GbUUzzGCttTQS1hAAdIsnr1Ql8W1tX6otofe/7T2D0fZgpxw=="
}

variable "vpc_a_region" {
  description = "IBM Cloud Region where resources will be provisioned"
  type        = string
  default     = "us-south"
  validation {
    error_message = "Region must be in a supported IBM VPC region."
    condition     = contains(["us-south", "us-east", "br-sao", "ca-tor", "eu-gb", "eu-de", "jp-tok", "jp-osa", "au-syd"], var.vpc_a_region)
  }
}

variable "vpc_b_region" {
  description = "IBM Cloud Region where resources will be provisioned"
  type        = string
  default     = "us-south"
  validation {
    error_message = "Region must be in a supported IBM VPC region."
    condition     = contains(["us-south", "us-east", "br-sao", "ca-tor", "eu-gb", "eu-de", "jp-tok", "jp-osa", "au-syd"], var.vpc_b_region)
  }
}

variable "vpc_name" {
  description = "The name of the VPC"
  type = string
  default = "bcbush-qbr-vpc"
}

variable "vpc_image_id" {
  default = "r014-e177f7ed-0077-413a-ae91-07fc79398ba4"
  description = "The image id used for the VSI in the VPC"
}

variable "vsi_profile" {
  default = "cx2-2x4"
  description = "The default profile to use, a cx2-2x4"
}

variable "vpc_a_zone" {
  default = "us-south-1"  
}

variable "vpc_b_zone" {
  default = "us-south-1"  
}

variable "vsi_instance_name" {
  default = "bcbush-jumpserver"
}
