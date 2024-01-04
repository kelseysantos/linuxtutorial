# linuxtutorial
Dicas e tutoriais de instalação ou comando linux para facilitar a vida.

#### Gravar ISO no DVD por terminal
 - Gravando um arquivo.iso no dvd
```
dd if=/home/edivaldo/Downloads/arquivo.iso of=/dev/cdrom bs=4M status=progress
```

## Configurando o disco com UUID
### Como encontrar o UUID para o dispositivo /dev/sdb2 no Linux?
 - Verificar o uuid do disco
```
blkid
ou
blkid /dev/sdb2
```
Saida do comando:
```
/dev/sda1: LABEL="storages" UUID="14f27f3d-952a-4f6b-acd5-ea4cd1e92173" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="35918667-01"
```
### Usando o UUID para montar o disco no /etc/fstab do Linux.
 - Exemplo de montagem no fstab
```
UUID={YOUR-UID}    {/path/to/mount/point}    {file-system-type}    defaults    0    1
```
 - Validação abaixo:
```
UUID=14f27f3d-952a-4f6b-acd5-ea4cd1e92173    /disk2p2    ext4    defaults    0    1
```
 - Salve e execute o comando para montar
```
mount -a
```
### Em casos raros de UUID Duplicados
Note que você poderá encontrar **UUID**, você deverá gerar um novo **UUID** e substituir para o novo **UUID** gerado.
 - Gerando o novo UUID
```
uuidgen
be8213ac-feba-43f0-8017-d598ebe1d9ba
```
 - Agora substituir o **UUID** gerado
```
tune2fs /dev/sdb2 -U be8213ac-feba-43f0-8017-d598ebe1d9ba
```
Pronto o seu novo **UUID** já está Customizado, agora é so montar com o novo **UUID** no `/etc/fstab`.
### Comandos importantes
```
lsblk
lsblk --fs
```
```
findmnt | more
findmnt /backup
```
FONTE: [https://www.cyberciti.biz/faq/linux-finding-using-uuids-to-update-fstab/](https://www.cyberciti.biz/faq/linux-finding-using-uuids-to-update-fstab/)

### Fazer upgrade somente um pacote especifico no Ubuntu.
 -  Tem esses comando abaixo:
```shell
apt-get install --only-upgrade brackets
apt-get dist-upgrade brackets
apt-get upgrade brackets
```
Fonte: [SourceDigit](https://sourcedigit.com/27287-how-to-update-only-one-package-in-ubuntu-linux/)

### Numero Max de descritores de arquivos
Verificar
```shell
ulimit -n
```
Se sua resposta for 1024 então alterar o arquivo **/etc/security/limits.conf** e reiniciar a maquina:
```
root soft nofile 65536
root hard nofile 65536
* soft nofile 65536
* hard nofile 65536
```
#### Optimizando os parametros do Kernel
Para ambientes com carga alta e muitas instancias é recomendado adicionar no **/etc/sysctl.conf** as configurações abaixo e depois reinicar a maquina ou executar o comando `sysctl -p`
```
net.core.somaxconn = 1024
net.core.netdev_max_backlog = 5000
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_wmem = 4096 12582912 16777216
net.ipv4.tcp_rmem = 4096 12582912 16777216
net.ipv4.tcp_max_syn_backlog = 8096
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 10240 65535
```
Fonte: [Fluentd](https://docs.fluentd.org/v/0.12/articles/before-install)