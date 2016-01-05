#!/bin/bash
openssl  req  -config /usr/ssl/openssl.cnf  -new  -x509  -keyout  ca-key.pem.txt -out  ca-certificate.pem.txt  -days  365 <<EOF
password
US
Colorado
Boulder
UCAR
Unidata
ucar.edu
ignore@unidata.ucar.edu
EOF
openssl x509 -in ca-certificate.pem.txt -text
