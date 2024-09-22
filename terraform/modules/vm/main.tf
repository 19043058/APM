# Define a Proxmox QEMU Virtual Machine using Cloud-Init
resource "proxmox_vm_qemu" "ubuntu_cloudinit_vm" {
  name        = "ubuntu-cloudinit-vm"
  target_node = "ardemium"  # Proxmox node where the cloud image is stored
  memory      = 2048        # Memory in MB
  cores       = 2           # Number of CPU cores
  sockets     = 1           # Number of CPU sockets

  # Disk configuration using the cloud-init image
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local"  # Proxmox storage pool
          size    = "10G"    # Disk size for the VM
          file    = "local:iso/noble-server-cloudimg-amd64.img"  # Path to cloud image
        }
      }
    }
  }

  # Cloud-Init disk
  disks {
    scsi {
      scsi1 {
        cloudinit {
          storage = "local"  # Proxmox storage pool for cloud-init
        }
      }
    }
  }

  # Network configuration
  network {
    bridge = "vmbr0"  # Proxmox bridge
  }

  # Boot settings
  bootdisk = "scsi0"
  boot     = "order=scsi0"

  # Cloud-Init user data (minimal setup with SSH access)
  cicustom = {
    user = <<EOF
#cloud-config
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ssh-rsa YOUR_PUBLIC_SSH_KEY
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
EOF
  }
}
