When installing a new thredds server on
remotetest.unidata.ucar.edu, the following
things must be observed.

1. This configuration directory should be the same
   as startup, except for catalog.xml and
   threddsConfig.xml. The critical one is catalog.xml,
   the changes to threddsConfig.xml are mostly
   just setting the host information.

2. Verify that all the datasets referenced in catalog.xml
   are in place in /opt/remotetest/content. Note that the
   "locations" in catalog.xml are not actual paths.

3. If you plan to modify remotetest:/opt/remotetest/content,
   make sure you keep a backup copy. The critical
   item in the content directory is the catalog.xml,
   which should be the one from this directory.
   You can set threddsConfig.xml also, but it is
   cosmetic only.

4. When you start the Apache Tomcat server, do not forget
   to set the following environment variable.
       CONTENT_ROOT="-Dtds.content.root.path=/opt/remotetest/content"

