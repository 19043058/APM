# Define a Proxmox QEMU Virtual Machine using the Cloud-Init template
resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu-vm"              # VM name
  target_node = "ardemium"               # Proxmox node name
  clone       = "ubuntu-cloud-init-template"  # Clone the Cloud-Init template VM

  memory      = 2048                     # Memory in MB
  cores       = 2                        # Number of CPU cores
  sockets     = 1                        # Number of CPU sockets
  pool        = "default"                # (Optional) Specify resource pool

  # Network configuration using Cloud-Init
  ipconfig0   = "ip=dhcp"                # Assign IP address dynamically via DHCP

  # Cloud-Init specific options
  ciuser     = "ubuntu"                  # Cloud-init username
  cipassword = "password"                # Cloud-init password
  sshkeys    = <<EOF
  ssh-rsa AABB3NzaC1kj...your-ssh-public-key
  EOF

  # Define disk settings (Cloud-Init disk will be auto-configured)
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
    bridge = "vmbr0"                     # Proxmox bridge (usually vmbr0)
  }

  # Enable QEMU Guest Agent for better VM control
  agent  = 1

  # Optional: Boot settings (VM will boot from the disk created via the template)
  boot = "order=scsi0"

  # Optional: Remote-exec provisioner to run post-provisioning commands
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")   # Replace with the path to your SSH private key
      host        = self.ipv4_address
      port        = 22
    }
  }
}
