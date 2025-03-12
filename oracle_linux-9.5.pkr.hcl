packer {
  required_plugins {
    openstack = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

source "openstack" "oracle-linux" {
  identity_endpoint    = var.openstack_auth_url
  username             = var.openstack_username
  password             = var.openstack_password
  domain_name          = var.openstack_domain
  tenant_name          = var.openstack_project
  flavor               = var.flavor
  image_name           = var.image_name
  external_source_image_url = var.source_image
  networks             = [var.network]
  floating_ip_network  = var.floating_ip_network
  ssh_timeout          = "5m"
  insecure             = "true"
  ssh_username         = "cloud-user"
  ssh_keypair_name     = var.ssh_keypair_name
  ssh_private_key_file = "itops-infra-project.pem"
  security_groups      = [var.security_groups]
  use_floating_ip      = true
}

build {
  sources = ["source.openstack.oracle-linux"]

  provisioner "file" {
    source      = "cloud.cfg"
    destination = "/tmp/cloud.cfg"
  }
  
  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "sudo mv /tmp/cloud.cfg /etc/cloud/cloud.cfg",
      "sudo chown root:root /etc/cloud/cloud.cfg",
      "sudo chmod 644 /etc/cloud/cloud.cfg",
    ]
  }
  provisioner "shell" {
    inline = [
      "sudo dnf autoremove -y",
      "sudo cloud-init clean",
      "sudo sync"
    ]
  }
}

