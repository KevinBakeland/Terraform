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

  # De Debian ISO als virtuele cd
  cdrom {
    file_id   = "local:iso/debian-12.8.0-amd64-netinst.iso"
    interface = "ide3"
  }

  # Lege disk waar Debian op geïnstalleerd wordt
  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  # Lege disk eerst, daarna de ISO
  boot_order = ["scsi0", "ide3"]

  operating_system {
    type = "l26"
  }
}
