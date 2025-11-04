# Instalacao Ubuntu

Instalação Ubuntu 24.04
 - Versão da ISO: **ubuntu-24.04-live-server-amd64.iso**

### Configurações pós instalação
Atualização do Systema NONINTERACTIVE
```shell
echo "alias update='apt clean && apt update -y && DEBIAN_FRONTEND=noninteractive apt full-upgrade -y -o Dpkg::Options::="--force-confdef" && DEBIAN_FRONTEND=noninteractive apt autoremove -y'" >> /root/.bashrc && unset HISTFILE && apt clean && apt update -y && DEBIAN_FRONTEND=noninteractive apt full-upgrade -y -o Dpkg::Options::="--force-confdef" && DEBIAN_FRONTEND=noninteractive apt autoremove -y
```
Atualização do Systema
```shell
echo "alias update='apt clean && apt update -y && apt full-upgrade -y && apt autoremove -y'" >> /root/.bashrc && unset HISTFILE && apt clean && apt update -y && apt full-upgrade -y && apt autoremove -y
```
Pacotes Necessários
```shell
apt install -y iputils-ping mtr nano cron vim chrony iptables
```
Desabilitar o Swap
```shell
swapoff -a;sed -i '/\/swap.img/s/^/#/' /etc/fstab
```
Desativar Serviços
```shell
systemctl stop apparmor && systemctl disable apparmor && systemctl stop systemd-resolved.service && systemctl disable systemd-resolved.service
```
Configurando o Resolv.conf
```shell
rm -frv /etc/resolv.conf && echo "nameserver 1.1.1.2" >> /etc/resolv.conf && echo "nameserver 8.8.8.8" >> /etc/resolv.conf && echo "search ks.local" >> /etc/resolv.conf
```
### Configurado o NETPLAN Network
Ubuntu **50-cloud-init.yaml**
<!-- ```shell
rm -f /etc/netplan/50-cloud-init.yaml && bash -c 'echo "network:\n  version: 2\n  ethernets:\n    ens3:\n      dhcp4: false\n      addresses: [192.168.246.23/24]\n      routes:\n        - to: default\n          via: 192.168.246.1\n          metric: 100\n      nameservers:\n        addresses: [192.168.1.10,8.8.8.8]\n        search: [ks.local]\n      dhcp6: false" > /etc/netplan/50-cloud-init.yaml' && chmod 600 /etc/netplan/50-cloud-init.yaml && netplan apply
``` -->
```shell
rm -f /etc/netplan/50-cloud-init.yaml && nano /etc/netplan/50-cloud-init.yaml && chmod 600 /etc/netplan/50-cloud-init.yaml && netplan apply
```
Exemplo **50-cloud-init.yaml**
```yaml
network:
  version: 2
  ethernets:
    # interface name
    ens3:
      dhcp4: false
      # IP address/subnet mask
      addresses: [192.168.246.21/24]
      # default gatewayrebo
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.246.1
          metric: 100
      nameservers:
        # name server to bind
        addresses: [192.168.1.10,8.8.8.8]
        # DNS search base
        search: [ks.local]
      dhcp6: false
```
Ubuntu **00-installer-config.yaml**
```shell
rm -f /etc/netplan/00-installer-config.yaml && nano /etc/netplan/01-netcfg.yaml && chmod 600 /etc/netplan/01-netcfg.yaml && netplan apply
```
Exemplo **00-installer-config.yaml**
```yaml
network:
  version: 2
  ethernets:
    # interface name
    enp5s0:
      dhcp4: false
      # IP address/subnet mask
      addresses: [192.168.1.51/24]
      # default gatewayrebo
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 192.168.1.1
          metric: 100
      nameservers:
        # name server to bind
        addresses: [1.0.0.2,1.1.1.2]
        # DNS search base
        search: [ks.local]
      dhcp6: false
```
### Caso precisar expandir o disco no LVM
```shell
lv_path=$(lvdisplay | grep 'LV Path' | awk '{print $3}');lvextend -l +100%FREE -r $lv_path
```
### Desabilitando o IPV6 na maquina
```shell
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf;sysctl -p;(crontab -l; echo "@reboot /sbin/sysctl -p") | crontab -
```
### Desabilitando o IPV6 na maquina se houver iptables
```shell
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf;echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf;sysctl -p;(crontab -l; echo "@reboot /sbin/sysctl -p") | crontab -
```

### Configurando Datetime
Observar qual a região do horário timezone, neste exemplo: **America/Cuiaba**
```shell
timedatectl set-timezone America/Cuiaba && sed -i 's/^#NTP=/NTP=a.st1.ntp.br/' /etc/systemd/timesyncd.conf && systemctl restart systemd-timesyncd && timedatectl timesync-status
```
Observar qual a região do horário timezone, neste exemplo: **America/Sao_Paulo**
```shell
timedatectl set-timezone America/Sao_Paulo && sed -i 's/^#NTP=/NTP=a.st1.ntp.br/' /etc/systemd/timesyncd.conf && systemctl restart systemd-timesyncd && timedatectl timesync-status
```
### Configurando Chrony NTP
Removendo comentários e linhas em branco do arquivo de configuração do chrony.
```shell
sed -i \
  -e '/^[ \t]*#/d' \
  -e 's/[ \t]*#.*$//' \
  -e 's/[ \t]*$//' \
  -e '/^$/d' \
  /etc/chrony/chrony.conf
```
Adicionando servidores NTP do Brasil no arquivo de configuração do chrony.
```shell
sed -i \
    -e '/^pool .*ubuntu/d' \
    -e '$a \
pool a.st1.ntp.br iburst maxsources 2\
pool b.st1.ntp.br iburst maxsources 1\
pool c.st1.ntp.br iburst maxsources 1\
pool seuntp.empresa.com.br iburst maxsources 1' \
    /etc/chrony/chrony.conf
```
Reiniciando o serviço do chrony para aplicar as mudanças.
```shell
systemctl restart chrony && chronyc sources -v && chronyc tracking
```

### Mudar hostname
Alterar o hostname se necessário, substituir **XXXXXX** pelo novo hostname.
```shell
hostnamectl set-hostname XXXXXX && sed -i 's/^127.0.1.1 MUDARNOME/127.0.1.1 XXXXXX/' /etc/hosts
```
### Travar Interface
Geralmente devemos travar a interface em certos hypervisor, caso a interface mude ao reiniciar.
```shell
echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
```
### Para Guest QEMU Harvester
```shell
apt install -y qemu-guest-agent && systemctl start qemu-guest-agent && systemctl enable qemu-guest-agent
```