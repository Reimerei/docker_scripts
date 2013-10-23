#!/bin/bash
############################################################################################
#
# MongoDB - Run image
#
# Runs a mongodb image created with init_database.sh. Mounts the existing data directory
# so data will be preserved when the image is restarted. 
#
############################################################################################

# quit if anything goes wrong
set -e

# Config
IMAGE_NAME=mongodb
DATA_DIR=$HOME/mongodb

if [ ! -d $DATA_DIR ]; then
	echo The data dir does not exist: $DATA_DIR
	exit 1
fi

sudo docker run -d -v $DATA_DIR/data:/data:rw $IMAGE_NAME
