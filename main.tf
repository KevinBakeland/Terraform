terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.60.0"
    }
  }
}

provider "proxmox" {
  # Haalt gegevens uit HCP Terraform Environment Variables
}

resource "proxmox_virtual_environment_vm" "debian_vm" {
  name      = "debian-vm-1"
  node_name = "proxmoxcloud"

  cdrom {
    file_id = "local:iso/debian-12.8.0-amd64-netinst.iso"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
    interface    = "scsi0"
  }

  network_device {
    bridge = "vmbr0"
  }

  started = true
}
