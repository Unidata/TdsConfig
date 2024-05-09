#!/bin/bash
rm -f ./content.tar ./config.zip
tar -cf ./content.tar thredds root
zip -r ./config.zip thredds root



