#!/bin/bash

# Caminho para o arquivo contendo os endereços IP
arquivo_ips="enderecos_ips.txt"

# Verifica se os arquivos existe
if [ ! -f hostsdown.txt ]; then
    echo "O arquivo hostsdown.txt não existe."
    touch hostsdown.txt
else
    echo "Enderecos IPs Downs" > hostsdown.txt
fi
if [ ! -f hostsup.txt ]; then
    echo "O arquivo hostsup.txt não existe."
    touch hostsup.txt
else
    echo "Enderecos IPs UP" > hostsup.txt
fi

# Verifica os hosts ativos
while IFS= read -r ip || [[ -n "$ip" ]]; do
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        echo "Host $ip está UP"
        echo "$ip" >> hostsup.txt
        # echo "https://$ip:98/shell" >> hostsup.txt
        # Abre o navegador para acessar o URL na porta 98
        # xdg-open "https://$ip:98/shell" &> /dev/null
        # firefox "https://$ip:98" &> /dev/null
    else
        echo "Host $ip está Down"
        echo $ip >> hostsdown.txt
    fi
done < "$arquivo_ips"