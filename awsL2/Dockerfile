FROM unidata/tds:v4.6.2
MAINTAINER Sean Arms <sarms@ucar.edu>
#
# Install netcdf and some basic command line tools
#
#RUN apt-get update && apt-get install -y \
#  less \
#  libnetcdf-dev \
#  vim 

USER root

RUN mkdir /usr/local/tomcat/content
RUN mkdir /usr/local/tomcat/content/thredds
RUN chown -R tomcat:tomcat /usr/local/tomcat/content/thredds

#
# Copy over TDS config files and unzip
#
USER tomcat

COPY conf/config.zip /usr/local/tomcat/content/thredds/config.zip
RUN cd /usr/local/tomcat/content/thredds/ && unzip config.zip
