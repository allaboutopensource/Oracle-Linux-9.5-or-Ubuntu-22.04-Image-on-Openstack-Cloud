variable "openstack_username" {
  type    = string
  default = env("OS_USERNAME")
}

variable "floating_ip_network" {
  description = "Network ID where you want resoures to be created"
  default     = "26c6d7d73-7a84bc1a787b"
}

variable "openstack_password" {
  type    = string
  default = env("OS_PASSWORD")
}

variable "openstack_auth_url" {
  type    = string
  default = env("OS_AUTH_URL")
}

variable "openstack_project" {
  type    = string
  default = env("OS_PROJECT_NAME")
}

variable "openstack_domain" {
  type    = string
  default = env("OS_USER_DOMAIN_NAME")
}

variable "image_name" {
  type    = string
  default = "Oracle Linux 9.5-{{isotime \"20060102-150405\"}}"
}

variable "ssh_keypair_name" {
  type    = string
  default = "Project"
}

variable "flavor" {
  type    = string
  default = "5325-aeb1-946d52678b2a"
}

variable "network" {
  type    = string
  default = "890cd5-6915d95fdc8f"
}

variable "source_image" {
  type    = string
  default = "https://yum.oracle.com/templates/OracleLinux/OL9/u5/x86_64/OL9U5_x86_64-kvm-b253.qcow2"
}


variable "security_groups" {
  type    = string
  default = "all-ports"
}
