# Configuração de logs Rotation

Vamos configurar a rotação de logs para gerenciar o tamanho dos arquivos de log e evitar que eles ocupem muito espaço em disco.
 - Sistema Oepracional: Linux Ubuntu 24.04 LTS
 - Ferramenta: logrotate

Exemplo a ser usado é no apache2, mas pode ser adaptado para outros serviços.

## Passos para Configuração
1. **Instalar o logrotate** (se ainda não estiver instalado):
```bash
apt-get install -y logrotate
```
Verifique se o serviço está instalado corretamente:
```bash
logrotate --version && systemctl status logrotate.timer
``` 
2. **Criar um arquivo de configuração para o serviço desejado**:
Crie/atualize um arquivo de configuração em `/etc/logrotate.d/` para o serviço que você deseja gerenciar. Por exemplo, para o Apache2:
```bash
nano /etc/logrotate.d/apache2
```
3. **Adicionar a configuração de rotação**:
Adicione o seguinte conteúdo ao arquivo:
```
/var/log/apache2/*.log {
    daily
    size 200M
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 640 root adm
    dateext
    sharedscripts
    prerotate
        if [ -d /etc/logrotate.d/httpd-prerotate ]; then
            run-parts /etc/logrotate.d/httpd-prerotate
        fi
    endscript
    postrotate
        if pgrep -f ^/usr/sbin/apache2 > /dev/null; then
            invoke-rc.d apache2 reload 2>&1 | logger -t apache2.logrotate
        fi
    endscript
}
```
Simulação:
```bash
logrotate -d /etc/logrotate.d/apache2
```
Forçar a rotação de logs para testar a configuração:
```bash
logrotate -f /etc/logrotate.d/apache2
```
| Você viu                        | Por quê                        |
| ------------------------------- | ------------------------------ |
| `access.log-20251126` sem `.gz` | por causa de **delaycompress** |
| Rotação aconteceu               | ✔ tudo funcionando             |
| Compressed só amanhã            | comportamento correto          |

## Verifique se o Apache realmente usa esses arquivos
Execute: 
```bash
grep -R "CustomLog" /etc/apache2 -n
```
```bash
grep -R "ErrorLog" /etc/apache2 -n
```
Saida Esperada:

![https://i.postimg.cc/HxMHrrLr/image.png](https://i.postimg.cc/HxMHrrLr/image.png)


## Caso queira compactar logs antigos

Para compactar arquivos logs grandes que já existem, você pode usar o comando `gzip` diretamente:
```bash
nice -n 19 ionice -c3 gzip error.log.1
```