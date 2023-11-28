terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.38.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true
  ssh {
    agent = true
  }
}

resource "proxmox_virtual_environment_vm" "kube-controller" {
  name      = "kube-controller"
  node_name = "pve"
  machine   = "q35"
  bios      = "ovmf"

  agent {
    enabled = true
  }

  clone {
    vm_id = "9999"
  }

  operating_system {
    type = "l26"
  }

  cpu {
    cores = 2
    type  = "host"
    numa  = true
  }

  memory {
    dedicated = 4096
  }

  disk {
    size         = "30"
    interface    = "scsi0"
    datastore_id = "local-lvm"
    file_format  = "raw"
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    interface = "scsi1"
    ip_config {
      ipv4 {
        address = "192.168.0.210/24"
        gateway = "192.168.0.1"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "kube-worker" {
  name       = "kube-worker"
  node_name  = "pve"
  machine    = "q35"
  bios       = "ovmf"

  agent {
    enabled = true
  }

  clone {
    vm_id = "9999"
  }

  operating_system {
    type = "l26"
  }

  cpu {
    cores = 32
    type  = "host"
    numa  = true
  }

  memory {
    dedicated = 65536
  }

  disk {
    size         = "30"
    discard      = "on"
    interface    = "scsi0"
    datastore_id = "local-lvm"
    file_format  = "raw"
  }

  disk {
    size         = "200"
    discard      = "on"
    interface    = "virtio0"
    datastore_id = "sda"
    file_format  = "raw"
  }

  disk {
    size         = "200"
    discard      = "on"
    interface    = "virtio1"
    datastore_id = "sdb"
    file_format  = "raw"
  }

  disk {
    size         = "200"
    discard      = "on"
    interface    = "virtio2"
    datastore_id = "sdc"
    file_format  = "raw"
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    interface = "scsi1"
    ip_config {
      ipv4 {
        address = "192.168.0.211/24"
        gateway = "192.168.0.1"
      }
    }
  }
}
