variable "pvs_data_center" {
  description = "Where to deploy the Power VS Workspace"
  default = "wdc07"
}

variable "workspace_a_name" {
  description = "The name of the workspace to create"
  default = "techxchange-pvs-workspace"
}

variable "workspace_a_subnet_name" {
  description = "The name of the subnet in workspace a"
  default = "main"
}

variable "workspace_a_subnet" {
  description = "The CIDR for the subnet that will be created in workspace a"
  default = "192.168.0.0/24"
}

variable "ssh_public_key" {
  description = "The public SSH key to use in IBM Cloud"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVcyJ8A3WvOAwp/k5NjgUvXXkDsfWxDiqhLEwv3X+l8u83qK0gtNcFD8RrabRGymFqRgYNTgFihXtIjAu7g/hSD+JEq/U8UE3fy6iWJ5yqPwG5PHnOYuKWMA205wEct6Cwo/vmG71OpVoezDJY8sJbdfTCjoQqir3ciiq73rlCPad6jJ0DslVwojhT0Q9PEP+ukslZgbf8nckkuKonb1ShCJBlWbXz9QQxYvw9wAh+MmFCBY6ktZyWskOM4M1DnBWVttecCUlq3OK3CsyahoszfA4UQDM92TUYrj2gF0ocQ/klGIMEJEvuFarI+p7CzO4tEMrxeDx3hkoSH4mtfjHA1d3hSBdvV2hgE2jp1hOXLIa7K1WhOFcb3qLDkWgIPwuPO93SeRRHcFaSj2MQx89rgDZUzZPa6i/ul7CIgoagp2eJRK9A4lCScl+usRi2ps6FRos8yGDnzBxXdJz+rt4zhYcOMtUQDL8MPH+BC/3xaRrlz6aY92EOJ5vSeLOqtP0="
}

variable "ssh_key_name" {
  description = "The name for the public ssh key"
  default = "techxchange-ssh-key"
}

variable "workspace_a_instance_name" {
  description = "The name of the AIX instance"
  default = "techxchange_aix_vsi"
}

variable "workspace_a_aix_image_id" {
  description = "The image ID for the AIX instance"
  default = "7337579b-cc50-46ea-81d8-7cd06788dcbf"
}

variable "workspace_a_system_type" {
  description = "The type of system to deploy (s922/s1022/s1122)"
  default = "s1022"
}

variable "workspace_a_system_ip_address" {
  description = "The IP address to use for the AIX lpar (needs to be in the subnet being created)"
  default = "192.168.0.10"
}

variable "workspace_a_storage_tier" {
  description = "The storage tier to use for the disk on the LPAR"
  default = "tier5k"
}

variable "mgmt_vpc_name" {
  description = "The name of the management vpc"
  default = "management-vpc"
}

variable "mgmt_vpc_region" {
  description = "IBM Cloud Region where the VPC will be provisioned"
  type        = string
  default     = "us-east"
  validation {
    error_message = "Region must be in a supported IBM VPC region."
    condition     = contains(["us-south", "us-east", "br-sao", "ca-tor", "eu-gb", "eu-de", "jp-tok", "jp-osa", "au-syd"], var.mgmt_vpc_region)
  }
}

variable "mgmt_vpc_zone" {
  description = "The zone we are going to use for the prefix and subnet"
  default = "us-east-1"  
}

variable "vpc_mgmt_prefix" {
  description = "The CIDR block to use for the prefix"
  default = "192.168.1.0/24"
}

variable "vpc_mgmt_sn" {
  description = "The CIDR block to use for the subnet, should be the same as vpc_mgmt_prefix or a subnet within it"
  default = "192.168.1.0/24"
}

variable "jumpserver_name" {
  description = "The name of the jumpserver VSI"
  default = "mgmt-jumpserver"
}

variable "jumpserver_image_id" {
  description = "The image id for the OS to deploy on the jumpserver VSI"
  default = "r014-17640494-4779-460c-99b2-000ff509896d"
}

variable "jumpserver_profile" {
  description = "The server profile to deploy the jumpserver on"
  default = "cx2-2x4"
}