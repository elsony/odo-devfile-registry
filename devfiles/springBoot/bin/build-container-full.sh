#!/bin/sh

# set -e -o pipefail

date
echo Started - Full build using container folders

echo listing project src
ls -la

date
echo running full maven build
mvn -Dmaven.repo.local=/data/cache/.m2/repository -f ./pom.xml package -Dmaven.test.skip=true

TARGET_JAR=$(ls target/*.jar | head -n1)

date
echo copying target jar to output dir
rm -rf /data/output/*.jar
mkdir -p /data/output
cp -rf $TARGET_JAR /data/output/

date
echo listing /data/output
ls -la /data/output

date
echo Finished - Full build using container folders
