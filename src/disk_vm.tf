resource "yandex_compute_disk" "storage_disk" {
  count = var.storage_disks_config.count
  
  name = "storage-disk-${count.index + 1}"
  type = var.storage_disks_config.type
  zone = var.zone
  size = var.storage_disks_config.size
  
  labels = {
    environment = "storage"
    disk-number = "${count.index + 1}"
  }
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.storage_vm_config.platform_id
  zone        = var.zone

  resources {
    cores         = var.storage_vm_config.cpu
    memory        = var.storage_vm_config.ram
    core_fraction = var.storage_vm_config.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.storage_vm_config.disk_size
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
    hostname = "storage"
  }

  depends_on = [
    yandex_compute_disk.storage_disk
  ]
}