# Define a Proxmox QEMU Virtual Machine
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"               # VM name
  target_node = "proxmox-node1"           # Proxmox node name
  memory      = 2048                      # Memory in MB
  cores       = 2                         # Number of CPU cores
  sockets     = 1                         # Number of CPU sockets

  # CPU type (optional)
  # cpu         = "host"                   # Use "host" for better performance

  # Disk configuration with local ISO
  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/ubuntu-24.04.1-live-server-amd64.iso"  # Path to your ISO
        }
      }
    }
  }

  # Network interface
  network {
    bridge = "vmbr0"                      # Proxmox bridge (usually vmbr0)
    # model  = "virtio"                   # Network card model (optional)
  }

  # Boot settings
  boot = "order=ide2"                     # Boot from CD-ROM (the ISO)

  # Start VM automatically after Proxmox boot (optional)
  # onboot = true

  # Enable QEMU Guest Agent (optional, requires agent installation in guest OS)
  # agent  = 1

  # BIOS type (optional, default is "seabios")
  # bios   = "seabios"

  # Provisioners and connection info (optional if not using Terraform provisioners)
  # ssh_user        = "ubuntu"            # SSH user for provisioners
  # ssh_private_key = file("~/.ssh/id_rsa")  # SSH private key for provisioners

  # OS type (optional, used for certain optimizations)
  # os_type = "ubuntu"

  # Remove if you are not using cloud-init or custom provisioning
  # ciuser     = "ubuntu"                 # Cloud-init username
  # cipassword = "password"               # Cloud-init password (sensitive)
  # ipconfig0  = "ip=dhcp"                # Network configuration for cloud-init

  # Other optional settings can be added here
}
