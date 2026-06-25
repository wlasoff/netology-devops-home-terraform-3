output "vms" {
   value=concat([for k,v in yandex_compute_instance.web :"name=${v.name},    id=${v.id},    fqdn=${v.fqdn}"],
   [for k,v in yandex_compute_instance.db : "name=${v.name},   id=${v.id},   fqdn=${v.fqdn}"])

}