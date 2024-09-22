# Define a Proxmox QEMU Virtual Machine using the Cloud-Init template
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"              # VM name
  target_node = "ardemium"               # Proxmox node name
  clone       = "ubuntu-cloud-init-template"  # Clone the Cloud-Init template VM

  memory      = 2048                     # Memory in MB
  cores       = 2                        # Number of CPU cores
  sockets     = 1                        # Number of CPU sockets

  # Cloud-Init specific options
  ciuser     = "ubuntu"                  # Cloud-init username
  cipassword = "password"                # Cloud-init password (replace with a secure password)

  # Network configuration using Cloud-Init
  ipconfig0   = "ip=dhcp"                # Assign IP address dynamically via DHCP

  # Define disk settings using SCSI (the default for Proxmox)
  disks {
    scsi0 {
      size    = "20G"                    # Disk size
      storage = "local-lvm"              # Storage location
    }
  }

  # Cloud-Init disk for injecting user-data (automatically created by Proxmox)
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  # Network interface for the VM
  network {
    model  = "virtio"                    # Network card model (virtio is recommended)
    bridge = "vmbr0"                     # Proxmox bridge (usually vmbr0)
  }

  # Enable QEMU Guest Agent for better VM control
  agent  = 1

  # Remove boot order explicitly to avoid referencing non-existent devices
  # boot = "order=scsi0"                 # This can be omitted unless specific boot order is required
}
