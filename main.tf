resource "proxmox_virtual_environment_download_file" "debian12_image" {
  node_name    = "proxmoxcloud"
  datastore_id = "local"
  content_type = "import"
  file_name    = "debian-12-genericcloud-amd64.qcow2"
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "proxmox_virtual_environment_vm" "debian12_vm" {
  name      = "debian12-vm"
  node_name = "proxmoxcloud"
  vm_id     = 110

  agent {
    enabled = false
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
    file_format  = "raw"
    import_from  = proxmox_virtual_environment_download_file.debian12_image.id
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    datastore_id = "local-lvm"

    user_account {
      username = "debian"
      password = var.vm_password
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  operating_system {
    type = "l26"
  }
}
