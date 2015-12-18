java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds093.1/**/.*grb2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds093.1.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds094.1/**/.*grb2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds094.1.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds113.0/**/.*grb -useCacheDir /rdavm/TDSIndexFiles > ds113.0.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds131.2/**/.*grib -useCacheDir /rdavm/TDSIndexFiles > ds131.2.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds628.0/**/.* -useCacheDir /rdavm/TDSIndexFiles > ds628.0.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds628.1/**/.* -useCacheDir /rdavm/TDSIndexFiles > ds628.1.out
