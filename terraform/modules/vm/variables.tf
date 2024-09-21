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

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "template_name" {
  description = "Name of the Proxmox VM template to clone"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "network_bridge" {
  description = "Network bridge to use"
  type        = string
}

variable "vm" {
  description = "Configuration for the VM"
  type = object({
    vm_id        = number
    vm_name      = string
    vm_memory    = number
    vm_cores     = number
    vm_disk_size = string
  })
}