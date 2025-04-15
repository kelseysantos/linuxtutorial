#!/bin/bash
# Verifica se é root (nmap requer privilégios para alguns scans)
if [ "$(id -u)" != "0" ]; then
    echo "[!] Aviso: Execute como root para resultados mais precisos (uso de ICMP)."
    echo "     Você pode usar 'sudo' ou executar como usuário normal (scan menos abrangente)."
    sleep 2
fi

# Verifica o nmap
if ! command -v nmap &>/dev/null; then
    echo "[!] Nmap não encontrado. Instalando..."
    # Detecta a distribuição
    if grep -qi 'ubuntu\|debian' /etc/os-release; then
        sudo apt update && sudo apt install -y nmap
    elif grep -qi 'centos\|rhel\|fedora' /etc/os-release; then
        sudo yum install -y nmap || sudo dnf install -y nmap
    elif grep -qi 'arch\|manjaro' /etc/os-release; then
        sudo pacman -Sy --noconfirm nmap
    else
        echo "[ERRO] Distro não reconhecida. Instale o nmap manualmente."
        exit 1
    fi
fi

# Função para validar formato da rede
validar_rede() {
    local padrao='^([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]{1,2})?$'
    if [[ ! $1 =~ $padrao ]]; then
        echo "[ERRO] Formato de rede inválido. Use como: 192.168.1.0/24 ou 10.0.0.1/16"
        exit 1
    fi
}

# Define a rede (argumento ou input)
if [ -n "$1" ]; then
    rede="$1"
else
    read -p "Digite a rede para scan (ex: 192.168.1.0/24): " rede
fi

validar_rede "$rede"

# Scan principal (método cross-distro)
echo -e "\n[+] Iniciando scan na rede $rede ..."
echo "[*] Método: ICMP + ARP (sudo) ou SYN Scan (usuário normal)"
echo -e "[*] Aguarde...\n"

# Executa o scan de acordo com privilégios
if [ "$(id -u)" = "0" ]; then
    # Scan como root (mais preciso)
    mapfile -t ips < <(sudo nmap -sn -n "$rede" | grep -oP '(\d+\.){3}\d+' | sort -u)
else
    # Scan como usuário normal (sem ICMP)
    mapfile -t ips < <(nmap -sn -n -PS "$rede" | grep -oP '(\d+\.){3}\d+' | sort -u)
fi

# Mostra resultados
if [ ${#ips[@]} -eq 0 ]; then
    echo "[!] Nenhum IP ativo encontrado."
else
    echo "---------------------------------"
    echo "IPs ativos na rede ($rede):"
    echo "---------------------------------"
    printf "  %s\n" "${ips[@]}"
    echo "---------------------------------"
    echo "Total de hosts ativos: ${#ips[@]}"
    echo "---------------------------------"
fi
