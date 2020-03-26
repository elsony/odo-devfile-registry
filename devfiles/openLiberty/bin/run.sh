#!/bin/sh

date
echo Started - Run

CONFIGDIR=$(dirname $(find /projects/openLiberty/target/liberty/wlp/usr/servers -name server.xml))
if [ ! $? -eq 0 ]; then
    echo "Cannot start the server because the config directory could not be found"
    exit 1
fi

date
echo Starting the server
/opt/ol/wlp/bin/server run
