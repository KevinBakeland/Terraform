
# Behoudt de bestaande VM in de Terraform-state
moved {
  from = proxmox_virtual_environment_vm.debian12_vm
  to   = proxmox_virtual_environment_vm.vm["debian12-vm"]
}

locals {
  vms = jsondecode(file("${path.module}/vms.json"))
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = local.vms

  name      = each.key
  node_name = each.value.node
  vm_id     = each.value.id

  agent {
    enabled = each.value.agent
  }

  cpu {
    cores = each.value.cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = each.value.storage
    interface    = "scsi0"
    size         = each.value.disk
    file_format  = "raw"
    import_from  = each.value.image
  }

  network_device {
    bridge = each.value.bridge
  }

  initialization {
    datastore_id = each.value.storage

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

