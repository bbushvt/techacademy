variable "ibmcloud_api_key" {
  description = "the IBM Cloud API key"
  default = ""
}

variable resource_group {
  description = "Name of resource group to provision resources"
  default     = "Default"
}

variable "ibmcloud_region" {
  description = "Preferred IBM Cloud region to use for your infrastructure"
  default = "us-south"
}

variable "vpc_name" {
  default = "ibmvpc"
  description = "Name of your VPC"
}

variable "zone1" {
  default = "us-south-1"
  description = "Define the 1st zone of the region"
}

variable "zone2" {
  default = "us-south-2"
  description = "Define the 2nd zone of the region"
}

variable "zone1_cidr" {
  default = "172.16.1.0/24"
  description = "CIDR block to be used for zone 1"
}

variable "zone2_cidr" {
  default = "172.16.2.0/24"
  description = "CIDR block to be used for zone 2"
}

variable "ssh_key_name" {
  default = "ibmawskey"
  description = "Name of an SSH key to create"
}

variable "ssh_public_key" {
  description = "The Public SSH key to use"
  default = ""
}

variable "image" {
  default = "r006-c065ea33-4694-46ac-a0c5-e59cb89a7f9e"
  description = "OS Image ID to be used for virtual instances"
}

variable "profile" {
  default = "cx2-2x4"
  description = "Instance profile to be used for virtual instances"
}

variable "aws_region" {
  default = "us-east-1"
  description = "The AWS region to target"
}

variable "aws_access_key" {
  default = ""
  description = "The AWS Access Key"
}

variable "aws_secret_key" {
  default = ""
  description = "The AWS Secret Access Key"
}

variable "aws_cidr" {
  default = "10.0.0.0/16"
  description = "The CIDR to use for the AWS VPC"  
}

variable "aws_vpc_name" {
  default = "myawsvpc"
  description = "The name tag for the AWS VPC"    
}

variable "aws_internet_gateway_name" {
  default = "main"
  description = "The name tag for the internet gateway"
  
}

variable "aws_route_table_name" {
  default = "custom-route-table"
  description = "The name tag for the custom route table"  
}

variable "aws_subnet_1" {
  default = "10.0.1.0/24"
  description = "The subnet to create in AWS, must be part of the aws_cidr"  
}

variable "aws_subnet_2" {
  default = "10.0.2.0/24"
  description = "The subnet to create in AWS, must be part of the aws_cidr"  
}

variable "aws_ip_1" {
  default = "10.0.1.100"
  description = "An IP address from the aws_subnet_1 subnet"  
}

variable "aws_ip_2" {
  default = "10.0.2.100"
  description = "An IP address from the aws_subnet_2 subnet"  
}

variable "aws_az_1" {
  default = "us-east-1a"
  description = "The first zone to use in AWS"  
}

variable "aws_az_2" {
  default = "us-east-1b"
  description = "The second zone to use in AWS"  
}

variable "aws_subnet_1_name" {
  default = "az1"
  description = "The name tag for the first subnet"
}

variable "aws_subnet_2_name" {
  default = "az2"
  description = "The name tag for the second subnet"
}

variable "aws_security_group_name" {
  default = "main_security_group"
  description = "The name of the security group"  
}

variable "aws_ami_1" {
  default = "ami-0230bd60aa48260c6"
  description = "The AMI to use for the first server"  
}

variable "aws_ami_2" {
  default = "ami-0230bd60aa48260c6"
  description = "The AMI to use for the second server"  
}

variable "aws_instance_type_a" {
  default = "t2.micro"
}

variable "aws_instance_type_b" {
  default = "t2.micro"
}

variable "aws_instance_1_name" {
  default = "instance_a"
  description = "Name of the first AWS instance"
}

variable "aws_instance_2_name" {
  default = "instance_b"
  description = "Name of the second AWS instance"
}

variable "preshared_key" {
  description = "the preshared key for the IPSEC tunnel"
}