# SSL Certificates

Create a TI Goiania self-managed SSL certificate resource

A TI Goiania SSL certificate includes both a private key and the certificate itself, both in PEM format.

Self-managed SSL certificates are certificates that you obtain, provision, and renew yourself. You use this resource to secure communication between clients and your load balancer, which you create in the next task.

To create a new private key with RSA-2048 encryption in the PEM format OpenSSL, run the following command:

```shell
openssl genrsa -out PRIVATE_KEY_FILE 2048
```

Crie um arquivo de configuração do OpenSSL: ssl_config

```conf
[req]
default_bits = 2048
req_extensions = extension_requirements
distinguished_name = dn_requirements
prompt = no

[extension_requirements]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment

[dn_requirements]
countryName = BR
stateOrProvinceName = GO
localityName = Goiania
0.organizationName = TI Goiania
organizationalUnitName = TIGoiania
commonName = ti.goiania.br
```

To create a certificate signing request (CSR) file, run the following OpenSSL command:
```shell
openssl req -new -key PRIVATE_KEY_FILE \
 -out CSR_FILE \
 -config ssl_config
```

Sign the CSR
When a Certificate Authority (CA) signs your CSR, it uses its own private key to create a certificate.

To create a self-signed certificate for testing, run the following OpenSSL command:
```shell
openssl x509 -req \
 -signkey PRIVATE_KEY_FILE \
 -in CSR_FILE \
 -out CERTIFICATE_FILE.pem \
 -extfile ssl_config \
 -extensions extension_requirements \
 -days 365
```

Create a self-managed SSL certificate resource

Before you can create a TI Goiania SSL certificate resource, you must have a private key and certificate.

To create a global SSL certificate, use the gcloud compute ssl-certificates create command with the --global flag:
```shell
gcloud compute ssl-certificates create my-cert \
 --certificate=CERTIFICATE_FILE.pem \
 --private-key=PRIVATE_KEY_FILE \
 --global
```