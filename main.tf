terraform {
  cloud {
    organization = "vives"

    workspaces {
      name = "test"
    }
  }
}

# Jullie eerste Ubuntu test-VM op Proxmox (proxmoxcloud)
resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "terraform-ubuntu-01"
  node_name = "proxmoxcloud"

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
    interface    = "scsi0"
    file_format  = "raw"
  }

  network_device {
    bridge = "vmbr0"
  }
}
