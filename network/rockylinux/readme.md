 	
# NETWORK ROCKYLINUX
If you did not configure network settings during the Rocky Linux Installation, Configure it like follows.

[1]	To set static IP address to the server, Modify settings like follows.

( Replace the interface name [enp1s0] to your own one because it's not the same on any System )

### if you did not set HostName, set it like follows
```shell
[root@localhost ~]# hostnamectl set-hostname dlp.servico.cuiaba
```
### Display devices
```shell
[root@localhost ~]# nmcli device
DEVICE  TYPE      STATE      CONNECTION
enp1s0  ethernet  connected  enp1s0
lo      loopback  unmanaged  --
# set IPv4 address
[root@localhost ~]# nmcli connection modify enp1s0 ipv4.addresses 10.0.0.30/24
# set gateway
[root@localhost ~]# nmcli connection modify enp1s0 ipv4.gateway 10.0.0.1
# set DNS
# for multiple DNS, specify with space separated ⇒ ipv4.dns "10.0.0.10 10.0.0.11 10.0.0.12"
[root@localhost ~]# nmcli connection modify enp1s0 ipv4.dns 10.0.0.10
# set DNS search base (your domain name)
[root@localhost ~]# nmcli connection modify enp1s0 ipv4.dns-search servico.cuiaba
# set [manual] for static setting
# it's [auto] for DHCP setting
[root@localhost ~]# nmcli connection modify enp1s0 ipv4.method manual
# restart the interface to reload settings
[root@localhost ~]# nmcli connection down enp1s0; nmcli connection up enp1s0
Connection 'enp1s0' successfully deactivated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/1)
Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/2)
```

### Confirm settings
```shell
[root@localhost ~]# nmcli device show enp1s0
GENERAL.DEVICE:                         enp1s0
GENERAL.TYPE:                           ethernet
GENERAL.HWADDR:                         52:54:00:54:9E:CF
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected)
GENERAL.CONNECTION:                     enp1s0
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveC>
WIRED-PROPERTIES.CARRIER:               on
IP4.ADDRESS[1]:                         10.0.0.30/24
IP4.GATEWAY:                            10.0.0.1
IP4.ROUTE[1]:                           dst = 10.0.0.0/24, nh = 0.0.0.0, mt = 1>
IP4.ROUTE[2]:                           dst = 0.0.0.0/0, nh = 10.0.0.1, mt = 100
IP4.DNS[1]:                             10.0.0.10
IP6.ADDRESS[1]:                         fe80::5054:ff:fe54:9ecf/64
IP6.GATEWAY:                            --
IP6.ROUTE[1]:                           dst = fe80::/64, nh = ::, mt = 100
IP6.ROUTE[2]:                           dst = ff00::/8, nh = ::, mt = 256, tabl>
```
[2]	If you don't need IPv6, it's possible to disable it like follows.
```shell
[root@localhost ~]# vi /etc/default/grub
```
 - line 7 : add
```
GRUB_CMDLINE_LINUX="ipv6.disable=1 rashkernel=auto .....
```
```shell
[root@localhost ~]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
done
[root@localhost ~]# reboot
[root@localhost ~]# ip address show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:54:9e:cf brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.30/24 brd 10.0.0.255 scope global noprefixroute enp1s0
       valid_lft forever preferred_lft forever
```