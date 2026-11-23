# Comandos SSH

Geração Autmática de chave ssh sem senha:
```shell
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
```

Para realizar uma manutenção programada, recomendo:

```shell
# 1. Verificar usuários conectados
w

loginctl list-sessions

# 2. Avisar todos os usuários
wall "AVISO: O servidor entrará em manutenção em 5 minutos. Salvem seus trabalhos e encerrem as sessões."

#Digite a mensagem e pressione Ctrl+D para finalizar.
write root pts/0

# 3. Aguardar 5 minutos
sleep 300

# 4. Verificar novamente
who

# 5. Encerrar uma sessão específica
loginctl terminate-session ID
```


