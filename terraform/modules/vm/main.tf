resource "proxmox_vm_qemu" "noble_server_vm" {
  name        = "noble-server"
  target_node = "ardemium"
  memory      = 2048
  cores       = 2
  sockets     = 1
  disk {
    size    = "10G"
    storage = "local"
    format  = "qcow2"
  }

  network {
    model     = "virtio"
    bridge    = "vmbr0"
  }

  disks {
    scsi {
      scsi0 {
        cdrom {
          iso = "local:iso/noble-server-cloudimg-amd64.img"
        }
      }
    }
  }

  boot        = "order=scsi0"
  qemu_os     = "l26"
  agent       = 1
  vmid        = 100
  define_connection_info = true

  # Cloud-init block
  cicustom    = "local:snippets/user-data"
  ciuser      = "ubuntu"
  cipassword  = "password"
  sshkeys     = "ssh-rsa AAAA... your-ssh-public-key"
  ipconfig0   = "ip=dhcp"

  # Set the VM state to "running" upon creation
  vm_state = "running"
}