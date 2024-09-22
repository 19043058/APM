# Define a Proxmox QEMU Virtual Machine using Cloud-Init
resource "proxmox_vm_qemu" "ubuntu_cloudinit_vm" {
  name        = var.vm["vm_name"]
  target_node = var.node_name  # Proxmox node
  memory      = var.vm["vm_memory"]
  cores       = var.vm["vm_cores"]
  sockets     = 1

  # Disk configuration using the cloud-init image
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local"  # Proxmox storage pool
          size    = var.vm["vm_disk_size"]
          format  = "qcow2"  # Disk format
        }
      }
    }
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
    model  = "virtio"  # Required network model
    bridge = var.network_bridge  # Proxmox bridge
  }

  # Boot settings
  bootdisk = "scsi0"
  boot     = "order=scsi0"

  # Cloud-Init user data
  cicustom = <<EOF
#cloud-config
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ${var.ssh_public_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
EOF
}
