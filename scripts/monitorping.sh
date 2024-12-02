#!/bin/bash

# Configurações
HOST="192.168.245.8"          # IP ou hostname a ser monitorado
INTERVALO=5             # Intervalo em segundos entre os pings
ALERTA_LOG="ping_alerta.log"

# Verifica se o script está sendo executado como root
if [ $(id -u) -ne 0 ]; then
  echo "Este script precisa ser executado como root!"
  exit 1
fi

# Função de alerta
alerta() {
  echo "$(date): Falha ao pingar o host $HOST!" | tee -a $ALERTA_LOG
  # Você pode adicionar aqui um comando para enviar e-mails ou outra forma de alerta.
}

# Loop de monitoramento
echo "Iniciando monitoramento do host $HOST..."
while true; do
  if ! ping -c 1 -w 2 $HOST &>/dev/null; then
    alerta
  fi
  sleep $INTERVALO
done
