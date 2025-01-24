#!/bin/bash

# Обновляем пакеты
sudo apt update

# Изменяем конфигурацию netplan для активации Wi-Fi
cat <<EOT | sudo tee /etc/netplan/orangepi-default.yaml
network:
  version: 2
  wifis:
    wlan0:
      access-points:
        "123":
          password: "12345678"
      dhcp4: true
EOT

# Изменяем права доступа к файлу netplan
sudo chmod 600 /etc/netplan/orangepi-default.yaml

# Устанавливаем необходимые пакеты
sudo apt-get install -y openvswitch-switch-dpdk

sudo netplan apply

curl -o- -k https://raw.githubusercontent.com/Oink70/Android-Mining/main/install.sh | bash

sudo netplan apply

curl -o- -k https://raw.githubusercontent.com/Oink70/Android-Mining/main/install.sh | bash



# Создаём конфигурационный файл майнера
cat <<EOT > ~/ccminer/config.json
{
    "pools": [
        {
            "name": "vipor",
            "url": "stratum+tcp://ru.vipor.net:5040",
            "timeout": 150,
            "disabled": 0
        }
    ],
    "user": "RQvK8B67qX4Na9jx3cvCduZVDpjF5JyWwo",
    "algo": "verus",
    "threads": 8,
    "cpu-priority": 1,
    "retry-pause": 5,
    "api-allow": "192.168.0.0/16",
    "api-bind": "0.0.0.0:4068"
}
EOT

# Добавляем майнер в автозагрузку
(crontab -l 2>/dev/null; echo "@reboot ~/ccminer/start.sh") | crontab -
