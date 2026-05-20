resource "yandex_compute_instance" "web" {
  count = var.web_vm_config.count
  
  name        = "web-${count.index + 1}"
  platform_id = var.web_vm_config.platform_id
  zone        = var.zone

  resources {
    cores         = var.web_vm_config.cpu
    memory        = var.web_vm_config.ram
    core_fraction = var.web_vm_config.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.web_vm_config.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.default.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.web-sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
    hostname = "web-${count.index + 1}"
  }

  depends_on = [
    yandex_compute_instance.db-vm
  ]
}