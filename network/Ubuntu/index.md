# Configurações de Rede Ubuntu

```sh=
network:
  ethernets:
    # interface name
    enp1s0:
      dhcp4: false
      addresses: [10.0.0.30/24]
      # default gateway
      # [metric] : set priority (specify it if multiple NICs are set)
      # lower value is higher priority
      routes:
        - to: default
          via: 10.0.0.1
          metric: 100
      nameservers:
        addresses: [10.0.0.10,10.0.0.11]
        search: [servicos.cuiaba,server.education]
      dhcp6: false
  version: 2
```