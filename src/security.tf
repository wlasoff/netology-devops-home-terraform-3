resource "yandex_vpc_security_group" "web-sg" {
  name        = "web-security-group"
  description = "Security group for web VMs"
  network_id  = yandex_vpc_network.default.id

  dynamic "ingress" {
    for_each = local.security_group_ingress_rules
    content {
      description    = ingress.value.description
      protocol       = ingress.value.protocol
      port           = ingress.value.port
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
    }
  }

  egress {
    description    = "All outcoming"
    protocol       = "ANY"
    v4_cidr_blocks = var.public_access_cidrs
  }
}