# Instalacao Ubuntu

Instalação Ubuntu 24.04
 - Versão da ISO: **ubuntu-24.04-live-server-amd64.iso**

### Configurações pós instalação
Atualização do Systema
```shell
echo "alias update='apt clean;apt update -y;apt full-upgrade -y;apt upgrade -y;apt autoremove -y'" >> /root/.bashrc;apt clean;apt update -y;apt full-upgrade -y;apt upgrade -y;apt autoremove -y
```
Desabilitar o Swap
```shell
swapoff -a;sed -i '/\/swap.img/s/^/#/' /etc/fstab
```
Desativar Serviços
```shell
systemctl stop apparmor; systemctl disable apparmor;systemctl stop systemd-resolved.service; systemctl disable systemd-resolved.service
```
Configurando o Resolv.conf
```shell
rm -frv /etc/resolv.conf;echo "nameserver 10.8.4.9" >> /etc/resolv.conf;echo "nameserver 10.8.4.10" >> /etc/resolv.conf;echo "search pcmt.local" >> /etc/resolv.conf
```
Configurado o NETPLAN Network
Ubuntu01
```shell
rm -f /etc/netplan/50-cloud-init.yaml;nano /etc/netplan/01-netcfg.yaml;chmod 600 /etc/netplan/01-netcfg.yaml;netplan apply
```
Ubuntu02
```shell
rm -f /etc/netplan/00-installer-config.yaml;nano /etc/netplan/01-netcfg.yaml;chmod 600 /etc/netplan/01-netcfg.yaml;netplan apply
```
```yaml
network:
  version: 2
  ethernets:
    # interface name
    ens3:
      dhcp4: false
      # IP address/subnet mask
      addresses: [10.8.4.21/24]
      # default gatewayrebo
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.8.4.98
          metric: 100
      nameservers:
        # name server to bind
        addresses: [10.8.4.9,8.8.8.8]
        # DNS search base
        search: [pcmt.local,seguranca.local]
      dhcp6: false
```
Caso precisar expandir o disco no LVM
```shell
lv_path=$(lvdisplay | grep 'LV Path' | awk '{print $3}');lvextend -l +100%FREE -r $lv_path
```
Desabilitando o IPV6 na maquina
```shell
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf;sysctl -p;ip a s;apt install -y cron;(crontab -l; echo "@reboot /sbin/sysctl -p") | sudo crontab -
```
