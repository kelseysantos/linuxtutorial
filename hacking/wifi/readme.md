# Wifi Hacking Passwords

Vamos utilizar uma metodologia de aprendizado.

Pré requisitos:
 - SO Ubuntu 22.04
 - Placa Wifi
 - Instalação dos pacotes abaixo:
```shell
apt update;apt install -y airgraph-ng aircrack-ng
```
Start check nas interface:
```shell
airmon-ng check kill && airmon-ng start wlp3s0
```
![fotowifi](https://i.postimg.cc/cJV78w8s/image.png)

Scanner do SSID Disponiveis:
```shell
airodump-ng wlp3s0
```
![fotoexpamle](https://i.postimg.cc/brqtQTYj/image.png)

Agora scanneado pega um