data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

data "yandex_vpc_network" "default" {
  name = "default-network"
}


data "yandex_vpc_subnet" "default" {
  name = "default-subnet"
}