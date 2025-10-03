#!/bin/bash

# URL para a versão estável mais recente do VS Code para Debian/Ubuntu (64-bit)
VSCODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

# Nome do arquivo de destino
DEB_FILE="/tmp/vscode-latest.deb"

echo "Baixando a versão mais recente do Visual Studio Code..."

# Baixa o arquivo .deb usando wget
# O argumento -O salva o arquivo com um nome específico no diretório /tmp
wget -O "$DEB_FILE" "$VSCODE_URL"

# Verifica se o download foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Download concluído com sucesso."
    echo "Instalando a atualização... (será necessária sua senha)"

    # Instala o pacote .deb usando dpkg
    # A senha de administrador (sudo) será solicitada aqui
    sudo dpkg -i "$DEB_FILE"

    # Corrige possíveis dependências quebradas
    sudo apt-get install -f

    echo "Limpeza dos arquivos de instalação..."
    # Remove o arquivo .deb baixado para economizar espaço
    rm "$DEB_FILE"

    echo "Visual Studio Code atualizado com sucesso!"
else
    echo "Falha ao baixar o Visual Studio Code. Verifique sua conexão com a internet ou a URL."
    exit 1
fi

exit 0
