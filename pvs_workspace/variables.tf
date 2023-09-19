variable "dr_pvs_region" {
  description = "Where to deploy the DR environment"
  default = "tor01"
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