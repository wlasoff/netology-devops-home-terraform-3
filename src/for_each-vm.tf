#создаем 2 разые ВМ
resource "yandex_compute_instance" "db" {
  for_each   = {
    for index, vm in var.each_vm:
    vm.vm_name => vm # Perfect, since VM names also need to be unique
    # OR: index => vm (unique but not perfect, since index will change frequently)
    # OR: uuid() => vm (do NOT do this! gets recreated everytime)
  }

  name       = each.value.vm_name
  hostname    = each.value.vm_name
  # ip_address = each.value.ip_address
  platform_id = "standard-v1"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }

  # metadata = var.metadata
    metadata = local.metadata
  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
     security_group_ids = toset([yandex_vpc_security_group.example.id])
  }
  allow_stopping_for_update = true
}
