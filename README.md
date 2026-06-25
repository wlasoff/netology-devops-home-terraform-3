# Домашнее задание к занятию «Управляющие конструкции в коде Terraform» - Студент группы FOPS-42 Власов Владимир

### Цели задания

1. Отработать основные принципы и методы работы с управляющими конструкциями Terraform.
2. Освоить работу с шаблонизатором Terraform (Interpolation Syntax).

------

### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Доступен исходный код для выполнения задания в директории [**03/src**](https://github.com/netology-code/ter-homeworks/tree/main/03/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------

### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.12.0
Теперь пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Изучите проект.
2. Инициализируйте проект, выполните код. 


Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud .

------

### Решение задания 1

1. Изучил проект.
2. Заполнил файл personal.auto.tfvars.
3. Инициализирувал проект, выполнив код. Он выполнится, даже если доступа к preview нет.

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image.png)

Правила «Группы безопасности» в ЛК Yandex Cloud:

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-2.png)


------


### Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk_volume , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```  
При желании внесите в переменную все возможные параметры.
3. ВМ, описанные в файле count-vm.tf, должны создаваться после ВМ, описанных в файле for_each-vm.tf.
4. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.
5. Инициализируйте проект, выполните код.

------


### Решенеи задания 2

1. Создал файл count-vm.tf, описав в нём создание двух **одинаковых** виртуальные машины (ВМ)  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначил ВМ созданную в первом задании группу безопасности:

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-1.png)

2. Создал файл for_each-vm.tf, описав в нём создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk_volume , используя мета-аргумент **for_each loop**.
Использовал для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```  

Сделал так:

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-3.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-4.png)


3. ВМ из пункта 1 данного задания должны создаваться после создания ВМ из пункта 2.

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-5.png)

4. Используя функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из задания 2.

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-6.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-7.png)

5. Инициализирую проект, выполнив код:

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-8.png)

------



### Задание 3

1. Создайте 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf** .
2. Создайте в том же файле **одиночную**(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage"  . Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

------

### Решение задания 3

1. Создайю 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf** .

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-9.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-10.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-11.png)

2. Создайю в том же файле **одиночную**(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage"  . Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-12.png)

После создания ВМ в консоле видно:

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-20.png)

------


### Задание 4

1. В файле ansible.tf создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demo).
Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.
2. Инвентарь должен содержать 3 группы и быть динамическим, т. е. обработать как группу из 2-х ВМ, так и 999 ВМ.
3. Добавьте в инвентарь переменную  [**fqdn**](https://cloud.yandex.ru/docs/compute/concepts/network#hostname).
``` 
[webservers]
web-1 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
web-2 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[databases]
main ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
replica ansible_host<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[storage]
storage ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
```
Пример fqdn: ```web1.ru-central1.internal```(в случае указания переменной hostname(не путать с переменной name)); ```fhm8k1oojmm5lie8i22a.auto.internal```(в случае отсутвия перменной hostname - автоматическая генерация имени,  зона изменяется на auto). нужную вам переменную найдите в документации провайдера или terraform console.
4. Выполните код. Приложите скриншот получившегося файла. 

Для общего зачёта создайте в вашем GitHub-репозитории новую ветку terraform-03. Закоммитьте в эту ветку свой финальный код проекта, пришлите ссылку на коммит.   
**Удалите все созданные ресурсы**.

------

### Решение задания 4

1. В файле ansible.tf создаю inventory-файл для ansible. Используя функцию tepmplatefile и файл-шаблон из лекции создал ansible inventory-файл.
Готовый код брал тут [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demo).
Передав него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, всего по 5 ВМ.
2. Инвентарь содержит 3 группы и работает динамическим, т. е. обрабатывает как группу из 2-х ВМ, так и 999 ВМ.
3. Добавил в инвентарь переменную  [**fqdn**](https://cloud.yandex.ru/docs/compute/concepts/network#hostname).
``` 
[webservers]
web-1 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
web-2 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[databases]
main ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
replica ansible_host<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[storage]
storage ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
```
по примеру fqdn: ```web1.ru-central1.internal```(в случае указания имени ВМ); ```fhm8k1oojmm5lie8i22a.auto.internal```(в случае автоматической генерации имени ВМ зона изменяется). нужную вам переменную найдите в документации провайдера или terraform console.

4. Выполните код. Приложите скриншот получившегося файла. 

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-13.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-14.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-15.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-16.png)

![alt text](https://github.com/wlasoff/netology-devops-home-terraform-3/blob/main/img/image-17.png)

Создал в своем GitHub-репозитории новую ветку terraform-03. 
Закоммител в эту ветку свой финальный код проекта, ссылка на коммит:   

https://github.com/wlasoff/netology-devops-home-terraform-3/commit/bf515fb6fa26dc79ec8eb6049b50c8cd0ca16b3d
