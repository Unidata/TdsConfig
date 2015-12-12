When installing a new thredds server on
remotetest.unidata.ucar.edu, the process
is as follows. This overrides any other instructions.

For purposes of this process, it is assumed that the content and logs
directories are in /opt/remotetest on the machine remotetest.unidata.ucar.edu.

1. Enter the directory TdsConfig/remotetest.
2. Edit as needed the following files:
   * thredds/threddsConfig.xml
   * thredds/catalog.xml
3. Run the shell script 'content.sh' to construct the file
   'content.tar'
4. Copy content.tar to the remotetest.unidata.ucar.edu machine.
5. Stop the tomcat server.
6. Move to the directory /opt/remotetest/content.
7. Untar content.tar
8. rm /opt/remotetest/logs/*
9. Restart the tomcat server (optionally deleting old logs).

Notes:

1. Since access to a restricted dataset is used here, you need to ensure
   that tomcat_users.xml contains something like the following lines:
     <role rolename="restrictedDatasetUser"/>
     <role rolename="tiggeData"/>
     <user username="tiggeUser" password="tigge" roles="restrictedDatasetUser,tiggeData"/>
   Depending on your tomcat installation, the tiggeUser password may
   need to be encrypted. You will also need to ensure that 'https:'
   access is enabled either in tomcat or apache httpd.

2. Verify that all the datasets referenced in catalog.xml
   are in place in /opt/remotetest/content/thredds/public.
   Note that the "locations" in catalog.xml are not actual paths:
   effectively the "content/" part refers to
	/opt/remotetest/content/thredds/public

3. If you plan to modify /opt/remotetest/content, make sure
   you keep a backup copy.

4. Make sure that the following environment variable in setenv.sh is set:
     CONTENT_ROOT="-Dtds.content.root.path=/opt/remotetest/content"
  
