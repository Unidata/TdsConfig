When installing a new thredds server on
remotetest.unidata.ucar.edu, the process is as follows.
This overrides any other instructions.

For purposes of this process, it is assumed that the content and logs
directories are in /opt/remotetest.

0. Enter the directory TdsConfig/remotetest.
1. Edit as needed the following files:
   * thredds/threddsConfig.xml
   * thredds/catalog.xml
2. Run the shell script 'content.sh' to construct the file
   'content.tar'
3. Copy content.tar to the remotetest.unidata.ucar.edu machine.
4. Stop the tomcat server.
5. Move to the directory /opt/remotetest/content.
6. Untar content.tar
7. rm /opt/remotetest/logs/*
8. Restart the tomcat server.

Notes:

1. This configuration directory will, as a rule, be the same as ../startup,
   except for catalog.xml and threddsConfig.xml. The critical one is
   catalog.xml, the changes to threddsConfig.xml are mostly just setting
   the host information.

2. Verify that all the datasets referenced in catalog.xml
   are in place in /opt/remotetest/content/thredds/public.
   Note that the "locations" in catalog.xml are not actual paths:
   effectively the "content/" part refers to
	/opt/remotetest/content/thredds/public

3. If you plan to modify /opt/remotetest/content, make sure
   you keep a backup copy.

4. Make sure that the following environment variable in setenv.sh is set:
     CONTENT_ROOT="-Dtds.content.root.path=/opt/remotetest/content"
  
