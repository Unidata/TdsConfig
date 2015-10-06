#!/bin/bash
# Grab the pom file
wget https://oss.sonatype.org/content/repositories/releases/com/upplication/s3fs/1.1.0/s3fs-1.1.0.pom

# Grab all the dependencies and move to a lib directory for packing
mvn -f s3fs-1.1.0.pom dependency:copy-dependencies
mv target/dependency lib/

# Grab the s3fs jar
wget https://oss.sonatype.org/content/repositories/releases/com/upplication/s3fs/1.1.0/s3fs-1.1.0.jar -O lib/s3fs-1.1.0.jar

# Pack up
tar cjf s3fs-libs.tar.bz2 lib/

# Clean up
rmdir target
rm -rf lib
rm s3fs-1.1.0.pom
