#!/bin/sh
unamestr=`uname`
if [[ "$unamestr" == "SunOS" ]]; then
	PATH=/opt/csw/bin:/opt/jdk/bin:$PATH
fi

{
	wget --no-check-certificate https://raw.githubusercontent.com/Unidata/TdsConfig/master/idd/config.zip -O config.zip
	jar xf config.zip
	exit
}
