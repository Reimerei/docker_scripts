#!/bin/bash
############################################################################################
#
# MongoDB - Create Image
#
# Creates an new mongodb image with an external data directory.
# New Database and User are created in that directory. 
# They can be used by any image that mounts the data directory.
#
############################################################################################

# quit if anything goes wrong
set -e

# Config
DATABASE_NAME=kolibri
DATABASE_USER=kolibri
DATABASE_PASS=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1)
DATA_DIR=$HOME/mongodb
IMAGE_NAME=mongodb

if [ -e $DATA_DIR ]; then
	echo The data directory "$DATA_DIR" already exists. Delete before creating a new database
	exit 1
fi

# create local directory for data and secrets
mkdir -p $DATA_DIR/data
mkdir -p $DATA_DIR/secrets

# copy resources
cp resources/* $DATA_DIR/data/

# build docker image
sudo docker build -t $IMAGE_NAME .

# create database
sudo docker run -v $DATA_DIR/data:/data:rw -entrypoint="/data/create_database.sh" -e DATABASE_NAME=$DATABASE_NAME -e DATABASE_USER=$DATABASE_USER -e DATABASE_PASS=$DATABASE_PASS $IMAGE_NAME

# write secrets to file
cat > $DATA_DIR/secrets/mongodb << EOF
DATABASE_NAME=$DATABASE_NAME
DATABASE_USER=$DATABASE_USER
DATABASE_PASS=$DATABASE_PASS
EOF
