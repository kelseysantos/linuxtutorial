#!/bin/bash

# Verifica se o argumento foi fornecido
if [ $# -ne 1 ]; then
    echo "Uso: $0 arquivo_de_entrada.html"
    exit 1
fi

# Armazena o nome do arquivo HTML de entrada
arquivo_entrada="$1"

# Verifica se o arquivo de entrada existe
if [ ! -f "$arquivo_entrada" ]; then
    echo "O arquivo '$arquivo_entrada' não existe."
    exit 1
fi

# Extrai os domínios do arquivo HTML e os salva em um arquivo de texto
grep -oE 'https?://[^/"]+' "$arquivo_entrada" | sed -E 's|^https?://||' | awk -F '/' '{print $1}' > dominios.txt

echo "Domínios extraídos e salvos em dominios.txt"