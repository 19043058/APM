# Define a Proxmox QEMU Virtual Machine
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"
  target_node = "ardemium"  # Specify the Proxmox node where the ISO is stored
  memory      = 2048        # Memory in MB
  cores       = 2           # Number of CPU cores
  sockets     = 1           # Number of CPU sockets
  cpu         = "host"      # CPU type
  
  # Define disk configuration with local ISO
  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/ubuntu-24.04.1-live-server-amd64.iso"  # Path to your ISO on node 'ardemium'
        }
      }
    }
  }

  # Define network configuration
  network {
    bridge   = "vmbr0"  # Proxmox bridge
    model    = "virtio" # Use virtio for better performance
    firewall = false    # Disable firewall for simplicity
  }

  # Boot settings
  boot = "order=ide2"

  # Additional optional settings
  onboot = true         # Start VM automatically after Proxmox boot
  agent  = 1            # Enable QEMU agent for guest integration
  bios   = "seabios"    # Use seabios as BIOS
}