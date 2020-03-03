#!/bin/sh

# set -e -o pipefail

date
echo Started - Full build using container folders

echo listing project src
ls -la

date
echo running full maven build
# mvn -B clean package -Dmaven.repo.local=/data/idp/cache/.m2/repository -DskipTests=true
mvn -Dmaven.repo.local=/data/cache/.m2/repository -f ./pom.xml package -Dmaven.test.skip=true

TARGET_JAR=$(ls target/*.jar | head -n1)

date
echo copying target jar to output dir
rm -rf /data/output/*.jar
mkdir -p /data/output
cp -rf $TARGET_JAR /data/output/
# chown -fR 1001 /data/idp/output

date
echo listing /data/output
ls -la /data/output

# date
# echo rm -rf /data/idp/buildartifacts and copying artifacts
# rm -rf /data/idp/buildartifacts
# mkdir -p /data/idp/buildartifacts/
# cp -r /data/idp/output/target/liberty/wlp/usr/servers/defaultServer/* /data/idp/buildartifacts/
# cp -r /data/idp/output/target/liberty/wlp/usr/shared/resources/ /data/idp/buildartifacts/
# cp /data/idp/src/src/main/liberty/config/jvmbx.options /data/idp/buildartifacts/jvm.options

# date
# echo chown the buildartifacts dir
# chown -fR 1001 /data/idp/buildartifacts

date
echo Finished - Full build using container folders
