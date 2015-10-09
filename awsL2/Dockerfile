FROM unidata/tds-buildconfig:v4.6.4-SNAPSHOT
MAINTAINER Ryan May <rmay@ucar.edu>

# Add libraries for runtime S3 filesystem support
USER root
ADD s3fs-libs.tar.bz2 /usr/local/tomcat/
RUN chown -R tomcat:tomcat /usr/local/tomcat/lib

USER tomcat
