terraform {
  required_version = "~> 1.9.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.60.0"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://10.20.203.14:8006/"
  api_token = var.proxmox_api_token
  insecure  = true
}
