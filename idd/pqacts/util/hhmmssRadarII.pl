#!/usr/bin/perl
#
#  hhmmssRadarII.pl 
#
#  Program to make Radar level II volume scans from the first piece and the rest
#  of the pieces. When the last piece arrives it will trigger this script.
#
# - first piece is store separately in it's own file
# - the middle pieces and ending piece are stored in another file
#    note: this is much more efficient then storing individual pieces
# 
# - when ending piece arrive:
# - if both files are available then concatenate together
# - if number of pieces < 10 store as maintenance product
#    else move to live directory removing seconds from name
# 
# - if first piece missing, move middle/ending pieces to
#    badLevel2/missing1piece directory.
# 
#
# defaults
#	datadir = "/data/ldm/pub/native/radar/level2";
#	log = "/data/ldm/logs/radar";
#	actual log name makeRadarII.log.yyyymmdd";
# 
# process command line switches
while ($_ = $ARGV[0], /^-/) {
	 shift;
       last if /^--$/;
	     /^(-d)/ && ( $datadir = shift ) ;
	     /^(-l)/ && ( $log = shift ) ;
	     /^(-v)/ && $verbose++;
}
# process input parameters
if( $#ARGV == 3 ) {
	$stn = $ARGV[ 0 ] ;
	$yyyymmdd = $ARGV[ 1 ] ;
	$hhmmss = $ARGV[ 2 ] ;
	$number = $ARGV[ 3 ] ;
} else {
	print "Not the correct number of parameters, need station yyyymmdd hhmm number_of_pieces\n";
	exit ( 1 );
}

if( ! $datadir ) {
	$datadir = "/data/ldm/pub/native/radar/level2";
}
if( ! $log ) {
	$log = "/data/ldm/logs/radar/makeRadarII.log";
} else {
	$log = $log . "/makeRadarII.log";
}
# go to dir 
if( ! chdir( "$datadir/$stn/$yyyymmdd/.tmp" ) ) {
	`/bin/echo  "$datadir/$stn/$yyyymmdd/.tmp not found" >> $log.$yyyymmdd`;
	exit ( 1 );
}

# first piece has full file name
$first = "Level2_" . $stn . "_" . $yyyymmdd . "_" . $hhmmss . ".ar2v";
# second part is the rest of the scan
$second = $stn . "_" . $yyyymmdd . "_" . $hhmmss;
# remove seconds
$first =~ /_(\d{4})\d{2}\./;
$new = "Level2_" . $stn . "_" . $yyyymmdd . "_" . $1 . ".ar2v";
# process ending piece request
processParts();

$number = 100;
# check for files with no ending piece
( @FILES ) = glob( "$stn*" );
exit( 0 ) if( $#FILES == -1 ); # no partial files

# sleep to catch pieces that arrived after ending piece
sleep 60;
foreach $file ( @FILES ) {
	# Level2_KTLH_20100311_165024
	$file =~ /(\d{8})_(\d{6})/;
	$yyyymmddNew = $1;
	$hhmmssNew = $2;
	# check for already processed files and for newer files
	next if( ! -e $file || $hhmmssNew > $hhmmss );
	# probably old product with no ending piece
	# first piece has full file name
	$first = "Level2_" . $stn . "_" . $yyyymmdd . "_" . $hhmmssNew . ".ar2v";
	# second part is the rest of the scan
	#$second = $file;
	$second = $stn . "_" . $yyyymmdd . "_" . $hhmmssNew;
	# remove seconds
	$first =~ /_(\d{4})\d{2}\./;
	$new = "Level2_" . $stn . "_" . $yyyymmdd . "_" . $1 . ".ar2v";
	# check if this file is a delayed piece
	if( -e "../$new" ) {
		`/bin/cat $file >> "../$new"`;
		`/bin/rm $file`;
		`/bin/echo "$stn $yyyymmdd $hhmmss added delayed pieces" >> $log.$yyyymmdd`;
	} else {
		processParts();
	}
}

exit( 0 );

# Process the parts by concatenation, removing, moving, and logging
sub processParts {

if( -e $first && -e $second ) {
	`/bin/cat $second >> $first`;
	`/bin/rm $second`;
	if( $number < 10 ) { # maintenance product
		`mv $first "$datadir/../badLevel2/maintenance/$first"`;
		`/bin/echo "$stn $yyyymmdd $hhmmss $number is maintenance product" >> $log.$yyyymmdd`;
	} elsif( $number == 100 ) { # partial product
		`/bin/mv $first ../$new`;
		`/bin/echo "$stn $yyyymmdd $hhmmssNew partial scan created with no ending piece" >> $log.$yyyymmdd`;
	} else {
		`/bin/mv $first ../$new`;
		`/bin/echo "$stn $yyyymmdd $hhmmss full scan created with $number pieces" >> $log.$yyyymmdd`;
	}
	return;
}
# first piece missing
if( -e $second ) {
        `mv $second "$datadir/../badLevel2/piece1missing/$first"`;
	if( $number == 100 ) { # partial product
        	`/bin/echo "$stn $yyyymmdd $hhmmss partial scan missing piece 1 and no ending piece" >> $log.$yyyymmdd`;
	} else {
        	`/bin/echo "$stn $yyyymmdd $hhmmss partial scan missing piece 1" >> $log.$yyyymmdd`;
	}
	return;
}
}
exit( 0 );

