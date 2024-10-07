#!/bin/bash
rede="10.1.1.0/24"  # Substitua pela sua faixa de rede

ips_ativos=$(nmap -sn $rede | awk '/Nmap scan report/{print $5}')

# Exibe os IPs ativos
echo "IPs Ativos na Rede $rede:"
echo "$ips_ativos"