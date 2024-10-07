# Configurações de Rede Ubuntu

 - Versão 01
```yaml
network:
  ethernets:
    # interface name
    enp0s3:
      dhcp4: false
      addresses: [10.100.214.100/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.100.214.100
          metric: 100
      nameservers:
        addresses: [192.168.3.7,10.100.254.9]
        search: [labgeia.local,pcmt.local]
      dhcp6: false
  version: 2
```
 - Versão 02
```yaml
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      addresses:
      - 10.100.214.100/24
      nameservers:
        addresses:
        - 10.100.254.9
        - 10.8.4.10
        search:
        - pcmt.local
      routes:
      - to: default
        via: 10.100.214.1
        metric: 100
      dhcp6: false
  version: 2
```
# Procedimento para deixar o DNS manual no NetworkManager
### Com o usuário root, crie o arquivo em: `/etc/NetworkManager/conf.d/90-dns-none.conf` dentro desse arquivo coloque:
```csharp
[main]
dns=default
```
### Reload no NetworkManager:
```shell
systemctl reload NetworkManager
```
### Remova o Link `/etc/resolv.conf` e crie o arquivo.
```shell
rm -fr /etc/resolv.conf && touch /etc/resolv.conf
```
### Edite o `/etc/resolv.conf` manualmente e coloque o seu servidor de DNS.
 - Exemplo: 
 ```csharp
nameserver 10.100.254.9
nameserver 1.1.1.1
nameserver 127.0.0.53
options edns0 trust-ad
search .
 ```
### Reload no NetworkManager:
```shell
systemctl restart NetworkManager
```
### No final temos que congelar
```shell
chattr +i /etc/resolv.conf
```

# Procedimento para não atualizar o resolv.conf

Executar os seguintes comandos e reinicar o host
```shell
systemctl stop apparmor; systemctl disable apparmor;systemctl stop systemd-resolved.service; systemctl disable systemd-resolved.service

rm /etc/resolv.conf;nano /etc/resolv.conf

# inserir os nameserver desejado
nameserver 1.1.1.1
nameserver 8.8.8.8
search home.local
```