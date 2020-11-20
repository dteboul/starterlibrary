#####################################################################
##
##      Created 10/12/20 by ucdpadmin for cloud ibmcloud. for test-cam-project2
##
#####################################################################

## REFERENCE {"ibm_network":{"type": "ibm_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "ibm" {
  version = "~> 0.7"
}

resource "ibm_compute_vm_instance" "webserver" {
  cores       = 1
  memory      = 1024
  domain      = "${var.vm_webserver_domain}"
  hostname    = "${var.vm_webserver_hostname}"
  datacenter  = "${var.vm_webserver_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.auth.id}"]
  os_reference_code = "${var.vm_webserver_os_reference_code}"
  hourly_billing = true
  public_vlan_id       = "${var.ibm_network_public_vlan_id}"
  private_vlan_id       = "${var.ibm_network_private_vlan_id}"
}

resource "ibm_compute_vm_instance" "dbserver" {
  cores       = 1
  memory      = 1024
  domain      = "${var.vm_dbserver_domain}"
  hostname    = "${var.vm_dbserver_hostname}"
  datacenter  = "${var.vm_dbserver_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.auth.id}"]
  os_reference_code = "${var.vm_dbserver_os_reference_code}"
  hourly_billing = true
  public_vlan_id       = "${var.ibm_network_public_vlan_id}"
  private_vlan_id       = "${var.ibm_network_private_vlan_id}"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "auth" {
  label = "CAM Public Key"
  public_key = "${var.ibm_ssh_key_name}"
}

