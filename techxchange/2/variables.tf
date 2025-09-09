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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9WtH8MgfX434Pxt8jBDR8ILUWLeyIR8ajSuZdr7wVq4vpj7sal6M1Bri8n/jCBIO3LsllkjuRzf0X3xAH6S5BNpoalaH5yjZMXV8ieonslhpqcKzj2+vWcteuKIGgGOGit3qrdEwXQNJRk5w8TxEVIBs7YfzomoaYBMzx+10pFZ6VvbP8B+Vf+Xld4wGFKDST+ou5M4cHn93p2Jk4Gz4djumsJMPp9cIsC2aub8h8KC4/pgG/guQI99aUPqrA/pmoCERZx80BoN0TNBO7VE5XNE+QTQ80JMPC4qucGffGgK8Q/6oGWyho5w9Ujxky0SF6dnZUhcCACFeItpQJiebqhCdb75y0KaL7tkIBn/aaHyeLf2PpOu7aHchvi78azdNcGmIolH2JnXAnZ4mWeuX1CGtsDqJGkbHGEvADno/u1zyM2ZuUCnSzMzlkwWoSvtgPbkD9YxxzsE4/1yVz7w+QGUxbet5CQN4rGYS3yEavyF0o2qdkBTTXYpE450I+Xos="
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