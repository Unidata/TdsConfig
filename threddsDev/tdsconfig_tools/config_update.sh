#!/bin/bash

LDM_PQACT_DIR="/opt/ldm/etc/TDS"
TDS_PQACT_DIR="/opt/tds/content/thredds/pqacts"


declare -a PqactFiles=("pqact.forecastModels" \
                       "pqact.forecastProdsAndAna" \
                       "pqact.modelsCmc" \
                       "pqact.radars" \
                       "pqact.satellite" \
                       "pqact.textProds" \
                       "pqact.bufr")

declare -a AuxDirs=( "util" )

# make sure we are in the correct directory
echo "Change directory to ${LDM_PQACT_DIR}" 
eval cd ${LDM_PQACT_DIR}

# refresh pqact files based on TdsConfig
echo "Refresh pqacts"
for pqact in ${PqactFiles[@]}; do
    echo "...refreshing $pqact"
    eval rm ./${pqact}
    eval cp ${TDS_PQACT_DIR}/${pqact} .
done

# refresh directories based on what is in TdsConfig
echo "Refresh directories"
for auxDir in ${AuxDirs[@]}; do
    echo "...refreshing ${auxDir}"
    eval rm -r ./${auxDir}
    eval cp -r ${TDS_PQACT_DIR}/${auxDir} .
done

# make sure things in util are executable by LDM
echo "Changing permissions in util directory"
chmod -R u+x ./util

echo "finished!"
