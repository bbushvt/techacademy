locals {
  # Map PowerVS data centers to regions
  ibm_powervs_zone_region_map = {
    "lon04"    = "lon"
    "lon06"    = "lon"
    "mad02"    = "mad"
    "mad04"    = "mad"
    "eu-de-1"  = "eu-de"
    "eu-de-2"  = "eu-de"
    "tor01"    = "tor"
    "mon01"    = "mon"
    "osa21"    = "osa"
    "tok04"    = "tok"
    "syd04"    = "syd"
    "syd05"    = "syd"
    "sao01"    = "sao"
    "sao04"    = "sao"
    "us-south" = "us-south"
    "dal10"    = "us-south"
    "dal12"    = "us-south"
    "dal14"    = "us-south"
    "us-east"  = "us-east"
    "wdc06"    = "us-east"
    "wdc07"    = "us-east"
  }
}

# The provider we'll use for deploying PowerVS resources
provider "ibm" {
    region              = lookup(local.ibm_powervs_zone_region_map, var.pvs_data_center, null)
    zone                = var.pvs_data_center
    alias               = "pvs_a"
}
