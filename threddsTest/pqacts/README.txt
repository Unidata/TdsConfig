This directory contains the pqact files needed to serve data from the IDD.

The files in this directory should be copied over to the LDM etc/TDS directory.
We've created a few bash scripts to help manage this, and they may be found in
the config.zip file:

config.zip
    |__tdsconfig_tools/
        |__config_update.sh
        |__pqact_diff.sh

config_update.sh: Copies over to the pqacts to the ldm account.
pqact_diff.sh: Checks for differences between the pqacts living under the ldm
account and the pqacts in the TDS content directory (as managed by TdsConfig).

Warning: you will likely need to edit these scripts to change the values of the
following ENVVARS appropriate for your system (current values shown)

* LDM_PQACT_DIR="/opt/ldm/etc/TDS"
* TDS_PQACT_DIR="/opt/tds-test/content/thredds/pqacts"

Remember, you will need to add these pqacts to the LDMs pqact.conf file. 
For example:

---------------------
- ldmd.conf snippet -
---------------------

#
# THREDDS processing (don't forget to ensure tabs are used between 
#                     EXEC and "pqact...")
#
EXEC    "pqact -f NGRID|CONDUIT|HRS|FNMOC etc/TDS/pqact.forecastModels"
EXEC    "pqact -f NGRID|CONDUIT etc/TDS/pqact.forecastProdsAndAna"
EXEC    "pqact -f HRS|NIMAGE|NOTHER etc/TDS/pqact.satellite"
EXEC    "pqact -f HRS|FNEXRAD|NNEXRAD|CRAFT etc/TDS/pqact.radars"
EXEC    "pqact -f WMO|HRS|NGRID|CONDUIT|EXP etc/TDS/pqact.testDatasets"
EXEC    "pqact -f IDS|HRS|NOTHER etc/TDS/pqact.ryan-test"
EXEC    "pqact -f CMC etc/TDS/pqact.modelsCmc"
EXEC    "pqact -f CONDUIT etc/TDS/pqact.modelsGdas"

Warning: you may need to change the path to the pqact files listed in the
ldmd.conf snippet above.

After running config_update.sh, look for new pqacts and add them to the 
ldmd.conf file.
To ensure there are no syntax errors in the new/updated pqacts, run

  ldmadmin pqactcheck

If there are no issues, then you are good to go.
If no new pqacts were added to ldmd.conf, simply run:

  ldmadmin pqactHUP 

otherwise, restart the ldm:

  ldmadmin restart