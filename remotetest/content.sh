#!/bin/bash
rm -f .content.tar
tar -cf ./content.tar \
threddsConfig.xml \
catalog.xml \
enhancedCatalog.xml \
wmsConfig.xml \
root \
-C public \
testdods \
wcsExample

