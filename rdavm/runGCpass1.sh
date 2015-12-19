java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds083.2/grib1/**/fnl_.*grib1 -useCacheDir /rdavm/TDSIndexFiles > ds083.2.grib1.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds083.2/grib2/**/fnl_.*grib2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds083.2.grib2.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds083.3/**/.*grib2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds083.3.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds084.1/**/.*grib2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds084.1.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds084.3/**/.*grib2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds084.3.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds084.4/**/.*grib2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds084.4.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds093.1/**/.*grb2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds093.1.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds094.1/**/.*grb2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds094.1.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds094.2/**/.*grb2 -isGrib2 -useCacheDir /rdavm/TDSIndexFiles > ds094.2.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds113.0/**/.*grb -useCacheDir /rdavm/TDSIndexFiles > ds113.0.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds131.2/**/.*grib -useCacheDir /rdavm/TDSIndexFiles > ds131.2.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds628.0/**/.* -useCacheDir /rdavm/TDSIndexFiles > ds628.0.out
java -Xmx4g -classpath tdm-5.0.jar thredds.tdm.GCpass1 -spec /glade/p/rda/data/ds628.1/**/.* -useCacheDir /rdavm/TDSIndexFiles > ds628.1.out
