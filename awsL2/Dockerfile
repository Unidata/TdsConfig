FROM unidata/tds-buildconfig:v4.6.4-SNAPSHOT
MAINTAINER Ryan May <rmay@ucar.edu>

# Add libraries for runtime S3 filesystem support
USER root
ADD s3fs-libs.tar.bz2 /usr/local/tomcat/
RUN chown -R tomcat:tomcat /usr/local/tomcat/lib

# SECRET keys for accessing S3
USER tomcat
ENV s3fs_access_key="" s3fs_secret_key="" AWS_ACCESS_KEY_ID="" AWS_SECRET_ACCESS_KEY=""
