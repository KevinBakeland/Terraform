terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
  }
}

variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API URL, bijv. https://192.168.1.10:8006/"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "Proxmox API token in formaat user@pam!tokenid=secret"
}

variable "proxmox_insecure" {
  type        = bool
  default     = true
  description = "Zet op false als Proxmox een geldig TLS-certificaat heeft"
}

variable "vm_name" {
  type        = string
  default     = "debian12-vm"
  description = "Naam van de gekloonde VM"
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure
}

resource "proxmox_virtual_environment_vm" "debian12_vm" {
  node_name = "proxmoxcloud"
  vm_id     = 100
  name      = var.vm_name

  clone {
    vm_id = 102
    full  = true
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
    file_format  = "raw"
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }
}

output "vm_id" {
  value = proxmox_virtual_environment_vm.debian12_vm.vm_id
}

output "vm_name" {
  value = proxmox_virtual_environment_vm.debian12_vm.name
}
