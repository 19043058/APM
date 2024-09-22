resource "proxmox_vm_qemu" "ubuntu_cloud_init_vm" {
  name        = "ubuntu-cloud-init-vm"
  target_node = "proxmox-node1"             # Proxmox node
  clone       = "ubuntu-cloud-init-template" # Clone from a cloud-init template

  # VM Hardware Configuration
  storage  = "local-lvm"   # Storage pool
  cores    = 2             # Number of CPU cores
  sockets  = 1             # Number of CPU sockets
  memory   = 2048          # Memory in MB
  disk_gb  = 10            # Disk size in GB

  # Cloud-Init Configuration
  ciuser     = "ubuntu"             # Cloud-init user
  cipassword = "password"           # User password
  ipconfig0  = "ip=dhcp"            # Dynamic IP address

  sshkeys = <<EOF
  ssh-rsa AAAAB3...GeneratedPublicKey
  EOF

  # Network Interface
  network {
    bridge = "vmbr0"                # Network bridge
    model  = "virtio"               # Network interface model
  }

  # Cloud-Init Disk
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"      # Cloud-Init storage
        }
      }
    }
  }
}
