# Define a Proxmox QEMU Virtual Machine using the Cloud-Init template
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"              # VM name
  target_node = "ardemium"               # Proxmox node name
  clone       = "ubuntu-cloud-init-template"  # Clone the Cloud-Init template VM

# VM hardware configuration
  storage  = "local-lvm"
  cores    = 2
  sockets  = 1
  memory   = 2048
  disk_gb  = 10

  # Cloud-Init basic configuration
  ciuser     = "ubuntu"            # Cloud-Init user
  cipassword = "ubuntu"            # Password for the user
  ipconfig0  = "ip=dhcp"           # Dynamic IP (DHCP)

  # Network interface
  network {
    model  = "virtio"
    bridge = "vmbr0"              # Proxmox bridge (usually vmbr0)
  }

  # Cloud-Init disk (mandatory for passing user data)
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}