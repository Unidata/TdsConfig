TdsConfig
=========

TDS configuration for the TDS at thredds.ucar.edu.

=========================

Configuration files

- kept in git repo thredds/TdsConfig

- each machine has their own subdirectory:
  - idd : common to all (4.6) idd servers
  - miami: brian mapes machine
  - ou: ?
  - rdavm : at CISL/RDA
  - remotetest : where? opendap/netcdf C test server
  - startup: this should be the minimal configuration for running a thredds server
  - thredds : motherlode (/opt/tds-live) (idd + casestudies)
  - threddsDev : lead (/opt/tds-dev). now for 5.0
  - threddsTest : lead (/opt/tds-test)

- to build the config:
   ./build.py [remotetest thredds]

   This will build config.zip files (and wget scripts) for all of the subdirectories.
   You can optionally pass one or more subdirectories to only build for them.
   This script runs on Python 2.7 as well as >= 3.2.
   Note <subdir>/build.info is used for this script.

   Build is automatically performed by Travis for this repo.

- config.zip hosted on [S3](http://unidata-tds.s3-website-us-east-1.amazonaws.com)

- to make changes to config files:
 - edit thredds/TdsConfig/*
 - commit your changes, so that the timestamps get updated in the zip file
 - run build.py
 - copy and unzip config.zip to (root)/content/thredds (or)
 - commit to github, then use the fetch.sh (wget) that is also generated, from the target machine
