variable "vm_name" {
  description = "The name of the VM"
  type        = string
}

variable "target_node" {
  description = "The Proxmox node on which to place the VM"
  type        = string
  default     = "ardemium"
}

variable "vm_id" {
  description = "The ID of the VM in Proxmox. If not provided, the next available ID will be used."
  type        = number
  default     = 0
}

variable "memory" {
  description = "Amount of memory to allocate to the VM in MB"
  type        = number
  default     = 2048
}

variable "cores" {
  description = "Number of CPU cores per socket"
  type        = number
  default     = 2
}

variable "sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "ipconfig0" {
  description = "IP configuration for the first network interface"
  type        = string
  default     = "ip=dhcp"
}

variable "nameserver" {
  description = "DNS nameserver for the VM"
  type        = string
  default     = "8.8.8.8"
}

variable "sshkeys" {
  description = "SSH public keys to add to the VM"
  type        = string
  default     = ""
}

variable "ciuser" {
  description = "Cloud-init username"
  type        = string
  default     = "ubuntu"
}

variable "cipassword" {
  description = "Cloud-init password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "bridge" {
  description = "The bridge to attach the network interface to"
  type        = string
  default     = "vmbr0"
}

variable "storage" {
  description = "The storage pool for the VM disks"
  type        = string
  default     = "local-lvm"
}

variable "disk_size" {
  description = "Size of the VM disk"
  type        = string
  default     = "20G"
}

variable "ssh_user" {
  description = "The SSH user for provisioners"
  type        = string
  default     = "ubuntu"
}

variable "ssh_private_key" {
  description = "Private key for SSH access"
  type        = string
  sensitive   = true
  default     = ""
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