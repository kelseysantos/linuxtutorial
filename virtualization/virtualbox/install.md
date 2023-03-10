# Instalando VirtualBox Ubuntu 22.04
 - Como instalar o Virutalbox no Ubuntu 22.04
```sh
apt -y install virtualbox virtualbox-ext-pack
VBoxManage -v
VBoxManage list extpacks
```
### Criando VM na pasta /storages/vms/vbox
```sh
mkdir /storages/vms/vbox
VBoxManage createvm \
--name Ubuntu2204 \
--ostype Ubuntu_64 \
--register \
--basefolder /storages/vms/vbox
```
### Modificar as Configurações da VM
### replace interface name [eno1] to your own environment
```sh
VBoxManage modifyvm Ubuntu2204 \
--cpus 4 \
--memory 4096 \
--nic1 bridged \
--bridgeadapter1 eno1 \
--boot1 dvd \
--vrde on \
--vrdeport 5001
```
### Configurando o armazenamento
```sh
VBoxManage storagectl Ubuntu2204 --name "Ubuntu2204_SATA" --add sata
VBoxManage createhd \
--filename /storages/vms/vbox/Ubuntu2204/Ubuntu2204.vdi \
--size 20480 \
--format VDI \
--variant Standard
```
```sh
VBoxManage storageattach Ubuntu2204 \
--storagectl Ubuntu2204_SATA \
--port 1 \
--type hdd \
--medium /storages/vms/vbox/Ubuntu2204/Ubuntu2204.vdi
```
### Configurar o Driver de DVD para VM
 - Como exemplo abaixo, você pode especificar o arquivo da ISO para instalação do sistema.
```sh
VBoxManage storageattach Ubuntu2204 \
--storagectl Ubuntu2204_SATA \
--port 0 \
--type dvddrive \
--medium /home/ubuntu-22.04-live-server-amd64.iso
```
### Verificando a configuração da VM Criada
```sh
VBoxManage showvminfo Ubuntu2204
```
 - Para remover o DVD, só rodar o comando abaixo:
```sh
VBoxManage storageattach Ubuntu2204 --storagectl Ubuntu2204_SATA --port 0 --device 0 --medium none
```
### Start a VM
```sh
VBoxManage startvm Ubuntu2204 --type headless
```
### Instalando o GuestAddition para o Virtualbox do Host
 - Execute o Apt
```
apt -y install virtualbox-guest-additions-iso
```
 - Agora instalar o VBoxGuestAdditions para a VM
```
VBoxManage storageattach Ubuntu2204 \
--storagectl Ubuntu2204_SATA \
--port 0 \
--type dvddrive \
--medium /usr/share/virtualbox/VBoxGuestAdditions.iso
```
### Instalando os pacotes necessários para o funcioanamento
 - Inicie a VM e efetue o login nela para instalar o **GuestAdditions**. Dentro da VM execute esses comando abaixo:
```
LINUX_HEADERS=$(uname -r)
apt -y install gcc make bzip2 linux-headers-$LINUX_HEADERS
mount /dev/cdrom /mnt
cd /mnt
/mnt# ./VBoxLinuxAdditions.run
```
 - Agora é so reinicar a VM que já vai estar instalado com sucesso. Para reinicar é só digigar o comando `reboot`.