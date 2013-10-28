#!/bin/bash
############################################################################################
#
# MongoDB - Run image
#
# Runs a mongodb image created with init_database.sh. Mounts the existing data directory
# so data will be preserved when the image is restarted. 
#
############################################################################################

# Config
IMAGE_NAME=mongodb
DATA_DIR=$HOME/mongodb

if [ ! -d $DATA_DIR ]; then
	echo The data dir does not exist: $DATA_DIR
	exit 1
fi

# check if the image is already running
sudo docker ps | grep $IMAGE_NAME:
if [ $? -eq "0" ]; then
	echo Another mongodb image is running. Exiting...
	exit 1
fi

sudo docker run -d -v $DATA_DIR/data:/data:rw $IMAGE_NAME -e 
