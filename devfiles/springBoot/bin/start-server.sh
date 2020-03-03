#!/bin/sh

# set -e -o pipefail

APP_JAR=/root/app.jar
TARGET_JAR=$(ls /data/output/*.jar | head -n1)

date
echo Started - Spring Server Script

# Kill the Spring App if its running
date
echo Stopping the Spring App
pkill -f "java -jar $APP_JAR" || echo "No Java Spring Application process found"

# Copy the maven built jar from the PVC
date
echo Copying the maven built jar from the PVC
cp -rf $TARGET_JAR $APP_JAR

# Start the Spring Application
date
echo Starting the Spring Application
nohup java -jar $APP_JAR

date
echo Finished - Spring Server Script
