resource "yandex_compute_disk" "mydisk" {
  count = 3

  name     = "mydisk-${count.index+1}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = 1
#   block_size = <размер_блока>
  labels = {
    environment = "test"
  }
}


resource "yandex_compute_instance" "storage" {

  name       ="storage"
  hostname    ="storage"
  # ip_address = each.value.ip_address
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  dynamic "secondary_disk" {
    for_each = "${yandex_compute_disk.mydisk.*.id}"
    content {
      # disk_id     = yandex_compute_disk.mydisk["${secondary_disk.key}"].id
      disk_id     = secondary_disk.value
    }
  }

#   dynamic "secondary_disk" 
#     for_each = yandex_compute_disk.mydisk
#     content {
#       disk_id = yandex_compute_disk.mydisk.id
#     }
 

#     dynamic "ingress" {
#     for_each = var.security_group_ingress
#     content {
#       protocol       = lookup(ingress.value, "protocol", null)
#       description    = lookup(ingress.value, "description", null)
#       port           = lookup(ingress.value, "port", null)
#       from_port      = lookup(ingress.value, "from_port", null)
#       to_port        = lookup(ingress.value, "to_port", null)
#       v4_cidr_blocks = lookup(ingress.value, "v4_cidr_blocks", null)
#     }
#   }


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
