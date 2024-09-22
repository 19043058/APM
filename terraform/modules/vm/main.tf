resource "proxmox_vm_qemu" "noble_server_vm" {
  name        = var.vm["vm_name"]
  target_node = var.node_name
  memory      = var.vm["vm_memory"]
  cores       = var.vm["vm_cores"]
  sockets     = 1

  disk {
    size    = var.vm["vm_disk_size"]
    storage = "local"
    format  = "qcow2"
    slot    = 0   # Add this slot parameter
  }

  network {
    model     = "virtio"
    bridge    = var.network_bridge
  }

  disks {
    scsi {
      scsi0 {
        cdrom {
          iso = "local:iso/${var.template_name}"
        }
      }
    }
  }

  boot        = "order=scsi0"
  qemu_os     = "l26"
  agent       = 1
  vmid        = var.vm["vm_id"]
  define_connection_info = true

  # Cloud-init block
  cicustom    = "local:snippets/user-data"
  ciuser      = "ubuntu"
  cipassword  = "password"
  sshkeys     = var.ssh_public_key
  ipconfig0   = "ip=dhcp"

  vm_state = "running"
}
