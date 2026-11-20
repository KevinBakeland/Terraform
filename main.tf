resource "proxmox_virtual_environment_vm" "debian_vm" {
  name      = "debian-vm-1"
  node_name = "proxmoxcloud"

  clone {
    vm_id = 102
    full  = true
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    file_format  = "raw"
  }

  network_device {
    bridge = "vmbr0"
  }

  started = true
}
