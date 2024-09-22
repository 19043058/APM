# Define a Proxmox QEMU Virtual Machine using the Cloud-Init template
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"              # VM name
  target_node = "ardemium"               # Proxmox node name
  clone       = "ubuntu-cloud-init-template"  # Clone the Cloud-Init template VM

  storage = "local"
  cores   = 3
  sockets = 1
  memory  = 2560
  disk_gb = 4
  nic     = "virtio"
  bridge  = "vmbr0"
  os_type   = "cloud-init"
}