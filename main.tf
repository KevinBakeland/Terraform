terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.60.0"
    }
  }
}

provider "proxmox" {
  # De provider haalt zijn inloggegevens en endpoint meestal 
  # uit je HCP Terraform Environment Variables (zoals PM_API_URL, PM_USER, etc.)
}

resource "proxmox_virtual_environment_vm" "debian_vm" {
  name      = "debian-vm-1"
  node_name = "proxmoxcloud"

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
