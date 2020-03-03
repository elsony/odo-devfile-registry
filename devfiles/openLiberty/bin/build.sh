#!/bin/sh

# set -e -o pipefail

date
echo Started - Full build

if [ "$TEST_ENV" = "true" ]; then
    echo "Running in test mode"
else
    echo "Running in development mode"
fi

if [ ! -f pom.xml ]; then
    echo "The current working directory ($PWD) does not contain a maven project"
    exit 1
fi

/opt/ol/wlp/bin/server stop

echo Project contents:
ls -la

date
echo Running full build in $PWD
mvn -B clean package -Dmaven.repo.local=/artifacts/.m2/repository -DskipTests=true
if [ ! $? -eq 0 ]; then
    echo "The maven build failed"
    exit 1
fi

date

echo Target directory contents after maven build:
ls -la ./target

date
echo Copying server configuration artifacts to /config
CONFIGDIR=$(dirname $(find /projects/openLiberty/target/liberty/wlp/usr/servers -name server.xml))
if [ ! $? -eq 0 ]; then
    echo "Cannot start the server because the config directory could not be found"
    exit 1
fi
rm -rf /config/*
cp -r $CONFIGDIR/* /config/
cp -r resources /opt/ol/wlp/output/defaultServer
ls -la /config/

date
echo Finished - Full build
