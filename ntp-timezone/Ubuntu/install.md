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
~~~shell
systemctl restart ntp
#verificar status
systemctl status ntp
#Mostrar Serviço NTP
ntpq -p
~~~

# Configure NTPClient para sincronização no Ubuntu 22.04
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
# Adiciona no final da Linha ou altera onde está NTP=
[Time]
NTP=a.st1.ntp.br
```
 - Restart o Serviço Timesyncd
```sh
systemctl restart systemd-timesyncd
#verificar agora o Status
timedatectl timesync-status
```
## Agora o Timezone
 - Configure o Timezone do servidor ou Desktop Ubuntu, siga os comandos abaixo:
```sh
nano /etc/timezone
#Verificar a lista de Timezones
timedatectl list-timezones
```
```markdown
#Apagar o padrão **Etc/UTC** e coloca para região de MatoGrosso.
America/Cuiaba
```
```
timedatectl set-timezone America/Cuiaba
```
 - Verificando a mudança se está correta.
```
root@kelseysantos:~# timedatectl 
               Local time: Fri 2023-02-03 16:18:46 -04
           Universal time: Fri 2023-02-03 20:18:46 UTC
                 RTC time: Fri 2023-02-03 20:18:56
                Time zone: America/Cuiaba (-04, -0400)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```