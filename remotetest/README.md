When installing a new thredds server on
remotetest.unidata.ucar.edu, the process is as follows.
This overrides any other instructions.

1. Edit threddsConfig.xml and catalog.xml as needed.
2. Run the shell script 'content.sh' to construct the file
   'content.tar'
3. Copy content.tar to the remotetest.unidata.ucar.edu machine.
4. Stop the tomcat server.
5. Move into the designated directory on that machine
   (probably /opt/remotetest/content).
   Untar content.tar
6. Restart the tomcat server.


Notes:

1. This configuration directory will, as a rule, be the same as ../startup,
   except for catalog.xml and threddsConfig.xml. The critical one is
   catalog.xml, the changes to threddsConfig.xml are mostly just setting
   the host information.

2. Verify that all the datasets referenced in catalog.xml are in place
   in /opt/remotetest/content. Note that the "locations" in catalog.xml
   are not actual paths.

3. If you plan to modify remotetest:/opt/remotetest/content, make sure
   you keep a backup copy.

4. When you start the Apache Tomcat server, do not forget to set the
   following environment variable in setenv.sh
   CONTENT_ROOT="-Dtds.content.root.path=/opt/remotetest/content"
   (or whereever the content directory is located).
