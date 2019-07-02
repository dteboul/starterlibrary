provider "ibm" {}

module "camtags" {
  source = "../Modules/camtags"
}

variable "public_ssh_key" {
  description = "Public SSH key used to connect to the virtual guest"
}

variable "datacenter" {
  description = "Softlayer datacenter where infrastructure resources will be deployed"
}

variable "hostname" {
  description = "Hostname of the virtual instance (small flavor) to be deployed"
  default     = "debian-small"
}

# This will create a new SSH key that will show up under the \
# Devices>Manage>SSH Keys in the SoftLayer console.
resource "ibm_compute_ssh_key" "orpheus_public_key" {
  label      = "Orpheus Public Key"
  public_key = "${var.public_ssh_key}"
}

variable "domain" {
  description = "VM domain"
}

# Create a new virtual guest using image "Debian"
resource "ibm_compute_vm_instance" "debian_small_virtual_guest" {
  hostname                 = "${var.hostname}"
  os_reference_code        = "DEBIAN_8_64"
  domain                   = "${var.domain}"
  datacenter               = "${var.datacenter}"
  network_speed            = 10
  hourly_billing           = true
  private_network_only     = false
  cores                    = 1
  memory                   = 1024
  disks                    = [25, 10, 20]
  user_metadata            = "{\"value\":\"newvalue\"}"
  dedicated_acct_host_only = false
  local_disk               = false
  ssh_key_ids              = ["${ibm_compute_ssh_key.orpheus_public_key.id}"]
  tags                     = ["${module.camtags.tagslist}"]
}

resource "null_resource" "install_client" {
  # Specify the ssh connection
  connection {
    type = "ssh"
    user = "${var.vm_os_user}"
    password =  "${var.vm_os_password}"
    private_key = "${length(var.private_key) > 0 ? base64decode(var.private_key) : ""}"
    host = "${var.boot_ipv4_address}"
    bastion_host        = "${var.bastion_host}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${length(var.bastion_private_key) > 0 ? base64decode(var.bastion_private_key) : var.bastion_private_key}"
    bastion_port        = "${var.bastion_port}"
    bastion_host_key    = "${var.bastion_host_key}"
    bastion_password    = "${var.bastion_password}"          
  }
  
  provisioner "file" {
    content = <<EOF
     #!/bin/bash

    # update ubuntu
    sudo apt-get update
    # install NAGIOS nagios_client
    sudo apt-get install nagios-nrpe-server nagios-plugins
    sed -i "s@#server_address=127.0.0.1@server_address=169.62.141.140@g" /etc/nagios/nrpe.cfg
    service nagios-nrpe-server restart
EOF
    
    destination = "/tmp/installation.sh"
    }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installation.sh; bash /tmp/installation.sh "
    ]
  }
}    
    
output "vm_ip" {
  value = "Public : ${ibm_compute_vm_instance.debian_small_virtual_guest.ipv4_address}"
}
