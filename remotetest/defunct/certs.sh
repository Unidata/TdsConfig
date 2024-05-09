rm -f serverKey.pem serverCert.pem
rm -fr ServerKeystore.pkcs12 ServerKeystore.jks
rm -f ServerTruststore.jks

##################################################
# Server Key Generation:

# Generate server private key :
openssl genrsa -des3 -passout pass:password -out serverKey.pem 2048

# Generate the self-signed certificate for the server,
openssl req -new -x509 -key serverKey.pem  -out serverCert.pem -days 3650 \
	-subj "/C=US/ST=Colorado/L=Boulder/O=UCAR/OU=Unidata/CN=www.ucar.edu" \
	-passin pass:password -passout pass:password

# Generate a keystore in JKS format
openssl pkcs12 -export -out ServerKeystore.pkcs12 -in serverCert.pem -inkey serverKey.pem -passin pass:password -passout pass:password

# Convert serverkeystore.pkcs12 file to JKS format keystore
keytool -importkeystore -alias 1 -srckeystore ServerKeystore.pkcs12 -srcstoretype PKCS12 -destkeystore ServerKeystore.jks -deststoretype JKS \
-srcstorepass password -srckeypass password -deststorepass password -destkeypass password -noprompt

##################################################
rm -f clientKey.pem clientCert.pem
rm -fr ClientKeystore.pkcs12 ClientKeystore.jks

# Client Key Generation:

# Generate client private key :
openssl genrsa -des3 -passout pass:password -out clientKey.pem 2048

# Generate the self-signed certificate for the client,
openssl req -new -x509 -key clientKey.pem  -out clientCert.pem -days 3650 \
	-subj "/C=US/ST=Colorado/L=Boulder/O=UCAR/OU=Unidata/CN=www.ucar.edu" \
	-passin pass:password -passout pass:password

# Generate a keystore in JKS format
openssl pkcs12 -export -out ClientKeystore.pkcs12 -in clientCert.pem -inkey clientKey.pem -passin pass:password -passout pass:password

# Convert clientkeystore.pkcs12 file to JKS format keystore
keytool -importkeystore -alias 1 -srckeystore ClientKeystore.pkcs12 -srcstoretype PKCS12 -destkeystore ClientKeystore.jks -deststoretype JKS \
-srcstorepass password -srckeypass password -deststorepass password -destkeypass password -noprompt

##################################################
# Generate the trust store for the server
keytool -importcert -alias mockdis -keystore ServerTruststore.jks -file clientCert.pem -storepass password -keypass password -trustcacerts <<EOF
yes
EOF

# Cleanup
rm -f serverKey.pem serverCert.pem
rm -fr ServerKeystore.pkcs12
rm -f clientKey.pem clientCert.pem
rm -fr ClientKeystore.pkcs12
exit


##################################################
# Ignore below this
# pkcs12 - to browser
`openssl pkcs12 -export -out clientKeystore.pkcs12 -in clientCert.pem -inkey clientKey.pem`

# Import this clientkeystore.pkcs12 file into firefox browser.
# Get client keystore file.
keytool -import -alias mockdis -keystore clientTrustore.jks -file clientCert.pem

# Tomcat configuration :
# <Connector port="8443" protocol="HTTP/1.1"
#		maxThreads="150"
#		SSLEnabled="true"
#		scheme="https"
#		secure="true"
#		clientAuth="true"
#		sslProtocol="TLS"
#		keyAlias="1"
#		keystoreFile="D:\OpenSSL-Win32\bin\ServerKeystore.jks"
#		keystorePass="changeit"
#		truststoreFile="D:\OpenSSL-Win32\bin\clientTrustore.jks"
#		truststorePass="changeit"
#		/> 
