TdsConfig
=========

TDS configuration for the TDS at thredds.ucar.edu.

=========================

Configuration files

- kept in git repo TdsConfig

- each machine has their own subdirectory:
  - idd : common to all (4.6) idd servers
  - rdavm : at CISL/RDA
  - remotetest : where? opendap/netcdf C test server
  - startup: this should be the minimal configuration for running a thredds server
  - thredds : atm-nwsc (/opt/tds) (idd + casestudies)
  - threddsTest : atm-nwsc (/opt/tds-test) (idd + casestudies + preprocessed)
  - threddsDev : lead (/opt/tds-dev)
  - awsL2 : jetstream machine serving AWS Level2 radar archive data

- to build the config:
   `./build.py [machine]` machine is optional e.g. remotetest

   This will build config.zip files (and wget scripts) for all of the subdirectories.
   You can optionally pass one or more subdirectories to only build for them.
   This script runs on Python 2.7 as well as >= 3.2.
   Note `<machine>/build.info` is used for this script.

   The build and upload of config.zip files is automatically performed by GitHub Actions for
   all changes committed to the repository.

- config.zip hosted on [Unidata Nexus](https://artifacts.unidata.ucar.edu/#browse/browse:downloads-tds-config)

- to make changes to config files:
  - Edit files, e.g. `thredds/*`
  - Commit your changes
  - Make a PR to get it reviewed and merged
  - Use the fetch.sh (wget) that is also generated, from the target machine
