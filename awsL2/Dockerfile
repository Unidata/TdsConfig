FROM unidata/tds-buildconfig:v4.6.4-SNAPSHOT
MAINTAINER Ryan May <rmay@ucar.edu>

# Add libraries for runtime S3 filesystem support
USER root
RUN rm -rf webapps/manager webapps/host-manager webapps/docs webapps/examples
ADD s3fs-libs.tar.bz2 /usr/local/tomcat/
ADD server.xml /usr/local/tomcat/conf/
ADD tomcat-users.xml /usr/local/tomcat/conf/
RUN chown -R tomcat:tomcat /usr/local/tomcat

USER tomcat
