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
