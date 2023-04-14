#!/bin/bash

# Pedindo o nome do arquivo
echo "Digite o nome do arquivo:"
read arquivo

# Pedindo a variável a ser adicionada na linha
echo "Digite a variável a ser adicionada na linha:"
read variavel

# Lendo cada linha do arquivo e substituindo o conteúdo com a adição da variável
while read -r linha
do
    # Concatenando a variável na linha
    nova_linha="$linha $variavel"

    # Substituindo o conteúdo da linha com a nova linha concatenada
    sed -i "s~$linha~$nova_linha~g" $arquivo
done < $arquivo

echo "Substituição concluída com sucesso!"
