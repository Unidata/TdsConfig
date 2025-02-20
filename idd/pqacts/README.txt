This directory contains the pqact files needed to serve data from the IDD.

Some files in this directory should be symlinked to the LDM etc/ directory.
Unidata has the following directory layout:

-----------------------------------------
- symlinks in the LDM etc/TDS directory -
-----------------------------------------

* make symlinks to the pqacts files, for example:
    <LDM_HOME>/etc/TDS/pqact.forecastModels -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.forecastModels
    <LDM_HOME>/etc/TDS/pqact.forecastProdsAndAna -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.forecastProdsAndAna
    <LDM_HOME>/etc/TDS/pqact.radars -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.radars
    <LDM_HOME>/etc/TDS/pqact.satellite -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.satellite
    <LDM_HOME>/etc/TDS/pqact.modelsCmc -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.modelsCmc
    <LDM_HOME>/etc/TDS/pqact.textProds -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.textProds
    <LDM_HOME>/etc/TDS/pqact.bufr -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.bufr

* make symlinks to util directory
    <LDM_HOME>/etc/TDS/util -> <TDS_CONTENT_ROOT>/thredds/pqacts/util

Remember, you will need to add the symlinked pqacts to the LDMs
pqact.conf file. For example:

---------------------
- ldmd.conf snippet -
---------------------

#
# THREDDS processing
#
EXEC    "pqact -f NGRID|CONDUIT|HRS etc/TDS/pqact.forecastModels"
EXEC    "pqact -f NGRID|CONDUIT|HDS|FNEXRAD etc/TDS/pqact.forecastProdsAndAna"
EXEC    "pqact -f HRS|NIMAGE|NOTHER etc/TDS/pqact.satellite"
EXEC    "pqact -f HRS|FNEXRAD|NNEXRAD|CRAFT etc/TDS/pqact.radars"
EXEC    "pqact -f HRS|IDS|DDPLUS etc/TDS/pqact.textProds"
EXEC    "pqact -f HRS|IDS|DDPLUS etc/TDS/pqact.bufr"
EXEC    "pqact -f CMC etc/TDS/pqact.modelsCmc"
