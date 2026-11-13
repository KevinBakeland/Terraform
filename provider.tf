terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.60.0"
    }
  }
}

provider "proxmox" {
  # De provider haalt de inloggegevens automatisch op 
  # via de Environment Variables die in HCP Terraform zijn ingesteld.
}
