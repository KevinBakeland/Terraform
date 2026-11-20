# Zorgt dat de bestaande VM 110 behouden blijft in de nieuwe opzet
moved {
  from = proxmox_virtual_environment_vm.debian12_vm
  to   = proxmox_virtual_environment_vm.vm["debian12-vm"]
}

locals {
  # Een VM erbij? Voeg gewoon een regel toe. Elk id moet uniek zijn.
  vms = {
    "debian12-vm"   = { id = 110, cores = 2, memory = 2048 }
    "debian12-vm-2" = { id = 111, cores = 2, memory = 2048 }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = local.vms

  name      = each.key
  node_name = "proxmoxcloud"
  vm_id     = each.value.id

  agent {
    enabled = false
  }

    cpu {
    cores = each.value.cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
    file_format  = "raw"
    import_from  = "local:import/debian-12-genericcloud-amd64.qcow2"
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    datastore_id = "local-lvm"

    user_account {
      username = "student"
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
