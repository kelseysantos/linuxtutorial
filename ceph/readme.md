# CEPH instalação no Proxmox

Instalação do CEPH

Clique no host que irá instalar o CEPH e faça a instalação;




### Verificar os discos no OSD
Listando as configurações do OSD:
```shell
ceph osd df tree
```
Visualização:
```shell
root@vinagre3:~# ceph osd df tree
ID  CLASS  WEIGHT    REWEIGHT  SIZE     RAW USE  DATA     OMAP    META     AVAIL    %USE  VAR   PGS  STATUS  TYPE NAME        
-1         72.47095         -   72 TiB  268 MiB  5.0 MiB  10 KiB  263 MiB   72 TiB     0  1.00    -          root default     
-3         72.47095         -   72 TiB  268 MiB  5.0 MiB  10 KiB  263 MiB   72 TiB     0  1.00    -              host vinagre3
 0    hdd  10.91409   1.00000   11 TiB   27 MiB  508 KiB   1 KiB   26 MiB   11 TiB     0  0.66    0      up          osd.0    
 1    hdd  10.91409   1.00000   11 TiB   27 MiB  508 KiB   1 KiB   26 MiB   11 TiB     0  0.66    1      up          osd.1    
 2    hdd  10.91409   1.00000   11 TiB   27 MiB  508 KiB   1 KiB   26 MiB   11 TiB     0  0.66    0      up          osd.2    
 3    hdd  10.91409   1.00000   11 TiB   27 MiB  508 KiB   1 KiB   26 MiB   11 TiB     0  0.66    0      up          osd.3    
 4    hdd  10.91409   1.00000   11 TiB   27 MiB  508 KiB   1 KiB   26 MiB   11 TiB     0  0.66    0      up          osd.4    
 5    hdd  10.91409   1.00000   11 TiB   27 MiB  508 KiB   1 KiB   26 MiB   11 TiB     0  0.66    0      up          osd.5    
 6    ssd   1.74660   1.00000  1.7 TiB   27 MiB  508 KiB   1 KiB   26 MiB  1.7 TiB  0.00  4.17    0      up          osd.6    
 7    ssd   1.74660   1.00000  1.7 TiB   27 MiB  508 KiB   1 KiB   26 MiB  1.7 TiB  0.00  4.17    0      up          osd.7    
 8    ssd   1.74660   1.00000  1.7 TiB   27 MiB  508 KiB   1 KiB   26 MiB  1.7 TiB  0.00  4.17    0      up          osd.8    
 9    ssd   1.74660   1.00000  1.7 TiB   27 MiB  508 KiB   1 KiB   26 MiB  1.7 TiB  0.00  4.17    0      up          osd.9    
                        TOTAL   72 TiB  268 MiB  5.0 MiB  16 KiB  263 MiB   72 TiB     0
```
Adicionando Rules HDD:
 - Para HDD
```shell
ceph osd crush rule create-replicated hdd_rule default host hdd
```
 - Para SSD
```shell
ceph osd crush rule create-replicated ssd_rule default host ssd
```

