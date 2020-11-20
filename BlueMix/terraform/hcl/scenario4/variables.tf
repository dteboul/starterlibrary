#####################################################################
##
##      Created 10/12/20 by ucdpadmin for cloud ibmcloud. for test-cam-project2
##
#####################################################################

variable "vm_webserver_domain" {
  type = "string"
  default = "ibm.com"
  description = "The domain for the computing instance."
}

variable "vm_webserver_hostname" {
  type = "string"
  default = "webhost"
  description = "The hostname for the computing instance."
}

variable "vm_webserver_datacenter" {
  type = "string"
  default = "par01"
  description = "The datacenter in which you want to provision the instance. NOTE: If dedicated_host_name or dedicated_host_id is provided then the datacenter should be same as the dedicated host datacenter."
}


variable "ibm_ssh_key_name" {
  type = "string"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWVcdGD+xpfEiWYjSXRd1k77kFewP0JwNQLVDyTUefrWTVmFGlBN4ycc1M16TB2I+7V+ZxWZDdY8M11/WEiegTvCEs6XVziG9Aa6cUsrALAWuxBdOcK4Hvpb0W09AaLep8k2DAuRiVswxUi8CcEbenvMu4GzJqs7t77Zm1KN65hKyw4PYAMg9aKt2VmrM7LoYZCr8759y8GIaiwE3UZDb3YAc9nfxc+el+2Nga9o+mwyD1VmjTuSRYs37ndBRsry5au6cuP2T1JYZWfRh9Fpnj3bVbeGrmjLuoSTruzqJKTr/dUBklEZvsLPkpqN5cXLt2LDmws7p+uaNRrgok8nGt"
  description = "Generated"
}

variable "vm_webserver_os_reference_code" {
  type = "string"
  description = "Generated"
  default     = "CENTOS_7_64"
}

variable "testsecurefield" {
  description = "testsecurefield"
  type = "string"
  default     = "123456789"
}

variable "ibm_network_public_vlan_id" {
  type = "string"
  description = "Generated"
  default = "2894292"
}

variable "ibm_network_private_vlan_id" {
  type = "string"
  description = "Generated"
  default = "2894294"
}

variable "vm_dbserver_domain" {
  type = "string"
  default = "ibm.com"
  description = "The domain for the computing instance."
}

variable "vm_dbserver_hostname" {
  type = "string"
  default = "dbhost"
  description = "The hostname for the computing instance."
}

variable "vm_dbserver_datacenter" {
  type = "string"
  default = "par01"
  description = "The datacenter in which you want to provision the instance. NOTE: If dedicated_host_name or dedicated_host_id is provided then the datacenter should be same as the dedicated host datacenter."
}

variable "vm_dbserver_os_reference_code" {
  type = "string"
  description = "Generated"
  default     = "CENTOS_7_64"
}


