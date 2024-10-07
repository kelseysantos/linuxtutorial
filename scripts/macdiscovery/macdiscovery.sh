#!/bin/bash

# Defina a interface de rede que você deseja escanear
INTERFACE="eno1"
NETWORKING="172.19.58.0/24"

arp-scan --interface=$INTERFACE $NETWORKING | grep -E '([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}' | awk '{print $2}' > mac.txt