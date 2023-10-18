#!/bin/sh

# Root CA
openssl genrsa -out _certs/root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key _certs/root-ca-key.pem -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=Augusto Liks Self Signed CA Authority" -out _certs/root-ca.pem -days 730

# Admin cert
openssl genrsa -out _certs/admin-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in _certs/admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out _certs/admin-key.pem
openssl req -new -key _certs/admin-key.pem -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch" -out _certs/admin.csr
openssl x509 -req -in _certs/admin.csr -CA _certs/root-ca.pem -CAkey _certs/root-ca-key.pem -CAcreateserial -sha256 -out _certs/admin.pem -days 730

# Node cert
openssl genrsa -out _certs/node-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in _certs/node-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out _certs/node-key.pem
openssl req -new -key _certs/node-key.pem -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch" -out _certs/node.csr
echo 'subjectAltName=DNS:opensearch' > _certs/node.ext
openssl x509 -req -in _certs/node.csr -CA _certs/root-ca.pem -CAkey _certs/root-ca-key.pem -CAcreateserial -sha256 -out _certs/node.pem -days 730 -extfile _certs/node.ext

# Client cert
openssl genrsa -out _certs/client-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in _certs/client-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out _certs/client-key.pem
openssl req -new -key _certs/client-key.pem -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch" -out _certs/client.csr
echo 'subjectAltName=DNS:opensearch' > _certs/client.ext
openssl x509 -req -in _certs/client.csr -CA _certs/root-ca.pem -CAkey _certs/root-ca-key.pem -CAcreateserial -sha256 -out _certs/client.pem -days 730 -extfile _certs/client.ext

# Cleanup
rm _certs/admin-key-temp.pem
rm _certs/admin.csr
rm _certs/node-key-temp.pem
rm _certs/node.csr
rm _certs/node.ext
rm _certs/client-key-temp.pem
rm _certs/client.csr
rm _certs/client.ext
