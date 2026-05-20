variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}


variable "zone" {
  description = "Yandex Cloud availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "v4_cidr_blocks" {
  description = "CIDR blocks for subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "public_access_cidrs" {
  description = "CIDR blocks for public access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "web_vm_config" {
  description = "Configuration for web VMs"
  type = object({
    count           = number
    cpu             = number
    ram             = number
    disk_size       = number
    core_fraction   = number
    platform_id     = string
  })
  default = {
    count         = 2
    cpu           = 2
    ram           = 2
    disk_size     = 10
    core_fraction = 20
    platform_id   = "standard-v1"
  }
}


variable "database_vms" {
  description = "Configuration for database VMs"
  type = list(object({
    name        = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      name        = "main"
      cpu         = 2
      ram         = 4
      disk_volume = 20
    },
    {
      name        = "replica"
      cpu         = 4
      ram         = 8
      disk_volume = 30
    }
  ]
}


variable "storage_disks_config" {
  description = "Configuration for storage disks"
  type = object({
    count       = number
    size        = number
    type        = string
  })
  default = {
    count = 3
    size  = 1
    type  = "network-hdd"
  }
}


variable "storage_vm_config" {
  description = "Configuration for storage VM"
  type = object({
    cpu           = number
    ram           = number
    disk_size     = number
    core_fraction = number
    platform_id   = string
  })
  default = {
    cpu           = 2
    ram           = 2
    disk_size     = 10
    core_fraction = 20
    platform_id   = "standard-v1"
  }
}


variable "security_group_rules" {
  description = "Security group rules"
  type = map(object({
    description = string
    protocol    = string
    port        = number
  }))
  default = {
    http = {
      description = "HTTP"
      protocol    = "TCP"
      port        = 80
    }
    https = {
      description = "HTTPS"
      protocol    = "TCP"
      port        = 443
    }
    ssh = {
      description = "SSH"
      protocol    = "TCP"
      port        = 22
    }
  }
}


variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}