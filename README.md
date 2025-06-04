# Linux Tutorial
Dicas e tutoriais de instalação ou comando linux para facilitar a vida.

#### Gravar ISO no DVD por terminal
 - Gravando um arquivo.iso no dvd
```shell
dd if=/home/edivaldo/Downloads/arquivo.iso of=/dev/cdrom bs=4M status=progress
```

## Configurando o disco com UUID
### Como encontrar o UUID para o dispositivo /dev/sdb2 no Linux?
 - Verificar o uuid do disco
```shell
blkid
ou
blkid /dev/sdb2
```
Saida do comando:
```shell
/dev/sda1: LABEL="storages" UUID="14f27f3d-952a-4f6b-acd5-ea4cd1e92173" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="35918667-01"
```
### Usando o UUID para montar o disco no /etc/fstab do Linux.
 - Exemplo de montagem no fstab
```shell
UUID={YOUR-UID}    {/path/to/mount/point}    {file-system-type}    defaults    0    1
```
 - Validação abaixo:
```shell
UUID=14f27f3d-952a-4f6b-acd5-ea4cd1e92173    /disk2p2    ext4    defaults    0    1
```
 - Salve e execute o comando para montar
```shell
mount -a
```
### Em casos raros de UUID Duplicados
Note que você poderá encontrar **UUID**, você deverá gerar um novo **UUID** e substituir para o novo **UUID** gerado.
 - Gerando o novo UUID
```shell
uuidgen
be8213ac-feba-43f0-8017-d598ebe1d9ba
```
 - Agora substituir o **UUID** gerado
```shell
tune2fs /dev/sdb2 -U be8213ac-feba-43f0-8017-d598ebe1d9ba
```
Pronto o seu novo **UUID** já está Customizado, agora é so montar com o novo **UUID** no `/etc/fstab`.
### Comandos importantes
```shell
lsblk
lsblk --fs
```
```shell
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
```c
root soft nofile 65536
root hard nofile 65536
* soft nofile 65536
* hard nofile 65536
```
#### Optimizando os parametros do Kernel
Para ambientes com carga alta e muitas instancias é recomendado adicionar no **/etc/sysctl.conf** as configurações abaixo e depois reinicar a maquina ou executar o comando `sysctl -p`
```shell
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
### SpeedTest para testar conexão
Instalação do SpeedTest no Terminal Linux Ubuntu
```shell
apt update -y;apt install -y curl;curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash;apt install -y speedtest
```
Instalação no Terminal Distro RedHat
```shell
rpm -qa | grep speedtest | xargs -I {} sudo yum -y remove {};curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash;yum install -y speedtest
```
![speedtest](https://i.postimg.cc/FKYY9kLY/image.png)

---

## FONTES

Fonte: [Fluentd](https://docs.fluentd.org/v/0.12/articles/before-install)

# Aboutme
I don't do miracles, but I work in the world of Linux clouds.

---

<div style="display: flex; justify-content: center;">
    <img src="https://github.com/marwin1991/profile-technology-icons/assets/76662862/2481dc48-be6b-4ebb-9e8c-3b957efe69fa" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 1px; margin-bottom: 0px;" />
    <!-- <img src="xxxxxxxxxxxxxxxxxxxxx" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 0px; margin-bottom: 0px;" /> -->
    <img src="https://techstack-generator.vercel.app/docker-icon.svg" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 1px; margin-bottom: 0px;" />
    <img src="https://techstack-generator.vercel.app/kubernetes-icon.svg" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 1px; margin-bottom: 0px;" />
    <img src="https://techstack-generator.vercel.app/python-icon.svg" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 1px; margin-bottom: 0px;" />
    <img src="https://techstack-generator.vercel.app/github-icon.svg" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 1px; margin-bottom: 0px;" />
    <img src="https://techstack-generator.vercel.app/nginx-icon.svg" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 1px; margin-bottom: 0px;" />
    <!-- <img src="xxxxxxxxxxxxxxxxxxxxx" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 0px; margin-bottom: 0px;" /> -->
    <img src="https://upload.wikimedia.org/wikipedia/commons/c/c0/Devops-toolchain-es.svg" alt="icon" width="100" style="width: 100px; height: 100px; margin-right: 0px; margin-bottom: 0px;" />
</div>

<!-- # Ferramentas de Trabalho

<div align="center">
	<table>
		<tr>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/192108372-f71d70ac-7ae6-4c0d-8395-51d8870c2ef0.png" alt="Git" title="Git"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/192108374-8da61ba1-99ec-41d7-80b8-fb2f7c0a4948.png" alt="GitHub" title="GitHub"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/192108376-c675d39b-90f6-4073-bde6-5a9291644657.png" alt="GitLab" title="GitLab"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/192108891-d86b6220-e232-423a-bf5f-90903e6887c3.png" alt="Visual Studio Code" title="Visual Studio Code"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/121401671-49102800-c959-11eb-9f6f-74d49a5e1774.png" alt="npm" title="npm"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/183423507-c056a6f9-1ba8-4312-a350-19bcbc5a8697.png" alt="Python" title="Python"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/117208740-bfb78400-adf5-11eb-97bb-09072b6bedfc.png" alt="PostgreSQL" title="PostgreSQL"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/192158606-7c2ef6bd-6e04-47cf-b5bc-da2797cb5bda.png" alt="bash" title="bash"/></code></td>
		</tr>
		<tr>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/117207330-263ba280-adf4-11eb-9b97-0ac5b40bc3be.png" alt="Docker" title="Docker"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/182534006-037f08b5-8e7b-4e5f-96b6-5d2a5558fa85.png" alt="Kubernetes" title="Kubernetes"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/183868728-b2e11072-00a5-47e2-8a4e-4ebbb2b8c554.png" alt="CI/CD" title="CI/CD"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/182534075-4962068b-4407-46c2-ac67-ddcb86af30cc.png" alt="Grafana" title="Grafana"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/190230082-55409fe9-d5a2-4f3d-bdba-0f0946190e67.png" alt="Loki" title="Loki"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/182534182-c510199a-7a4d-4084-96e3-e3db2251bbce.png" alt="Prometheus" title="Prometheus"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/183345124-0948a5e0-5326-495f-824f-b99d3aee5467.png" alt="Vault" title="Vault"/></code></td>
			<td><code><img width="50" src="https://user-images.githubusercontent.com/25181517/183345125-9a7cd2e6-6ad6-436f-8490-44c903bef84c.png" alt="Nginx" title="Nginx"/></code></td>
		</tr>
		<tr>
			<td><code><img width="50" src="https://github.com/marwin1991/profile-technology-icons/assets/76662862/2481dc48-be6b-4ebb-9e8c-3b957efe69fa" alt="Linux" title="Linux"/></code></td>
		</tr>
	</table>
</div> -->

![Typing SVG](https://readme-typing-svg.demolab.com?font=Roboto&pause=1000&color=2902FF&width=435&lines=Kelsey+Santos;Let+me+be+a+better+for+me;Let+me+be+a+better+for+you)

# Estatisticas
![GitHub Streak](https://streak-stats.demolab.com?user=kelseysantos&locale=pt_BR&date_format=j%20M%5B%20Y%5D&exclude_days=Sun%2CSat)

## Links Interessantes

[Tecnologia de Icones](https://marwin1991.github.io/profile-technology-icons/)

[Frase Texto](https://readme-typing-svg.demolab.com/)