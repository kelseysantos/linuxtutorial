# Aumentar o limite de arquivos abertos

De `1024` para `65535`:

```shell
ulimit -n 65535
```
Ou rodar o Script:
```shell
#!/bin/bash

set -e

LIMITE=65535

echo "✅ Aumentando limite de arquivos abertos para $LIMITE"

# Backup arquivos antes de alterar
backup_file() {
    [ -f "$1" ] && sudo cp "$1" "$1.bak.$(date +%s)"
}

# 1. /etc/security/limits.conf
LIMITS_CONF="/etc/security/limits.conf"
backup_file "$LIMITS_CONF"
sudo sed -i '/^\* soft nofile/d' "$LIMITS_CONF"
sudo sed -i '/^\* hard nofile/d' "$LIMITS_CONF"
echo -e "* soft nofile $LIMITE\n* hard nofile $LIMITE" | sudo tee -a "$LIMITS_CONF" > /dev/null

# 2. /etc/pam.d/common-session
PAM_FILE="/etc/pam.d/common-session"
backup_file "$PAM_FILE"
if ! grep -q "pam_limits.so" "$PAM_FILE"; then
    echo "session required pam_limits.so" | sudo tee -a "$PAM_FILE" > /dev/null
fi

# 3. /etc/profile
PROFILE_FILE="/etc/profile"
backup_file "$PROFILE_FILE"
if ! grep -q "ulimit -n $LIMITE" "$PROFILE_FILE"; then
    echo "ulimit -n $LIMITE" | sudo tee -a "$PROFILE_FILE" > /dev/null
fi

# 4. systemd: /etc/systemd/system.conf
SYSTEM_CONF="/etc/systemd/system.conf"
backup_file "$SYSTEM_CONF"
sudo sed -i 's/^#DefaultLimitNOFILE=.*//g' "$SYSTEM_CONF"
sudo sed -i 's/^DefaultLimitNOFILE=.*//g' "$SYSTEM_CONF"
echo "DefaultLimitNOFILE=$LIMITE" | sudo tee -a "$SYSTEM_CONF" > /dev/null

# 5. systemd: /etc/systemd/user.conf
USER_CONF="/etc/systemd/user.conf"
backup_file "$USER_CONF"
sudo sed -i 's/^#DefaultLimitNOFILE=.*//g' "$USER_CONF"
sudo sed -i 's/^DefaultLimitNOFILE=.*//g' "$USER_CONF"
echo "DefaultLimitNOFILE=$LIMITE" | sudo tee -a "$USER_CONF" > /dev/null

# 6. Recarregar systemd
echo "🔁 Recarregando systemd..."
sudo systemctl daemon-reexec

echo -e "\n✅ Alterações aplicadas com sucesso!"
echo "⚠️ Reinicie o sistema para garantir que todas as mudanças tenham efeito: sudo reboot"
```