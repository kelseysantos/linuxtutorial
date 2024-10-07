#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Uso: $0 <endereco_IP>"
  exit 1
fi

endereco_IP=$1

# Obtém o endereço MAC usando o comando arp
mac_address=$(arp -n | awk -v ip="$endereco_IP" '$1 == ip {print $3}')

# Exibe o resultado
if [ -z "$mac_address" ]; then
  echo "Não foi possível obter o endereço MAC para o IP $endereco_IP."
else
  echo "Endereço MAC para o IP $endereco_IP: $mac_address"
fi
