resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-cloud-init-vm"
  target_node = "ardemium"
  memory      = 2048
  cores       = 2
  sockets     = 1
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"

  # Disk settings using the cloud-init image
  disks {
    scsi0 {
      size = "10G"
      storage = "local-lvm"
      file = "local-lvm:vm-9000-disk-0"  # Reference to the disk created in Proxmox
    }
  }

  # Cloud-init configuration
  ciuser     = "ubuntu"
  cipassword = "your-password"
  ipconfig0  = "ip=dhcp"
  sshkeys    = file("~/.ssh/id_rsa.pub")

  network {
    bridge = "vmbr0"
  }

  # Enable QEMU Guest Agent
  agent = 1

  # Start VM after Proxmox reboots
  onboot = true

  # Boot from the disk
  boot = "order=scsi0"
}