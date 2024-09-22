output "vm_id" {
  description = "The ID of the created VM"
  value       = proxmox_vm_qemu.vm.vmid
}

output "vm_ip" {
  description = "The default IPv4 address of the VM"
  value       = proxmox_vm_qemu.vm.default_ipv4_address
}

output "ssh_host" {
  description = "The SSH host to connect to the VM"
  value       = proxmox_vm_qemu.vm.ssh_host
}

output "ssh_port" {
  description = "The SSH port to connect to the VM"
  value       = proxmox_vm_qemu.vm.ssh_port
}
