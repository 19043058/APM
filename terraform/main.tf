module "nginx_vm" {
  source = "./modules/vm"

  vm_id           = 100
  vm_name         = "nginx-server"
  vm_memory       = 2048      # Adjust as needed
  vm_cores        = 2         # Adjust as needed
  vm_disk_size    = "20G"     # Adjust as needed
  node_name       = var.node_name
  network_bridge  = var.network_bridge
  ssh_public_key  = var.ssh_public_key
  template_name   = var.template_name
  proxmox_url          = var.proxmox_url
  proxmox_token_id     = var.proxmox_token_id
  proxmox_token_secret = var.proxmox_token_secret
}
