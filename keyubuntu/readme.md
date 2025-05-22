# Problemas de chave Ubuntu

Ao apresentar o erro: **The following signatures couldn't be verified because the public key is not available: NO_PUBKEY E84AC2C0460F3994**
 - resolução:
```shell
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E84AC2C0460F3994
```
[Debian](https://wiki.debian.org/DebianKeyring)
```shell
gpg --keyserver keyring.debian.org --recv-key 32EE5355A6BC6E42
```