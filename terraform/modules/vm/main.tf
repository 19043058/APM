resource "proxmox_vm_qemu" "vm" {
  name        = var.vm_name
  vmid        = var.vm_id
  memory      = var.vm_memory
  cores       = var.vm_cores
  sockets     = 1
  scsihw      = "virtio-scsi-pci"
  boot        = "cdn"
  bootdisk    = "scsi0"
  agent       = 1
  onboot      = true
  os_type     = "cloud-init"
  target_node = var.node_name

  disk {
    slot     = 0
    size     = var.vm_disk_size
    type     = "scsi"
    storage  = "local-lvm"
    iothread = true
  }

  network {
    model    = "virtio"
    bridge   = var.network_bridge
  }

  clone = var.template_name

  lifecycle {
    ignore_changes = [
      network[0].macaddr  # Ignore changes to MAC address
    ]
  }
}