resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-minimal-vm"
  target_node = "ardemium"
  clone       = "ubuntu-cloud-init-template"

  # Cloud-Init configuration
  ciuser     = "your_username"
  cipassword = "your_password"

  # Enable the QEMU guest agent (optional but recommended)
  agent = 1

  # Network configuration
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Disk configuration
  disk {
    slot     = "scsi0"
    size     = "10G"
    storage  = "local-lvm"
    type     = "disk"
  }
}