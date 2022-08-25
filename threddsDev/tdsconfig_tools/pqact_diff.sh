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

# make sure we are in the correct directory
echo "Change directory to ${LDM_PQACT_DIR}" 
eval cd ${LDM_PQACT_DIR}

echo "Checking diffs"
echo "< Production (${LDM_PQACT_DIR})"
echo "> TdsConfig (${TDS_PQACT_DIR})"
for pqact in ${PqactFiles[@]}; do
    echo "diff for ${pqact} ..."
    eval diff ./$pqact ${TDS_PQACT_DIR}/${pqact}
done
