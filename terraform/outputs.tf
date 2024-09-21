output "nginx_vm_ip" {
  value     = module.nginx_vm.vm_ip
  sensitive = true
}

output "nginx_vm_name" {
  value = module.nginx_vm.vm_name
}