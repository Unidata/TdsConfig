This directory contains the pqact files needed to serve data from the IDD.

Because the TDS currently relies on the perl-decoders to handel observational
data coming across the IDD, the necessary perl decoder scripts, cdl files,
and table files are included in this repository.

Some files in this directory should be symlinked to the LDM etc/ directory.
Unidata has the following directory layout:

<LDM_HOME>/etc/TDS:
 - symlinks to the pqacts in this directory
 - symlinks to the .tbl files in this directory

For example (may have more or less pqact files, depending 
on your setup):

-----------------------------------------
- symlinks in the LDM etc/TDS directory -
-----------------------------------------

<LDM_HOME>/etc/TDS/pqact.obsData -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.obsData
<LDM_HOME>/etc/TDS/pqact.radars -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.radars
<LDM_HOME>/etc/TDS/pqact.newPointObs -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.newPointObs
<LDM_HOME>/etc/TDS/pqact.satellite -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.satellite
<LDM_HOME>/etc/TDS/pqact.modelsNcep -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.modelsNcep
<LDM_HOME>/etc/TDS/pqact.modelsFnmoc -> <TDS_CONTENT_ROOT>/thredds/pqacts/pqact.modelsFnmoc
<LDM_HOME>/etc/TDS/snstns.tbl-> <TDS_CONTENT_ROOT>/thredds/pqacts/snstns.tbl
<LDM_HOME>/etc/TDS/snstns.tbl-> <TDS_CONTENT_ROOT>/thredds/pqacts/snstns.tbl

Remember, you will need to add the symlinked pqacts to the LDMs
pqact.conf file. For example:

---------------------
- ldmd.conf snippet -
---------------------

#
# THREDDS processing
#
exec    "pqact -f NIMAGE etc/TDS/pqact.satellite"
exec    "pqact -f NNEXRAD|CRAFT etc/TDS/pqact.radars"
exec    "pqact -f FNMOC etc/TDS/pqact.modelsFnmoc"
exec    "pqact -f NGRID|CONDUIT|HRS etc/TDS/pqact.modelsNcep"
exec    "pqact -f DDS|IDS etc/TDS/pqact.newPointObs"
exec    "pqact -f FSL2|HRS etc/TDS/pqact.obsData"
