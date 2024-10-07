# Instacao RockyLinux

Instalação Rocky Linux 9.4
 - Versão ISO: **Rocky-9.4-x86_64-minimal.iso**

Atualizar sistema
```shell
dnf -y upgrade
```
Desabilitando o **Firewall** e **SELinux**.
```shell
systemctl stop firewalld;systemctl disable firewalld;sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config;grep '^SELINUX=' /etc/selinux/config
```
Install repositorio necessários **Epel-Release**.
```shell
dnf -y install epel-release;dnf -y install elrepo-release
```
Desabilitando o IPV6.
 - Se na instalação você já desabilitou o IPV6 não precisa realizar esse procedimento, caso contrário fazer.
```shell
#Editar o arquivo grub
nano /etc/default/grub

#Na Linha que contem GRUB_CMDLINE_LINUX inserir o disable ipv6:
GRUB_CMDLINE_LINUX="ipv6.disable=1 crashkernel= ...."

#Aplicar as configurações
grub2-mkconfig -o /boot/grub2/grub.cfg

#Reiniciar a maquina
reboot
```
Aumentando o disco LVM
```shell
#Verificar os LVM Path
lvdisplay | grep 'LV Path' | awk '{print $3}'

/dev/rl_rockylinux/root
/dev/rl_rockylinux/swap

#Exemplo de expansão.
lvextend -l +100%FREE -r /dev/rl_rockylinux/root
```
Virtualizador VMWare install Tools - [LINKS](https://docs.rockylinux.org/pt-BR/guides/virtualization/vmware_tools/), verificar se inicializou.
 -  Instalacao do VMWareTools, componentes necessários.
```shell
 dnf install -y kernel-devel kernel-headers xorg-x11-drv-vmware perl tar
```
 - Caso não existir a pasta init.d, crie manualmente.
```shell
mkdir -p /etc/init.d;for i in {0,1,2,3,4,5,6}; do mkdir -p "/etc/init.d/rc$i.d"; done
```
 - Após a instalação conforme o tutorial executar o comando para iniciar no boot.
```shell
(crontab -l; echo "@reboot /etc/init.d/vmware-tools start") | sudo crontab -
```
Mudando endereço de IP no NMCLI.
```shell
nmcli connection modify ens33 ipv4.addresses 192.168.245.7/24;nmcli connection modify ens33 ipv4.gateway 192.168.245.1;nmcli connection down ens33;nmcli connection up ens33
```