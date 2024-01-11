variable "dr_pvs_region" {
  description = "Where to deploy the DR environment"
  default = "us-south"
}

variable "ssh_key_name" {
  description = "Name of the ssh key to be used"
  type        = string
  default     = "Key02"
}

variable "ssh_key_rsa" {
  description = "Public ssh key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC81/IS6vSLOvl8Jdbo/cY4w9WHz7bmEggdY0grNMPkDRowEKXy9QgfOopymvhBdwipDDKJBGTw8k3lxoL2Iz9kIfD2LMn5EVC5utMvbQrIDwnD3mYaxFhGxHqCDiB7PvIi2d0H0MGYjdCmEhv8rtjmD+q5rfUC5Ficjtgok34WzdphAndY7ckrBr3wOL/O3Jjz3lgyEFCx7c+SK38ZM7u9BWuNhhUXTssfAwlzmKbwTrDBSwCbXV02JqkNja+LzHangGVSIMiZwRnPbMiybiS36C2wvxmlEFgI3v03vE5610a8nKeh5+CPW+onA7kwxHnppVJxD7LLm/2RLpTOVPdA5e/bZtt6hLGs/cZaCIgNC/e7krqjEy4Iw5ZRPBrUibRWcpxewk0fI9Ue5R7zCN/DYO9pY+48wHeX65V1mnggOGoJtqDyLORSmIr5AWvIKpIIyhj7wwELkYPeCBjypxVkhq10GJL3IpKgR/gh3cITwLF8Uq7mkBsK86c2MfhqyM7Z7/I2OCQokjvXgvyN1HN2Lt5HKkNTsN1Al9+VfUj36BRzeNANmT17pNPutmjPWOTzAIAoBCr0q+ctcZpqfK05hC28AUFgyDxaLiiJLaCRMtkKG62xbdEWauJHYRXWTbax/oAwLZ4uMGN6dt11yJdzauHGUXeRFwxWHuzqzntVmw== Tech Academy"
}

variable "pvs_workspace_name" {
  description = "Name of the PowerVS workspace"
  type = string
  default = "TechXchange Workshop DR"
}

variable "pvs_private_subnet_name" {
  description = "The name to give the PowerVS subnet"
  type = string
  default = "dr-network"
}

variable "pvs_private_subnet_mtu" {
  description = "The MTU for the private Network"
  type = number
  default = 9000
}

variable "pvs_public_subnet_name" {
  description = "The name to give the PowerVS subnet"
  type = string
  default = "pub-net"
}

variable "pvs_private_subnet_cidr" {
  description = "The CIDR for the subnet (ex 192.168.0.0/24)"
  type = string
  default = "172.16.1.0/24"
}

variable "pvs_private_subnet_gateway" {
  description = "Gateway address for the subnet, generally the first address, ex 192.168.0.1"
  type = string
  default = "172.16.1.1"
}

variable "pvs_private_subnet_start_address" {
  description = "The starting IP address for the subnet, should start at the 4th address, ex 192.168.0.4"
  type = string
  default = "172.16.1.4"
}

variable "pvs_private_subnet_end_address" {
  description = "The ending IP address for the subnet, should end at 254, ex 192.168.0.254"
  type = string
  default = "172.16.1.254"
}

variable "pvs_aix_image_id" {
  description = "The image ID for the AIX Image we want to deploy"
  type = string
  default = "2eee95bf-9d27-4166-a9ba-17835f8ae821"
}

variable "pvs_aix_image_name" {
  description = "The name of the image"
  type = string
  default = "7100-05-09"
}

variable "pvs_dr_instance_cores" {
  description = "The number of cores for the dr instance"
  type = string
  default = ".25"
}

variable "pvs_dr_instance_memory" {
  description = "The amount of memory (GB) for the dr instance"
  type = string
  default = "4"
}

variable "pvs_dr_instance_name" {
  description = "The name of the DR instance"
  type = string
  default = "VM02"
}