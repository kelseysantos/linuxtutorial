#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Uso: $0 <endereco_IP>"
  exit 1
fi

endereco_IP=$1

# Utiliza o nmap para escanear todas as portas do host
portas_abertas=$(nmap -p- --open --min-rate=1000 -T4 $endereco_IP | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')

# Exibe as portas abertas
echo "Portas Abertas no Host $endereco_IP:"
echo "$portas_abertas"