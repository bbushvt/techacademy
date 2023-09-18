variable "dr_pvs_region" {
  description = "Where to deploy the DR environment"
  default = "tor01"
}

variable "ssh_key_name" {
  description = "Name of the ssh key to be used"
  type        = string
  default     = "test_ssh"
}

variable "ssh_key_rsa" {
  description = "Public ssh key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5z4xt0DntJzFKbK897Y5wqYiem+1RNACwsA5VvPa8U3rp+83bxwKsvPfSfT9QptXvpBiZ6r7/FkxAG4Hv9d5yOQnBBzO0OfKulYB2C7DDXCCaWJgCTNk7wvI0Y+TuNcWo6mH2nl4GNx2BpmVbH0qpRyD1zUhfQe22StaMCMdHpyqpy09GMpglofIIRU4c+uDCElsD2mwKu4dVETpgRxmcKVK7fAORz43d8OU9aGFmN2Pkzb8cKyhL1BFt4y2nZerYeLaFzFeCI7OXcBdwcqBLFniDfctvJU7p/S8eKh6EtIwSmbWpLXPFu9StomWxRx43bPRmKR5kDfijUejlw8b4DMBMD03D1dLVmPBIcA1ywuha5XkWP3mFw3/7dYnsoy3F8LuWeqETd4BaWIwVaCSJKXN9kGT7WWqUF3cr7crfn3jiBcl/Pkg/4t/ObcxGddkYG10D/IqwegbcYvk1NOhiXOUhJNweH1Bj5tpyQj6LicmtNifLBqJg47FQZkLO5dVD/K+LShMH2KUio904n4ObyOvRtin9YiH3Mz8qnCiah9khaeQ05OPXDpR2l6D5IOmkFgyq2TIKvCKPSlqFtA4zCH5em0A5JJ2l4MNIQCA45q4ZeCxpMTBATWE5BIIBc/KWD355poKXD3JogBuc0uke+AIpPQcIUcx5Ej+/T1S3Sw== Tech Academy"
}