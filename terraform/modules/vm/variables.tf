variable "vm_id" {
  type = number
}

variable "vm_name" {
  type = string
}

variable "vm_memory" {
  type = number
}

variable "vm_cores" {
  type = number
}

variable "vm_disk_size" {
  type = string
}

variable "node_name" {
  type = string
}

variable "network_bridge" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "template_name" {
  type = string
}

variable "proxmox_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_token_id" {
  description = "Proxmox API Token ID"
  type        = string
}

variable "proxmox_token_secret" {
  description = "Proxmox API Token Secret"
  type        = string
  sensitive   = true
}