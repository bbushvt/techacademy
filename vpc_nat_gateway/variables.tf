variable "base_name" {
  description = "base name to use to identify items"
  type = string
  default = "nat-gateway"
}

variable "resource_group_name" {
  description = "The name of the resource group to use"
  default = "Default"
}

locals {
  # Define a map for default values based on the region
  image_id_by_region = {
    "us-south"  = "r006-e1a644b8-c961-4388-9a82-fedcb73ad1f1"
    "us-east"   = "r014-e177f7ed-0077-413a-ae91-07fc79398ba4"
    "br-sao"    = "r042-eabceae5-916b-4195-b5d1-4484634a9ea4"
    "ca-tor"    = "r038-41a60492-13ad-4ccf-a6e4-51f1d4a9d4d3"
    "ca-mon"    = "r058-90815097-ecf7-4ea3-b038-66620ea1c529"
    "eu-gb"     = "r018-7b4fdcf8-8931-4680-9fea-5535753963cc"
    "eu-es"     = "r050-ac6a35b4-dad9-4b0b-9d7e-52c9d3aa4937"
    "jp-tok"    = "r022-7d041528-5242-4e8d-a192-90aac3c8732f"
    "jp-osa"    = "r034-c522f04c-4ae8-41e7-a7d2-50c51bf69c20"
    "au-syd"    = "r026-6932f1a5-90b5-49ef-b2b8-ebc78b00bb5c"    
  }
}

variable "nat_gateway_region" {
  description = "The region to deploy the VPC to"
  type        = string
  default     = "us-south"
  validation {
    error_message = "Region must be in a supported IBM VPC region."
    condition     = contains(["us-south", "us-east", "br-sao", "ca-tor", "ca-mon", "eu-gb", "eu-de", "eu-es", "jp-tok", "jp-osa", "au-syd"], var.nat_gateway_region)
  }
}

variable "zone" {
  description = "Which zone to deploy the nat gateway to.  1, 2, or 3"
  type = string
  default = "2"
  validation {
    error_message = "Zone must be 1, 2 or 3"
    condition = contains(["1", "2", "3"], var.zone)
  }
}

variable "cidr_block" {
  description = "The CIDR block to use for the NAT gateway"
  type = string
  default = "192.168.0.0/24"
}

variable "ssh_ingress_cidr" {
  description = "This is the cidr block to allow in for ssh"
  type = string
  default = "0.0.0.0/0"
  validation {
    condition     = can(cidrhost(var.ssh_ingress_cidr, 32))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "ssh_key" {
  description = "Public ssh key"
  type        = string
  validation {
    condition     = can(regex("^(ssh-rsa|ssh-ed25519) AAAAB3NzaC.*", var.ssh_key))
    error_message = "Invalid SSH public key format. Must be RSA or Ed25519."
  }
}

variable "vsi_image_id" {
  default     = ""
  description = "The image id used for the VSI.  Leave blank to auto select"
}

variable "vsi_profile" {
  default = "cx2-2x4"
  description = "The default profile to use, a cx2-2x4"
}

variable "user_data" {
  description = "shell script to run on first boot.  Used to configure NAT and ip forwarding"
  type = string
  default = <<EOF
#!/bin/bash
DEBIAN_FRONTEND=noninteractive apt install -y iptables-persistent
echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4
EOF
}
