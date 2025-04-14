# Apagar todas evidencias na maquina Ubuntu 22.04

scrit  basico
 - Rodar o script no usuário que irá fazer a remoção.
```shell
#!/bin/bash

# Histórico de shell
rm -f ~/.bash_history ~/.zsh_history
history -c
unset HISTFILE

# Pastas pessoais
rm -rf ~/Documents/* ~/Downloads/* ~/Pictures/* ~/Videos/* ~/Music/* ~/Desktop/*

# Navegadores
rm -rf ~/.mozilla ~/.cache/mozilla
rm -rf ~/.config/google-chrome ~/.cache/google-chrome
rm -rf ~/.config/chromium ~/.cache/chromium
rm -rf ~/.config/BraveSoftware ~/.cache/BraveSoftware

# Cache e lixeira
rm -rf ~/.cache/*
rm -rf ~/.local/share/Trash/*
rm -rf ~/.local/share/recently-used.xbel
rm -rf ~/.local/share/gvfs-metadata/*

# Temporários do sistema (requer sudo)
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo truncate -s 0 /var/log/auth.log
sudo truncate -s 0 /var/log/syslog
```