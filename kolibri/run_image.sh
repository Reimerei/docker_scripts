#!/bin/bash
############################################################################################
#
# Kolibri - Run image
#
# Runs a kolibri image. Mounts a data directory with the play config file.
# This image does not contain any state, so no data needs to be persisted.
#
############################################################################################

# Config
INSTANCE_NAME=kolibri
IMAGE_NAME=kolibri
DATA_DIR=$HOME/$INSTANCE_NAME

if [ ! -d $DATA_DIR ]; then
	echo The data dir does not exist: $DATA_DIR
	exit 1
fi

# start database
echo "Starting database"
../mongodb/run_image.sh

sudo docker run -d -v $DATA_DIR:/data:rw $IMAGE_NAME -e PLAY_PARAMS="-Dconfig.resource=/data/${INSTANCE_NAME}.conf"
