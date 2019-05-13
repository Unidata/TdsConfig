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
    <LDM_HOME>/etc/TDS/pqact.modelsHrrr -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.modelsHrrr
    <LDM_HOME>/etc/TDS/pqact.testDatasets -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.testDatasets
    <LDM_HOME>/etc/TDS/pqact.modelsCmc -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.modelsCmc
    <LDM_HOME>/etc/TDS/pqact.modelsGdas -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.modelsGdas

Remember, you will need to add the symlinked pqacts to the LDMs
pqact.conf file. For example:

---------------------
- ldmd.conf snippet -
---------------------

#
# THREDDS processing
#
EXEC    "pqact -f NGRID|CONDUIT|HRS|FNMOC etc/TDS/pqact.forecastModels"
EXEC    "pqact -f NGRID|CONDUIT etc/TDS/pqact.forecastProdsAndAna"
EXEC    "pqact -f NIMAGE etc/TDS/pqact.satellite"
EXEC    "pqact -f HRS|FNEXRAD|NNEXRAD|CRAFT etc/TDS/pqact.radars"
EXEC    "pqact -f NGRID|FSL2 etc/TDS/pqact.modelsHrrr"
EXEC    "pqact -f HRS|NGRID|CONDUIT etc/TDS/pqact.testDatasets"
EXEC    "pqact -f CMC etc/TDS/pqact.modelsCmc"
EXEC    "pqact -f CONDUIT etc/TDS/pqact.modelsGdas"
