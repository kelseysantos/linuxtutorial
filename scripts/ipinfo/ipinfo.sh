#!/bin/bash

# Caminho para o arquivo contendo os endereços IP
arquivo_ips="ipinfo.txt"

# Verifica se os arquivos existe
if [ ! -f hostsdown.txt ]; then
    # echo "O arquivo hostsdown.txt não existe."
    touch hostsdown.txt
else
    echo "IP ADDRESS DOWN NOT VISIBLE" > hostsdown.txt
fi
if [ ! -f hostsup.txt ]; then
    # echo "O arquivo hostsup.txt não existe."
    touch hostsup.txt
else
    echo "IP ADDRESS UP VISIBLE" > hostsup.txt
fi

# Verifica os hosts ativos
while IFS= read -r ip || [[ -n "$ip" ]]; do
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        echo "Host $ip está UP"
        curl "ipinfo.io/$ip?token=0ce98c85a73a24" >> hostsup.txt
        echo " " >> hostsup.txt
        echo "#######################################################################################" >> hostsup.txt
    else
        echo "Host $ip está Down"
        curl "ipinfo.io/$ip?token=0ce98c85a73a24" >> hostsdown.txt
        echo " " >> hostsdown.txt
        echo "#######################################################################################" >> hostsdown.txt
    fi
done < "$arquivo_ips"