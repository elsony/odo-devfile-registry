#!/bin/sh

# set -e -o pipefail

date
echo Started - Update build

if [ ! -f pom.xml ]; then
    echo "The current working directory ($PWD) does not contain a maven project"
    exit 1
fi

echo Project contents:
ls -la

date
echo Running update build in $PWD
mvn -B compile -Dmaven.repo.local=/artifacts/.m2/repository -DskipTests=true
if [ $? -ne 0 ]; then
    echo "The maven build failed"
    exit 1
fi

date

echo Target directory contents after maven build:
ls -la ./target

date
echo Finished - Update build
