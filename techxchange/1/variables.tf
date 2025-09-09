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