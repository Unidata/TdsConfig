
SSLContextBuilder 	loadTrustMaterial(File file, char[] storePassword, TrustStrategy trustStrategy) 
http://hc.apache.org/httpcomponents-core-ga/httpcore/apidocs/org/apache/http/ssl/SSLContextBuilder.html?is-external=true

https://hc.apache.org/httpcomponents-client-ga/httpclient/apidocs/org/apache/http/conn/ssl/SSLConnectionSocketFactory.html

SSLSocketFactory can be used to validate the identity of the HTTPS
server against a list of trusted certificates and to authenticate to the
HTTPS server using a private key.

SSLSocketFactory will enable server authentication when supplied with a
trust-store file containing one or several trusted certificates. The
client secure socket will reject the connection during the SSL session
handshake if the target HTTPS server attempts to authenticate itself
with a non-trusted certificate.

Use JDK keytool utility to import a trusted certificate and generate a
trust-store file:

> keytool -import -alias "my server cert" -file server.crt -keystore my.truststore

In special cases the standard trust verification process can be bypassed
by using a custom TrustStrategy. This interface is primarily intended
for allowing self-signed certificates to be accepted as trusted without
having to add them to the trust-store file.

SSLSocketFactory will enable client authentication when supplied with a
key-store file containing a private key/public certificate pair. The
client secure socket will use the private key to authenticate itself to
the target HTTPS server during the SSL session handshake if requested to
do so by the server. The target HTTPS server will in its turn verify the
certificate presented by the client in order to establish client's
authenticity.

Use the following sequence of actions to generate a key-store file

Use JDK keytool utility to generate a new key

> keytool -genkey -v -alias "my client key" -validity 365 -keystore my.keystore

For simplicity use the same password for the key as that of the key-store

Issue a certificate signing request (CSR)

> keytool -certreq -alias "my client key" -file mycertreq.csr -keystore my.keystore

Send the certificate request to the trusted Certificate Authority for
signature. One may choose to act as her own CA and sign the certificate
request using a PKI tool, such as OpenSSL.

Import the trusted CA root certificate

> keytool -import -alias "my trusted ca" -file caroot.crt -keystore my.keystore

Import the PKCS#7 file containing the complete certificate chain

> keytool -import -alias "my client key" -file mycert.p7 -keystore my.keystore

Verify the content of the resultant keystore file

> keytool -list -v -keystore my.keystore

