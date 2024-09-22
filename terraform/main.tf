module "my_vm" {
  source = "./modules/vm"

  vm_name          = "my-new-vm"
  vm_id            = 100  # Optional; set to 0 or omit to auto-assign
  memory           = 4096  # Optional; default is 2048
  cores            = 4     # Optional; default is 2
  sockets          = 1     # Optional; default is 1
  ipconfig0        = "ip=dhcp"  # Optional; default is "ip=dhcp"
  nameserver       = "8.8.8.8"  # Optional; default is "8.8.8.8"
  sshkeys          = file("~/.ssh/id_rsa.pub")
  ciuser           = "ubuntu"   # Optional; default is "ubuntu"
  cipassword       = "yourpassword"  # Optional; sensitive
  ssh_private_key  = file("~/.ssh/id_rsa")
  ssh_user         = "ubuntu"   # Optional; default is "ubuntu"
  storage          = "local-lvm"  # Optional; default is "local-lvm"
  disk_size        = "30G"      # Optional; default is "20G"
  proxmox_url          = var.proxmox_url
  proxmox_token_id     = var.proxmox_token_id
  proxmox_token_secret = var.proxmox_token_secret
}
