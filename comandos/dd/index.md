# Como usar o comando DD

1. Insira o cartão SD ou HD para fazer a imagem.
2. Siga os comando abaixo:
## Criando a imagem do disco
```shell
# Listar os discos
fdisk -l
# Apos listar e verificar o disco e realizar o DD para um arquivo de imagem.
dd if=/dev/sdb of=~/hdkelseysantos.img status=progress
# Realizando um DD para um arquivo de imagem compactado.
dd if=/dev/sdb status=progress | gzip -c >~/hdkelseysantos.img.gz
```
## Restaurando a imagem do Disco
```shell
# Listar os Dicos
fdisk -l
# restore img
dd if=~/hdkelseysantos.img of=/dev/sdb bs=4M status=progress
# restore gzipped img
gunzip -c ~/hdkelseysantos.img.gz | dd of=/dev/sdb bs=4M status=progress
```