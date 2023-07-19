echo "Deletando arquivos PEM"
rm *.pem

# 1. Generate CA's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 3650 -keyout ca-key.pem -out ca-cert.pem -nodes -subj "/C=BR/ST=MatoGrosso/L=Cuiaba/O=PCMT/OU=PCMT/CN=*.pcmt.local/emailAddress=coti@pjc.mt.gov.br"

echo "CA's self-signed certificate"
openssl x509 -in ca-cert.pem -text
openssl x509 -in ca-cert.pem -purpose -noout -text

# 2. Generate web server's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -keyout server-key.pem -out server-req.pem -nodes -subj "/C=BR/ST=MatoGrosso/L=Cuiaba/O=PCMT/OU=PCMT/CN=*.pcmt.local/emailAddress=coti@pjc.mt.gov.br"

if [ -e "server-ext.cnf" ]; then
    echo "subjectAltName=DNS:*.pcmt.local,DNS:*.pcmt.local,IP:0.0.0.0" > server-ext.cnf
    # rm -f server-ext.cnf
else
    touch server-ext.cnf;echo "subjectAltName=DNS:*.pcmt.local,DNS:*.pcmt.local,IP:0.0.0.0" > server-ext.cnf
fi

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server-req.pem -days 3650 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text

echo "Verificando se o Certificado está OK: " 
openssl verify -CAfile ca-cert.pem server-cert.pem