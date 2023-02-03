# Instalar o NTP Server no CentOS
 - Instalando e configurando o serviço Chrony.
```markdown
dnf -y install chrony
vi /etc/chrony.conf
# Linha 3 : Alterar o servidor para syncronização
# need NTP server itself to sync time with other NTP server
#pool 2.centos.pool.ntp.org iburst
pool a.st1.ntp.br iburst
pool b.st1.ntp.br iburst
# linha 27 : Adicionar a Rede que vai aceitar as requisições NTP Clientes
# specify your local network and so on
# if not specified, only localhost is allowed
allow 10.0.0.0/24
```
 - Habilitando o serviço Chronyd.
```
systemctl enable --now chronyd
```
 - Caso esteja usando firewall colocar as seguintes regras.
```
firewall-cmd --add-service=ntp

firewall-cmd --runtime-to-permanent
```
 - Verificando se o serviço está rodando normalmente.
```
chronyc sources
```