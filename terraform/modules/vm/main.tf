# Define a Proxmox QEMU Virtual Machine using the Cloud-Init template
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"              # VM name
  target_node = "ardemium"               # Proxmox node name
  clone       = "ubuntu-cloud-init-template"  # Clone the Cloud-Init template VM

# VM hardware configuration
  storage  = "local"
  cores    = 2
  sockets  = 1
  memory   = 2048
  disk_gb  = 10

  # Cloud-Init basic configuration
  ciuser     = "ubuntu"            # Cloud-Init user
  cipassword = "ubuntu"            # Password for the user

  os_type   = "cloud-init"
}