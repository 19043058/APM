import os
from proxmoxer import ProxmoxAPI

proxmox = ProxmoxAPI(
    os.environ['PROXMOX_HOST'],
    token_name=os.environ['PROXMOX_TOKEN_ID'],
    token_value=os.environ['PROXMOX_TOKEN_SECRET'],
    verify_ssl=False
)

node = os.environ['NODE_NAME']
storage = os.environ['STORAGE_NAME']
vmid = 9000

# Create VM
proxmox.nodes(node).qemu.create(
    vmid=vmid,
    name="nixos-template",
    memory=2048,
    cores=2,
    net0="virtio,bridge=vmbr0",
    scsihw="virtio-scsi-pci",
    ide2=f"{storage}:cloudinit",
    ostype='l26',
    boot='cdn',
    bootdisk='scsi0',
    agent=1,
    onboot=True,
    description='NixOS Template'
)

# Import Disk
proxmox.nodes(node).qemu(vmid).create('importdisk', filename='nixos.qcow2', storage=storage)

# Attach Disk
proxmox.nodes(node).qemu(vmid).config.update(
    scsihw='virtio-scsi-pci',
    scsi0=f'{storage}:vm-{vmid}-disk-0'
)

# Convert to Template
proxmox.nodes(node).qemu(vmid).template.create()
