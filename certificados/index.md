# Guia de Referência de Certificados SSL

X.509 é um padrão da ITU que define o formato de certificados de chave pública. Os certificados X.509 são usados no TLS/SSL, que é a base para o HTTPS. Um certificado X.509 associa uma identidade a uma chave pública usando uma assinatura digital. Um certificado contém uma identidade (nome do host, organização, etc.) e uma chave pública (RSA, DSA, ECDSA, ed25519, etc.), e pode ser assinado por uma Autoridade de Certificação ou ser autoassinado.

## Certificados Autoassinados

### Gerar a Autoridade Certificadora (CA)
1. Gerar uma chave RSA
```bash
openssl genrsa -aes256 -out ca-key.pem 4096
```
2. Gerar um Certificado CA público
```bash
openssl req -new -x509 -sha256 -days 3650 -key ca-key.pem -out ca.pem
```

### Etapa Opcional: Visualizar o Conteúdo do Certificado
```bash
openssl x509 -in ca.pem -text
openssl x509 -in ca.pem -purpose -noout -text
```

### Gerar um Certificado
1. Criar uma chave RSA
```bash
openssl genrsa -out cert-key.pem 4096
```
2. Criar uma Solicitação de Assinatura de Certificado (CSR)
```bash
openssl req -new -sha256 -subj "/CN=kelseysantos" -key cert-key.pem -out cert.csr
```
3. Criar um `extfile` com todos os nomes alternativos
```bash
echo "subjectAltName=DNS:*.kelseysantos.local*,IP:10.0.0.1" >> extfile.cnf
```
```bash
# opcional
echo extendedKeyUsage = serverAuth >> extfile.cnf
```
4. Criar o certificado
```bash
openssl x509 -req -sha256 -days 3650 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial
```

## Formatos de Certificado

Os Certificados X.509 existem em Formatos Base64 **PEM (.pem, .crt, .ca-bundle)**, **PKCS#7 (.p7b, p7s)** e Formatos Binários **DER (.der, .cer)**, **PKCS#12 (.pfx, p12)**.

### Converter Certificados

COMANDO | CONVERSÃO
---|---
`openssl x509 -outform der -in cert.pem -out cert.der` | PEM para DER
`openssl x509 -inform der -in cert.der -out cert.pem` | DER para PEM
`openssl pkcs12 -in cert.pfx -out cert.pem -nodes` | PFX para PEM

## Verificar Certificados
`openssl verify -CAfile ca.pem -verbose cert.pem`

## Instalar o Certificado da CA como uma Autoridade de Raiz Confiável

### No Debian e Derivados
- Mova o certificado CA (`ca.pem`) para `/usr/local/share/ca-certificates/ca.crt`.
- Atualize o Armazenamento de Certificados com:
```bash
sudo update-ca-certificates
```

Consulte a documentação [aqui](https://wiki.debian.org/Self-Signed_Certificate) e [aqui](https://manpages.debian.org/buster/ca-certificates/update-ca-certificates.8.en.html).

### No Fedora
- Mova o certificado CA (`ca.pem`) para `/etc/pki/ca-trust/source/anchors/ca.pem` ou `/usr/share/pki/ca-trust-source/anchors/ca.pem`.
- Em seguida, execute (com sudo, se necessário):
```bash
update-ca-trust
```

Consulte a documentação [aqui](https://docs.fedoraproject.org/en-US/quick-docs/using-shared-system-certificates/).

### No Arch
Em todo o sistema - Arch (p11-kit)
(Do wiki do Arch)
- Execute (como root):
```bash
trust anchor --store myCA.crt
```
- O certificado será gravado em /etc/ca-certificates/trust-source/myCA.p11-kit e os diretórios "legacy" serão atualizados automaticamente.
- Se você receber "no configured writable location" ou um erro semelhante, importe a CA manualmente:
- Copie o certificado para o diretório /etc/ca-certificates/trust-source/anchors.
- E então
```bash 
update-ca-trust
```
Página do wiki [aqui](https://wiki.archlinux.org/title/User:Grawity/Adding_a_trusted_CA_certificate).

### No Windows

Supondo que o caminho para o seu certificado CA gerado seja `C:\ca.pem`, execute:
```powershell
Import-Certificate -FilePath "C:\ca.pem" -CertStoreLocation Cert:\LocalMachine\Root
```
- Defina `-CertStoreLocation` como `Cert:\CurrentUser\Root` caso queira confiar apenas em certificados para o usuário logado.

OU

No Prompt de Comando, execute:
```sh
certutil.exe -addstore root C:\ca.pem
```

- `certutil.exe` é uma ferramenta integrada (clássica `System32`) e adiciona uma âncora de confiança em todo o sistema.

### No Android

Os passos exatos variam de dispositivo para dispositivo, mas aqui está um guia generalizado:
1. Abra as Configurações do telefone.
2. Localize a seção `Criptografia e Credenciais`. Geralmente é encontrada em `Configurações > Segurança > Criptografia e Credenciais`.
3. Escolha `Instalar um certificado`.
4. Escolha `Certificado CA`.
5. Localize o arquivo de certificado `ca.pem` em seu Cartão SD/Armazenamento Interno usando o gerenciador de arquivos.
6. Selecione para carregá-lo.
7. Concluído!"


## Guia de Referência de Segurança SSL
### Versão do TLS e Cifras
Analisar a Versão do TLS e Cifras Suportadas: `nmap --script ssl-enum-ciphers <alvo>`

Ferramenta | Link | Descrição
---|---|---
Qualys SSL Labs | https://www.ssllabs.com/projects/index.html | Ferramentas de Segurança SSL da Qualys