# Interface Bond0

Interface bond0 com duas interfaces:

```yaml
auto lo
iface lo inet loopback

iface eno1np0 inet manual

auto bond0
iface bond0 inet manual
	bond-slaves eno1np0 eno2np1
	bond-miimon 100
	bond-mode 802.3ad
	mtu 9000

auto vmbr0
iface vmbr0 inet static
	address 192.168.246.15/24
	gateway 192.168.246.1
	bridge-ports bond0
	bridge-stp off
	bridge-fd 0

iface eno2np1 inet manual

iface eno3np2 inet manual

iface eno4np3 inet manual

source /etc/network/interfaces.d/*
```
