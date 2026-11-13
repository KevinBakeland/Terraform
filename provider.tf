terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.60.0"
    }
  }
}

variable "proxmox_endpoint" { 
  type = string 
}
variable "proxmox_username" { 
  type = string 
}
variable "proxmox_password" { 
  type      = string 
  sensitive = true 
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  username  = var.proxmox_username
  password  = var.proxmox_password
  insecure  = true
}
