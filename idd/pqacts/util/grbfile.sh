#!/bin/bash

#--------------------------------------------------------------------------
#
# Name:    grbfile.sh
#
# Purpose: file a LDM product and log the product's receipt
#
# Notes:   modify the 'LOG' file to suit your needs
#
#EXP    (OR_(ABI)-L1b-RadC-M3C(..)_G(..)_s(....)(...).*)
#       PIPE    -close
#       util/grbfile.sh /data/ldm/pub/native/satellite/GOES/GRB\4/\2/CONUS \1 \2 \3 \5 \6 576 logs/grb16.log
#
#EXP    (OR_(GLM)-L2-(....)_G(..)_s(....)(...).*)
#       PIPE    -close
#       util/grbfile.sh /data/ldm/pub/native/satellite/GOES/GRB\4/\2 \1 \2 \3 \4 \6 2160 logs/grb16.log
#
#EXP    (OR_(EXIS)-L1b-(....)_G(..)_s(....)(...).*)
#       PIPE    -close
#       util/grbfile.sh /data/ldm/pub/native/satellite/GOES/GRB\4/\2 \1 \2 \3 \4 \6 720 logs/grb16.log
#
#EXP    (OR_(MAG)-L1b-(....)_G(..)_s(....)(...).*)
#       PIPE    -close
#       util/grbfile.sh /data/ldm/pub/native/satellite/GOES/GRB\4/\2 \1 \2 \3 \4 \6 720 logs/grb16.log
#
#EXP    (OR_(SEIS)-L1b-(....)_G(..)_s(....)(...).*)
#       PIPE    -close
#       util/grbfile.sh /data/ldm/pub/native/satellite/GOES/GRB\4/\2 \1 \2 \3 \4 \6 720 logs/grb16.log
#
#EXP    (OR_(SUVI)-L1b-(.....)_G16_s(....)(...).*)
#       PIPE    -close
#       util/grbfile.sh /data/ldm/pub/native/satellite/GOES/GRB\4/\2 \1 \2 \3 \4 \6 720 logs/grb16.log
#
#          Passed parameters:
#
#                $1 - root of output directory
#          \1 -> $2 - full file name
#          \2 -> $3 - image type: ABI, GLM, SEIS, SUVI, EXIS, MAG
#          \3 -> $4 - wavelength channel or space weather type
#          \4 ->    - GOES platform: 16, 17
#          \5 -> $5 - image CCYY
#          \6 -> $6 - image Julian day JJJ
#                $7 - number of images to keep in current directory
#                $8 - log file
#
# History: 20170914 - Created for CSPP GEO created GRB image filing
#
#--------------------------------------------------------------------------

SHELL=bash
export SHELL

# Date format for LOG file follows: 20170901T000001.826060Z
dfmt="%Y%m%dT%H%M%S"

# Program name and time hack
program="`date -u +$dfmt`.`date -u +'%N' | cut -b 1-6`Z `basename $0`[$$]:"

# Set log file name
if [ $# -ge 8 ]; then
  logfile=$8
else
  logfile=var/logs/grb.log
fi

# Make sure that the log directory exists
dname=`basename $logfile`
if [ ! -d "$dname" ]; then
  mkdir -p $dname >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    message="ERROR: unable to create LOG directory $dname, exiting"
    echo $program $message
    cat > /dev/null
    exit 1
  fi
fi

# Send all messages to the log file
exec >>$logfile 2>&1

# Sanity check for output file name
if [ $# -lt 2 ]; then
  message="ERROR: output file name not specifed, exiting"
  echo $program $message
  cat > /dev/null
  exit 1
fi

# Set the number of images to keep in the current directory
if [ $# -ge 7 ]; then
   KEEP=$7
else
   KEEP=96
fi

# Convert image CCYY and JJJ into CCYYMMDD
ccyymmdd=`date -d "$5-01-01 +$6 days -1 day" +"%Y%m%d"`

# Create the fully qualified pathname of the output file
case "$3" in
  ABI  ) # Write the log message and output
         dname=$1/Channel$4/$ccyymmdd
         ;;
  *    ) # Failure occurred in the operating-system
         dname=$1/$4/$ccyymmdd
         ;;
esac

# Create output directory
if [ ! -d "$dname" ]; then
  mkdir -p $dname >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    message="ERROR: unable to create output directory $dname"
    echo $program $message
    cat > /dev/null
    exit 1
  fi
fi

# Write the log message and output
pathname=$dname/$2
program="`date -u +$dfmt`.`date -u +'%N' | cut -b 1-6`Z `basename $0`[$$]:"
message="FILE: $pathname"
echo $program $message
cat > $pathname

# Create link directory
curdir=`dirname $dname`/current
if [ ! -d "$curdir" ]; then
  mkdir -p $curdir >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    message="ERROR: unable to create current directory $curdir"
    echo $program $message
    exit 1
  fi
fi

# Create a link to the file just written
program="`date -u +$dfmt`.`date -u +'%N' | cut -b 1-6`Z `basename $0`[$$]:"
message="LINK: $curdir/$2"
#echo $program $message
ln $pathname $curdir/$2

# Keep a maximum of $KEEP files in the 'current' directory
cd $curdir
KEEP=$(expr $KEEP + 1)

case `uname -s` in
SunOS)
  files=`ls -1t | tail +${KEEP}`
  ;;
*)
  files=`ls -1t | tail --lines=+${KEEP}`
  ;;
esac

KEEP=$(expr $KEEP - 1)
if [ ! -z "$files" ]; then
  program="`date -u +$dfmt`.`date -u +'%N' | cut -b 1-6`Z `basename $0`[$$]:"
  message="KEEP: $KEEP in $curdir"
  #echo $program $message
  rm -f $files
fi

# Done
exit 0
