resource "proxmox_vm_qemu" "vm" {
  name        = var.vm_name
  target_node = var.target_node
  clone       = "ubuntu-cloud-init-template"
  vmid        = var.vm_id

  memory      = var.memory
  cores       = var.cores
  sockets     = var.sockets

  ciuser      = var.ciuser
  cipassword  = var.cipassword
  sshkeys     = var.sshkeys
  ipconfig0   = var.ipconfig0
  nameserver  = var.nameserver

  agent       = 1
  onboot      = true

  network {
    model  = "virtio"
    bridge = var.bridge
  }

  disk {
    slot     = "scsi0"
    size     = var.disk_size
    storage  = var.storage
    type     = "disk"
  }

  # Optional: Provisioner to run commands on the VM after creation
  # Requires SSH access; ensure that 'ssh_user' and 'ssh_private_key' are set
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.default_ipv4_address
      user        = var.ssh_user
      private_key = var.ssh_private_key
    }

    inline = [
      # Add any commands you want to execute on the VM here
      "echo 'Provisioning completed!' > /tmp/provisioning.log"
    ]
  }
}
