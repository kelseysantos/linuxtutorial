# Instalando um servidor NTP para Server Ubuntu 22.04
 - Instalar e configurar o NTPd
```
apt -y install ntp
```
 - Editar o arquivo para configurar o NTP Server
```
nano /etc/ntp.conf
```
 - Na linha 21 comentar todos que estão padrão deixando somente o abaixo.
```markdown
# Usando o NTP.br
pool a.st1.ntp.br iburst 
pool b.st1.ntp.br iburst 
```
 - Na Linha 51 Adicionar o range que irá aceitar os clientes.
```markdown
restrict 10.0.0.0 mask 255.255.255.0 nomodify notrap
```
 - Restart o Serviço e verifica se está funcionando.
```sh
systemctl restart ntp
#verificar status
systemctl status ntp
#Mostrar Serviço NTP
ntpq -p
```

# Configure Timezone in Ubuntu 22.04
 - Verificar o Status do NTP Server
```
systemctl status systemd-timesyncd
```
 - Alterar o **timesyncd.conf**.
```
nano /etc/systemd/timesyncd.conf
```
 - Adiciona na linha NTP o seu servidor NTP da internet ou internamente.
```markdown
# Adiciona no final da Linha ou 
[Time]
NTP=a.st1.ntp.br
```
 - Restart o Serviço Timesyncd
```
systemctl restart systemd-timesyncd && timedatectl timesync-status
```
