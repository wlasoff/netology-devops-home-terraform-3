locals {
  webservers_for_ansible = [
    for i, vm in yandex_compute_instance.web : {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]
  
  databases_for_ansible = [
    for name, vm in yandex_compute_instance.db-vm : {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]
  
  storage_for_ansible = [
    {
      name        = yandex_compute_instance.storage.name
      external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn        = yandex_compute_instance.storage.fqdn
    }
  ]
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/inventory.tmpl", {
    webservers = local.webservers_for_ansible
    databases  = local.databases_for_ansible
    storage    = local.storage_for_ansible
  })
  
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db-vm,
    yandex_compute_instance.storage
  ]
}