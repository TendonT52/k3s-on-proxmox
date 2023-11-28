variable "proxmox_username" {
  description = "Proxmox username"
  type        = string
  sensitive   = true
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "endpoint" {
  description = "Proxmox API URL"
  type        = string
  default     = "https://192.168.0.200:8006/api2/json"
}

variable "template_name" {
  default = "ubuntu-cloud"
}

variable "vm_count" {
  default = 1
}