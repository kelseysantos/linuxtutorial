# Configure Timezone in Ubuntu 22.04
 - Verificar o Status do NTP Server
```sh
systemctl status systemd-timesyncd
```
 - Alterar o **timesyncd.conf**.
```sh
nano /etc/systemd/timesyncd.conf
```
```markdown
# Adiciona no final da Linha ou 
[Time]
NTP=ntp.pcmt.local
```

