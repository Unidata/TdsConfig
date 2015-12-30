Setup Instructions For The remotetest.unidata.ucar.edu Tomcat Server
====

When installing a new thredds server on
_remotetest.unidata.ucar.edu_, the process
is as follows. This overrides any other instructions.

For purposes of this process, it is assumed that the content and logs
directories are in _/opt/remotetest_
on the machine _remotetest.unidata.ucar.edu_.

1. Enter the directory _TdsConfig/remotetest_.
2. Edit as needed the following files:
   * _thredds/threddsConfig.xml_
   * _thredds/catalog.xml_
3. Run the shell script 'content.sh' to construct the file
   'content.tar'
4. Copy _content.tar_ to the _remotetest.unidata.ucar.edu_ machine.
5. Stop the tomcat server.
6. Move to the directory _/opt/remotetest/content_.
7. Untar content.tar into _/opt/remotetest/content_.
8. (optional) clear logs: _rm -f /opt/remotetest/logs/*_
9. Build and install server side keystore and truststore (see below)
10. (optional) modify *$CATALINA_HOME/conf/server.xml* (see below)
11. (optional) modify *$CATALINA_HOME/conf/tomcat-users.xml* (see below)
12. Restart the tomcat server.

Optional Changes to $CATALINA_HOME/conf/server.xml
----
On a one time basis, you will need to modify *$CATALINA_HOME/conf/server.xml*
to support SSL and also to support a password protected dataset.

1. Insert the following &lt;Connector&gt; into conf/server.xml
<pre>
	&lt;Connector
		port="8443"
		maxThreads="150"
		SSLEnabled="true"
		scheme="https"
		secure="true" 
		clientAuth="want"
		sslProtocol="TLS"
		keyAlias="1"
		keystoreFile="conf/ServerKeystore.jks"
		keystorePass="password"
		keyPass="password"
	/&gt;
</pre>
Note the 'clientAuth="want"' line. This tells tomcat to attempt
to use client-side keys but if not successful, ignore and continue.
See below with respect to the 'keystoreFile' line.

Optional Changes to $CATALINA_HOME/conf/tomcat-users.xml
----
Since access to a restricted dataset is used as a test,
the tomcat-users.xml file must be modified to include the following lines.
<pre>
	<role rolename="restrictedDatasetUser"/>
	<role rolename="tiggeData"/>
	<user username="tiggeUser"
		password="tigge"
	    roles="restrictedDatasetUser,tiggeData"/>
</pre>
The roles defined here must be consistent with _content/thredds/catalog.xml_.

Depending on your tomcat installation, the tiggeUser password may
need to be encrypted. You will also need to ensure that 'https:'
access is enabled either in tomcat (see above) or apache httpd.

Key/Trust Store Construction and Installation:
----
If you are running a standalone Tomcat (typically using Intellij),
and in order to support server keys and (optionally) client side keys
the shell script certs.sh must executed. This will construct
JKS format key and trust stores.

1. Run certs.sh to produce
   * ServerKeystore.jks
   * ClientKeystore.jks
   * ClientTruststore.jks
2. Put ServerKeystore.jks and ClientTruststore.jks into ${CATALINA_HOME}/conf

Notes:
-----
1. Verify that all the datasets referenced in catalog.xml
   are in place in /opt/remotetest/content/thredds/public.
   Note that the "locations" in catalog.xml are not actual paths:
   effectively the "content/" part refers to
    /opt/remotetest/content/thredds/public

2. If you plan to modify /opt/remotetest/content, make sure
   you keep a backup copy.

3. Make sure that the following environment variable in setenv.sh is set:
     CONTENT_ROOT="-Dtds.content.root.path=/opt/remotetest/content"
  
