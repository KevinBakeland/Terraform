resource "proxmox_virtual_environment_vm" "debian_vm" {
  name      = "debian-vm-1"
  node_name = "proxmoxcloud"
  vm_id     = 670

  # Koppel het ISO-bestand dat je hebt geüpload naar de 'local' opslag
  cdrom {
    file_id = "local:iso/debian-12.8.0-amd64-netinst.iso"
  }

  # De virtuele harde schijf waar het OS op wordt geïnstalleerd
  disk {
    datastore_id = "local-lvm"
    size         = 20
    interface    = "scsi0"
  }

  # Netwerkconfiguratie gekoppeld aan je standaard bridge
  network_device {
    bridge = "vmbr0"
  }

  started = true
}
