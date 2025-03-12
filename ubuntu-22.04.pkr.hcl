packer {
  required_plugins {
    openstack = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/openstack"
    }
  }
}


source "openstack" "ubuntu" {
  identity_endpoint = var.openstack_auth_url
  username    = var.openstack_username
  password    = var.openstack_password
  domain_name = var.openstack_domain
  tenant_name = var.openstack_project
  flavor      = var.flavor
  image_name  = var.image_name
  external_source_image_url = var.source_image
  networks    = var.private_networks
  floating_ip_network  = var.floating_ip_network
  ssh_timeout          = "20m"
  insecure             = "true"
  ssh_username = "ubuntu"
  security_groups = var.security_groups
  use_floating_ip = true
}

build {
  sources = ["source.openstack.ubuntu"]

  provisioner "file" {
    source = "cloud.cfg"
    destination = "/tmp/cloud.cfg"
  }

  provisioner "file" {
    source = "50-cloudimg-settings.cfg"
    destination = "/tmp/50-cloudimg-settings.cfg"
  }

  # Packages installation
  provisioner "shell" {
    inline = [
      "sudo apt-get clean",
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt-get update",
      "sudo apt-get install -y wget curl vim git unzip htop"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/cloud.cfg /etc/cloud/cloud.cfg",
      "sudo chown root:root /etc/cloud/cloud.cfg",
      "sudo chmod 644 /etc/cloud/cloud.cfg",
      "sudo mv /tmp/50-cloudimg-settings.cfg /etc/default/grub.d/50-cloudimg-settings.cfg",
      "sudo chown root:root /etc/default/grub.d/50-cloudimg-settings.cfg",
      "sudo chmod 644 /etc/default/grub.d/50-cloudimg-settings.cfg",
      "sudo update-grub"

    ]
  }

  # Cleanup Steps

  provisioner "shell" {
    inline = [
      "sudo apt-get autoremove -y",
      "sudo cloud-init clean",
      "sudo sync"
    ]
  }
}
